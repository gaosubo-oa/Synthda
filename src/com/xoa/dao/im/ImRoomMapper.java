package com.xoa.dao.im;

import com.xoa.model.im.ImRoom;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


public interface ImRoomMapper {
	List<ImRoom> getAllRoom(Map<String, String> map);

	ImRoom getRoomByRoomOf(Map<String, String> map);

	int roomUpdateInvite(Map<String, String> map);

	int saveRoom(ImRoom ir);

	int roomUpdateByroomOf(ImRoom irm);

	int updateRoomName(ImRoom irm);

	int updatePersonToRoom(ImRoom irm);

	/**
	 * @创建作者: 牛江丽
	 * @创建日期: 2017/12/25 15:15
	 * @函数介绍: 根据roomOf和群成员查询
	 * @参数说明: @param map
	 * @return: ImRoom
	 **/
	ImRoom selRoomByRoomOfUid(Map<String,Object> map);

	/**
	 * @创建作者: 韩东堂
	 * @函数介绍: 获取全部的房间信息
	 * @参数说明: @param map
	 * @return: ImRoom
	 */
	List<ImRoom> getAllRoomByAdmin();

    void updateRoomMember(ImRoom irm);

	List<ImRoom> getAllRoomWithCreater(@Param("userId") Integer userId);

}