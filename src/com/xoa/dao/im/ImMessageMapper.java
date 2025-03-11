package com.xoa.dao.im;

import com.xoa.model.im.ImMessage;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ImMessageMapper {

	int deleteByUuid(Map<String, Object> map);

	List<ImMessage> getMessageList(Map<String, Object> map);

	List<ImMessage> getGroupMessage(Map<String, Object> map);

	List<ImMessage> getGroupMessageAll(Map<String, Object> map);

	int save(ImMessage record);

	ImMessage getLastMessage(Map<String, Object> map);

	List<ImMessage> getLastMessage1(Map<String, Object> map);

	List<ImMessage> selectMessageByPage(Map<String, Object> map);

	List<ImMessage> selectMessageByPageAll(Map<String, Object> map);

	List<ImMessage> getAttchments(Map<String, Object> map);

	List<ImMessage> selectMessage(Map<String, Object> map);

	/**
	 * @创建作者: 牛江丽
	 * @创建日期: 2017/12/25 15:15
	 * @函数介绍: 根据uuid查询
	 * @参数说明: @param map
	 * @return: ImMessage
	 **/
	ImMessage getMessageByLast(Map<String, Object> map);

	List<ImMessage> getAllGroupMessage(String toId);

	int upMessageByType(Map<String,Object> map);

	int updateDeleteFlagByUUID(@Param("uuid")String uuid);


	List<ImMessage> querySubject(Map<String, Object> map);

	List<String> queryFile(Map<String, Object> map);
}