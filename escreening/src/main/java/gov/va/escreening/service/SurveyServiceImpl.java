package gov.va.escreening.service;

import com.google.common.base.Function;
import com.google.common.collect.Collections2;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import gov.va.escreening.domain.SurveyDto;
import gov.va.escreening.dto.ae.ErrorBuilder;
import gov.va.escreening.dto.ae.Page;
import gov.va.escreening.dto.editors.QuestionInfo;
import gov.va.escreening.dto.editors.SurveyInfo;
import gov.va.escreening.dto.editors.SurveyPageInfo;
import gov.va.escreening.dto.editors.SurveySectionInfo;
import gov.va.escreening.entity.*;
import gov.va.escreening.exception.EscreeningDataValidationException;
import gov.va.escreening.repository.*;
import gov.va.escreening.service.export.DataDictionaryService;
import gov.va.escreening.transformer.EditorsQuestionViewTransformer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Nullable;
import javax.annotation.Resource;
import java.util.*;

import static org.springframework.beans.BeanUtils.copyProperties;

@Transactional(readOnly = true)
@Service
public class SurveyServiceImpl implements SurveyService {

    private static final Logger logger = LoggerFactory.getLogger(SurveyServiceImpl.class);
    @Resource(name = "dataDictionaryService")
    DataDictionaryService dds;
    private SurveyRepository surveyRepository;
    @Autowired
    private SurveySectionRepository surveySectionRepository;

    @Autowired
    private MeasureRepository measureRepository;

    @Autowired
    private SurveyPageRepository surveyPageRepository;

    @Autowired
    private ClinicalReminderSurveyRepository clinicalReminderSurveyRepo;

    @Autowired
    private ClinicalReminderRepository clinicalReminderRepo;

    @Autowired
    public void setSurveyRepository(SurveyRepository surveyRepository) {
        this.surveyRepository = surveyRepository;
    }

    @Transactional(readOnly = true)
    @Override
    public List<Survey> findForVeteranAssessmentId(int veteranAssessmentId) {

        List<Survey> surveyList = surveyRepository.findForVeteranAssessmentId(veteranAssessmentId);

        // We need to iterate through the collections until we can get eager fetch working using JQL or find a
        // workaround for it.
        if (surveyList != null) {
            for (Survey survey : surveyList) {
                // logger.tracesurvey.getName());

                List<SurveyPage> spLst = survey.getSurveyPageList();
                if (spLst != null) {
                    for (SurveyPage surveyPage : spLst) {
                        // logger.tracesurveyPage.getTitle());

                        List<Measure> mLst = surveyPage != null ? surveyPage.getMeasures() : null;
                        exhaustMeasures(mLst);
                    }
                }
            }
        }

        return surveyList;
    }

    private void exhaustMeasures(Collection<Measure> mLst) {
        if (mLst != null) {
            for (Measure measure : mLst) {
                // logger.tracemeasure.getMeasureText());

                List<MeasureAnswer> maLst = measure != null ? measure.getMeasureAnswerList() : null;
                if (maLst != null) {
                    for (MeasureAnswer measureAnswer : maLst) {
                        // logger.tracemeasureAnswer.getAnswerText());
                    }
                }

                exhaustMeasures(measure.getChildren());
            }
        }
    }

    @Transactional(readOnly = true)
    @Override
    public List<SurveyDto> getSurveyListForVeteranAssessment(
            int veteranAssessmentId) {
        logger.trace("getVeteranAssessmentSurveys()");

        List<Survey> surveys = surveyRepository.findForVeteranAssessmentId(veteranAssessmentId);

        List<SurveyDto> surveyDtoList = new ArrayList<SurveyDto>();
        for (Survey survey : surveys) {
            surveyDtoList.add(new SurveyDto(survey));
        }

        return surveyDtoList;
    }

    @Transactional(readOnly = true)
    @Override
    public List<SurveyDto> getSurveyList() {
        logger.trace("getSurveyList()");
        return toDtos(surveyRepository.getSurveyList(), Collections.<Integer>emptySet());
    }

