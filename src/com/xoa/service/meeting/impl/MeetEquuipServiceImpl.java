package com.xoa.service.meeting.impl;

import com.xoa.dao.meet.MeetingEquuipmentMapper;
import com.xoa.model.meet.MeetingEquuipment;
import com.xoa.service.meeting.MeetEquuipmentService;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/7/28 14:00
 * 类介绍  :   会议设备管理模块
 * 构造参数:
 */
@Service
public class MeetEquuipServiceImpl implements MeetEquuipmentService {

    @Resource
    private MeetingEquuipmentMapper meetingEquuipmentMapper;


    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月28日 下午13:40:41
     * 方法介绍:   查询所有会议设备
     * 参数说明:   map 分页参数
     * @return    HrStaffContract
     */
    @Override
    public ToJson<MeetingEquuipment> getAllEquip(Integer page, Integer pageSize, boolean useFlag) {

        ToJson<MeetingEquuipment> json =new ToJson<MeetingEquuipment>();
        Map<String,Object> map =new HashMap<String,Object>();
        PageParams pageParams =new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        map.put("page", pageParams);
        try {
            List<MeetingEquuipment> allequuip = meetingEquuipmentMapper.getAllequuip(map);
            json.setObj(allequuip);
            json.setFlag(0);
            json.setMsg("ok");
            if (pageParams.getTotal() == null) {
                json.setTotleNum(0);
            } else {
                json.setTotleNum(pageParams.getTotal());
            }
        } catch (Exception e) {
            json.setObj(null);
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月28日 下午14:14:41
     * 方法介绍:   查询会议设备详细信息BySId
     * 参数说明:    Sid 自动自增的唯一字段
     * @return    ToJson<MeetingEquuipment>
     */
    @Override
    public ToJson<MeetingEquuipment> getdetailEquiet(String Sid) {
        ToJson<MeetingEquuipment> json =new ToJson<MeetingEquuipment>();
        if(Sid!=null && Sid!=""){
            try {
                MeetingEquuipment meetingEquuipment = meetingEquuipmentMapper.getdetailEquiet(Integer.valueOf(Sid));
                json.setFlag(0);
                json.setObject(meetingEquuipment);
                json.setMsg("ok");
            } catch (NumberFormatException e) {
                json.setFlag(1);
                json.setObject(null);
                json.setMsg("err");
                e.printStackTrace();
            }
        }else{
            json.setFlag(1);
            json.setObject(null);
            json.setMsg("err");
        }
        return json;
    }

    @Override
    public ToJson<Object> updateEquiet(HttpServletRequest request,MeetingEquuipment meetingEquuipment) {
        ToJson<Object> json =new ToJson<Object>();
        if(meetingEquuipment!=null){
            try {
                meetingEquuipmentMapper.updatequuip(meetingEquuipment);
                json.setFlag(0);
                json.setMsg("ok");
            } catch (Exception e) {
                json.setFlag(1);
                json.setMsg("err");
                e.printStackTrace();
            }
        }else{
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    @Override
    public ToJson<Object> deleteEquiets(HttpServletRequest request,String Sids) {
        ToJson<Object> json =new ToJson<Object>();
            try {

                String[] split = Sids.split(",");
                if (split != null && split.length > 0) {
                    meetingEquuipmentMapper.deleteequuips(split);
                }

                json.setFlag(0);
                json.setMsg("ok");

            } catch (Exception e) {
                json.setFlag(1);
                json.setMsg("err");
                e.printStackTrace();
            }
        return json;
    }

    @Override
    public ToJson<Object> addEquiet(HttpServletRequest request, MeetingEquuipment meetingEquuipment) {
        ToJson<Object> json =new ToJson<Object>();
        try {
            meetingEquuipmentMapper.insertSelective(meetingEquuipment);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    /**
     * @作者 廉立深
     * @时间 2020-08-12
     * @方法介绍 根据设备名称串查询设备ID
     */
    @Override
    public String getEquietId(String name) {
        if (StringUtils.checkNull(name)){
            return "";
        }

        return meetingEquuipmentMapper.getEquietId(name.split(","));
    }
}
