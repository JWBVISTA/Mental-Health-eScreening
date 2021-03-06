package gov.va.escreening.controller.dashboard;

import gov.va.escreening.domain.ExportTypeEnum;
import gov.va.escreening.dto.DataTableResponse;
import gov.va.escreening.dto.DropDownObject;
import gov.va.escreening.dto.dashboard.AssessmentDataExport;
import gov.va.escreening.dto.dashboard.ExportDataSearchResult;
import gov.va.escreening.form.ExportDataFormBean;
import gov.va.escreening.security.CurrentUser;
import gov.va.escreening.security.EscreenUser;
import gov.va.escreening.service.ProgramService;
import gov.va.escreening.service.UserService;
import gov.va.escreening.service.VeteranAssessmentService;
import gov.va.escreening.service.export.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StopWatch;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping(value = "/dashboard")
public class ExportDataRestController extends BaseDashboardRestController {

    private static final Logger logger = LoggerFactory.getLogger(ExportDataRestController.class);

    private static final String IDENTIFIED_EXPORT = "identified";
    private static final String DEIDENTIFIED_EXPORT = "deidentified";
    @Resource(name = "theDataDictionary")
    DataDictionary dd;
    @Resource(type = DataDictionaryService.class)
    DataDictionaryService dds;
    @Autowired
    private ExportDataFilterOptionsService exportDataFilterOptionsService;
    @Autowired
    private ExportDataService exportDataService;
    @Autowired
    private ExportLogService exportLogService;
    @Autowired
    private ProgramService programService;
    @Autowired
    private UserService userService;
    @Autowired
    private VeteranAssessmentService veteranAssessmentService;

    @RequestMapping(value = "/exportData/services/exports/search/init", method = RequestMethod.GET)
    @ResponseBody
    public ExportDataFormBean getFormBean(HttpServletRequest request) {
        logger.trace("In ExportDataRestController::getFormBean");
        ExportDataFormBean exportDataFormBean = new ExportDataFormBean();
        return exportDataFormBean;
    }

    @RequestMapping("/exportData/services/exports/resetDD")
    public void resetDd() {
        dd.markNotReady();
    }

    @RequestMapping(value = "/exportData/services/exports/genExportData", method = RequestMethod.GET)
    @ResponseBody
    public String genExportData(
            ModelAndView modelAndView,
            HttpServletRequest request,
            HttpServletResponse response,
            @CurrentUser EscreenUser escreenUser,
            @RequestParam(value = "fromAssessmentDate", required = false) String fromAssessmentDate,
            @RequestParam(value = "toAssessmentDate", required = false) String toAssessmentDate,
            @RequestParam(value = "clinicianId", required = false) String clinicianId,
            @RequestParam(value = "createdByUserId", required = false) String createdByUserId,
            @RequestParam(value = "programId", required = false) String programId,
            @RequestParam(value = "veteranId", required = false) String veteranId,
            @RequestParam(value = "comment", required = false) String comment,
            @RequestParam(value = "exportDataType", required = true) String exportDataType) {

        if (logger.isTraceEnabled()) {
            logger.trace(String.format("genExportData: arguments fromAssessmentDate=%s, toAssessmentDate=%s, clinicianId=%s, createdByUserId=%s, programId=%s, veteranId=%s, comment=%s, exportDataType=%s", fromAssessmentDate, toAssessmentDate, clinicianId, createdByUserId, programId, veteranId, comment, exportDataType));
        }

        List<String> errors = new ArrayList<String>();
        ExportDataFormBean exportDataFormBean = getSearchFormBean(escreenUser, fromAssessmentDate, toAssessmentDate, clinicianId, createdByUserId, programId, veteranId, comment, exportDataType, errors);

        if (errors.size() > 0) {
            //modelAndView.addObject("createUserStatusMessage", errors);
            //modelAndView.setViewName("exportData");
            //return modelAndView;
            return errors.toString();
        }

        exportDataFormBean.setExportedByUserId(escreenUser.getUserId());

        if (!dds.tryPrepareDataDictionary(false)) {
            //modelAndView.addObject("createUserStatusMessage", Arrays.asList("Data Dictionary is being built. Please try again in a min. or so..."));
            //modelAndView.setViewName("exportData");
            //return modelAndView;
            return "Data Dictionary is being built. Please try again in a min. or so...";
        }
        AssessmentDataExport dataExport = exportDataService.getAssessmentDataExport(exportDataFormBean, null);

        if (dataExport != null) {
            //modelAndView.setViewName("dataArchiveZipView");
            //modelAndView.addObject("model", dataExport.getExportZipAsModel());
            request.getSession().setAttribute("dataArchiveZipView", dataExport.getExportZipAsModel());
            return "prepared";
        } else if (!errors.isEmpty()) {
            //modelAndView.addObject("createUserStatusMessage", Arrays.asList("There is no result found for the provided search criteria"));
            //modelAndView.setViewName("exportData");
            return "There is no result found for the provided search criteria";
        }

        return "not_prepared";
    }

