package gov.va.escreening.repository;

import gov.va.escreening.dto.ae.Measure;
import gov.va.escreening.entity.SurveyPage;

import java.util.List;

import javax.annotation.Nullable;
import javax.persistence.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class SurveyPageRepositoryImpl extends AbstractHibernateRepository<SurveyPage> implements SurveyPageRepository {

    private static final Logger logger = LoggerFactory.getLogger(SurveyPageRepositoryImpl.class);

    public SurveyPageRepositoryImpl() {
        super();

        setClazz(SurveyPage.class);
    }

    public List<SurveyPage> getSurveyPagesForVeteranAssessmentId(int veteranAssessmentId) {

        logger.trace("getSurveyPagesForVeteranAssessmentId");
        
        String sql = "select sp.* from survey_page sp join survey s on sp.survey_id = s.survey_id join survey_section ss on s.survey_section_id = ss.survey_section_id "
                + "where s.survey_id in (select survey_id from veteran_assessment_survey where veteran_assessment_survey.veteran_assessment_id= :veteranAssessmentId) "
                + " order by ss.display_order, s.display_order_for_section, sp.page_number";

        Query query = entityManager.createNativeQuery(sql, SurveyPage.class);
        query.setParameter("veteranAssessmentId", veteranAssessmentId);

        List<SurveyPage> surveyPageList = query.getResultList();

        return surveyPageList;
    }

    @Override
    public List<Object[]> getSuveyPageAnswerStatuses(int veteranAssessmentId){
        String sql = "SELECT "
                + "all_pages.survey_page_id, "
                + "isnull(answered_pages.has_answer, 0) has_answer"
                + " FROM"
                + " ( "
                    + "SELECT sp.survey_page_id, ss.display_order, sp.page_number "
                    + "FROM veteran_assessment_survey vas "
                    + "INNER JOIN survey s ON vas.survey_id=s.survey_id "
                    + "INNER JOIN survey_page sp ON s.survey_id=sp.survey_id "
                    + "INNER JOIN survey_section ss ON s.survey_section_id = ss.survey_section_id "
                    + "WHERE vas.veteran_assessment_id = :veteranAssessmentId "
                    + "GROUP BY sp.survey_page_id "
                + ") all_pages "
                + "LEFT OUTER JOIN "
                + "( "
                    + "SELECT spm.survey_page_id, 1 has_answer "
                    + "FROM survey_measure_response smr "
                    + "INNER JOIN measure m ON smr.measure_id=m.measure_id "
                    + "INNER JOIN survey_page_measure spm on smr.measure_id=spm.measure_id "
                    + "WHERE smr.veteran_assessment_id = :veteranAssessmentId "
                    + "AND m.measure_type_id IN ( " + Measure.COUNTED_MEASURE_TYPES + " ) "
                    + "AND (smr.boolean_value = 1 OR smr.number_value IS NOT NULL OR text_value IS NOT NULL) "
                    + "GROUP BY spm.survey_page_id "
                    + ") answered_pages ON answered_pages.survey_page_id=all_pages.survey_page_id "
                + "ORDER BY all_pages.display_order, all_pages.page_number";

        Query query = entityManager.createNativeQuery(sql);
        query.setParameter("veteranAssessmentId", veteranAssessmentId);
        
        @SuppressWarnings("unchecked")
        List<Object[]> result = query.getResultList();

        return result;
    }
    
    @Override
    public List<Object[]> getSurveyPageSkippedStatuses(int veteranAssessmentId){
        return getSurveyPageSkippedStatuses(veteranAssessmentId, null);
    }
    
    @Override
    public List<Object[]> getSurveyPageSkippedStatuses(int veteranAssessmentId, 
                                                       @Nullable Integer surveySectionId ){
        String allMeasureSurveyQuery = surveySectionId == null ? "" : "AND s.survey_section_id = :surveySectionId ";
        
        Query query = entityManager.createNativeQuery(String.format(SKIP_QUERY_FORMAT, allMeasureSurveyQuery, allMeasureSurveyQuery, allMeasureSurveyQuery));
        query.setParameter("veteranAssessmentId", veteranAssessmentId);
        
        if(surveySectionId != null){
            query.setParameter("surveySectionId", surveySectionId);
        }
        
        @SuppressWarnings("unchecked")
        List<Object[]> result = query.getResultList();
        
        if(logger.isTraceEnabled()){
            for(Object[] row: result)
                logger.info("Survey page ID: " + row[0] + ", has_skip: " + row[1]);
        }

        return result;
    }
    
    @Override
	public SurveyPage getSurveyPageByMeasureId(Integer questionId) {
		logger.trace("getSurveyPageByMeasureId");
		        
		String sql = "select sp.* from survey_page sp join survey_page_measure m on sp.survey_page_id = "
				+ "m.survey_page_id where m.measure_id = "+questionId.intValue();

        Query query = entityManager.createNativeQuery(sql, SurveyPage.class);
        
		List<SurveyPage> surveyPages = query.getResultList();
		
		if (surveyPages!=null && surveyPages.size() > 0 )
		{
			return surveyPages.get(0);
		}
		else 
		{
			return null;
		}
	} 
    
    private static final String SKIP_QUERY_FORMAT =
      "SELECT survey_page_measure_count.survey_page_id, case when survey_page_measure_count.measure_count <> survey_page_measure_count.respons_count then 1 else 0 end has_skipped "
      +"FROM ( " 
            +"SELECT survey_page_id, count(survey_page_id) measure_count, sum(case when measure_compare.measure_id = measure_compare.response then 1 else 0 end) respons_count " 
            +"FROM ( " 
                +"SELECT all_measures.survey_page_id, all_measures.measure_id, isnull(answered_measures.measure_id, -1) response " 
                +"FROM( "
                    +"SELECT spm.survey_page_id, spm.measure_id "
                    +"FROM measure m "
                    +"LEFT OUTER JOIN veteran_assessment_measure_visibility vamv ON " 
                    +"m.measure_id=vamv.measure_id AND vamv.veteran_assessment_id= :veteranAssessmentId "
                    +"INNER JOIN survey_page_measure spm ON isnull(m.parent_measure_id, m.measure_id)=spm.measure_id " 
                    +"INNER JOIN survey_page sp ON spm.survey_page_id=sp.survey_page_id " 
                    +"INNER JOIN survey s ON sp.survey_id=s.survey_id " 
                    +"INNER JOIN veteran_assessment_survey vas ON sp.survey_id=vas.survey_id " 
                    +"WHERE vas.veteran_assessment_id = :veteranAssessmentId " 
                    +"%s"  
                    +"AND m.measure_type_id IN ( " + Measure.COUNTED_MEASURE_TYPES + " ) " 
                    +"AND isnull(vamv.is_visible, 1) = 1 "
                    +"GROUP BY spm.survey_page_id, spm.measure_id " 
                +") all_measures " 
                +"LEFT OUTER JOIN ( " 
                   /* Business rules are: if table parent question contains a non-false answer we include it; if an entire row 
                      of child questions have at least one true or non-null we return the parent;  if there is any number 
                      of completed rows but at least one that is incomplete we don't include the parent */
                    +"SELECT DISTINCT spm.measure_id "
                    +"FROM survey_measure_response smr " 
                    +"INNER JOIN measure m ON smr.measure_id=m.measure_id " 
                    +"INNER JOIN survey_page_measure spm on isnull(m.parent_measure_id, m.measure_id)=spm.measure_id " 
                    +"INNER JOIN survey s ON smr.survey_id=s.survey_id " 
                    +"WHERE smr.veteran_assessment_id = :veteranAssessmentId " 
                    +"%s"  
                    +"AND m.measure_type_id IN ( " + Measure.COUNTED_MEASURE_TYPES + " ) " 
                    +"AND ( " 
                        +"(spm.measure_id=smr.measure_id AND (smr.boolean_value = 1 OR smr.number_value IS NOT NULL OR smr.text_value IS NOT NULL) ) "
                        +"OR ( " /* check to see if this is a parent with answered children */
                              
                            /* used to make sure the second sub-query contains at least one answer 
                               (i.e. when no child answers have been given the second sub-query will be true which we don't want) */
                            +"0 NOT IN ( "
                                    +"SELECT COUNT(*) FROM survey_measure_response smr2 "
                                    +"INNER JOIN measure m ON smr2.measure_id=m.measure_id "   
                                    +"WHERE smr2.veteran_assessment_id = :veteranAssessmentId "
                                    +"AND m.parent_measure_id = spm.measure_id ) "
                            +"AND "
                                 /* collect responses grouped by measure and tabular row. Get sum of the number of answers. 
                                    If a row has a 0 then that row had no answer for that measure */
                                +"0 NOT IN ( "
                                    +"SELECT sum(case when smr2.boolean_value = 1 OR smr2.number_value IS NOT NULL OR smr2.text_value IS NOT NULL then 1 else 0 end) answer_count "
                                    +"FROM measure m "
                                    +"LEFT JOIN (SELECT * FROM survey_measure_response smr2 WHERE smr2.veteran_assessment_id = :veteranAssessmentId) smr2 " 
									+"ON smr2.measure_id=m.measure_id "    
                                    +"WHERE m.parent_measure_id = spm.measure_id "
                                    +"AND m.measure_type_id IN ( " + Measure.COUNTED_MEASURE_TYPES + " ) "
                                    +"GROUP BY smr2.measure_id, smr2.tabular_row ) "
                        +") "
                    +") "
                +") answered_measures " 
                +"ON answered_measures.measure_id=all_measures.measure_id " 
            +") measure_compare group by survey_page_id ) survey_page_measure_count "
      +"INNER JOIN survey_page sp ON survey_page_measure_count.survey_page_id=sp.survey_page_id " 
      +"INNER JOIN survey s on sp.survey_id=s.survey_id " 
      +"ORDER BY s.display_order_for_section, sp.page_number";
}
