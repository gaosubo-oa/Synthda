package com.xoa.controller.address;

import com.xoa.model.address.Address;
import com.xoa.model.address.AddressWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.service.address.AddressService;
import com.xoa.service.sms.SmsService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ServletUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/address")
public class AddressController {
    @Autowired
    AddressService addressService;

    @Resource
    SmsService smsService;

    //电话簿主页面
    @RequestMapping("/index")
    public String myAttendance(HttpServletRequest request) {
        String bodyId=request.getParameter("bodyId");
        if(!StringUtils.checkNull(bodyId)){
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users=SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            smsService.setSmsFileRead(bodyId,"100","/address/index",users);
        }
        return "app/address/index";
    }

    //电话簿主页面
    @RequestMapping("/addressh5")
    public String addressh5(HttpServletRequest request) {
        return "app/address/index";
    }

    //编辑人员主页面
    @RequestMapping("/editIndex")
    public String editIndex(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/editIndex";
    }



    //请求分组联系人详情页面
    @RequestMapping("/showList")
    public String showList(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/show_list";
    }

    //请求联系人详情页面
    @RequestMapping("/show_add")
    public String getUserInfo(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/show_add";
    }
    //分组发送短信页面
    @RequestMapping("/sendMessage")
    public String sendMessage(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/group/sendMessage";
    }
    //同事发送短信外部号码页面
    @RequestMapping("/oaMessage")
    public String oaMessage(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/oaMessage";
    }
    //同事发送短信页面
    @RequestMapping("/outMessage")
    public String outMessage(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/group/outMessage";
    }

    @RequestMapping("/show_edit")
    public String getUserEdit(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/show_edit";
    }

    //联系人详情页面
    @RequestMapping("/show_view")
    public String getUserInfoView(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/view";
    }

    //    公共通讯簿页面
    @RequestMapping("/commonAdd")
    public String commonAdd(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/commonAddress/commonAdd";
    }

    //添加联系人页面
    @RequestMapping("/new")
    public String add(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/new";
    }

    //导入页面
    @RequestMapping("/goImportUsers")
    public String goImportUsers(){
        return "app/address/importUsers";
    }


    //设置
    @RequestMapping("/setting")
    public String setting(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/setting";
    }

    //修改联系人信息页面
    @RequestMapping("/edit")
    public String edit(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/edit";
    }
    //查询联系人信息页面
    @RequestMapping("/conQuery")
    public String conQuery(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/conQuery";
    }