    @Transactional(readOnly = true)
    @Override
    public List<SurveyDto> getSurveyListUnionAssessment(int veteranAssessmentId) {
        List<Survey> assessmentSurveys = surveyRepository.findForVeteranAssessmentId(veteranAssessmentId);
        if (assessmentSurveys == null) {
            throw new IllegalArgumentException("Unknown assessment");
        }
        Set<Integer> allowableSurveys = Sets.newHashSetWithExpectedSize(assessmentSurveys.size());
        for (Survey assessmentSurvey : assessmentSurveys) {
            allowableSurveys.add(assessmentSurvey.getSurveyId());
        }

        return toDtos(surveyRepository.getSurveyList(), allowableSurveys);
    }

    /**
     * Filters only public surveys and turns them into SurveyDtos
     *
     * @param surveys
     * @param allowableSurveys - surveys that should be included even if they are not public
     * @return
     */
    private List<SurveyDto> toDtos(List<Survey> surveys, Set<Integer> allowableSurveys) {
        List<SurveyDto> surveyDtoList = new ArrayList<SurveyDto>();
        for (Survey survey : surveys) {
            if (survey.isPublished() || allowableSurveys.contains(survey.getSurveyId())) {
                surveyDtoList.add(new SurveyDto(survey));
            }
        }
        return surveyDtoList;
    }

    /**
     * This will return all surveys regardless if they are published or not
     */
    @Transactional(readOnly = true)
    @Override
    public List<SurveyInfo> getSurveyItemList() {
        List<Survey> surveys = surveyRepository.getSurveyList();
        List<SurveyInfo> surveyInfoList = toSurveyInfo(surveys);

        return surveyInfoList;
    }

    @Override
    @Transactional(readOnly = false, propagation = Propagation.REQUIRED)
    public SurveyInfo update(SurveyInfo surveyInfo) {

        if (surveyInfo.getSurveySectionInfo() == null ||
                surveyInfo.getSurveySectionInfo().getSurveySectionId() == null) {
            ErrorBuilder.throwing(EscreeningDataValidationException.class)
                    .toAdmin("surveyInfo passed in with null section ID. Debug UI.")
                    .toUser("Invalid request. Please contact support")
                    .throwIt();
        }

        Survey survey = surveyRepository.findOne(surveyInfo.getSurveyId());
        SurveySection newSurveySection = surveySectionRepository.findOne(surveyInfo.getSurveySectionInfo().getSurveySectionId());
        SurveySection oldSurveySection = survey.getSurveySection();

        boolean updateOldSurveySectionOrdering = false;
        boolean isNewSection = !oldSurveySection.getSurveySectionId().equals(newSurveySection.getSurveySectionId());
        if (isNewSection && surveyInfo.getDisplayOrderForSection() == null) {
            //the module's section has changed and no order was set so set it the the next larger index
            surveyInfo.setDisplayOrderForSection(newSurveySection.getSurveyList().size() + 1);
            updateOldSurveySectionOrdering = true;
        }

        // copy any changed properties from incoming surveyInfo to the data for database 'survey'
        copyProperties(surveyInfo, survey);

        // and now make sure that surveyInfo's survey Section is also reflected back to the survey
        survey.setSurveySection(newSurveySection);

        surveyRepository.update(survey);

        if (updateOldSurveySectionOrdering) {
            reorderSurveySection(oldSurveySection, survey);
        }

        clinicalReminderSurveyRepo.removeSurveyMapping(surveyInfo.getSurveyId());

        if (surveyInfo.getClinicalReminderIdList() != null && !surveyInfo.getClinicalReminderIdList().isEmpty()) {
            for (Integer crId : surveyInfo.getClinicalReminderIdList()) {
                clinicalReminderSurveyRepo.createClinicalReminderSurvey(crId, surveyInfo.getSurveyId());
            }
        }
        dds.invalidateDataDictionary();
        return surveyInfo;
    }

    private void reorderSurveySection(SurveySection surveySection, Survey removedSurvey) {
        int index = 1;
        for (Survey survey : surveySection.getSurveyList()) {
            if (!survey.equals(removedSurvey)) {
                survey.setDisplayOrderForSection(index++);
            }
        }

        surveySectionRepository.update(surveySection);
        dds.invalidateDataDictionary();
    }

    @Override
    public Survey findOne(int surveyId) {
        return surveyRepository.findOne(surveyId);
    }

