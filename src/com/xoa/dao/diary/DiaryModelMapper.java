package com.xoa.dao.diary;

import com.xoa.model.diary.DiaryModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


public interface DiaryModelMapper {

	//根据上级部门Id查询
	List<String> findChildDept(@Param("deptParent") String deptParent);

	//查询比自己大的角色,返回角色Ids
	String findDauserPrivs(@Param("privNo") String privNo);

	//优化工作日志
	List<DiaryModel> findDiarySelf(Map diaryMap);

	Integer findDiarySelfCount(Map diaryMap);

	//根据部门角色人员查询userId @Param("viewDepts") String viewDepts,@Param("viewPrivs") String viewPrivs,@Param("viewUsers") String viewUsers
	String findDiaryUserId(Map map);

	List<String> selectDiaryUserId(Map map);

	String selectDiaryUserTopIdByUserPriv(Map<String, Object> map);

	List<DiaryModel> getDiarySelf(Map<String, Object> diaryMap);



	List<DiaryModel> getDiaryList(Map<String, Object> diaryMap);

	List<DiaryModel> getAdminDiaryList(Map<String, Object> diaryMap);

	List<DiaryModel> getDiaryOtherList(Map<String, Object> diaryMap);

	Integer getDiaryOtherListCount(Map<String, Object> diaryMap);

	List<DiaryModel> getAdminDiaryOtherList(Map<String, Object> diaryMap);

	Integer getAdminDiaryOtherListCount(Map<String, Object> diaryMap);


	DiaryModel getDiaryByDiaId(DiaryModel diaryModel);



	int updateDiary(DiaryModel diaryModel);



	int saveDiary(DiaryModel diaryModel);



	int updateReadersByDiaId(DiaryModel diaryModel);



	int deletDiaById(DiaryModel diaryModel);



	int getCountSelf(Map<String, Object> diaryMap);



	List<DiaryModel> getAdminCountOther(Map<String, Object> otherdiaryMap);

	Integer  getAdminCountDiartOther(Map<String, Object> otherdiaryMap);

	List<DiaryModel> getCountOther(Map<String, Object> otherdiaryMap);


	Integer getCountDiaryOther(Map<String, Object> otherdiaryMap);


	List<String> getDeptUserId(Map<String, Object> mapParam);



	List<String> getUserIdByPriv(List<String> asList);



	List<DiaryModel> diarySelectFour(Map<String, Object> diaryMap);



	List<DiaryModel> diarySelectThree(Map<String, Object> diaryMap);


	List<DiaryModel> diarySelectTwo(Map<String, Object> diaryMap);


	List<DiaryModel> diarySelectOne(Map<String, Object> diaryMap);



	List<DiaryModel> diarySelectFive(Map<String, Object> diaryMap);



	List<String> selectName(List<String> toIdsl);

	/**
	 * @作者：张航宁
	 * @时间：2017/7/20
	 * @介绍：查询该日志下的浏览用户
	 * @参数：
	 */
	DiaryModel getReadUsers(Integer diaId);

	List<DiaryModel> selectShareName(@Param("userId") String userId);

	List<DiaryModel> getDiaryListByIds(Map<String, Object> diaryMap);

	Integer getDiaryListByIdsCount(Map<String, Object> diaryMap);

	Integer getDiaryListByIdsCount2(Map<String, Object> diaryMap);

	DiaryModel getDiaryById(String id);

	Integer getCountDiarySubord(String[] ids);

	Integer diarySelectTwoCounts(Map<String, Object> diaryMap);

	List<String> diarySelectOneUser(Map<String, Object> diaryMap);

	List<DiaryModel> diaryQuery(Map<String, Object> map);

	DiaryModel reportStatistic(Map<String, Object> map);

	DiaryModel statisticsDiaryNumber(String userId);

	List<DiaryModel> selectDiaryComment(String userId);

	List<DiaryModel> getNotCommentDiary(Map<String, Object> map);

	List<DiaryModel> selectDiaryMonthlyReport(Map<String, Object> map);

	List<DiaryModel> selectDiaryWeeklyReport(Map<String, Object> map);

	List<DiaryModel> selectDiaryDailyReport(Map<String, Object> map);

	DiaryModel selectDiaryModelByDiaId(Integer diaId);

	String selectDeptIdByManager(String userId);

	String selectDiaryUserIdByUserHierarchy(Map<String, Object> map);

	List<DiaryModel> mobileTerminalOtherPeople(Map<String, Object> map);

	List<DiaryModel> mobileTerminalOneself(Map<String, Object> map);

    List<DiaryModel> mobileTerminalCommentDiary(Map<String, Object> map);

	List<DiaryModel> selectDiaryByUserId(Map<String, Object> map);

    DiaryModel selectDiaPre(@Param("userId")String userId,@Param("diaDate")String diaDate);

	DiaryModel selectDiaNext(@Param("userId")String userId,@Param("diaDate")String diaDate);

    List<DiaryModel> reportStatisticExcelDiary(@Param("diaIds")String[] diaIds);

	List<DiaryModel> mobileTerminaluserBottomDiary(Map<String, Object> map);

	List<DiaryModel> diaryAdvancedQuery(Map<String, Object> map);


	List<DiaryModel> querySubject(Map<String, Object> map);
	List<String>  queryFile(Map<String, Object> map);
}