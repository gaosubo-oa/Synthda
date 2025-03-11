package com.xoa.dao.im;

import com.xoa.model.im.ImChatData;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


public interface ImChatDataMapper {

    int saveChat(ImChatData chatModel);

    List<String> getSingleObject(Map<String, Object> map);

    int updateChatlist(ImChatData chatModel);

    List<Object> getChatList(Map<String, Object> map);

    List<Object> getChatAllList(Map<String, Object> map);

    int getSingleObjectInt(Map<String, Object> map);

    ImChatData getSingleByListId(Map<String, Object> map);

    ImChatData getPriv(Map<String, Object> map);

    /**
     * @创建作者: 牛江丽
     * @创建日期: 2017/12/25 15:15
     * @函数介绍: 根据ofFrom查询
     * @参数说明: @param map
     * @return: List
     **/
    List<Object> getChatListByFrom(Map<String, Object> map);

    int getCountSingleObject(Map<String, Object> map);

    List<String> getDataSingleObject(Map<String, Object> map);
    /**
     * @创建作者: 牛江丽
     * @创建日期: 2017/12/25 15:15
     * @函数介绍: 查询群聊记录的listId
     * @参数说明: @param map
     * @return: List
     **/
    String getDatagroupObject(@Param("toUid") String toUid);

    /**
     * @创建作者: 牛江丽
     * @创建日期: 2017/12/25 15:15
     * @函数介绍: 根据listId修改uidIgnore
     * @参数说明: @param map
     * @return: List
     **/
    int upChatByIgnore(Map<String, Object> map);

    /**
     * @创建作者: 牛江丽
     * @创建日期: 2017/12/25 15:15
     * @函数介绍: 根据listId进行查询
     * @参数说明: @param map
     * @return: List
     **/
    ImChatData selChatByListId(int listId);

    ImChatData getGroupByToUid(@Param("toUid") String toUid);


    ImChatData getDataSingleByUid(Map<String,Object> map);

    List<String> getMsgFreeByUid(Map<String,Object> map);

    ImChatData queryListByCon(Map<String,Object> map);

}