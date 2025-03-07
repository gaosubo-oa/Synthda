package com.xoa.service.officesupplies;

import com.alibaba.fastjson.JSONObject;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.officesupplies.OfficeInventoryInfoMapper;
import com.xoa.dao.officesupplies.OfficeProductsMapper;
import com.xoa.dao.officesupplies.OfficeTranshistoryMapper;
import com.xoa.dao.officesupplies.OfficeTypeMapper;
import com.xoa.dao.sms.SmsBodyMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.officesupplies.*;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.users.Users;
import com.xoa.service.sms.SmsService;
import com.xoa.util.*;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.page.PageParams;
import net.sf.json.JSONArray;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 *
 * 创建作者:   高亚峰
 * 创建日期:   2017/10/8 13:37
 * 类介绍  :   办公用品申请记录
 * 构造参数:
 */
@Service
public class OfficeTransHistoryService {

    @Resource
    private OfficeTranshistoryMapper officeTranshistoryMapper;
    @Resource
    private OfficeTypeMapper officeTypeMapper;
    @Resource
    private OfficeProductsMapper  officeProductsMapper;

    @Resource
    private UsersMapper usersMapper;

    @Resource
    private DepartmentMapper departmentMapper;

    @Resource
    private SmsService smsService;
    @Resource
    private SmsBodyMapper smsBodyMapper;
    @Resource
    ThreadPoolTaskExecutor threadPoolTaskExecutor;

