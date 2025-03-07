package com.xoa.service.officesupplies;

import com.xoa.dao.officesupplies.OfficeAllocateMapper;
import com.xoa.dao.officesupplies.OfficeProductsMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.officesupplies.OfficeAllocate;
import com.xoa.model.officesupplies.OfficeProductsWithBLOBs;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.users.Users;
import com.xoa.service.sms.SmsService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OfficeAllocateService {

    @Resource
    private OfficeAllocateMapper officeAllocateMapper;

    @Resource
    private OfficeProductsMapper officeProductsMapper;
    @Resource
    private UsersMapper usersMapper;
    @Resource
    private SmsService smsService;
    public ToJson selectByMap(HttpServletRequest request, Integer page, Integer pageSize, String approvalStatus, String beginDate, String endDate, String subName) {
        ToJson json = new ToJson(1, "error");
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            Map<String, Object> map = new HashMap<>();
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(true);
            map.put("page", pageParams);
            map.put("approvalStatus", approvalStatus);
            if (!StringUtils.checkNull(beginDate)) {
                map.put("beginDate", beginDate);
            }
            if (!StringUtils.checkNull(endDate)) {
                map.put("endDate", endDate);
            }
            map.put("subName", subName);
            map.put("userId", users.getUserId());
            List<OfficeAllocate> officeAllocates = officeAllocateMapper.selectByMap(map);
            for (OfficeAllocate officeAllocate : officeAllocates) {

                Integer proIdOut = officeAllocate.getProIdOut();
                 if (proIdOut!=null){
                     OfficeProductsWithBLOBs officeProductsWithBLOBs = officeProductsMapper.selectByPrimaryKey(proIdOut);
                     if (officeProductsWithBLOBs!=null){
                         officeAllocate.setProDesc( officeProductsWithBLOBs.getProDesc());
                     }

                 }
                String creator = officeAllocate.getCreator();
                if(!StringUtils.checkNull(creator)){
                    Users user= usersMapper.getUserId(creator);
                    if (user != null) {
                        officeAllocate.setCreatorName(user.getUserName());
                    }
                }
                String auditer = officeAllocate.getAuditer();
                if(!StringUtils.checkNull(auditer)){
                    Users user = usersMapper.getUserId(auditer);
                    if (user != null) {
                        officeAllocate.setAuditerName(user.getUserName());
                    }
                }
            }
            json.setMsg("ok");
            json.setObj(officeAllocates);
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }


    public ToJson insertSelective(OfficeAllocate officeAllocate) {
        ToJson json = new ToJson(1, "error");
        try {
            OfficeProductsWithBLOBs pro=officeProductsMapper.selectByPrimaryKey(officeAllocate.getProIdOut());
            if(pro!=null){//除采购入库外，其他类型需要判断其库存和最低警戒库存的数量
                if(pro.getProStock()!=null){
                    if((pro.getProStock() - Integer.valueOf(officeAllocate.getAllocateNum())) < 0){
                        json.setMsg("numNoEnough");
                        return json;
                    }
                }
            }else {
                return json;
            }
            int i = officeAllocateMapper.insertSelective(officeAllocate);

                //审批事务
                // 提醒
                //向sms_body插入提醒数据
                SmsBody smsBody = new SmsBody();
                smsBody.setFromId(officeAllocate.getCreator());
                smsBody.setSmsType("24");
                smsBody.setContent("请查看办公库存调拨信息");
                smsBody.setSendTime((int)(System.currentTimeMillis() / 1000));
                smsBody.setRemindUrl("/officetransHistory/transfers");
                if(officeAllocate.getAuditer()!=null) {
                    smsService.saveSms(smsBody, officeAllocate.getAuditer(), "1", "0", "", "", "");
                 }
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }


    public ToJson updateSelective(OfficeAllocate officeAllocate) {
        ToJson json = new ToJson(1, "error");

        try {
            if (officeAllocate != null && officeAllocate.getId() != null) {

                OfficeAllocate officeAllocate1 = officeAllocateMapper.selectById(officeAllocate.getId());
                if ("1".equals(officeAllocate.getApprovalStatus())) {
                 if (officeAllocate1.getProIdIN()==null){
                     //新增库存
                     OfficeProductsWithBLOBs officeProductOut = officeProductsMapper.selectByPrimaryKey(officeAllocate1.getProIdOut());
                     if (officeProductOut != null) {
                         if((officeProductOut.getProStock() - Integer.valueOf(officeAllocate1.getAllocateNum())) < 0){
                             json.setMsg("numNoEnough");
                             return json;
                         }
                         officeProductOut.setProStock(officeProductOut.getProStock()- Integer.valueOf(officeAllocate1.getAllocateNum()));
                         officeProductsMapper.updateByPrimaryKeySelective(officeProductOut);
                         officeProductOut.setProStock(Integer.valueOf(officeAllocate1.getAllocateNum()));
                         officeProductOut.setOfficeProtype(officeAllocate1.getOffcieProTypeIn());
                         officeProductOut.setProId(null);
                         officeProductsMapper.insertSelective(officeProductOut);
                     }else {
                         return json;
                     }
                 }else {
                     // 修改当前库存
                     OfficeProductsWithBLOBs officeProductOut = officeProductsMapper.selectByPrimaryKey(officeAllocate1.getProIdOut());
                     OfficeProductsWithBLOBs officeProductIn = officeProductsMapper.selectByPrimaryKey(officeAllocate1.getProIdIN());
                     if (officeProductOut != null && officeProductIn != null) {
                         if((officeProductOut.getProStock() - Integer.valueOf(officeAllocate1.getAllocateNum())) < 0){
                             json.setMsg("numNoEnough");
                             return json;
                         }
                         officeProductOut.setProStock(officeProductOut.getProStock()- Integer.valueOf(officeAllocate1.getAllocateNum()));
                         officeProductsMapper.updateByPrimaryKeySelective(officeProductOut);
                         officeProductIn.setProStock(officeProductOut.getProStock()+Integer.valueOf(officeAllocate1.getAllocateNum()));
                         officeProductsMapper.updateByPrimaryKeySelective(officeProductIn);
                     } else {
                         return json;
                     }
                 }
                    int i = officeAllocateMapper.updateStatus(officeAllocate);
                    SmsBody smsBody = new SmsBody();
                    smsBody.setFromId(officeAllocate.getAuditer());
                    smsBody.setSmsType("24");
                    smsBody.setContent("请查看办公库存调拨信息");
                    smsBody.setSendTime((int)(System.currentTimeMillis() / 1000));
                    smsBody.setRemindUrl("/officetransHistory/transfers");
                    if(officeAllocate.getAuditer()!=null) {
                        smsService.saveSms(smsBody, officeAllocate.getCreator(), "1", "0", "", "", "");
                    }
                } else if ("0".equals(officeAllocate1.getApprovalStatus())&&"2".equals(officeAllocate.getApprovalStatus())) {
                    int i = officeAllocateMapper.updateStatus(officeAllocate);
                    SmsBody smsBody = new SmsBody();
                    smsBody.setFromId(officeAllocate.getAuditer());
                    smsBody.setSmsType("24");
                    smsBody.setContent("请查看办公库存调拨信息");
                    smsBody.setSendTime((int)(System.currentTimeMillis() / 1000));
                    smsBody.setRemindUrl("/officetransHistory/transfers");
                    if(officeAllocate.getAuditer()!=null) {
                        smsService.saveSms(smsBody, officeAllocate.getCreator(), "1", "0", "", "", "");
                    }
                } else if ("0".equals(officeAllocate1.getApprovalStatus())&&"3".equals(officeAllocate.getApprovalStatus())) {
                    int i = officeAllocateMapper.updateStatus(officeAllocate);
                }else if ("0".equals(officeAllocate1.getApprovalStatus())&&StringUtils.checkNull(officeAllocate.getApprovalStatus())){
                    int i = officeAllocateMapper.updateSelective(officeAllocate);
                }else {
                    return json;
                }

            }
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

}