    @RequestMapping(value = "/exportData/services/exports/getExportDataFromSession", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView getExportDataNow(
            ModelAndView modelAndView,
            HttpServletRequest request,
            HttpServletResponse response,
            @CurrentUser EscreenUser escreenUser) {

        modelAndView.setViewName("dataArchiveZipView");
        modelAndView.addObject("model", request.getSession().getAttribute("dataArchiveZipView"));
        return modelAndView;
    }

    @RequestMapping(value = "/exportData/services/exports/downloadAgain/{exportLogId}", method = RequestMethod.GET)
    public ModelAndView downloadAgain(ModelAndView modelAndView,
                                      HttpServletRequest request, @CurrentUser EscreenUser escreenUser,
                                      @PathVariable int exportLogId,
                                      @RequestParam(value = "comment", required = true) String comment) {

        AssessmentDataExport dataExport = exportDataService.downloadExportData(escreenUser.getUserId(), exportLogId, comment);

        modelAndView.setViewName("dataArchiveZipView");
        modelAndView.addObject("model", dataExport.getExportZipAsModel());

        return modelAndView;
    }

    @RequestMapping(value = "/exportData/services/exports/genDataDictionary", method = RequestMethod.GET)
    @ResponseBody
    public boolean generateDataDictionary(ModelAndView modelAndView,
                                          HttpServletRequest request, @CurrentUser EscreenUser escreenUser) {

        dds.tryPrepareDataDictionary(true);
        return dd.isReady();
    }

    @RequestMapping(value = "/exportData/services/exports/dataDictionary", method = RequestMethod.GET)
    public ModelAndView getDataDictionaryNow(ModelAndView modelAndView,
                                             HttpServletRequest request, @CurrentUser EscreenUser escreenUser) {

        dds.tryPrepareDataDictionary(false);
        modelAndView.setViewName("dataDictionaryExcelView");

        return modelAndView;
    }

    @RequestMapping(value = "/exportData/services/exports/exportLog", method = RequestMethod.POST)
    @ResponseBody
    public DataTableResponse<ExportDataSearchResult> getExportLog(
            HttpServletRequest request, @CurrentUser EscreenUser escreenUser) {

        String echo = request.getParameter("sEcho");
        logger.trace("sEcho: " + echo);

        List<ExportDataSearchResult> results = exportLogService.getExportLogs(escreenUser.getProgramIdList(), -1);
        return prepareResponse(results, echo);
    }

    private DataTableResponse<ExportDataSearchResult> prepareResponse(
            List<ExportDataSearchResult> results, String echo) {
        // Start populating the response.

        DataTableResponse<ExportDataSearchResult> dataTableResponse = new DataTableResponse<ExportDataSearchResult>();
        dataTableResponse.setEcho(echo);
        dataTableResponse.setTotalRecords(results.size());
        dataTableResponse.setTotalDisplayRecords(results.size());

        dataTableResponse.setData(results);

        return dataTableResponse;
    }

    @RequestMapping(value = "/exportData/services/exports/exportLog/{noOfDays}", method = RequestMethod.POST)
    @ResponseBody
    public DataTableResponse<ExportDataSearchResult> getExportLog(
            HttpServletRequest request, @CurrentUser EscreenUser escreenUser,
            @PathVariable int noOfDays) {

        String echo = request.getParameter("sEcho");
        logger.trace("sEcho: " + echo);

        List<ExportDataSearchResult> results = exportLogService.getExportLogs(escreenUser.getProgramIdList(), noOfDays);
        return prepareResponse(results, echo);
    }

    @RequestMapping(value = "/exportData/services/exports/filterOptions", method = RequestMethod.POST)
    @ResponseBody
    public List<DropDownObject> getFilterOptions(
            @CurrentUser EscreenUser escreenUser) {
        logger.trace("getFilterOptions");
        List<DropDownObject> dropDownObjectList = exportDataFilterOptionsService.getExportDataFilterOptions();
        return dropDownObjectList;
    }

    @RequestMapping(value = "/exportData/services/user/clinicians", method = RequestMethod.POST)
    @ResponseBody
    public List<DropDownObject> getClinician(@RequestParam Boolean includeAll,
                                             @CurrentUser EscreenUser escreenUser) {

        logger.trace("getClinician");
        logger.trace("includeAll: " + includeAll);

        List<Integer> userStatusIdList = new ArrayList<Integer>();
        userStatusIdList.add(1);
        userStatusIdList.add(2);

        if (includeAll) {
            userStatusIdList.add(3);
        }

        List<DropDownObject> dropDownObjectList = userService.getAssessmentClinicianDropDownObjects(userStatusIdList, escreenUser.getProgramIdList());

        return dropDownObjectList;
    }

    @RequestMapping(value = "/exportData/services/user/assessmentCreators", method = RequestMethod.POST)
    @ResponseBody
    public List<DropDownObject> getAssessmentCreators(
            @RequestParam Boolean includeAll,
            @CurrentUser EscreenUser escreenUser) {

        logger.trace("getAssessmentCreators");
        logger.trace("includeAll: " + includeAll);

        List<Integer> userStatusIdList = new ArrayList<Integer>();
        userStatusIdList.add(1);
        userStatusIdList.add(2);

        if (includeAll) {
            userStatusIdList.add(3);
        }

        List<DropDownObject> dropDownObjectList = userService.getAssessmentCreatorDropDownObjects(userStatusIdList, escreenUser.getProgramIdList());

        return dropDownObjectList;
    }

    @RequestMapping(value = "/exportData/services/user/programs", method = RequestMethod.POST)
    @ResponseBody
    public List<DropDownObject> getPrograms(@CurrentUser EscreenUser escreenUser) {

        logger.trace("getPrograms");

        List<DropDownObject> dropDownObjectList = programService.getProgramDropDownObjects(escreenUser.getProgramIdList());

        return dropDownObjectList;
    }

    /**
     * Takes the passed in query string parameters and populates the exportDataFormBean.
     *
     * @param escreenUser
     * @param fromAssessmentDate
     * @param toAssessmentDate
     * @param clinicianId
     * @param createdByUserId
     * @param programId
     * @param veteranId
     * @param comment
     * @param exportDataType
     * @return
     */
    public ExportDataFormBean getSearchFormBean(EscreenUser escreenUser,
                                                String fromAssessmentDate, String toAssessmentDate,
                                                String clinicianId, String createdByUserId, String programId,
                                                String veteranId, String comment, String exportDataType,
                                                List<String> errors) {

        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");

        ExportDataFormBean exportDataFormBean = new ExportDataFormBean();
        exportDataFormBean.setHasParameter(false);

        if (clinicianId != null && !clinicianId.isEmpty() && !"null".equals(clinicianId) && !clinicianId.equalsIgnoreCase("undefined")) {
            if (isInteger(clinicianId)) {
                exportDataFormBean.setClinicianId(Integer.parseInt(clinicianId));
                exportDataFormBean.setHasParameter(true);
            } else {
                logger.warn(String.format("clinicanId could not be parsed as an Integer, was: %s", clinicianId));
                errors.add("Clinician must be be a number.");
            }
        }

        if (createdByUserId != null && !createdByUserId.isEmpty() && !"null".equals(createdByUserId) && !createdByUserId.equalsIgnoreCase("undefined")) {
            if (isInteger(createdByUserId)) {
                exportDataFormBean.setCreatedByUserId(Integer.parseInt(createdByUserId));
                exportDataFormBean.setHasParameter(true);
            } else {
                logger.warn(String.format("createdByUserId could not be parsed as an Integer, was: %s", createdByUserId));
                errors.add("Created by user must be be a number.");
            }
        }

        if (veteranId != null && !veteranId.isEmpty() && !"null".equals(veteranId) && !veteranId.equalsIgnoreCase("undefined")) {
            if (isInteger(veteranId)) {
                exportDataFormBean.setVeteranId(Integer.parseInt(veteranId));
                exportDataFormBean.setHasParameter(true);
            } else {
                logger.warn(String.format("veteranId could not be parsed as an Integer, was: %s", veteranId));
                errors.add("Veteran must be be a number.");
            }
        }

        if (fromAssessmentDate != null && !fromAssessmentDate.isEmpty() && !fromAssessmentDate.equalsIgnoreCase("undefined")) {
            try {
                exportDataFormBean.setFromAssessmentDate(sdf.parse(fromAssessmentDate));
                exportDataFormBean.setHasParameter(true);
            } catch (ParseException e) {
                logger.warn(String.format("fromAssessmentDate could not be parsed as a date, was: %s", fromAssessmentDate));
                errors.add("From Assessment Date must be a valid date: MM/dd/yyyy.");
            }
        }

        if (toAssessmentDate != null && !toAssessmentDate.isEmpty() && !toAssessmentDate.equalsIgnoreCase("undefined")) {
            try {
                exportDataFormBean.setToAssessmentDate(sdf.parse(toAssessmentDate));
                exportDataFormBean.setHasParameter(true);
            } catch (ParseException e) {
                logger.warn(String.format("toAssessmentDate could not be parsed as a date, was: %s", toAssessmentDate));
                errors.add("To Assessment Date must be a valid date: MM/dd/yyyy.");
            }
        }

        if (programId != null && !programId.isEmpty() && !"null".equals(programId) && !programId.equalsIgnoreCase("undefined")) {
            if (isInteger(programId)) {
                exportDataFormBean.setProgramId(Integer.parseInt(programId));
                exportDataFormBean.setHasParameter(true);
            } else {
                logger.warn(String.format("programId could not be parsed as an Integer, was: %s", programId));
                errors.add("Program must be be a number.");
            }
        }

        if (comment != null && !comment.isEmpty()) {
            exportDataFormBean.setCommentText(comment);
        }

        if (exportDataType != null && !exportDataType.isEmpty()) {
            if (exportDataType.equalsIgnoreCase(IDENTIFIED_EXPORT)) {
                exportDataFormBean.setExportTypeId(ExportTypeEnum.IDENTIFIED.getExportTypeId());
            } else if (exportDataType.equalsIgnoreCase(DEIDENTIFIED_EXPORT)) {
                exportDataFormBean.setExportTypeId(ExportTypeEnum.DEIDENTIFIED.getExportTypeId());
            } else {
                logger.error(String.format("Unregistered exportDataType of: %s could not be handled", exportDataType));
                errors.add("Export type must either be 'identified' or 'deidentified'.");
            }
        }

        // Populate the clinic id list from the logged in user.
        // exportDataFormBean.setProgramIdList(escreenUser != null ? escreenUser.getProgramIdList() : null);

        // Assessment Start Date from last snapshop date is by default
        if (!exportDataFormBean.getHasParameter() && errors.isEmpty()) {
            exportDataFormBean.setFromAssessmentDate(exportDataService.getLastSnapshotDate());
            exportDataFormBean.setToAssessmentDate(new Date());
            exportDataFormBean.setHasParameter(true);
        }
        return exportDataFormBean;
    }

    private boolean isInteger(String str) {
        try {
            Integer.parseInt(str);
        } catch (NumberFormatException nfe) {
            return false;
        }
        return true;
    }
}