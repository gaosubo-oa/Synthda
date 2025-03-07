package com.xoa.controller.officeSupplies;

import com.xoa.model.officesupplies.OfficeTranshistoryWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.service.officesupplies.OfficeTransHistoryService;
import com.xoa.service.sms.SmsService;
import com.xoa.util.AjaxJson;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/10/8 13:35
 * 类介绍  :  办公用品申请记录
 * 构造参数:
 */
@Controller
@RequestMapping("/officetransHistory")
public class OfficeTransHistoryController {

    @Resource
    private OfficeTransHistoryService officeTransHistoryService;
    @Resource
    private SmsService smsService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/12 13:48
     * 类介绍  :   办公用品我的申请记录映射
     * 构造参数:
     */
    @RequestMapping("/goMyOfficeApply")
    public String goMyOfficeApply(HttpServletRequest request){
        //消除事务提醒
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        smsService.setSmsFileRead(null,"24","/officetransHistory/goMyOfficeApply",users);
        return "app/officeSupplies/product/myApply";
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/18 10:18
     * 类介绍  :   办公用品库存维护
     * 构造参数:
     */
    @RequestMapping("/goFixDepository")
    public String goFixDepository(){
        return "app/officeSupplies/depository/fixDepository";
    }

    // 办公用品库存盘点
    @RequestMapping("/officeInventory")
    public String officeInventory(){
        return "app/officeSupplies/depository/officeInventory";
    }

    @RequestMapping("/transfers")
    public String transfers(HttpServletRequest request){
        //消除事务提醒
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        smsService.setSmsFileRead(null,"24","/officetransHistory/transfers",users);
        return "app/officeSupplies/depository/transfers";
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/18 10:18
     * 类介绍  :   待登记
     * 构造参数:
     */
    @RequestMapping("/goPendregistration")
    public String goPendregistration(){
        return "app/officeSupplies/depository/goPendregistration";
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/18 10:18
     * 类介绍  :   待登记
     * 构造参数:
     */
    @RequestMapping("/goQuery")
    public String goQuery(){
        return "app/officeSupplies/depository/query";
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017/10/12 13:44
     * 类介绍  :   办公用品发放界面映射
     * 构造参数1:
     */
    @RequestMapping("/productRelease")
    public String productRelease(HttpServletRequest request){
        //消除事务提醒
        String transId = request.getParameter("transId");
        if (!StringUtils.checkNull(transId)) {
            String remindUrl= "/officetransHistory/productRelease?transId="  + transId;
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            smsService.setSmsFileRead(null,"24",remindUrl,users);
        }
        return "app/officeSupplies/release/productRelease";
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017/10/12 13:44
     * 类介绍  :   办公用品审批界面映射
     * 构造参数1:
     */
    @RequestMapping("/approvalIndex")
    public String approvalIndex(){
        return "app/officeSupplies/approval/index";
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017/10/12 13:44
     * 类介绍  :   办公用品待批申请界面映射
     * 构造参数1:
     */
    @RequestMapping("/NoApproval")
    public String NoApproval(HttpServletRequest request){
        //消除事务提醒
        String status = request.getParameter("status");
        String transId = request.getParameter("transId");
        if (!StringUtils.checkNull(status) && !StringUtils.checkNull(transId)) {
            String remindUrl= "/officetransHistory/NoApproval?status=" +status + "&transId=" + transId;
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            smsService.setSmsFileRead(null,"24",remindUrl,users);
        }
        return "app/officeSupplies/approval/NoApproval";
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017/10/12 13:44
     * 类介绍  :   办公用品申领记录界面映射
     * 构造参数1:
     */
    @RequestMapping("/applyRecord")
    public String applyRecord(){
        return "app/officeSupplies/approval/applyRecord";
    }


    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/12 9:44
     * 类介绍  :   办公用品编辑申请界面
     * 构造参数:
     */
    @RequestMapping("/OfficeProductApply")
    public String OfficeProductApply(int editFlag, int transId, Map<String,Object> map){
        map.put("editFlag",editFlag);
        map.put("transId",transId);
        return "app/officeSupplies/product/editApply";
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/12 9:44
     * 类介绍  :   选中办公用品申请界面
     * 构造参数:
     */
    @RequestMapping("/gpProApply")
    public String goProductApply(int editFlag,int transId, int proid,int depositoryid,int protypeid,Map<String,Object> map){
        map.put("editFlag",editFlag);
        map.put("transId",transId);
        map.put("proid",proid);
        map.put("depositoryid",depositoryid);
        map.put("protypeid",protypeid);
        return "app/officeSupplies/product/gpProApply";
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/12 9:44
     * 类介绍  :   办公用品申请界面
     * 构造参数:
     */
    @RequestMapping("/OfficeProductApplyIndex")
    public String OfficeProductApplyIndex(){
        return "app/officeSupplies/product/index";
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017/10/19 9:44
     * 类介绍  :   库存映射界面
     * 构造参数:
     */
    @RequestMapping("/stockIndex")
    public String stockIndex(){
        return "app/officeSupplies/depository/stockIndex";
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/12 9:44
     * 类介绍  :   办公用品报表
     * 构造参数:
     */
    @RequestMapping("/ReportForm")
    public String ReportForm(){
        return "app/officeSupplies/ReportForm/formIndex";
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/08 13:44
     * 类介绍  :   申请办公用品
     * 构造参数:
     */
    @ResponseBody
    @RequestMapping("/insertObject")
    public ToJson<Object> insertObject(HttpServletRequest request,OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs,int flag){
         return officeTransHistoryService.insertObject(request,officeTranshistoryWithBLOBs,flag);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/08 13:44
     * 类介绍  :   查询我的申请记录
     * 构造参数:
     */
    @ResponseBody
    @RequestMapping("/getMyHistroy")
    public ToJson<OfficeTranshistoryWithBLOBs> getMyHistroy(HttpServletRequest request,int page,int pageSize,boolean useFlag){
         return officeTransHistoryService.getMyHistroy(request,page,pageSize,useFlag);
    }

     /**
      * 创建作者:   高亚峰
      *  创建日期:  2017/10/08 13:44
      * 类介绍  :   删除申请记录
      * 构造参数:
      */
     @ResponseBody
     @RequestMapping("/deleteObject")
     public ToJson<Object> deleteObject(Integer transId){
         return officeTransHistoryService.deleteObject(transId);
     }
    /**
     * 创建作者:   高亚峰
     *  创建日期:  2017/10/08 13:44
     * 类介绍  :   编辑申请记录
     * 构造参数:
     */
    @ResponseBody
    @RequestMapping("/editObject")
    public ToJson<Object> editObject(OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs){
        return officeTransHistoryService.editObject(officeTranshistoryWithBLOBs);
    }
    /**
     * 创建作者:   高亚峰
     *  创建日期:  2017/10/08 13:44
     * 类介绍  :   申请记录详情接口
     * 构造参数:
     */
    @ResponseBody
    @RequestMapping("/getObjectById")
    public ToJson<OfficeTranshistoryWithBLOBs> getObjectById(Integer transId){
        return officeTransHistoryService.getObjectById(transId);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 下午15:47:00
     * 方法介绍:   根据当前登录人查询待批申请
     * 参数说明:   @param currentUser 当前登录人
     * 返回值说明:
     */
    @ResponseBody
    @RequestMapping("/selTranshistoryByState")
    ToJson<OfficeTranshistoryWithBLOBs> selTranshistoryByState(HttpServletRequest request,int page,int pageSize,boolean useFlag, OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs){
        return  officeTransHistoryService.selTranshistoryByState(request,page,pageSize,useFlag,officeTranshistoryWithBLOBs);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 下午15:47:00
     * 方法介绍:   审批办公用品(批准：1，不批准：2)
     * 参数说明:   @param transhistory(transId,transState)
     * 返回值说明:
     */
    @ResponseBody
    @RequestMapping("/upTransHistoryState")
    public ToJson<OfficeTranshistoryWithBLOBs> upTransHistoryState(String transState, String transId, HttpServletRequest request){
        return officeTransHistoryService.upTransHistoryState(transState,transId,request);
    }
    /**
     * 创建作者:   高亚峰
     *  创建日期:  2017/10/08 13:44
     * 类介绍  :   下拉框获取接口
     * 构造参数:
     */
    @ResponseBody
    @RequestMapping("/getDownObjects")
    public AjaxJson getDownObjects(String typeDepository, String officeProductType, String officeInventory) {
        return officeTransHistoryService.getDownObjects(typeDepository, officeProductType, officeInventory);
    }

    @ResponseBody
    @RequestMapping("/getDownObjectLikeBytype")
    public ToJson getDownObjectLikeBytype( String officeProductType,String proName){
        return officeTransHistoryService.getDownObjectLikeBytype(officeProductType,proName);
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 下午15:47:00
     * 方法介绍:   根据条件进行办公用品发放查询（可分页）
     * 参数说明:   @param
     * 返回值说明:
     */
    @ResponseBody
    @RequestMapping("/selGrantByCond")
    ToJson<OfficeTranshistoryWithBLOBs> selGrantByCond(OfficeTranshistoryWithBLOBs transhistory,HttpServletRequest request,Integer page, Integer pageSize, boolean useFlag){
        return  officeTransHistoryService.selGrantByCond(transhistory,request,page,pageSize,useFlag);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 下午15:47:00
     * 方法介绍:   修改发放状态
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    @ResponseBody
    @RequestMapping("/upGrantStatus")
    ToJson<OfficeTranshistoryWithBLOBs>  upGrantStatus (String grantStatus, String transId){
        return  officeTransHistoryService.upGrantStatus(grantStatus,transId);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月9日 下午15:47:00
     * 方法介绍:   办公用品查询
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    @ResponseBody
    @RequestMapping("/selTranshistoryByCond")
     ToJson<OfficeTranshistoryWithBLOBs> selTranshistoryByCond(HttpServletRequest request,OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs, Integer output, HttpServletResponse response,Integer page,Integer pageSize,Boolean useFlag) {

        return  officeTransHistoryService.selTranshistoryByCond(officeTranshistoryWithBLOBs, output, request, response, page, pageSize, useFlag);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月10日 下午15:47:00
     * 方法介绍:   查询今日维护办公用品列表（操作员是当前登录人）
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    @ResponseBody
    @RequestMapping("/selMaintain")
    ToJson<OfficeTranshistoryWithBLOBs> selMaintain(OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs,HttpServletRequest request){
        return  officeTransHistoryService.selMaintain(officeTranshistoryWithBLOBs,request);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月10日 下午15:47:00
     * 方法介绍:   查询今日代登记办公用品列表（操作员是当前登录人）
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    @ResponseBody
    @RequestMapping("/selInstead")
    ToJson<OfficeTranshistoryWithBLOBs> selInstead(OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs,HttpServletRequest request){
        return  officeTransHistoryService.selInstead(officeTranshistoryWithBLOBs,request);
    }
    /**
     * 创建作者:   高亚峰
     *  创建日期:  2017/10/19 14:24
     * 类介绍  :   办公用品归还
     * 构造参数:
     */
    @ResponseBody
    @RequestMapping("/returnObject")
    public ToJson<Object> returnObject(String transIds){
        return officeTransHistoryService.returnObject(transIds);
    }


    //办公用品申领详情页
    @RequestMapping("/ProductInfo")
    public String productInfo(){
        return "app/officeSupplies/product/ProductInfo";
    }

    //办公用品申请警告
    @ResponseBody
    @RequestMapping("/getJingao")
    public ToJson getJingao(String proId,String transQty){
        return officeTransHistoryService.getJingao(Integer.parseInt(proId),Integer.parseInt(transQty));
    }

    //办公用品批量申领页面
    @RequestMapping("/goMyOfficeApplyBatch")
    public String goMyOfficeApplyBatch(){
        return "app/officeSupplies/approval/applyRecordBatch";
    }

    /** 审领暂存提交页面 */
    @RequestMapping("/applyStageSubmit")
    public String applyStageSubmit(){
        return "app/officeSupplies/approval/applyStageSubmit";
    }

    @RequestMapping("/getApplayBatch")
    @ResponseBody
    public  ToJson getApplayBatch(HttpServletRequest request,String jsonStr,String deptManager,String  remark,int flag ){
        return  officeTransHistoryService.getApplayBatch(request,jsonStr,deptManager,remark ,flag);
    }

    /**
     * hwx
     * @param request
     * @param depositoryId  办公用品库id
     * @param typeId        办公用品类别id
     * @param productsId    办公用品id
     * @param beginDate     日期开始时间
     * @param endDate       日期结束时间
     * @return
     */
    @ResponseBody
    @RequestMapping("/getOfficeProducts")
    public ToJson queryOfficeProducts(HttpServletRequest request,Integer depositoryId, Integer typeId, Integer productsId, String beginDate, String endDate){
        return officeTransHistoryService.queryOfficeProducts(depositoryId,typeId,productsId,beginDate,endDate);
    }
    @ResponseBody
    @RequestMapping("/selShopList")
    public ToJson selShopList(HttpServletRequest request,Integer page, Integer limit, boolean useFlag){
        return officeTransHistoryService.selShopList(request,page,limit,useFlag);
    }
    @ResponseBody
    @RequestMapping("/exportShopList")
    public ToJson exportShopList(HttpServletRequest request,HttpServletResponse response){
        return officeTransHistoryService.exportShopList(request,response);
    }


    //    web App  教育版代码

    /*
     *   创建日期 ：2020/9/29
     *   类介绍：办公用品编辑申请界面App
     *
     * */
    @RequestMapping("/editApplyApp")
    public String editApplyApp(int editFlag, int transId, Map<String,Object> map){
        map.put("editFlag",editFlag);
        map.put("transId",transId);
        return "app/officeSupplies/product/m/editApply_app";
    }

    /**
     * 创建日期:   2020/9/29
     * 类介绍  :   办公用品编辑申请界面App
     * 构造参数:
     */
    @RequestMapping("/gpProApplyApp")
    public String goProductApplyApp(int editFlag,int transId, int proid,int depositoryid,int protypeid,Map<String,Object> map){
        map.put("editFlag",editFlag);
        map.put("transId",transId);
        map.put("proid",proid);
        map.put("depositoryid",depositoryid);
        map.put("protypeid",protypeid);
        return "app/officeSupplies/product/m/gpProApply_app";
    }
    @RequestMapping("/selectDetailed")
    @ResponseBody
    public ToJson selectDetailed(HttpServletRequest request,Integer transId,String deptManager,String  remark){
        return officeTransHistoryService.selectDetailed(request,transId,deptManager,remark);
    }
    @RequestMapping("/deleteCommodity")
    @ResponseBody
    public ToJson deleteCommodity(HttpServletRequest request,String proId,Integer transId){
        return officeTransHistoryService.deleteCommodity(request,proId,transId);
    }
    @RequestMapping("/updateCommodity")
    @ResponseBody
    public ToJson updateCommodity(HttpServletRequest request,String jsonStr,Integer transId){
        return officeTransHistoryService.updateCommodity(request,jsonStr,transId);
    }
    @RequestMapping("/selectByBorrower")
    @ResponseBody
    public ToJson selectByBorrower(HttpServletRequest request){
        return officeTransHistoryService.selectByBorrower(request);
    }
    @ResponseBody
    @RequestMapping("/deleteByTransId")
    public  ToJson deleteByTransId(HttpServletRequest request,Integer transId){
        return officeTransHistoryService.deleteByTransId(request,transId);
    }

    /**
     * 办公用品入库汇总
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
    @ResponseBody
    @RequestMapping("/warehousingStatistics")
    ToJson<OfficeTranshistoryWithBLOBs> warehousingStatistics(Integer id,Integer typeId,Integer proId,@RequestParam(value="export",defaultValue ="0")Integer export,String beginDate, String endDate,
                                                              @RequestParam(value="page",defaultValue ="1")Integer page,
                                                              @RequestParam(value="pageSize",defaultValue ="10")Integer pageSize,
                                                              @RequestParam(value="useFlag",defaultValue ="true") boolean useFlag, HttpServletRequest request,HttpServletResponse response){
        return officeTransHistoryService.warehousingStatistics(1,id,typeId,proId,export,beginDate,endDate,page,pageSize,useFlag,request,response);
    }

    /**
     * 办公用品出库汇总
     * @param id 物品ID
     * @param typeId  物品类型ID
     * @param proId  物品库ID
     * @param export  是否导出(1-导出，0-查询)
     * @param beginDate 出库日期范围，开始时间
     * @param endDate  出库日期范围，截止时间
     * @param page  分页页数
     * @param pageSize  分页条数
     * @param useFlag  是否开启分页
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/deliveryStatistics")
    ToJson<OfficeTranshistoryWithBLOBs> deliveryStatistics(Integer id,Integer typeId,Integer proId,@RequestParam(value="export",defaultValue ="0")Integer export,String beginDate, String endDate,
                                                           @RequestParam(value="page",defaultValue ="1")Integer page,
                                                           @RequestParam(value="pageSize",defaultValue ="10")Integer pageSize,
                                                           @RequestParam(value="useFlag",defaultValue ="true") boolean useFlag, HttpServletRequest request,HttpServletResponse response){
        return officeTransHistoryService.warehousingStatistics(2,id,typeId,proId,export,beginDate,endDate,page,pageSize,useFlag,request,response);
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
    @ResponseBody
    @RequestMapping("/settlementStatistics")
    ToJson<OfficeTranshistoryWithBLOBs> settlementStatistics(Integer id, Integer typeId, Integer proId, @RequestParam(value="export",defaultValue ="0")Integer export, String userIds, String beginDate, String endDate,
                                                             @RequestParam(value="page",defaultValue ="1")Integer page,
                                                             @RequestParam(value="pageSize",defaultValue ="10")Integer pageSize,
                                                             @RequestParam(value="useFlag",defaultValue ="true") boolean useFlag, HttpServletRequest request, HttpServletResponse response){
        return officeTransHistoryService.settlementStatistics(id,typeId,proId,export,userIds,beginDate,endDate,page,pageSize,useFlag,request,response);
    }

    /**
     * 办公用品维护统计
     * @param id 物品ID
     * @param typeId  物品类型ID
     * @param proId  物品库ID
     * @param beginDate 维护日期范围，开始时间
     * @param endDate  维护日期范围，截止时间
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/maintainStatistics")
    ToJson<OfficeTranshistoryWithBLOBs> maintainStatistics(Integer id,Integer typeId,Integer proId,Date beginDate, Date endDate,HttpServletRequest request){
        return officeTransHistoryService.maintainStatistics(1,id,typeId,proId,beginDate,endDate,request);
    }


    /**
     * 办公用品报废统计
     * @param id 物品ID
     * @param typeId  物品类型ID
     * @param proId  物品库ID
     * @param beginDate 报废日期范围，开始时间
     * @param endDate  报废日期范围，截止时间
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/scrapStatistics")
    ToJson<OfficeTranshistoryWithBLOBs> scrapStatistics(Integer id,Integer typeId,Integer proId,Date beginDate, Date endDate,HttpServletRequest request){
        return officeTransHistoryService.maintainStatistics(2,id,typeId,proId,beginDate,endDate,request);
    }

    @ResponseBody
    @RequestMapping("/updateReturn")
    ToJson<OfficeTranshistoryWithBLOBs>  updateReturn (Integer transId){
        return  officeTransHistoryService.updateReturn(transId);
    }

    @ResponseBody
    @RequestMapping("/earlyReturn")
    public void earlyReturn(HttpServletRequest request,Integer transId) {
        officeTransHistoryService.earlyReturn(request,transId);
    }
}