    @Transactional(readOnly = false, propagation = Propagation.REQUIRED)
    @Override
    public void removeMeasureFromSurvey(Integer surveyId, Integer questionId) {

        Measure measure = measureRepository.findOne(questionId);

        if (measure != null) {
            if (measure.getParent() != null) {
                measure.setParent(null);
                measureRepository.update(measure);
                measureRepository.commit();
            } else {
                SurveyPage sp = surveyPageRepository.getSurveyPageByMeasureId(questionId);

                if (sp != null) {
                    sp.getMeasures().remove(measure);
                    surveyPageRepository.update(sp);
                    surveyPageRepository.commit();
                }

            }
        }
        dds.invalidateDataDictionary();
    }

    @Override
    public void createSurveyPage(Integer surveyId, Page page) {
        Survey survey = surveyRepository.findOne(surveyId);

        SurveyPage surveyPage = new SurveyPage();
        surveyPage.setPageNumber(page.getPageNumber());
        surveyPage.setDescription(page.getDescription());
        surveyPage.setTitle(page.getPageTitle());
        surveyPage.setSurvey(survey);

        surveyPageRepository.create(surveyPage);
        dds.invalidateDataDictionary();
    }

    @Override
    @Transactional(readOnly = false, propagation = Propagation.REQUIRED)
    public void updateSurveyPages(Integer surveyId,
                                  List<SurveyPageInfo> surveyPageInfos) {


        Survey survey = surveyRepository.findOne(surveyId);

        List<SurveyPage> surveyPageList = new ArrayList<SurveyPage>();

        String surveyPageTitle = survey.getSurveySection().getName();

        for (SurveyPageInfo surveyPageInfo : surveyPageInfos) {

            SurveyPage surveyPage = null;

            if (surveyPageInfo.getSurveyPageId() == null) {
                surveyPage = new SurveyPage();
            } else {
                surveyPage = surveyPageRepository.findOne(surveyPageInfo.getSurveyPageId());
            }

            surveyPage.setPageNumber(surveyPageInfo.getPageNumber());
            surveyPage.setDescription(surveyPageInfo.getDescription());
            surveyPage.setTitle(surveyPageTitle);
            surveyPage.setSurveyPageId(surveyPageInfo.getSurveyPageId());

            if (surveyPageInfo.getDateCreated() == null) {
                surveyPage.setDateCreated(new Date());
            } else {
                surveyPage.setDateCreated(surveyPageInfo.getDateCreated());
            }
            surveyPage.setSurvey(survey);

            List<Measure> measures = new ArrayList<Measure>();
            surveyPage.setMeasures(measures);

            for (final QuestionInfo questionInfo : surveyPageInfo.getQuestions()) {
                Integer measureId = questionInfo.getId();
                if (measureId != null && measureId > -1) {
                    measureRepository.updateMeasure(EditorsQuestionViewTransformer.transformQuestionInfo(questionInfo));
                    measures.add(measureRepository.findOne(questionInfo.getId()));
                } else {
                    gov.va.escreening.dto.ae.Measure measureDTO = measureRepository.createMeasure(EditorsQuestionViewTransformer.transformQuestionInfo(questionInfo));
                    measures.add(measureRepository.findOne(measureDTO.getMeasureId()));

                    // update questionInfo's id with measure id
                    questionInfo.setId(measureDTO.getMeasureId());
                }
            }

            if (surveyPageInfo.getSurveyPageId() == null) {
                surveyPageRepository.create(surveyPage);
                surveyPageInfo.setSurveyPageId(surveyPage.getSurveyPageId());
            } else {
                surveyPageRepository.update(surveyPage);
            }

            surveyPageList.add(surveyPage);
        }

        survey.setSurveyPageList(surveyPageList);
        surveyRepository.update(survey);
        dds.invalidateDataDictionary();
    }

    @Override
    @Transactional(readOnly = true)
    public List<SurveyPageInfo> getSurveyPages(Integer surveyId, int pageNumber) {
        Survey survey = surveyRepository.findOne(surveyId);
        List<SurveyPage> surveyPages = survey.getSurveyPageList();

        List<SurveyPageInfo> surveyPageInfos = new ArrayList<SurveyPageInfo>();
        for (SurveyPage surveyPage : surveyPages) {

            if (pageNumber == -1 || surveyPage.getPageNumber() == pageNumber) {
                SurveyPageInfo spi = new SurveyPageInfo();
                BeanUtils.copyProperties(surveyPage, spi);

                spi.setQuestions(new ArrayList<QuestionInfo>());
                for (Measure measure : surveyPage.getMeasures()) {
                    spi.getQuestions().add(EditorsQuestionViewTransformer.transformQuestion(new gov.va.escreening.dto.ae.Measure(measure)));
                }
                surveyPageInfos.add(spi);
            }
        }
        return surveyPageInfos;
    }

