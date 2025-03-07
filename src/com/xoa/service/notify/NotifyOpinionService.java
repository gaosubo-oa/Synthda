package com.xoa.service.notify;

import com.xoa.model.notify.NotifyOpinionWithBLOBs;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface NotifyOpinionService {

    ToJson addOpinion(NotifyOpinionWithBLOBs notifyOpinion);

    NotifyOpinionWithBLOBs selectByNotiId(int notiId ,String userId,String sqlType);

    int updateOpinion(NotifyOpinionWithBLOBs notifyOpinion);

    int returnOpinion(HttpServletRequest request,int notifyId ,String userId,String returnComments);

    List<NotifyOpinionWithBLOBs> selectByNotiIdList(HttpServletRequest request ,int notyId );

    ToJson urgeOpin(HttpServletRequest request ,int notifyId ,String userIds );

    ToJson outputNotifyOpins(HttpServletRequest request , HttpServletResponse response ,int notifyId );

    ToJson downLoadZipAttachment(HttpServletRequest request , HttpServletResponse response ,int notifyId );

}
