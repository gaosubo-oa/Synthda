package com.xoa.service.myNotify;

import com.xoa.model.myNotify.MyNotifyOpinionWithBLOBs;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface MyNotifyOpinionService {

    ToJson addOpinion(MyNotifyOpinionWithBLOBs notifyOpinion,String specifyTable);

    MyNotifyOpinionWithBLOBs selectByNotiId(int notiId, String userId, String sqlType,String specifyTable);

    int updateOpinion(MyNotifyOpinionWithBLOBs notifyOpinion,String specifyTable);

    int returnOpinion(int notifyId, String userId,String specifyTable);

    List<MyNotifyOpinionWithBLOBs> selectByNotiIdList(HttpServletRequest request, int notyId,String specifyTable);

    ToJson urgeOpin(HttpServletRequest request, int notifyId, String userIds,String specifyTable);

    ToJson outputNotifyOpins(HttpServletRequest request, HttpServletResponse response, int notifyId,String specifyTable);

    ToJson downLoadZipAttachment(HttpServletRequest request, HttpServletResponse response, int notifyId,String specifyTable);

}