    @Resource
    private OfficeInventoryInfoMapper officeInventoryInfoMapper;

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/08 13:44
     * 类介绍  :   申请办公用品(flag分为自己申请1，代登记2，维护3)
     * 构造参数:
     */
    public ToJson<Object> insertObject(HttpServletRequest request,OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs,int flag){
        ToJson <Object> json =new ToJson<Object>(1,"err");
        try {
            OfficeProductsWithBLOBs temp=new OfficeProductsWithBLOBs();
            temp.setProId(officeTranshistoryWithBLOBs.getProId());
            temp.setOfficeProtype(String.valueOf(officeTranshistoryWithBLOBs.getTypeId()));
            temp.setDepositoryId(String.valueOf(officeTranshistoryWithBLOBs.getDepositoryId()));
            OfficeProductsWithBLOBs pro=officeProductsMapper.selByDepoAndTypeAndPro(temp);
            if(officeTranshistoryWithBLOBs.getTransQty()==null){
                officeTranshistoryWithBLOBs.setTransQty(1);
            }
            if(!StringUtils.checkNull(officeTranshistoryWithBLOBs.getTransFlag()) && !officeTranshistoryWithBLOBs.getTransFlag().equals("3")){//除采购入库外，其他类型需要判断其库存和最低警戒库存的数量
                if(pro!=null){
                    if((pro.getProStock() - officeTranshistoryWithBLOBs.getTransQty()) < 0){
                        json.setMsg("numNoEnough");
                        return json;
                    }
                }
            }else if(!StringUtils.checkNull(officeTranshistoryWithBLOBs.getTransFlag()) && officeTranshistoryWithBLOBs.getTransFlag().equals("3")){//采购入库，需要判断其最够警戒库存数
                if(pro!=null && pro.getProMaxstock()!=null && pro.getProMaxstock()!=0){
                    if((pro.getProStock()+officeTranshistoryWithBLOBs.getTransQty())>pro.getProMaxstock()){
                        json.setMsg("numMax");
                        return json;
                    }
                }
            }
            //从session中获取当前登录人的信息
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            if(flag==1){
                officeTranshistoryWithBLOBs.setBorrower(users.getUserId());
            }
            if(!StringUtils.checkNull(officeTranshistoryWithBLOBs.getBorrower())){
                if(officeTranshistoryWithBLOBs.getBorrower().contains(",")){
                    officeTranshistoryWithBLOBs.setBorrower(officeTranshistoryWithBLOBs.getBorrower().substring(0,officeTranshistoryWithBLOBs.getBorrower().length()-1));
                }
            }
            //申请人所属部门
            Users borrowUser=null;
            if(!StringUtils.checkNull(officeTranshistoryWithBLOBs.getBorrower())){
                borrowUser=usersMapper.getUserId(officeTranshistoryWithBLOBs.getBorrower());
            }

            if(borrowUser!=null){
                officeTranshistoryWithBLOBs.setDeptId(borrowUser.getDeptId());
            }
            if(!StringUtils.checkNull(officeTranshistoryWithBLOBs.getDeptManager())){
                if(officeTranshistoryWithBLOBs.getDeptManager().contains(",")){
                    officeTranshistoryWithBLOBs.setDeptManager(officeTranshistoryWithBLOBs.getDeptManager().substring(0,officeTranshistoryWithBLOBs.getDeptManager().length()-1));
                }
            }
            officeTranshistoryWithBLOBs.setOperator(users.getUserId());
            Date date =new Date();
            officeTranshistoryWithBLOBs.setTransDate(date);
            if(!StringUtils.checkNull(officeTranshistoryWithBLOBs.getDeptManager())){
                officeTranshistoryWithBLOBs.setTransState("01");
            }else{
                officeTranshistoryWithBLOBs.setTransState("02");
            }
            officeTranshistoryWithBLOBs.setGetSubmitStatus("1");
            int i = officeTranshistoryMapper.insertSelective(officeTranshistoryWithBLOBs);
            if(pro!=null){
                if(!StringUtils.checkNull(officeTranshistoryWithBLOBs.getTransFlag()) && !officeTranshistoryWithBLOBs.getTransFlag().equals("3")) {//除采购入库外，其他类型需要将库存数量减少
                    pro.setProStock(pro.getProStock()-officeTranshistoryWithBLOBs.getTransQty());
                 }
//                else if(!StringUtils.checkNull(officeTranshistoryWithBLOBs.getTransFlag()) && officeTranshistoryWithBLOBs.getTransFlag().equals("3")) {//采购入库，需要将库存数量进行添加
//                    pro.setProStock(pro.getProStock()+officeTranshistoryWithBLOBs.getTransQty());
//                }
            }
            i+=officeProductsMapper.updateByPrimaryKeyWithBLOBs(pro);
            //审批事务
            // 提醒
            //向sms_body插入提醒数据
            String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            SmsBody smsBody = new SmsBody();
            smsBody.setFromId(users.getUserId());
            smsBody.setSmsType("24");
            smsBody.setContent("请查看办公审批信息");
            if (locale.equals("zh_CN")) {
                smsBody.setContent("请查看办公审批信息");
            } else if (locale.equals("en_US")) {
                smsBody.setContent("Please review the office approval information");
            } else if (locale.equals("zh_TW")) {
                smsBody.setContent("請查看辦公審批資訊");
            }
            smsBody.setSendTime((int)(System.currentTimeMillis() / 1000));
            smsBody.setRemindUrl("/officetransHistory/NoApproval?status=1&transId="+ officeTranshistoryWithBLOBs.getTransId());
            if(officeTranshistoryWithBLOBs.getDeptManager()!=null) {
                smsService.saveSms(smsBody, officeTranshistoryWithBLOBs.getDeptManager().toString(), "1", "0", "", "", "");
            }
            if(i>0){
                json.setFlag(0);
                json.setMsg("ok");
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/08 13:44
     * 类介绍  :   查询我的申请记录
     * 构造参数:
     */
    public ToJson<OfficeTranshistoryWithBLOBs> getMyHistroy(HttpServletRequest request,int page,int pageSize,boolean useFlag){
        ToJson <OfficeTranshistoryWithBLOBs> json =new ToJson<OfficeTranshistoryWithBLOBs>(1,"err");
        String reflag=request.getParameter("reflag");
        //从session中获取当前登录人的信息
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs =new OfficeTranshistoryWithBLOBs();
        officeTranshistoryWithBLOBs.setBorrower(users.getUserId());
        PageParams pageParams=new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        Map map=new HashMap();
        map.put("page",pageParams);
        map.put("officeTranshistoryWithBLOBs",officeTranshistoryWithBLOBs);
        String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try {
            List<OfficeTranshistoryWithBLOBs> myHistory=null;
            if("submit".equals(reflag)){
                 myHistory = officeTranshistoryMapper.getMyHistory(map);
            }else if("save".equals(reflag)){
                myHistory = officeTranshistoryMapper.getMyHistorys(map);
            }
            for(OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs1:myHistory){
                    //办公用品名称
                    Integer proId = officeTranshistoryWithBLOBs1.getProId();
                    if(proId!=null&&proId!=0){
                        OfficeProductsWithBLOBs officeProductsWithBLOBs = officeProductsMapper.selectByPrimaryKey(proId);
                        if(officeProductsWithBLOBs!=null){
                            officeTranshistoryWithBLOBs1.setProName(officeProductsWithBLOBs.getProName());
                        }else{
                            officeTranshistoryWithBLOBs1.setProName("已删除办公用品");
                        }
                    }else if(proId==0){
                        officeTranshistoryWithBLOBs1.setProName("申领暂存");
                    }
                    //登记类型
                    String transFlag = officeTranshistoryWithBLOBs1.getTransFlag();
                    if(!StringUtils.checkNull(transFlag)){
                        if(transFlag.equals("1")){
                            officeTranshistoryWithBLOBs1.setTransFlagName(I18nUtils.getMessage("vote.th.user"));
                        }else{
                            officeTranshistoryWithBLOBs1.setTransFlagName(I18nUtils.getMessage("vote.th.borrow"));
                        }
                    }
                    //状态
                    String transState = officeTranshistoryWithBLOBs1.getTransState();
                    if(!StringUtils.checkNull(transState)){
                            if (transState.equals("01")) {
                                officeTranshistoryWithBLOBs1.setTransStateName(I18nUtils.getMessage("vote.th.ApprovalDepartment"));
                            } else if (transState.equals("02")) {
                                officeTranshistoryWithBLOBs1.setTransStateName(I18nUtils.getMessage("vote.th.ToAdministrator"));
                            } else if (transState.equals("1")) {
                                officeTranshistoryWithBLOBs1.setTransStateName(I18nUtils.getMessage("license.Approved"));
                                if (transState.equals("0")) {
                                    officeTranshistoryWithBLOBs1.setGrantStatusName(I18nUtils.getMessage("vote.th.WaitDistribution"));
                                } else if (transState.equals("1")) {
                                    officeTranshistoryWithBLOBs1.setGrantStatusName(I18nUtils.getMessage("vote.th.AlreadyIssued"));
                                } else if (transState.equals("2")) {
                                    officeTranshistoryWithBLOBs1.setGrantStatusName(I18nUtils.getMessage("office.confirmed"));
                                }
                            } else if (transState.equals("21")) {
                                officeTranshistoryWithBLOBs1.setTransStateName(I18nUtils.getMessage("vote.th.DisapprovaApproval"));
                            } else if (transState.equals("22")) {
                                officeTranshistoryWithBLOBs1.setTransStateName(I18nUtils.getMessage("vote.th.StorekeeperDismissal"));
                            }
                    }

                    //部门审批人
                    String deptManager = officeTranshistoryWithBLOBs1.getDeptManager();
                    Users byuserId = usersMapper.getUserId(deptManager);
                    if(byuserId!=null){
                        officeTranshistoryWithBLOBs1.setDeptManagerName(byuserId.getUserName());
                    }
            }
            json.setTotleNum(pageParams.getTotal());
            json.setObj(myHistory);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/08 13:44
     * 类介绍  :   删除申请记录
     * 构造参数:
     */

    public ToJson<Object> deleteObject(Integer transId){
        ToJson<Object> json =new ToJson<Object>(1,"err");
        try {
            OfficeProductsWithBLOBs pro=null;
            OfficeTranshistoryWithBLOBs trans=officeTranshistoryMapper.selectByPrimaryKey(transId);
            if(!StringUtils.checkNull(trans.getTransState())&&trans.getTransState()!=""){
                if(trans.getTransState().equals("01") || trans.getTransState().equals("02")){
//
//                    OfficeProductsWithBLOBs temp=new OfficeProductsWithBLOBs();
//                    temp.setProId(trans.getProId());
//                    temp.setOfficeProtype(String.valueOf(trans.getTypeId()));
//                    temp.setDepositoryId(String.valueOf(trans.getDepositoryId()));
//                    pro=officeProductsMapper.selByDepoAndTypeAndPro(temp);
//                    if(pro!=null && trans.getTransFlag().equals("3")){ //采购入库
//                        pro.setProStock(pro.getProStock()-trans.getTransQty());
//                        officeProductsMapper.updateByPrimaryKeyWithBLOBs(pro);
//                    }
                }
            }
            int i = officeTranshistoryMapper.deleteByPrimaryKey(transId);
            if(i>0){
                //排除采购入库，删除完申领物品新增库存
                if(pro!=null && !trans.getTransFlag().equals("3")){
                    pro.setProStock(pro.getProStock()+trans.getTransQty());
                    officeProductsMapper.updateByPrimaryKeyWithBLOBs(pro);
                }
                json.setFlag(0);
                json.setMsg("ok");
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:  2017/10/08 13:44
     * 类介绍  :   编辑申请记录
     * 构造参数:
     */
    public ToJson<Object> editObject(OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs){
        ToJson<Object> json =new ToJson<Object>(1,"err");
        try {
            OfficeTranshistoryWithBLOBs trans=officeTranshistoryMapper.selectByPrimaryKey(officeTranshistoryWithBLOBs.getTransId());//原来申请的数量

            OfficeProductsWithBLOBs temp=new OfficeProductsWithBLOBs();
            temp.setProId(trans.getProId());
            temp.setOfficeProtype(String.valueOf(trans.getTypeId()));
            temp.setDepositoryId(String.valueOf(trans.getDepositoryId()));
            if(officeTranshistoryWithBLOBs.getTransQty()==null){
                officeTranshistoryWithBLOBs.setTransQty(1);
            }


            OfficeProductsWithBLOBs pro=officeProductsMapper.selByDepoAndTypeAndPro(temp);//获取办公用品的库存数量

            //思路：（办公用品库存+原申请数量-先现申请数量）和库存的最低警戒以及库存数量相比较
            if(!StringUtils.checkNull(trans.getTransFlag()) && !trans.getTransFlag().equals("3")){//除采购入库外，其他类型需要判断其库存和最低警戒库存的数量
                if(pro!=null){
                    if((pro.getProStock()+trans.getTransQty()-officeTranshistoryWithBLOBs.getTransQty())<pro.getProLowstock() && (pro.getProStock()+trans.getTransQty()-officeTranshistoryWithBLOBs.getTransQty())<0){
                        json.setMsg("numNoEnough");
                        return json;
                    }
                }
            }else if(!StringUtils.checkNull(trans.getTransFlag()) && trans.getTransFlag().equals("3")){//采购入库，需要判断其最够警戒库存数
                if(pro!=null && pro.getProMaxstock()!=null && pro.getProMaxstock()!=0){
                    if((pro.getProStock()-trans.getTransQty()+officeTranshistoryWithBLOBs.getTransQty())>pro.getProMaxstock()){
                        json.setMsg("numMax");
                        return json;
                    }
                }
            }
            if(!StringUtils.checkNull(officeTranshistoryWithBLOBs.getBorrower())){
                if(officeTranshistoryWithBLOBs.getBorrower().contains(",")){
                    officeTranshistoryWithBLOBs.setBorrower(officeTranshistoryWithBLOBs.getBorrower().substring(0,officeTranshistoryWithBLOBs.getBorrower().length()-1));
                }
            }
            if(!StringUtils.checkNull(officeTranshistoryWithBLOBs.getDeptManager())){
                if(officeTranshistoryWithBLOBs.getDeptManager().contains(",")){
                    officeTranshistoryWithBLOBs.setDeptManager(officeTranshistoryWithBLOBs.getDeptManager().substring(0,officeTranshistoryWithBLOBs.getDeptManager().length()-1));
                }
            }
            int i = officeTranshistoryMapper.updateByPrimaryKeySelective(officeTranshistoryWithBLOBs);
            if(i>0){
                //申请数修改完修改库存
                if (pro!=null && pro.getProStock()!=null && officeTranshistoryWithBLOBs.getTransQty()!=null){
                    if (trans.getTransFlag().equals("3")){ //采购入库
//                        pro.setProStock((pro.getProStock()+officeTranshistoryWithBLOBs.getTransQty())-trans.getTransQty()); //（原当前库存总数+修改的申请数）-原申请数=新库存
                    }else{
                        pro.setProStock((pro.getProStock()+trans.getTransQty())-officeTranshistoryWithBLOBs.getTransQty() ); //（原当前库存总数+原申请数）-修改的申请数=新库存
                    }
                    officeProductsMapper.updateByPrimaryKeySelective(pro);
                }
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:  2017/10/08 13:44
     * 类介绍  :   申请记录详情接口
     * 构造参数:
     */
    public ToJson<OfficeTranshistoryWithBLOBs> getObjectById(Integer transId){
        ToJson<OfficeTranshistoryWithBLOBs> json =new ToJson<OfficeTranshistoryWithBLOBs>(1,"err");
        try {
            OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs = officeTranshistoryMapper.selectByPrimaryKey(transId);
            String borrower = officeTranshistoryWithBLOBs.getBorrower();
            Users byuserId = usersMapper.getUserId(borrower);
            if(byuserId!=null){
                officeTranshistoryWithBLOBs.setBorrowerName(byuserId.getUserName());
            }
            //部门审批人
            String deptManager = officeTranshistoryWithBLOBs.getDeptManager();
            Users byuserId1 = usersMapper.getUserId(deptManager);
            if(byuserId1!=null){
                officeTranshistoryWithBLOBs.setDeptManagerName(byuserId1.getUserName());
            }
            json.setMsg("ok");
            json.setFlag(0);
            json.setObject(officeTranshistoryWithBLOBs);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 下午15:47:00
     * 方法介绍:   根据当前登录人查询待批申请
     * 参数说明:   @param currentUser 当前登录人
     * 返回值说明:
     */
    public ToJson<OfficeTranshistoryWithBLOBs> selTranshistoryByState(HttpServletRequest request,int page,int pageSize,boolean useFlag,OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs){
        ToJson<OfficeTranshistoryWithBLOBs> json = new ToJson<OfficeTranshistoryWithBLOBs>(1, "error");
        try{
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
           /* Map map=new HashMap();
            PageParams pageParams=new PageParams();
            pageParams.setPageSize(pageSize);
            pageParams.setPage(page);
            pageParams.setUseFlag(useFlag);
            map.put("currentUser",users.getUserId());
            map.put("page",pageParams);
            map.put("officeTranshistoryWithBLOBs",officeTranshistoryWithBLOBs);*/
            List<OfficeTranshistoryWithBLOBs> list=officeTranshistoryMapper.selTranshistoryByState(users.getUserId());
            List<OfficeTranshistoryWithBLOBs> list1=officeTranshistoryMapper.getMyHistoryss(users.getUserId());
            for (OfficeTranshistoryWithBLOBs transhistoryWithBLOBs : list1) {
                StringBuffer sb=new StringBuffer();
                com.alibaba.fastjson.JSONArray getGetSubmitList= com.alibaba.fastjson.JSONArray.parseArray(transhistoryWithBLOBs.getGetSubmitList());
                if(getGetSubmitList!=null){
                for (int i = 0; i < getGetSubmitList.size(); i++) {
                    JSONObject jsonObject=(JSONObject)getGetSubmitList.get(i);
                    Integer proId=Integer.valueOf(jsonObject.get("proId").toString());
                    OfficeProducts officeProducts=officeProductsMapper.getProName(proId);
                    sb.append(officeProducts.getProName()+",");
                }
                    transhistoryWithBLOBs.setProName(sb.substring(0,sb.length()-1));
                }
            }
            list.addAll(list1);
            for (OfficeTranshistoryWithBLOBs transhistoryWithBLOBs:list){
                Users eduUser=usersMapper.getUserId(transhistoryWithBLOBs.getBorrower());
                if(eduUser!=null){
                    transhistoryWithBLOBs.setBorrowerName(eduUser.getUserName());
                }
            }
            json.setTotleNum(list.size());
            json.setObj(getPageList(page,pageSize,list));
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("OfficeTransHistoryService selTranshistoryByState:"+e);
            e.printStackTrace();
        }
        return  json;
    }
    //业务层分页 yyl
    public List getPageList(Integer page, Integer limit, List list) {
        if(page!=null&&limit!=null&&page>0&&limit>0){
            List list1 = new ArrayList();
            if (page == 1 && list.size() <= limit) {
                return list;
            } else if (page == 1 && list.size() > limit) {
                for (int i = 0; i < limit; i++) {
                    list1.add(list.get(i));
                }
                return list1;

            } else if (page > 1) {
                if (list.size() / limit >= page) {
                    for (int i = 0; i < limit; i++) {
                        list1.add(list.get(limit * (page - 1) + i));

                    }
                    return list1;
                } else {
                    for (int i = 0; i < list.size()%limit; i++) {
                        list1.add(list.get(limit * (page - 1) + i));
                    }
                }
                return list1;

            } else {
                return null;
            }
        }else{
            return list;
        }
    }
    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 下午15:47:00
     * 方法介绍:   审批办公用品(批准：1，不批准：2)
     * 参数说明:   @param transhistory(transId,transState)
     * 返回值说明:
     */
    public ToJson<OfficeTranshistoryWithBLOBs> upTransHistoryState(String transState, String transIds, HttpServletRequest request){
        ToJson<OfficeTranshistoryWithBLOBs> json = new ToJson<OfficeTranshistoryWithBLOBs>(1, "error");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
        String proIds=request.getParameter("proIds");
        try{
            String[] transId = transIds.split(",");
            String[] proId=proIds.split(",");
            List<OfficeTranshistoryWithBLOBs> officeTranshistoryWithBLOBsList= officeTranshistoryMapper.selectByTransIds(transId);
            List<JSONObject> objects = new ArrayList<>();
            List<String> remindUrls = new ArrayList<>();
            for (int i = 0; i < transId.length; i++) {
                OfficeTranshistoryWithBLOBs transhistory = new OfficeTranshistoryWithBLOBs();
                int anInt = Integer.parseInt(transId[i]);
                int index=Integer.valueOf(proId[i]);
                transhistory.setTransId(anInt);
                OfficeTranshistoryWithBLOBs temp=new OfficeTranshistoryWithBLOBs();
                Optional<OfficeTranshistoryWithBLOBs> optional = officeTranshistoryWithBLOBsList.stream().filter((officeTranshistoryWithBLOBs) -> anInt==officeTranshistoryWithBLOBs.getTransId()
                ).findFirst();
                if(optional.isPresent()){
                    temp=  optional.get();
                }
                if (temp == null) {
                    continue;
                }
//                if(index!=0){
//                     temp=officeTranshistoryMapper.selectByPrimaryKey(anInt);
//                }else {
//                    temp=officeTranshistoryMapper.selectDetailed(anInt);
//                }
                String pd=temp.getTransState();
                if(("1").equals(transState)){//同意

                    if ((temp.getTransState().equals("02")) || (temp.getTransState().equals("01") && users.getUserPriv()==1)||index==0){ //超级管理员

                        transhistory.setTransState("1");
                        JSONObject object = new JSONObject();
                        object.put("manager",temp.getBorrower());
                        object.put("remindUrl","/officetransHistory/goMyOfficeApply?edit=1");
                        objects.add(object);
//                        SmsBody smsBody = new SmsBody();
//                        smsBody.setFromId(users.getUserId());
//                        smsBody.setSmsType("24");
//                        smsBody.setContent("您申领的办公用品已通过，请前往领取并确认");
//                        smsBody.setSendTime((int)(System.currentTimeMillis() / 1000));
//                        smsBody.setRemindUrl("/officetransHistory/goMyOfficeApply");
//                        smsService.saveSms(smsBody,temp.getBorrower(),"1","0","","","");

                    }else if(temp.getTransState().equals("01")){  //原来为待部门审批人审批状态01，则修改为待库管理员审批状态02
                        transhistory.setTransState("02");
//                        String manager= officeTranshistoryMapper.getManagerByTransId(anInt);
                        JSONObject object = new JSONObject();
                        object.put("manager",temp.getManager());
                        object.put("remindUrl","/officetransHistory/NoApproval?status=2&transId="+transhistory.getTransId());
                        objects.add(object);
//                        //审批事务
//                        // 提醒
//                        //向sms_body插入提醒数据
//                        SmsBody smsBody = new SmsBody();
//                        smsBody.setFromId(users.getUserId());
//
//                        smsBody.setSmsType("24");
//                        smsBody.setContent("请查看办公审批信息");
//                        smsBody.setSendTime((int)(System.currentTimeMillis() / 1000));
//                        smsBody.setRemindUrl("/officetransHistory/NoApproval?status=2&transId="+ transhistory.getTransId());
//                        smsService.saveSms(smsBody,manager,"1","0","","","");
                    }
                }
                if(("2").equals(transState)){
                    if(temp.getTransState().equals("01")){  //原来为待部门审批人审批状态01，则修改为部门审批驳回21
                        transhistory.setTransState("21");
                    }
                    if(temp.getTransState().equals("02")){  //原来为待库管员审批状态02，则修改为库管员驳回22
                        transhistory.setTransState("22");
                    }
                    OfficeProductsWithBLOBs proTemp=new OfficeProductsWithBLOBs();
                    String s=temp.getGetSubmitList();
                    if(temp.getGetSubmitList()==null){
                        proTemp.setProId(temp.getProId());
                        proTemp.setOfficeProtype(String.valueOf(temp.getTypeId()));
                        proTemp.setDepositoryId(String.valueOf(temp.getDepositoryId()));
                        OfficeProductsWithBLOBs pro=officeProductsMapper.selByDepoAndTypeAndPro(proTemp);
                        pro.setProStock(pro.getProStock()+temp.getTransQty());
                        officeProductsMapper.updateByPrimaryKeyWithBLOBs(pro);
                    }else {
                        List<OfficeTranshistoryWithBLOBs> list = JSONArray.toList(JSONArray.fromObject(temp.getGetSubmitList()), OfficeTranshistoryWithBLOBs.class);
                        for (OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs : list) {
                            proTemp.setProId(officeTranshistoryWithBLOBs.getProId());
                            proTemp.setOfficeProtype(String.valueOf(officeTranshistoryWithBLOBs.getTypeId()));
                            proTemp.setDepositoryId(String.valueOf(officeTranshistoryWithBLOBs.getDepositoryId()));
                            OfficeProductsWithBLOBs pro = officeProductsMapper.selByDepoAndTypeAndPro(proTemp);
                            pro.setProStock(pro.getProStock()+officeTranshistoryWithBLOBs.getTransQty());
                            officeProductsMapper.updateByPrimaryKeyWithBLOBs(pro);
                        }
                    }
                }
                officeTranshistoryMapper.upTransHistoryState(transhistory);
                //消除审批事务提醒
                //判断是消除部门审批还是库管理事务提醒
                String remindUrl="";
                if("01".equals(pd)){
                    remindUrl= "/officetransHistory/NoApproval?status=1&transId="+transhistory.getTransId();
                    remindUrls.add(remindUrl);
                }else if("02".equals(pd)){
                    remindUrl= "/officetransHistory/NoApproval?status=2&transId="+transhistory.getTransId();
                    remindUrls.add(remindUrl);
                }
//                smsService.setSmsFileRead(null,"24",remindUrl,users);

                // 采购入库 审批通过后增加库存
                transhistory = officeTranshistoryMapper.selectByPrimaryKey(transhistory.getTransId());
                if (transhistory != null) {
                    if ("3".equals(transhistory.getTransFlag()) && "1".equals(transhistory.getTransState())) {
                        OfficeProductsWithBLOBs officeProductsWithBLOBs = officeProductsMapper.selectByPrimaryKey(transhistory.getProId());
                        if (officeProductsWithBLOBs != null) {
                            officeProductsWithBLOBs.setProStock(officeProductsWithBLOBs.getProStock() + transhistory.getTransQty());
                            officeProductsMapper.updateByPrimaryKeyWithBLOBs(officeProductsWithBLOBs);
                        }
                    }
                }
            }

            if (remindUrls != null&&remindUrls.size()>0) {
                this.readAffairs(remindUrls,request,users);
            }
            if (objects != null&&objects.size()>0) {
                this.addAffairs(objects, request, users);
            }
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("OfficeTransHistoryService selTranshistoryByState:"+e);
            e.printStackTrace();
        }
        return  json;
    }

    @Async
    public void addAffairs(final List<JSONObject> objects,HttpServletRequest request,Users users) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        final String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                for (JSONObject object : objects) {
                    SmsBody smsBody = new SmsBody();
                    smsBody.setFromId(users.getUserId());
                    smsBody.setSmsType("24");
                    smsBody.setContent("请查看办公审批信息");
                    if (locale.equals("zh_CN")) {
                        smsBody.setContent("请查看办公审批信息");
                    } else if (locale.equals("en_US")) {
                        smsBody.setContent("Please review the office approval information");
                    } else if (locale.equals("zh_TW")) {
                        smsBody.setContent("請查看辦公審批資訊");
                    }
                    smsBody.setSendTime((int)(System.currentTimeMillis() / 1000));
                    smsBody.setRemindUrl(object.getString("remindUrl"));
                    smsService.saveSms(smsBody,object.getString("manager"),"1","0","","",sqlType);
                }
            }
        });
    }
    @Async
    public void readAffairs(List<String> remindUrls,HttpServletRequest request,Users users){
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                for (String remindUrl : remindUrls) {
                    smsService.setSmsFileRead(null,"24",remindUrl,users);
                }
            }
        });
    }

    /**
     * 创建作者:   高亚峰
     *  创建日期:  2017/10/08 13:44
     * 类介绍  :   下拉框获取接口
     * 构造参数:
     */
    public AjaxJson getDownObjects(String typeDepository, String officeProductType, String officeInventory){
        AjaxJson ajaxJson =new AjaxJson();
        if(!StringUtils.checkNull(typeDepository)){
            List<OfficeType> officeTypes = officeTypeMapper.selectDownObject(typeDepository);
            ajaxJson.setMsg("ok");
            ajaxJson.setFlag(true);
            ajaxJson.setSuccess(true);
            ajaxJson.setObj(officeTypes);
        }
        if(!StringUtils.checkNull(officeProductType)){
            List<OfficeProductsWithBLOBs> officeProductsWithBLOBs = officeProductsMapper.selectDownObject(officeProductType);
            // 库存盘点处理
            if (!StringUtils.checkNull(officeInventory) && "1".equals(officeInventory)) {
                for (OfficeProductsWithBLOBs officeProductsWithBLOB : officeProductsWithBLOBs) {
                    String lastInventoryDate = null;
                    // 上期盘点时间 上期结余
                    OfficeInventoryInfo officeInventoryInfo = officeInventoryInfoMapper.selectLastOfficeInventoryInfo(officeProductsWithBLOB.getProId());
                    if (officeInventoryInfo != null) {
                        if (officeInventoryInfo.getInventoryDate() != null) {
                            officeProductsWithBLOB.setLastInventoryDate(officeInventoryInfo.getInventoryDate());
                            lastInventoryDate = DateFormat.getDatestr(officeInventoryInfo.getInventoryDate());
                        }

                        if (officeInventoryInfo.getActualDiskCount() != null) {
                            officeProductsWithBLOB.setOldBalance(officeInventoryInfo.getActualDiskCount());
                        }
                    }
                    // 入库量 入库量为当前时间范围内实际入库量与借用归还数量之和
                    String currentTime = DateFormat.getDatestr(new Date());
                    Integer scheduledReceipt = officeTranshistoryMapper.selectScheduledReceipt(officeProductsWithBLOB.getProId(), lastInventoryDate, currentTime);
                    if (scheduledReceipt != null) {
                        officeProductsWithBLOB.setScheduledReceipt(scheduledReceipt);
                    } else {
                        officeProductsWithBLOB.setScheduledReceipt(0);
                    }
                    // 出库量 领用，借用未还数量之和
                    Integer outboundQuantity = officeTranshistoryMapper.selectOutboundQuantity(officeProductsWithBLOB.getProId(), lastInventoryDate, currentTime);
                    if (outboundQuantity != null) {
                        officeProductsWithBLOB.setOutboundQuantity(outboundQuantity);
                    } else {
                        officeProductsWithBLOB.setOutboundQuantity(0);
                    }
                }
            }
            ajaxJson.setMsg("ok");
            ajaxJson.setFlag(true);
            ajaxJson.setSuccess(true);
            ajaxJson.setObj(officeProductsWithBLOBs);
        }
        return ajaxJson;
    }

    public ToJson getDownObjectLikeBytype(String officeProductType,String proName){
        ToJson toJson=new ToJson();
        try{
            Map map=new HashMap();
            map.put("officeProductType",officeProductType);
            map.put("proName",proName);
            List<OfficeProductsWithBLOBs> officeProductsWithBLOBs = officeProductsMapper.getDownObjectLikeBytype(map);
            toJson.setObj(officeProductsWithBLOBs);
            toJson.setMsg("true");
            toJson.setFlag(0);
        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            toJson.setFlag(1);
        }
        return toJson;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 下午15:47:00
     * 方法介绍:   根据条件进行办公用品发放查询（可分页）
     * 参数说明:   @param
     * 返回值说明:
     */
    public ToJson<OfficeTranshistoryWithBLOBs> selGrantByCond(OfficeTranshistoryWithBLOBs transhistory,HttpServletRequest request,Integer page, Integer pageSize, boolean useFlag){
        ToJson<OfficeTranshistoryWithBLOBs> json = new ToJson<OfficeTranshistoryWithBLOBs>(1, "error");
        try{
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            transhistory.setCurrentUser(users.getUserId());
            if(!StringUtils.checkNull(transhistory.getBorrower())){
                if(transhistory.getBorrower().contains(",")){
                    transhistory.setBorrower(transhistory.getBorrower().substring(0,transhistory.getBorrower().length()-1));
                }
            }
            //分页
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", pageParams);
            map.put("OfficeTranshistory",transhistory);
            List<OfficeTranshistoryWithBLOBs> list=officeTranshistoryMapper.selGrantByCond(map);
            for(OfficeTranshistoryWithBLOBs temp:list){
                if(!StringUtils.checkNull(temp.getBorrower())){
                    if(usersMapper.getUserId(temp.getBorrower())!=null){
                        temp.setBorrowerName(usersMapper.getUserId(temp.getBorrower()).getUserName());
                    }
                }
                if(!StringUtils.checkNull(temp.getGrantor())){
                    if(usersMapper.getUserId(temp.getGrantor())!=null){
                        temp.setGrantorName(usersMapper.getUserId(temp.getGrantor()).getUserName());
                    }
                }
            }
            json.setTotleNum(officeTranshistoryMapper.selGrantCountByCond(transhistory));
            json.setObj(list);
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("OfficeTransHistoryService selGrantByCond:"+e);
            e.printStackTrace();
        }
        return  json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 下午15:47:00
     * 方法介绍:   修改发放状态
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    public ToJson<OfficeTranshistoryWithBLOBs>  upGrantStatus (String transState, String transIds){
        ToJson<OfficeTranshistoryWithBLOBs> json = new ToJson<OfficeTranshistoryWithBLOBs>(1, "error");
        try{
            int count = 0;
            String[] transId = transIds.split(",");
            for (int i = 0; i < transId.length; i++) {
                count += officeTranshistoryMapper.upGrantStatus(transState,transId[i]);
            }
            if(count>0){
                json.setMsg("ok");
                json.setFlag(0);
            }
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("OfficeTransHistoryService upGrantStatus:"+e);
            e.printStackTrace();
        }
        return  json;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月9日 下午15:47:00
     * 方法介绍:   办公用品查询
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    public ToJson<OfficeTranshistoryWithBLOBs> selTranshistoryByCond(OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs, Integer output, HttpServletRequest request, HttpServletResponse response,Integer page,Integer pageSize,Boolean useFlag)  {
        ToJson<OfficeTranshistoryWithBLOBs> json = new ToJson<OfficeTranshistoryWithBLOBs>(1, "error");
        Map map=new HashMap();
        try {
            PageParams pageParams=new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            map.put("page",pageParams);
        }catch (Exception e){
            e.printStackTrace();
        }
        try{

            OutputStream  out=response.getOutputStream();
            if(!StringUtils.checkNull(officeTranshistoryWithBLOBs.getBorrower()) && officeTranshistoryWithBLOBs.getBorrower().contains(",")){
                officeTranshistoryWithBLOBs.setBorrower(officeTranshistoryWithBLOBs.getBorrower().substring(0,officeTranshistoryWithBLOBs.getBorrower().length()-1));
            }
            String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            I18nUtils.setLocale(locale);
            map.put("officeTranshistoryWithBLOBs",officeTranshistoryWithBLOBs);
            List<OfficeTranshistoryWithBLOBs> list=officeTranshistoryMapper.selTranshistoryByCond(map);
            for (OfficeTranshistoryWithBLOBs transhistoryWithBLOBs:list){
                if(!StringUtils.checkNull(transhistoryWithBLOBs.getBorrower())){
                    if(usersMapper.getUserId(transhistoryWithBLOBs.getBorrower())!=null){
                        transhistoryWithBLOBs.setBorrowerName(usersMapper.getUserId(transhistoryWithBLOBs.getBorrower()).getUserName());
                    }
                }
                if(!StringUtils.checkNull(transhistoryWithBLOBs.getOperator())){
                    if(usersMapper.getUserId(transhistoryWithBLOBs.getOperator())!=null){
                        transhistoryWithBLOBs.setOperatorName(usersMapper.getUserId(transhistoryWithBLOBs.getOperator()).getUserName());
                    }
                }
                if(!StringUtils.checkNull(transhistoryWithBLOBs.getGrantor())){
                    if(usersMapper.getUserId(transhistoryWithBLOBs.getGrantor())!=null){
                        transhistoryWithBLOBs.setGrantorName(usersMapper.getUserId(transhistoryWithBLOBs.getGrantor()).getUserName());
                    }
                }
                if(transhistoryWithBLOBs.getTransFlag().equals("1")){
                    transhistoryWithBLOBs.setTransFlagName(I18nUtils.getMessage("vote.th.user"));
                }else  if(transhistoryWithBLOBs.getTransFlag().equals("2")){
                    transhistoryWithBLOBs.setTransFlagName(I18nUtils.getMessage("vote.th.borrow"));
                }
                if(transhistoryWithBLOBs.getDeptId()!=null){
                    transhistoryWithBLOBs.setDeptName(departmentMapper.getDeptNameById(transhistoryWithBLOBs.getDeptId()));
                }
                transhistoryWithBLOBs.setGrantStatusName(I18nUtils.getMessage("vote.th.NotAudited"));
                if (!StringUtils.checkNull(transhistoryWithBLOBs.getTransState())) {
                    if (transhistoryWithBLOBs.getTransState().equals("01")) {
                        transhistoryWithBLOBs.setTransStateName(I18nUtils.getMessage("vote.th.ApprovalDepartment"));
                    } else if (transhistoryWithBLOBs.getTransState().equals("02")) {
                        transhistoryWithBLOBs.setTransStateName(I18nUtils.getMessage("vote.th.ToAdministrator"));
                    } else if (transhistoryWithBLOBs.getTransState().equals("1")) {
                        transhistoryWithBLOBs.setTransStateName(I18nUtils.getMessage("license.Approved"));
                        if (transhistoryWithBLOBs.getGrantStatus().equals("0")) {
                            transhistoryWithBLOBs.setGrantStatusName(I18nUtils.getMessage("vote.th.WaitDistribution"));
                        } else if (transhistoryWithBLOBs.getGrantStatus().equals("1")) {
                            transhistoryWithBLOBs.setGrantStatusName(I18nUtils.getMessage("vote.th.AlreadyIssued"));
                        } else if (transhistoryWithBLOBs.getGrantStatus().equals("2")) {
                            transhistoryWithBLOBs.setGrantStatusName(I18nUtils.getMessage("office.confirmed"));
                        }
                    } else if (transhistoryWithBLOBs.getTransState().equals("21")) {
                        transhistoryWithBLOBs.setTransStateName(I18nUtils.getMessage("vote.th.DisapprovaApproval"));
                    } else if (transhistoryWithBLOBs.getTransState().equals("22")) {
                        transhistoryWithBLOBs.setTransStateName(I18nUtils.getMessage("vote.th.StorekeeperDismissal"));
                    }
                }
                //给定一个状态值flag，判断当前登录是发放员、审批员
                transhistoryWithBLOBs.setFlag(0);
                Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
                Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
                transhistoryWithBLOBs.setCurrentUser(users.getUserId());
                if(officeTranshistoryMapper.isApproval(transhistoryWithBLOBs)==1){
                    transhistoryWithBLOBs.setFlag(1);//可以进行审批
                }
                if(officeTranshistoryMapper.isGrant(transhistoryWithBLOBs)==1){
                    transhistoryWithBLOBs.setFlag(2);//可以进行发放
                }
            }
            if(output!=null && output==1) {//output==1,则进行导出操作
                // 申请日期格式化
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                for (OfficeTranshistoryWithBLOBs transhistoryWithBLOBs : list) {
                    transhistoryWithBLOBs.setTransDateStr(sdf.format(transhistoryWithBLOBs.getTransDate()));
                }

                HSSFWorkbook tableWork = ExcelUtil.makeExcelHead(I18nUtils.getMessage("office.xls"), 15);
                String[] secondTitles = {I18nUtils.getMessage("vote.th.OfficeName"),I18nUtils.getMessage("vote.th.OfficeStorehouse"),I18nUtils.getMessage("vote.th.OfficeCategory"),I18nUtils.getMessage("vote.th.Registration"),
                         I18nUtils.getMessage("license.applicant"),I18nUtils.getMessage("workflow.th.sector"),I18nUtils.getMessage("event.th.Number"),
                        I18nUtils.getMessage( "vote.th.UnitPrice"),I18nUtils.getMessage("hr.th.DateOfApplication"),I18nUtils.getMessage("event.th.ApprovalStatus"),I18nUtils.getMessage("notice.th.state"),
                        I18nUtils.getMessage("journal.th.Remarks")};
                HSSFWorkbook excelWork = ExcelUtil.makeSecondHead(tableWork, secondTitles);
                String[] beanProperty = {"proName","depositoryName","typeName","transFlagName","borrowerName","deptName","transQty","proPrice","transDateStr","transStateName","grantStatusName","remark"};
                HSSFWorkbook workbook = ExcelUtil.exportExcelData(excelWork, list, beanProperty);
                response.setContentType("text/html;charset=UTF-8");


                String filename =  I18nUtils.getMessage("office.xls")+".xls"; //考虑多语言
                filename = FileUtils.encodeDownloadFilename(filename,
                        request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("content-disposition",
                        "attachment;filename=" + filename);
                workbook.write(out);
                out.flush();
            }
            json.setObj(list);
            PageParams pageParams=(PageParams) map.get("page");
            json.setTotleNum(pageParams.getTotal());
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("OfficeTransHistoryService selTranshistoryByCond:"+e);
            e.printStackTrace();
        }
        return  json;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月10日 下午15:47:00
     * 方法介绍:   查询今日维护办公用品列表（操作员是当前登录人）
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    public ToJson<OfficeTranshistoryWithBLOBs> selMaintain(OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs,HttpServletRequest request){
        ToJson<OfficeTranshistoryWithBLOBs> json = new ToJson<OfficeTranshistoryWithBLOBs>(1, "error");
        try{
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            Date date =new Date();
            SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(date);
            officeTranshistoryWithBLOBs.setCurrentUser(users.getUserId());
            officeTranshistoryWithBLOBs.setCurrentTime(format);
            List<OfficeTranshistoryWithBLOBs> list=officeTranshistoryMapper.selMaintain(officeTranshistoryWithBLOBs);
            for (OfficeTranshistoryWithBLOBs transhistoryWithBLOBs:list){
                if(!StringUtils.checkNull(transhistoryWithBLOBs.getBorrower())){
                    if(usersMapper.getUserId(transhistoryWithBLOBs.getBorrower())!=null){
                        transhistoryWithBLOBs.setBorrowerName(usersMapper.getUserId(transhistoryWithBLOBs.getBorrower()).getUserName());
                    }
                }
                if(!StringUtils.checkNull(transhistoryWithBLOBs.getOperator())){
                    if(usersMapper.getUserId(transhistoryWithBLOBs.getOperator())!=null){
                        transhistoryWithBLOBs.setOperatorName(usersMapper.getUserId(transhistoryWithBLOBs.getOperator()).getUserName());
                    }
                }
                if(!StringUtils.checkNull(transhistoryWithBLOBs.getGrantor())){
                    if(usersMapper.getUserId(transhistoryWithBLOBs.getGrantor())!=null){
                        transhistoryWithBLOBs.setGrantorName(usersMapper.getUserId(transhistoryWithBLOBs.getGrantor()).getUserName());
                    }
                }
            }
            json.setObj(list);
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("OfficeTransHistoryService selMaintain:"+e);
            e.printStackTrace();
        }
        return  json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月10日 下午15:47:00
     * 方法介绍:   查询今日代登记办公用品列表（操作员是当前登录人）
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    public ToJson<OfficeTranshistoryWithBLOBs> selInstead(OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs,HttpServletRequest request){
        ToJson<OfficeTranshistoryWithBLOBs> json = new ToJson<OfficeTranshistoryWithBLOBs>(1, "error");
        try{
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            Date date =new Date();
            SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(date);
            officeTranshistoryWithBLOBs.setCurrentUser(users.getUserId());
            officeTranshistoryWithBLOBs.setCurrentTime(format);
            List<OfficeTranshistoryWithBLOBs> list=officeTranshistoryMapper.selInstead(officeTranshistoryWithBLOBs);
            for (OfficeTranshistoryWithBLOBs transhistoryWithBLOBs:list){
                if(!StringUtils.checkNull(transhistoryWithBLOBs.getBorrower())){
                    if(usersMapper.getUserId(transhistoryWithBLOBs.getBorrower())!=null){
                        transhistoryWithBLOBs.setBorrowerName(usersMapper.getUserId(transhistoryWithBLOBs.getBorrower()).getUserName());
                    }
                }
                if(!StringUtils.checkNull(transhistoryWithBLOBs.getGrantor())){
                    if(usersMapper.getUserId(transhistoryWithBLOBs.getGrantor())!=null){
                        transhistoryWithBLOBs.setGrantorName(usersMapper.getUserId(transhistoryWithBLOBs.getGrantor()).getUserName());
                    }
                }
            }
            json.setObj(list);
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("OfficeTransHistoryService selInstead:"+e);
            e.printStackTrace();
        }
        return  json;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:  2017/10/08 13:44
     * 类介绍  :   编辑申请记录
     * 构造参数:
     */
    public ToJson<Object> returnObject(String transIds){
        ToJson<Object> json =new ToJson<Object>(1,"err");
        try {
            OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs =new OfficeTranshistoryWithBLOBs();
            String[] split = transIds.split(",");
            for(String s:split){
                //设置商品的id
                officeTranshistoryWithBLOBs.setTransId(Integer.valueOf(s));
                //设置归还时间
                Date date =new Date();
                officeTranshistoryWithBLOBs.setReturnDate(date);
                //改变归还状态
                officeTranshistoryWithBLOBs.setReturnStatus(1);
                //查询一下该商品原来的库存数量
                OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs1 = officeTranshistoryMapper.selectByPrimaryKey(Integer.valueOf(s));
                if(officeTranshistoryWithBLOBs1!=null){
                    Integer transQty = officeTranshistoryWithBLOBs1.getTransQty();
                    OfficeProductsWithBLOBs officeProductsWithBLOBs = officeProductsMapper.selectByPrimaryKey(officeTranshistoryWithBLOBs1.getProId());
                    Integer proStock = officeProductsWithBLOBs.getProStock();
                    int i = transQty + proStock;
                    OfficeProductsWithBLOBs officeProductsWithBLOBs1 =new OfficeProductsWithBLOBs();
                    officeProductsWithBLOBs.setProId(officeProductsWithBLOBs.getProId());
                    officeProductsWithBLOBs.setProStock(i);
                    int i1 = officeProductsMapper.updateByPrimaryKeySelective(officeProductsWithBLOBs);
                }

                officeTranshistoryMapper.updateByPrimaryKeySelective(officeTranshistoryWithBLOBs);
            }
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }

    //办公用品申请警告
    public ToJson getJingao(int proId,int transQty){
        ToJson toJson=new ToJson();
        try{
            //得到库存，最低，最高警戒线
            OfficeProducts officeProducts =officeProductsMapper.getJingao(proId);
            //判断数量是否超过库存
            if( transQty > officeProducts.getProStock()){
                //超过库存返回0
                toJson.setObject("1");
            }else{
                //正常返回3
                toJson.setObject("0");
            }
            toJson.setMsg("true");
            toJson.setFlag(0);
        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            toJson.setFlag(1);
        }

        return toJson;
    }
    public ToJson<OfficeTranshistoryWithBLOBs> getTranshistoryById(String borrower) {
        ToJson<OfficeTranshistoryWithBLOBs> json=new ToJson<OfficeTranshistoryWithBLOBs>();
        try{
            List<OfficeTranshistoryWithBLOBs> list=officeTranshistoryMapper.getTranshistoryById(borrower);
            if(list.size()>0){
                json.setMsg("ok");
                json.setFlag(0);
                json.setObj(list);
            }else{
                json.setMsg("null");
                json.setFlag(0);
                json.setObj(null);
            }
        }catch (Exception e){
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }
    /**
     * 创建人：刘景龙
     * 创建时间：2021-09-22 14:46
     * 方法介绍：判断当前用户是否已经暂存过商品还未提交
     * 参数说明：
     */
    public ToJson selectByBorrower(HttpServletRequest request){
        ToJson json=new ToJson();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        OfficeTranshistory officeTranshistory = officeTranshistoryMapper.selectByBorrower(users.getUserId());
        if(officeTranshistory!=null){
            json.setMsg("ok");
            json.setFlag(0);
        }else{
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    public ToJson getApplayBatch(HttpServletRequest request,String jsonStr,String deptManager,String  remark,int flag){
        ToJson toJson=new ToJson();
        String reflag=request.getParameter("reflag");
        //从session中获取当前登录人的信息
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        if("submit".equals(reflag)) {
            try {
                //得到申领的办公用品
                List<OfficeTranshistoryWithBLOBs> list = JSONArray.toList(JSONArray.fromObject(jsonStr), OfficeTranshistoryWithBLOBs.class);
                for (OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs : list) {
                    OfficeProductsWithBLOBs temp = new OfficeProductsWithBLOBs();
                    temp.setProId(officeTranshistoryWithBLOBs.getProId());
                    temp.setOfficeProtype(String.valueOf(officeTranshistoryWithBLOBs.getTypeId()));
                    temp.setDepositoryId(String.valueOf(officeTranshistoryWithBLOBs.getDepositoryId()));
                    OfficeProductsWithBLOBs pro = officeProductsMapper.selByDepoAndTypeAndPro(temp);
                    if (officeTranshistoryWithBLOBs.getTransQty() == null) {
                        officeTranshistoryWithBLOBs.setTransQty(1);
                    }
                    if (!StringUtils.checkNull(officeTranshistoryWithBLOBs.getTransFlag()) && !officeTranshistoryWithBLOBs.getTransFlag().equals("3")) {//除采购入库外，其他类型需要判断其库存和最低警戒库存的数量
                        if (pro != null) {
                            if ((pro.getProStock() - officeTranshistoryWithBLOBs.getTransQty()) < pro.getProLowstock() && (pro.getProStock() - officeTranshistoryWithBLOBs.getTransQty()) < 0) {
                                toJson.setMsg("numNoEnough");
                                return toJson;
                            }
                        }
                    } else if (!StringUtils.checkNull(officeTranshistoryWithBLOBs.getTransFlag()) && officeTranshistoryWithBLOBs.getTransFlag().equals("3")) {//采购入库，需要判断其最够警戒库存数
                        if (pro != null && pro.getProMaxstock() != null && pro.getProMaxstock() != 0) {
                            if ((pro.getProStock() + officeTranshistoryWithBLOBs.getTransQty()) > pro.getProMaxstock()) {
                                toJson.setMsg("numMax");
                                return toJson;
                            }
                        }
                    }
                    officeTranshistoryWithBLOBs.setTransFlag("1");
                    officeTranshistoryWithBLOBs.setDeptManager(deptManager);
                    officeTranshistoryWithBLOBs.setRemark(remark);
                    if (flag == 1) {
                        officeTranshistoryWithBLOBs.setBorrower(users.getUserId());
                    }
                    if (!StringUtils.checkNull(officeTranshistoryWithBLOBs.getBorrower())) {
                        if (officeTranshistoryWithBLOBs.getBorrower().contains(",")) {
                            officeTranshistoryWithBLOBs.setBorrower(officeTranshistoryWithBLOBs.getBorrower().substring(0, officeTranshistoryWithBLOBs.getBorrower().length() - 1));
                        }
                    }
                    //申请人所属部门
                    Users borrowUser = null;
                    if (!StringUtils.checkNull(officeTranshistoryWithBLOBs.getBorrower())) {
                        borrowUser = usersMapper.getUserId(officeTranshistoryWithBLOBs.getBorrower());
                    }

                    if (borrowUser != null) {
                        officeTranshistoryWithBLOBs.setDeptId(borrowUser.getDeptId());
                    }
                    if (!StringUtils.checkNull(officeTranshistoryWithBLOBs.getDeptManager())) {
                        if (officeTranshistoryWithBLOBs.getDeptManager().contains(",")) {
                            officeTranshistoryWithBLOBs.setDeptManager(officeTranshistoryWithBLOBs.getDeptManager().substring(0, officeTranshistoryWithBLOBs.getDeptManager().length() - 1));
                        }
                    }
                    officeTranshistoryWithBLOBs.setOperator(users.getUserId());
                    Date date = new Date();
                    officeTranshistoryWithBLOBs.setTransDate(date);
                    if (!StringUtils.checkNull(officeTranshistoryWithBLOBs.getDeptManager())) {
                        officeTranshistoryWithBLOBs.setTransState("01");
                    } else {
                        officeTranshistoryWithBLOBs.setTransState("02");
                    }
                    officeTranshistoryWithBLOBs.setGetSubmitStatus("1");
                    int i = officeTranshistoryMapper.insertSelective(officeTranshistoryWithBLOBs);
                    if (pro != null) {
                        if (!StringUtils.checkNull(officeTranshistoryWithBLOBs.getTransFlag()) && !officeTranshistoryWithBLOBs.getTransFlag().equals("3")) {//除采购入库外，其他类型需要将库存数量减少
                            pro.setProStock(pro.getProStock() - officeTranshistoryWithBLOBs.getTransQty());
                        } else if (!StringUtils.checkNull(officeTranshistoryWithBLOBs.getTransFlag()) && officeTranshistoryWithBLOBs.getTransFlag().equals("3")) {//采购入库，需要将库存数量进行添加
                            pro.setProStock(pro.getProStock() + officeTranshistoryWithBLOBs.getTransQty());
                        }
                    }
                    i += officeProductsMapper.updateByPrimaryKeyWithBLOBs(pro);
                    //审批事务
                    // 提醒
                    //向sms_body插入提醒数据
                    String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
                    SmsBody smsBody = new SmsBody();
                    smsBody.setFromId(users.getUserId());
                    smsBody.setSmsType("24");
                    smsBody.setContent("请查看办公审批信息");
                    if (locale.equals("zh_CN")) {
                        smsBody.setContent("请查看办公审批信息");
                    } else if (locale.equals("en_US")) {
                        smsBody.setContent("Please review the office approval information");
                    } else if (locale.equals("zh_TW")) {
                        smsBody.setContent("請查看辦公審批資訊");
                    }
                    smsBody.setSendTime((int) (System.currentTimeMillis() / 1000));
                    smsBody.setRemindUrl("/officetransHistory/NoApproval?status=1&transId=" + officeTranshistoryWithBLOBs.getTransId());
                    if (officeTranshistoryWithBLOBs.getDeptManager() != null) {
                        smsService.saveSms(smsBody, officeTranshistoryWithBLOBs.getDeptManager().toString(), "1", "0", "", "", "");
                    }
                }
                toJson.setFlag(0);
                toJson.setMsg("true");
            } catch (Exception e) {
                toJson.setFlag(1);
                toJson.setMsg(e.getMessage());
            }
        }
        if("save".equals(reflag)) {
            OfficeTranshistory officeTranshistory = officeTranshistoryMapper.selectByBorrower(users.getUserId());
            if (officeTranshistory != null) {
                Integer transQty12=officeTranshistory.getTransQty();
                List<OfficeTranshistoryWithBLOBs> list = JSONArray.toList(JSONArray.fromObject(jsonStr), OfficeTranshistoryWithBLOBs.class);
                for (OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs : list) {
                    transQty12=officeTranshistoryWithBLOBs.getTransQty()+transQty12;
                }
                officeTranshistory.setTransQty(transQty12);
                com.alibaba.fastjson.JSONArray jsonStr1= com.alibaba.fastjson.JSONArray.parseArray(jsonStr);
                com.alibaba.fastjson.JSONArray getSubmitList1=com.alibaba.fastjson.JSONArray.parseArray(officeTranshistory.getGetSubmitList());
                for (int i = 0; i < getSubmitList1.size(); i++) {
                    int index=0;
                    JSONObject jsonObjectgsl=(JSONObject)getSubmitList1.get(i);
                    for (int j = 0; j < jsonStr1.size(); j++) {
                        JSONObject jsonObjectjs=(JSONObject)jsonStr1.get(j);
                        if(jsonObjectjs.get("proId").equals(jsonObjectgsl.get("proId"))){
                            Integer transQty=Integer.valueOf(jsonObjectgsl.get("transQty").toString());
                            Integer transQty1=Integer.valueOf(jsonObjectjs.get("transQty").toString());
                            Integer he=transQty+transQty1;
                            jsonObjectgsl.remove("transQty");
                            jsonObjectgsl.put("transQty",he.toString());
                            jsonObjectgsl.remove("totalPrice");
                            Double proPrice = Double.valueOf(jsonObjectgsl.get("proPrice").toString());
                            Double totalPrice = proPrice * he;
                            jsonObjectgsl.put("totalPrice",totalPrice.toString());
                            jsonStr1.remove(index);
                        }
                        index++;
                    }
                }
                officeTranshistory.setGetSubmitList(getSubmitList1.toString().substring(0,getSubmitList1.toString().length()-1)+","+jsonStr1.toString().substring(1));
                int i=officeTranshistoryMapper.updateGetSubmitList(officeTranshistory);
                if(i>0){
                    toJson.setMsg("ok");
                    toJson.setFlag(0);
                }else{
                    toJson.setMsg("err");
                    toJson.setFlag(1);
                }
            } else {
                List<OfficeTranshistoryWithBLOBs> list = JSONArray.toList(JSONArray.fromObject(jsonStr), OfficeTranshistoryWithBLOBs.class);
                OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs = new OfficeTranshistoryWithBLOBs();
                Integer transQty=0;
                for (OfficeTranshistoryWithBLOBs transhistoryWithBLOBs : list) {
                    transQty=transhistoryWithBLOBs.getTransQty()+transQty;
                }
                officeTranshistoryWithBLOBs.setTransQty(transQty);
                officeTranshistoryWithBLOBs.setGetSubmitList(jsonStr);
                officeTranshistoryWithBLOBs.setGetSubmitStatus("0");
                officeTranshistoryWithBLOBs.setProId(0);
                officeTranshistoryWithBLOBs.setTransFlag("1");
                if (!StringUtils.checkNull(deptManager)){
                    officeTranshistoryWithBLOBs.setDeptManager(deptManager.substring(0, deptManager.length() - 1));
                }
                officeTranshistoryWithBLOBs.setRemark(remark);
                Date date = new Date();
                officeTranshistoryWithBLOBs.setTransDate(date);
                officeTranshistoryWithBLOBs.setOperator(users.getUserId());
                if (!StringUtils.checkNull(deptManager)) {
                    officeTranshistoryWithBLOBs.setTransState("01");
                } else {
                    officeTranshistoryWithBLOBs.setTransState("02");
                }
                if (flag == 1) {
                    officeTranshistoryWithBLOBs.setBorrower(users.getUserId());
                }
                if (!StringUtils.checkNull(officeTranshistoryWithBLOBs.getBorrower())) {
                    if (officeTranshistoryWithBLOBs.getBorrower().contains(",")) {
                        officeTranshistoryWithBLOBs.setBorrower(officeTranshistoryWithBLOBs.getBorrower().substring(0, officeTranshistoryWithBLOBs.getBorrower().length() - 1));
                    }
                }
                //申请人所属部门
                Users borrowUser = null;
                if (!StringUtils.checkNull(officeTranshistoryWithBLOBs.getBorrower())) {
                    borrowUser = usersMapper.getUserId(officeTranshistoryWithBLOBs.getBorrower());
                }
                if (borrowUser != null) {
                    officeTranshistoryWithBLOBs.setDeptId(borrowUser.getDeptId());
                }
                int i = officeTranshistoryMapper.insertSelective(officeTranshistoryWithBLOBs);
                if (i > 0) {
                    toJson.setMsg("ok");
                    toJson.setFlag(0);
                } else {
                    toJson.setMsg("err");
                    toJson.setFlag(1);
                }
            }
        }
        return toJson;
    }
    /**
     * 创建人：刘景龙
     * 创建时间：2021-09-17 13:49
     * 方法介绍：暂存页面详情和提交方法
     * 参数说明：
     */
    public ToJson selectDetailed(HttpServletRequest request,Integer transId,String deptManager,String  remark){
        String reflag=request.getParameter("reflag");
        ToJson json=new ToJson();
        OfficeTranshistoryWithBLOBs officeTranshistory= null;
        try {
            String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            officeTranshistory = officeTranshistoryMapper.selectDetailed(transId);
            if("detailed".equals(reflag)){
                List<OfficeTranshistoryWithBLOBs> list = JSONArray.toList(JSONArray.fromObject(officeTranshistory.getGetSubmitList()), OfficeTranshistoryWithBLOBs.class);
                json.setObj(list);
                json.setFlag(0);
                json.setMsg("ok");
            }
            if("submit".equals(reflag)){
                List<OfficeTranshistoryWithBLOBs> list = JSONArray.toList(JSONArray.fromObject(officeTranshistory.getGetSubmitList()), OfficeTranshistoryWithBLOBs.class);

                int pd=0;
                StringBuffer sb=new StringBuffer();
                for (OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs : list) {
                    OfficeProductsWithBLOBs temp = new OfficeProductsWithBLOBs();
                    temp.setProId(officeTranshistoryWithBLOBs.getProId());
                    temp.setOfficeProtype(String.valueOf(officeTranshistoryWithBLOBs.getTypeId()));
                    temp.setDepositoryId(String.valueOf(officeTranshistoryWithBLOBs.getDepositoryId()));
                    OfficeProductsWithBLOBs pro = officeProductsMapper.selByDepoAndTypeAndPro(temp);
                    if (pro != null) {
                            if(pro.getProStock()<officeTranshistoryWithBLOBs.getTransQty()){
                                if (locale.equals("zh_CN")) {
                                    sb.append(pro.getProName()+"库存不足，");
                                } else if (locale.equals("en_US")) {
                                    sb.append(pro.getProName()+"Insufficient inventory，");
                                } else if (locale.equals("zh_TW")) {
                                    sb.append(pro.getProName()+"庫存不足，");
                                }else {
                                    sb.append(pro.getProName()+"库存不足，");
                                }
                              pd++;
                            }
                    }
                }
                if(pd==0){
                    officeTranshistory.setGetSubmitStatus("1");
                    int i = officeTranshistoryMapper.updateGetSubmitStatus(officeTranshistory);
                    for (OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs : list) {
                        OfficeProductsWithBLOBs temp = new OfficeProductsWithBLOBs();
                        temp.setProId(officeTranshistoryWithBLOBs.getProId());
                        temp.setOfficeProtype(String.valueOf(officeTranshistoryWithBLOBs.getTypeId()));
                        temp.setDepositoryId(String.valueOf(officeTranshistoryWithBLOBs.getDepositoryId()));
                        OfficeProductsWithBLOBs pro = officeProductsMapper.selByDepoAndTypeAndPro(temp);
                        if(pro!=null){
                            pro.setProStock(pro.getProStock() - officeTranshistoryWithBLOBs.getTransQty());
                            i += officeProductsMapper.updateByPrimaryKeyWithBLOBs(pro);
                        }

                        //批量生成申请记录
                        officeTranshistory.setTransId(null);
                        officeTranshistory.setProId(officeTranshistoryWithBLOBs.getProId());
                        officeTranshistory.setTransQty(officeTranshistoryWithBLOBs.getTransQty());
                        officeTranshistory.setPrice(BigDecimal.valueOf(officeTranshistoryWithBLOBs.getProPrice()));
                        officeTranshistory.setGetSubmitStatus("1");
                        officeTranshistory.setGetSubmitList(null);
                        i += officeTranshistoryMapper.insertSelective(officeTranshistory);

                        //审批事务
                        // 提醒
                        //向sms_body插入提醒数据

                        SmsBody smsBody = new SmsBody();
                        smsBody.setFromId(officeTranshistory.getBorrower());
                        smsBody.setSmsType("24");
                        smsBody.setContent("请查看办公审批信息");
                        if (locale.equals("zh_CN")) {
                            smsBody.setContent("请查看办公审批信息");
                        } else if (locale.equals("en_US")) {
                            smsBody.setContent("Please review the office approval information");
                        } else if (locale.equals("zh_TW")) {
                            smsBody.setContent("請查看辦公審批資訊");
                        }
                        smsBody.setSendTime((int) (System.currentTimeMillis() / 1000));
                        smsBody.setRemindUrl("/officetransHistory/NoApproval?status=1&transId=" + officeTranshistory.getTransId());
                        if (officeTranshistory.getDeptManager() != null) {
                            smsService.saveSms(smsBody, officeTranshistory.getDeptManager().toString(), "1", "0", "", "", "");
                        }

                    }

                    json.setFlag(0);
                    json.setMsg("ok");
                }else {
                    json.setFlag(2);
                    json.setMsg(sb.toString());
                }
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }
    /**
     * 创建人：刘景龙
     * 创建时间：2021-09-21 19:19
     * 方法介绍：删除购物车某个商品
     * 参数说明：
     */
    public ToJson deleteCommodity(HttpServletRequest request,String proId,Integer transId){
        ToJson json=new ToJson();
        String transQty=request.getParameter("transQty");
        OfficeTranshistoryWithBLOBs officeTranshistory = officeTranshistoryMapper.selectDetailed(transId);
            com.alibaba.fastjson.JSONArray getSubmitList= com.alibaba.fastjson.JSONArray.parseArray(officeTranshistory.getGetSubmitList());
            int index=0;
            for (int i = 0; i < getSubmitList.size(); i++) {
                JSONObject jsonObject=(JSONObject)getSubmitList.get(i);
                if(proId.equals(jsonObject.get("proId"))){
                    getSubmitList.remove(index);
                }
                index++;
            }
            Integer transQty1=officeTranshistory.getTransQty()-Integer.valueOf(transQty);
            officeTranshistory.setTransQty(transQty1);
            officeTranshistory.setGetSubmitList(getSubmitList.toString());
            int i=officeTranshistoryMapper.updateGetSubmitList(officeTranshistory);
            if(i>0){
                json.setFlag(0);
                json.setMsg("ok");
            }else {
                json.setFlag(1);
                json.setMsg("err");
            }
        return json;
    }
    public ToJson deleteByTransId(HttpServletRequest request,Integer transId){
        ToJson json=new ToJson();
        try {
            int i=officeTranshistoryMapper.deleteByPrimaryKey(transId);
            if(i>0){
                json.setFlag(0);
                json.setMsg("ok");
            }else {
                json.setFlag(1);
                json.setMsg("err");
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    /**
     * 创建人：刘景龙
     * 创建时间：2021-09-21 19:20
     * 方法介绍：查询购物车某个商品的详情和修改方法deleteCommodity
     * 参数说明：
     */
    public ToJson updateCommodity(HttpServletRequest request,String jsonStr,Integer transId){
        ToJson json=new ToJson();
        String reflag=request.getParameter("reflag");
        if("sel".equals(reflag)){
            List<OfficeTranshistoryWithBLOBs> list=JSONArray.toList(JSONArray.fromObject(jsonStr),OfficeTranshistoryWithBLOBs.class);
            if(list!=null){
                json.setFlag(0);
                json.setMsg("ok");
                json.setObj(list);
            }else {
                json.setFlag(1);
                json.setMsg("err");
            }
        }
        if("upd".equals(reflag)){
            OfficeTranshistoryWithBLOBs officeTranshistory = officeTranshistoryMapper.selectDetailed(transId);
            com.alibaba.fastjson.JSONArray getSubmitList= com.alibaba.fastjson.JSONArray.parseArray(officeTranshistory.getGetSubmitList());
            com.alibaba.fastjson.JSONArray getJsonStr= com.alibaba.fastjson.JSONArray.parseArray(jsonStr);
            int index=0;
            for (int i = 0; i < getSubmitList.size(); i++) {
                JSONObject jsonObject=(JSONObject)getSubmitList.get(i);
                for (int j = 0; j < getJsonStr.size(); j++) {
                    JSONObject jsonObject1=(JSONObject)getJsonStr.get(0);
                    if(jsonObject1.get("porId").equals(jsonObject.get("proId"))){
                        getSubmitList.remove(index);
                        getSubmitList.add(jsonObject1);
                    }
                }
                index ++;
            }
            for (int i = 0; i < getSubmitList.size(); i++) {

            }
        }
        return json;
    }
    public ToJson queryOfficeProducts(Integer depositoryId, Integer typeId, Integer productsId, String beginDate, String endDate) {
        ToJson toJson = new ToJson();

        return null;
    }
    public ToJson<OfficeTranshistoryWithBLOBs> selShopList(HttpServletRequest request,Integer page, Integer limit, boolean useFlag){
        ToJson<OfficeTranshistoryWithBLOBs> json = new ToJson<OfficeTranshistoryWithBLOBs>(1, "error");
        try{
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            //分页
            PageParams pageParams = new PageParams();
            useFlag=true;
            pageParams.setPage(page);
            pageParams.setPageSize(limit);
            pageParams.setUseFlag(useFlag);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", pageParams);
            List<OfficeTranshistoryWithBLOBs> list=officeTranshistoryMapper.selectShopList(map);
            for (OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs:list){
                officeTranshistoryWithBLOBs.setShoplistCount((officeTranshistoryWithBLOBs.getProLowstock()-officeTranshistoryWithBLOBs.getProStock())+"");
            }
            json.setTotleNum(officeTranshistoryMapper.selectShopListCount());
            json.setObj(list);
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("OfficeTransHistoryService selGrantByCond:"+e);
            e.printStackTrace();
        }
        return  json;
    }
    public ToJson<OfficeTranshistoryWithBLOBs> exportShopList(HttpServletRequest request,HttpServletResponse response){
        ToJson<OfficeTranshistoryWithBLOBs> json = new ToJson<OfficeTranshistoryWithBLOBs>(1, "error");
        try{
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            //分页
            Map<String, Object> map = new HashMap<String, Object>();
            List<OfficeTranshistoryWithBLOBs> list=officeTranshistoryMapper.selectShopList(map);
            for (OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs:list){
                officeTranshistoryWithBLOBs.setShoplistCount((officeTranshistoryWithBLOBs.getProLowstock()-officeTranshistoryWithBLOBs.getProStock())+"");
            }
            HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("采购清单导出信息表", 9);
            String[] secondTitles = {"物品名称", "物品类别", "当前库存", "最低采购数量", "最低警示数量", "最高警示数量", "单价", "单位"};
            HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
            String[] beanProperty = {"proName", "typeName", "proStock", "shoplistCount", "proLowstock", "proMaxstock", "proPrice", "proUnit"};
            HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, list, beanProperty);
            OutputStream out = response.getOutputStream();
            String filename = "采购清单导出信息表.xls";
            filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
            response.setContentType("application/vnd.ms-excel;charset=UTF-8");
            response.setHeader("content-disposition", "attachment;filename=" + filename);
            workbook.write(out);
            out.close();
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return  json;
    }


    /**
     * 办公用品出入库汇总
     * @param flag 入库1，出库2
     * @param id 物品ID
     * @param typeId  物品类型ID
     * @param proId  物品库ID
     * @param export  是否导出(1-导出，0-查询)
     * @param beginDate 入库日期范围，开始时间
     * @param endDate  入库日期范围，截止时间
     * @param page  分页页数
     * @param pageSize  分页条数
     * @param useFlag  是否开启分页
     * @param request
     * @return
     */
    public ToJson<OfficeTranshistoryWithBLOBs> warehousingStatistics(Integer flag,Integer id, Integer typeId, Integer proId, Integer export, String beginDate, String endDate,
                                                                     Integer page, Integer pageSize, boolean useFlag, HttpServletRequest request,HttpServletResponse response) {
        ToJson<OfficeTranshistoryWithBLOBs> json = new ToJson<OfficeTranshistoryWithBLOBs>(1, "error");
        try{
            Map<String,Object> paraMap = new HashMap<>();
            paraMap.put("id",id);
            paraMap.put("typeId",typeId);
            paraMap.put("proId",proId);
            paraMap.put("beginDate",beginDate);
            paraMap.put("endDate",endDate);
            paraMap.put("transFlag",flag);
            PageParams pageParams = new PageParams();
            if(export != 1) {
                pageParams.setPage(page);
                pageParams.setPageSize(pageSize);
                pageParams.setUseFlag(useFlag);
                paraMap.put("page",pageParams);
            }
            List<OfficeTranshistoryWithBLOBs> list = officeTranshistoryMapper.warehousingStatistics(paraMap);
            if(export == 1){
                HSSFWorkbook workbook1 = null;
                String[] secondTitles = null;
                String filename = "";
                if(flag == 1) {
                    workbook1 = ExcelUtil.makeExcelHead("办公用品入库汇总表", 9);
                    secondTitles = new String[]{"物品名称", "物品类别", "规格/型号", "计量单位", "单价", "入库数量（采购入库）", "当前库存", "最低警戒库存", "最高警戒库存"};
                    filename = "办公用品入库统计表.xls";
                }
                if(flag == 2) {
                    workbook1 = ExcelUtil.makeExcelHead("办公用品出库汇总表", 9);
                    secondTitles = new String[]{"物品名称", "物品类别", "规格/型号", "计量单位", "单价", "出库数量（领用、借用）", "当前库存", "最低警戒库存", "最高警戒库存"};
                    filename = "办公用品出库统计表.xls";
                }
                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                String[] beanProperty = {"proName", "typeName", "proDesc", "proUnit", "proPrice", "transQty", "proStock", "proLowstock", "proMaxstock"};
                HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, list, beanProperty);
                OutputStream out = response.getOutputStream();
                filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel;charset=UTF-8");
                response.setHeader("content-disposition", "attachment;filename=" + filename);
                workbook.write(out);
                out.close();
            }
            if(export != 1) {
                json.setTotleNum(pageParams.getTotal());
            }
            json.setObj(list);
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            L.e("OfficeTransHistoryService warehousingStatistics:"+e);
            e.printStackTrace();
        }
        return  json;
    }


    /**
     * 办公用品费用结算统计表
     * @param id 物品ID
     * @param typeId  物品类型ID
     * @param proId  物品库ID
     * @param userIds  申请人用户ID串
     * @param beginDate 申领日期范围，开始时间
     * @param endDate  申领日期范围，截止时间
     * @param export  是否导出(1-导出，0-查询)
     * @param page  分页页数
     * @param pageSize  分页条数
     * @param useFlag  是否开启分页
     * @param request
     * @return
     */
    public ToJson<OfficeTranshistoryWithBLOBs> settlementStatistics(Integer id, Integer typeId, Integer proId, Integer export, String userIds,String beginDate, String endDate,
                                                                    Integer page, Integer pageSize, boolean useFlag, HttpServletRequest request, HttpServletResponse response) {
        ToJson<OfficeTranshistoryWithBLOBs> json = new ToJson<OfficeTranshistoryWithBLOBs>(1, "error");
        try{
            Map<String,Object> paraMap = new HashMap<>();
            paraMap.put("id",id);
            paraMap.put("typeId",typeId);
            paraMap.put("proId",proId);
            paraMap.put("beginDate",beginDate);
            paraMap.put("endDate",endDate);
            PageParams pageParams = new PageParams();
            if(export != 1) {
                pageParams.setPage(page);
                pageParams.setPageSize(pageSize);
                pageParams.setUseFlag(useFlag);
                paraMap.put("page",pageParams);
            }
            List<OfficeTranshistoryWithBLOBs> list = officeTranshistoryMapper.settlementStatistics(paraMap);
            //计算合计
            for (OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs : list) {
                if(officeTranshistoryWithBLOBs.getTransQty() > 0 && !Objects.isNull(officeTranshistoryWithBLOBs.getProPrice())){
                    officeTranshistoryWithBLOBs.setTotalPrice(officeTranshistoryWithBLOBs.getTransQty() * officeTranshistoryWithBLOBs.getProPrice());
                }
            }
            if(export == 1){
                HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("办公用品费用结算统计表", 9);
                String[] secondTitles = new String[]{"所属部门", "申请人", "申领日期", "办公用品", "数量", "单价", "合计", "备注"};
                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                String[] beanProperty = {"borrowerName", "deptName", "transDateStr", "proName", "transQty", "proPrice", "totalPrice", "remark"};
                HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, list, beanProperty);
                OutputStream out = response.getOutputStream();
                String filename = "办公用品费用结算统计表.xls";
                filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel;charset=UTF-8");
                response.setHeader("content-disposition", "attachment;filename=" + filename);
                workbook.write(out);
                out.close();
            }
            if(export != 1) {
                json.setTotleNum(pageParams.getTotal());
            }
            json.setObj(list);
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            L.e("OfficeTransHistoryService settlementStatistics:"+e);
            e.printStackTrace();
        }
        return  json;
    }



    /**
     * 办公用品维护和报废统计
     * @param flag 维护1，报废2
     * @param id 物品ID
     * @param typeId  物品类型ID
     * @param proId  物品库ID
     * @param beginDate 出库日期范围，开始时间
     * @param endDate  出库日期范围，截止时间
     * @param request
     * @return
     */
    public ToJson<OfficeTranshistoryWithBLOBs> maintainStatistics(Integer flag,Integer id,Integer typeId,Integer proId,Date beginDate,Date endDate,HttpServletRequest request) {
        ToJson<OfficeTranshistoryWithBLOBs> json = new ToJson(1, "error");
        try{
            Map<String,Object> paraMap = new HashMap<>();
            paraMap.put("id",id);
            paraMap.put("typeId",typeId);
            paraMap.put("proId",proId);
            paraMap.put("beginDate",beginDate);
            paraMap.put("endDate",endDate);
            paraMap.put("transFlag",flag);
            List<OfficeTranshistoryWithBLOBs> res = officeTranshistoryMapper.maintainStatistics(paraMap);
            json.setObject(res);
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            L.e("OfficeTransHistoryService maintainStatistics:"+e);
            e.printStackTrace();
        }
        return  json;
    }


    public ToJson<OfficeTranshistoryWithBLOBs>  updateReturn (Integer transIds){
        ToJson<OfficeTranshistoryWithBLOBs> json = new ToJson<OfficeTranshistoryWithBLOBs>(1, "error");
        try{
            OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs = officeTranshistoryMapper.selectByPrimaryKey(transIds);
            officeTranshistoryMapper.upReturnStatus("1", transIds.toString());
            officeTranshistoryMapper.updateReturn(officeTranshistoryWithBLOBs.getTransQty(),officeTranshistoryWithBLOBs.getProId());
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("OfficeTransHistoryService upGrantStatus:"+e);
            e.printStackTrace();
        }
        return  json;
    }


    public void   earlyReturn (HttpServletRequest request,Integer transIds){
        ToJson<OfficeTranshistoryWithBLOBs> json = new ToJson<OfficeTranshistoryWithBLOBs>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        try{
            OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs = officeTranshistoryMapper.selectByPrimaryKey(transIds);
            SmsBody smsBody = new SmsBody();
            smsBody.setFromId(users.getUserId());
            smsBody.setSmsType("24");
            smsBody.setContent(users.getDeptName()+users.getUserName()+"提前归还"+officeTranshistoryWithBLOBs.getProName());
            smsBody.setSendTime((int)(System.currentTimeMillis() / 1000));
            smsBody.setRemindUrl("/officetransHistory/productRelease?transId="+ officeTranshistoryWithBLOBs.getTransId());
            if(officeTranshistoryWithBLOBs.getDeptManager()!=null) {
                smsService.saveSms(smsBody, officeTranshistoryWithBLOBs.getDeptManager().toString(), "1", "0", "", "", "");
            }
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("OfficeTransHistoryService upGrantStatus:"+e);
            e.printStackTrace();
        }

    }
}
