package com.xoa.service.meeting;

import com.xoa.model.meet.MeetingEquuipment;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;

/**
 *    创建作者:      高亚峰
 *    创建日期：     2017-07-28 13:56
 *    类介绍：       会议设备管理
 *    构造参数：
 *
 */
public interface MeetEquuipmentService {

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月28日 下午13:40:41
     * 方法介绍:   查询所有会议设备
     * 参数说明:   map 分页参数
     * @return    HrStaffContract
     */
    public ToJson<MeetingEquuipment> getAllEquip(Integer page,Integer pageSize,boolean useFlag);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月28日 下午14:14:41
     * 方法介绍:   查询会议设备详细信息BySId
     * 参数说明:    Sid 自动自增的唯一字段
     * @return    ToJson<MeetingEquuipment>
     */
    public ToJson<MeetingEquuipment> getdetailEquiet(String Sid);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月28日 下午14:50:41
     * 方法介绍:   更新会议设备的名称
     * 参数说明:    MeetingEquuipment 需要修改的参数
     * @return    ToJson<Object>
     */
    public ToJson<Object> updateEquiet(HttpServletRequest request,MeetingEquuipment meetingEquuipment);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月28日 下午15:00:41
     * 方法介绍:   批量删除会议设备
     * 参数说明:   Sid 自动自增的唯一字段
     * @return    ToJson<Object>
     */
    public ToJson<Object> deleteEquiets(HttpServletRequest request,String Sids);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月28日 下午15:30:41
     * 方法介绍:   添加会议设备
     * 参数说明:    MeetingEquuipment 需要添加的参数
     * @return    ToJson<Object>
     */
    public ToJson<Object> addEquiet(HttpServletRequest request, MeetingEquuipment meetingEquuipment);

    /**
     * @作者 廉立深
     * @时间 2020-08-12
     * @方法介绍 根据设备名称串查询设备ID
     */
    String getEquietId(String name);
}
