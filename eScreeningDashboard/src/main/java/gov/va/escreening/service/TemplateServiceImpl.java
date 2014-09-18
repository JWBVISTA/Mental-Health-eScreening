package gov.va.escreening.service;


import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import gov.va.escreening.constants.TemplateConstants;
import gov.va.escreening.constants.TemplateConstants.TemplateType;
import gov.va.escreening.dto.TemplateDTO;
import gov.va.escreening.entity.Battery;
import gov.va.escreening.entity.Survey;
import gov.va.escreening.entity.Template;
import gov.va.escreening.repository.BatteryRepository;
import gov.va.escreening.repository.SurveyRepository;
import gov.va.escreening.repository.TemplateRepository;
import gov.va.escreening.repository.TemplateTypeRepository;
import gov.va.escreening.transformer.TemplateTransformer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TemplateServiceImpl implements TemplateService {
	
	@Autowired
	private TemplateRepository templateRepository;
	
	@Autowired
	private TemplateTypeRepository templateTypeRepository;
	
	@Autowired
	private SurveyRepository surveyRepository;
	
	@Autowired
	private BatteryRepository batteryRepository;
	

	private static List<TemplateType> surveyTemplates = new ArrayList<TemplateType>() {{
		add(TemplateType.CPRS_ENTRY);
		add(TemplateType.VET_SUMMARY_ENTRY);
		add(TemplateType.VISTA_QA);
		
	}};
	
	private static List<TemplateType> batteryTemplates = new ArrayList<TemplateType>() {{
		add(TemplateType.CPRS_HEADER);
		add(TemplateType.CPRS_FOOTER);
		add(TemplateType.ASSESS_SCORE_TABLE);
		add(TemplateType.ASSESS_CONCLUSION);
		add(TemplateType.VET_SUMMARY_HEADER);
		add(TemplateType.VET_SUMMARY_FOOTER);
	}};
	
	@Override
	@Transactional(readOnly=false, propagation=Propagation.REQUIRED)
	public void deleteTemplate(Integer templateId)
	{
		Template template = templateRepository.findOne(templateId);
		
		if (template == null)
		{
			return;
		}
		
		if (surveyTemplates.contains(TemplateConstants.typeForId(template.getTemplateType().getTemplateTypeId())))
		{
			// need to remove this template from associated survey
			List<Survey> surveys = surveyRepository.findByTemplateId(templateId);
			
			if (surveys != null && surveys.size() >  0)
			{
				for(Survey survey: surveys)
				{
					survey.getTemplates().remove(template);
					surveyRepository.update(survey);
				}					
			}
		}
		else
		{
			// need to remove this template from associated battery
			
			// find the survey or battery 
			List<Battery> batteries = batteryRepository.findByTemplateId(templateId);
			
			if (batteries != null && batteries.size() >  0)
			{
				for(Battery battery: batteries)
				{
					battery.getTemplates().remove(template);
					batteryRepository.update(battery);
				}					
			}			
		}
		
		
		
		templateRepository.deleteById(templateId);
	}
	
	@Override
	@Transactional(readOnly=true)
	public TemplateDTO readTemplate(Integer templateId)
	{
		Template template = templateRepository.findOne(templateId);
		
		if (template == null)
		{
			return null;
		}
		else
		{
			return TemplateTransformer.copyToTemplateDTO(template, null);
		}
		
	}
	
	@Override
	@Transactional(readOnly=false, propagation=Propagation.REQUIRED)
	public void updateTemplate(TemplateDTO templateDTO)
	{

		Template template = templateRepository.findOne(templateDTO.getTemplateId());
		TemplateTransformer.copyToTemplate(templateDTO, template);
		templateRepository.update(template);
	}
	
	@Override
	@Transactional(readOnly=false, propagation=Propagation.REQUIRED)
	public void createTemplate(TemplateDTO templateDTO, Integer parentId, boolean isSurvey)
	{
		Template template = TemplateTransformer.copyToTemplate(templateDTO, null);
		
		template.setTemplateType(templateTypeRepository.findOne(templateDTO.getTemplateTypeId()));

		if (parentId == null)
		{
			templateRepository.create(template);
		}
		else
		{
			if (isSurvey)
			{
				Survey survey = surveyRepository.findOne(parentId);
				Set<Template> templateSet = survey.getTemplates();
				survey.setTemplates(addTemplateToSet(templateSet, template, surveyTemplates));
				surveyRepository.update(survey);
			}
			else
			{
				Battery battery = batteryRepository.findOne(parentId);
				Set<Template> templateSet = battery.getTemplates();
				battery.setTemplates(addTemplateToSet(templateSet, template, batteryTemplates));
				batteryRepository.update(battery);
			}
		}
		
	}
	
	/**
	 * 
	 * Ensure the uniqueness of the template in either survey or battery
	 * 
	 * @param templateSet
	 * @param template
	 * @param uniquTemplateTypes
	 * @return
	 */
	private Set<Template> addTemplateToSet(Set<Template> templateSet, Template template, List<TemplateType> uniquTemplateTypes)
	{
		if (templateSet == null)
		{
			templateSet = new HashSet<Template>();
			templateSet.add(template);
		}
		else
		{
			// first we make sure 
			boolean needsToBeUnique = false;
			
			for(TemplateType tt : uniquTemplateTypes)
			{
				if (tt.getId() == template.getTemplateType().getTemplateTypeId())
				{
					needsToBeUnique = true;
					break;
				}
			}
			
			if (needsToBeUnique)
			{
				for(Template t : templateSet)
				{
					if (t.getTemplateType().getTemplateTypeId() == template.getTemplateType().getTemplateTypeId())
					{
						templateSet.remove(t);
						break;
					}
				}
			}
			
			templateSet.add(template);
		}
		
		return templateSet;
	}
	
	

}