    @Override
    @Transactional
    public SurveyInfo createSurvey(SurveyInfo surveyInfo) {
        SurveySection surveySection = surveySectionRepository.findOne(surveyInfo.getSurveySectionInfo().getSurveySectionId());

        //we have to always set this to the last index of the section
        surveyInfo.setDisplayOrderForSection(surveySection.getSurveyList().size() + 1);

        Survey survey = new Survey();
        BeanUtils.copyProperties(surveyInfo, survey);
        survey.setSurveySection(surveySection);


        surveyRepository.create(survey);

        for (Integer crId : surveyInfo.getClinicalReminderIdList()) {
            ClinicalReminderSurvey cr = new ClinicalReminderSurvey();
            ClinicalReminder reminder = clinicalReminderRepo.findOne(crId);
            cr.setClinicalReminder(reminder);
            cr.setSurvey(survey);
            clinicalReminderSurveyRepo.create(cr);

        }
        SurveyInfo surveyInfoResult = toSurveyInfo(Arrays.asList(survey)).iterator().next();
        dds.invalidateDataDictionary();
        return surveyInfoResult;
    }

    @Override
    public List<SurveyInfo> toSurveyInfo(List<Survey> surveyList) {

        Function<Survey, SurveyInfo> transformerFun = new Function<Survey, SurveyInfo>() {
            @Nullable
            @Override
            public SurveyInfo apply(Survey survey) {
                SurveyInfo si = new SurveyInfo();
                BeanUtils.copyProperties(survey, si);

                SurveySectionInfo ssInfo = new SurveySectionInfo();
                copyProperties(survey.getSurveySection(), ssInfo);

                si.setSurveySectionInfo(ssInfo);

                if (survey.getClinicalReminderSurveyList() != null && !survey.getClinicalReminderSurveyList().isEmpty()) {
                    for (ClinicalReminderSurvey cr : survey.getClinicalReminderSurveyList()) {
                        si.getClinicalReminderIdList().add(cr.getClinicalReminder().getClinicalReminderId());
                    }
                }

                return si;
            }
        };

        ArrayList<SurveyInfo> surveyInfos = Lists.newArrayList(Collections2.transform(surveyList, transformerFun));
        return surveyInfos;
    }

    @Override
    public SurveyInfo findSurveyById(Integer surveyId) {
        Survey survey = surveyRepository.findOne(surveyId);
        return toSurveyInfo(Arrays.asList(survey)).iterator().next();
    }

    @Override
    public SurveyPageInfo getSurveyPage(Integer surveyId, Integer pageId) {
        Survey survey = surveyRepository.findOne(surveyId);
        List<SurveyPage> surveyPages = survey.getSurveyPageList();

        for (SurveyPage surveyPage : surveyPages) {
            if (surveyPage.getSurveyPageId().equals(pageId)) {
                SurveyPageInfo spi = new SurveyPageInfo();
                BeanUtils.copyProperties(surveyPage, spi);

                spi.setQuestions(new ArrayList<QuestionInfo>());
                for (Measure measure : surveyPage.getMeasures()) {
                    spi.getQuestions().add(EditorsQuestionViewTransformer.transformQuestion(new gov.va.escreening.dto.ae.Measure(measure)));
                }

                return spi;

            }
        }
        return null;
    }

    @Override
    @Transactional
    public void removeSurveyPage(Integer surveyId, Integer pageId) {
        surveyPageRepository.deleteById(pageId);
        dds.invalidateDataDictionary();
    }

    @Override
    public List<SurveyDto> getSurveyListByNames(List<String> surveyNames) {

        logger.trace("getSurveyListByNames()");

        List<Survey> surveys = surveyRepository.getSurveyList();

        // create adapter object for view
        List<SurveyDto> surveyDtoList = new ArrayList<SurveyDto>();
        for (Survey survey : surveys) {
            if (surveyNames.contains(survey.getName())) {
                surveyDtoList.add(new SurveyDto(survey));
            }
        }

        return surveyDtoList;

    }
}
