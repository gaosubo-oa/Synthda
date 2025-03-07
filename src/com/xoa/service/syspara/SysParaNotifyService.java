package com.xoa.service.syspara;

import com.xoa.model.notify.Notify;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;

/**
 *
 * @ClassName (类名):  SysParaNotifyService
 * @Description(简述): 公告审批模块接口
 * @author(作者):      刘新婷
 * @date(日期):        2017-11-20
 * 公告通知设置
 */
@Service
public interface SysParaNotifyService {
    /**
     * @Description: 更新公告通知设置业务方法
     * @author:  刘新婷
     * @date:  2017-11-20
     * @param singls
     * @param manager
     * @param edit
     * @param userIds
     * @return
     */
    public ToJson<Object> editNotify(String singls,String manager,String edit,String userIds ,String exceptionUserIds);

    /**
     * @Description: 编辑公告通知设置业务接口
     * @author:  刘新婷
     * @date:  2017-11-20
     * @return
     */
    public ToJson<Object> selectNotify();

    /**
     * @Description: 查询本部门主管人员和指定可审批公告人员业务处理接口
     * @author:  刘新婷
     * @date:  2017-11-21
     * @return
     */
    public ToJson<Object> getDeptManagers(HttpServletRequest request);

    /**
     * @Description: 根据公告类型查询已审批公告业务处理接口
     * @author:  刘新婷
     * @date:  2017-11-21
     * @param typeId
     * @param start
     * @param size
     * @return
     */
    public ToJson<Notify> getApprovedNotifyList(String typeId,Integer start,Integer size,Integer page,Integer pageSize,Boolean useFlag,HttpServletRequest request);

    /**
     * @Description: 根据公告类型查询待审批公告业务处理接口
     * @author:  刘新婷
     * @date:  2017-11-22
     * @param typeId
     * @param start
     * @param size
     * @return
     */
    public ToJson<Notify> getPendingNotifyList(String typeId, Integer start, Integer size,Integer page,Integer pageSize,Boolean useFlag,HttpServletRequest request);

    /**
     * @Description: 获取公告类型业务处理接口
     * @author:  刘新婷
     * @date:  2017-11-24
     * @return
     */
    public ToJson<Object> getNotifyTypeList(HttpServletRequest request);

    ToJson<Object> getNotifyCode( HttpServletRequest request);
}