    //根据组id获取该分组下联系人
    @ResponseBody
    @RequestMapping("/getUsersById")
    public BaseWrapper getUsersById(HttpServletRequest request, String groupId, String PUBLIC_FLAG, String SHARE_TYPE, String TYPE) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return addressService.getUsersById(request, groupId, PUBLIC_FLAG, SHARE_TYPE, TYPE);
    }

    @ResponseBody
    @RequestMapping("/getNotUserById")
    public BaseWrapper getNotUserById(HttpServletRequest request, String groupId, String PUBLIC_FLAG, String SHARE_TYPE, String TYPE){
        return addressService.getNotUserById(request, groupId, PUBLIC_FLAG, SHARE_TYPE, TYPE);
    }

    //根据id获取联系人详情
    @ResponseBody
    @RequestMapping("/getUserInfoById")
    public BaseWrapper getUserInfoById(HttpServletRequest request,@RequestParam(value = "uid",required = false)String uid,
                                       @RequestParam(value = "addId",required = false) String addId
                                       ) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        if (uid!=null){
            return addressService.selectByPrimaryKey(uid);
        }else {
            return addressService.selectByPrimaryKey(addId);
        }

    }


    //添加联系人(带头像参数)
    @ResponseBody
    @RequestMapping("/addUser")
    public BaseWrapper addUser(HttpServletRequest request, String birthday,String  addStart , String  addEnd, MultipartFile file,String type,String shareUserId) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        AddressWithBLOBs addressWithBLOBs = new AddressWithBLOBs();
        ServletUtil.requestParamsCopyToObject(request, addressWithBLOBs);
        return addressService.addUser(request, addressWithBLOBs,birthday,addStart,addEnd,file,type,shareUserId);
    }


    //修改联系人信息
    @ResponseBody
    @RequestMapping("/updateUser")
    public BaseWrapper updateAdd(HttpServletRequest request, String birthday,MultipartFile file,String type,String shareUserId) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        AddressWithBLOBs addressWithBLOBs = new AddressWithBLOBs();
        ServletUtil.requestParamsCopyToObject(request, addressWithBLOBs);
        return addressService.updateUser(request, addressWithBLOBs,birthday,file,type,shareUserId);
    }

    //删除联系人信息
    @ResponseBody
    @RequestMapping("/deleteUser")
    public BaseWrapper deleteUser(HttpServletRequest request, Integer addId) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return addressService.deleteUser(request, Integer.valueOf(addId));
    }
    @ResponseBody
    @RequestMapping("/deleteUserAll")
    public BaseWrapper deleteUserAll(HttpServletRequest request,  String[] addId) {
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        /* return addressService.deleteUser(request, Integer.valueOf(addId));*/


        BaseWrapper baseWrapper = new BaseWrapper();


        if (addId.length>0) {
            addressService.deleteUserss(request,addId);

        }
        baseWrapper.setStatus(true);
        baseWrapper.setFlag(true);
        if (locale.equals("zh_CN")) {
            baseWrapper.setData("删除成功");
        } else if (locale.equals("en_US")) {
            baseWrapper.setData("Deleted successfully");
        } else if (locale.equals("zh_TW")) {
            baseWrapper.setData("删除成功");
        }
        return baseWrapper;
    }
    /**
     * 查询共享联系人
     * 作者：王煜
     * 日期：2022/07/21
     * 说明：查询共享联系人
     */
    @ResponseBody
    @RequestMapping("/getShareUsersById")
    public  BaseWrapper getShareUsersById(HttpServletRequest request, String groupId, String PUBLIC_FLAG, String SHARE_TYPE, String TYPE){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return addressService.getShareById(request, groupId, PUBLIC_FLAG, SHARE_TYPE, TYPE);

    }
    @ResponseBody
    @RequestMapping("/selectStartUser")
    public ToJson<Address> selectStartUser(HttpServletRequest request, Integer page,
                                         Integer pageSize, boolean useFlag, Address address, String export, HttpServletResponse response){
        return addressService.selectStartUser(request, page, pageSize, useFlag, address,export,response);
    }



    /**
     * 作者: 张凯铭
     * 日期: 2018/05/12
     * 说明: 根据用户组和名字来搜索用户
     */
    @ResponseBody
    @RequestMapping("/query")
    public BaseWrapper query(Integer groupId, String name) {
        return addressService.queryAddress(groupId, name);
    }

    /**
     * 作者: 张航宁
     * 日期: 2017/10/18
     * 说明: 导出
     */
   /* @ResponseBody
    @RequestMapping("/exportAddress")
    public BaseWrapper exportAddress(HttpServletRequest request, HttpServletResponse response){
        return addressService.exportAddress(request,response);
    }*/


    /**
     * 作者: 张凯铭
     * 日期: 2018/5/12
     * 说明: 通讯录查询
     */
    @ResponseBody
    @RequestMapping("/selectAddress")
    public ToJson<Address> selectAddress(HttpServletRequest request, Integer page,
                                         Integer pageSize, boolean useFlag, Address address, String export, HttpServletResponse response){
        return addressService.selectAddress(request, page, pageSize, useFlag, address,export,response);
    }

    /**
     * 作者: 张凯铭
     * 日期: 2018/5/15
     * 说明: 查询同部门联系人
     */
    @ResponseBody
    @RequestMapping("/selectUser")
    public ToJson<Users> selectUser(HttpServletRequest request, Integer page,
                                    Integer pageSize, boolean useFlag, Users users){
        return addressService.selectUser(request, page, pageSize, useFlag,users);
    }

    @ResponseBody
    @RequestMapping("/queryUserInfoById")
    public ToJson<Users> getUserInfoById(Integer uid, HttpServletRequest request){
        return addressService.getUserInfoById(uid,request);
    }
    @ResponseBody
    @RequestMapping("/importAddress")
    public ToJson importAddress(HttpServletRequest request,HttpServletResponse response,MultipartFile file){
        return addressService.importAddress(request,response,file);
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); // true:允许输入空值，false:不能为空值
    }


}
