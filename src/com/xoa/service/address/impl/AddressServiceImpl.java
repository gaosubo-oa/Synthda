package com.xoa.service.address.impl;

import com.xoa.dao.address.AddressGroupMapper;
import com.xoa.dao.address.AddressMapper;
import com.xoa.dao.hierarchical.HierarchicalGlobalMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.address.Address;
import com.xoa.model.address.AddressWithBLOBs;
import com.xoa.model.addressGroup.AddressGroup;
import com.xoa.model.addressGroup.AddressGroupWithBLOBs;
import com.xoa.model.department.Department;
import com.xoa.model.hierarchical.HierarchicalGlobal;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.users.Users;
import com.xoa.service.address.AddressService;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.sms.SmsService;
import com.xoa.util.*;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.page.PageParams;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.xoa.util.FileUploadUtil.allowUpload;

/**
 * Created by 张勇 on 2017/10/8.
 */
@Service
public class AddressServiceImpl implements AddressService {

    @Autowired
    AddressMapper addressMapper;
    @Autowired
    AddressGroupMapper addressGroupMapper;
    @Autowired
    HierarchicalGlobalMapper hierarchicalGlobalMapper;
    @Resource
    DepartmentService departmentService;

    @Resource
    private SmsService smsService;

    @Resource
    private UsersMapper usersMapper;


    /** 查询个人分组人员
     * @param request
     * @param groupId
     * @param PUBLIC_FLAG
     * @param SHARE_TYPE  人员来源 如果为2 则是oa人员
     * @param TYPE
     * @return
     */
    @Override
    public BaseWrapper getUsersById(HttpServletRequest request, String groupId, String PUBLIC_FLAG, String SHARE_TYPE, String TYPE) {
        BaseWrapper baseWrapper = new BaseWrapper();
        //获取当前登陆的用户user_id
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        if(groupId==null){
        }else if (groupId.equals("-1")){
            groupId = null;
        }
        List<Address> data = new ArrayList<>();
        List<Address> addressList = new ArrayList<>();
        if(groupId==null){
            Map param1 = new HashMap();
            param1.put("userId",users.getUserId());
            List<AddressGroupWithBLOBs> addressGroupWithBLOBs1 = addressGroupMapper.selectPublicGroup(param1);
            String privDept = null;
            String privRole = null;
            String privUser = null;
            Map<String, Object> maps = new HashMap<String, Object>();
            if (users != null && users.getUserId() != null) {
                privUser = users.getUserId();
                privRole = users.getUserPriv() + "";
                privDept = users.getDeptId() + "";
            }
            maps.put("userId","");
            maps.put("privDept", privDept);
            maps.put("privRole", privRole);
            maps.put("privUser", privUser);
            List<AddressGroupWithBLOBs> addressGroupWithBLOBs2 = new ArrayList<AddressGroupWithBLOBs>();
            List<AddressGroupWithBLOBs> addressGroupWithBLOBsList = addressGroupMapper.selectAllAddressGroup(maps);

            if(addressGroupWithBLOBs1.size()>0){
                for (AddressGroupWithBLOBs addressGroupWithBLOBs4:addressGroupWithBLOBs1){
                    addressGroupWithBLOBs2.add(addressGroupWithBLOBs4);
                }
            }
            if(addressGroupWithBLOBsList.size()>0){
                for (AddressGroupWithBLOBs addressGroupWithBLOBs3:addressGroupWithBLOBsList){
                    addressGroupWithBLOBs2.add(addressGroupWithBLOBs3);
                }
            }
            Map<String, Object> param = new HashedMap();
            param.put("userId", users.getUserId());
            param.put("groupId", groupId);
            data = addressMapper.getUsersById(param);
            for (Address address:data){
                for(AddressGroupWithBLOBs addressGroupWithBLOBs:addressGroupWithBLOBs2){
                    if(address.getGroupId()==null||address.getGroupId()==0){
                        addressList.add(address);
                        break;
                    }else if(address.getGroupId()==addressGroupWithBLOBs.getGroupId()){
                        addressList.add(address);
                    }

                }
            }
        }else {
            Map<String, Object> param = new HashedMap();
            param.put("userId", users.getUserId());
            param.put("groupId", groupId);
            addressList = addressMapper.getUsersById(param);
        }
        baseWrapper.setData(addressList);
        baseWrapper.setStatus(true);
        return baseWrapper;
    }
    /**
     * 作者: 季佳伟
     * 日期: 2017/12/15
     * 说明: 查询分组内人员，并根据权限判断显示公共通讯簿分组人员
     */
    public BaseWrapper getAddressUser(HttpServletRequest request, String groupId, String PUBLIC_FLAG, String SHARE_TYPE, String TYPE) {
        BaseWrapper baseWrapper = new BaseWrapper();
        //获取当前登陆的用户user_id
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        if(groupId==null){
        }else if (groupId.equals("-1")){
            groupId = null;
        }
        List<Address> data = new ArrayList<>();
        List<Address> addressList = new ArrayList<>();
        if(groupId==null){
            Map param1 = new HashMap();
            param1.put("userId",users.getUserId());
            List<AddressGroupWithBLOBs> addressGroupWithBLOBs1 = addressGroupMapper.selectPublicGroup(param1);
            String privDept = null;
            String privRole = null;
            String privUser = null;
            Map<String, Object> maps = new HashMap<String, Object>();
            if (users != null && users.getUserId() != null) {
                privUser = users.getUserId();
                privRole = users.getUserPriv() + "";
                privDept = users.getDeptId() + "";
            }
            maps.put("userId","");
            maps.put("privDept", privDept);
            maps.put("privRole", privRole);
            maps.put("privUser", privUser);
            List<AddressGroupWithBLOBs> addressGroupWithBLOBs2 = new ArrayList<AddressGroupWithBLOBs>();
            List<AddressGroupWithBLOBs> addressGroupWithBLOBsList = addressGroupMapper.selectAllAddressGroup(maps);

            if(addressGroupWithBLOBs1.size()>0){
                for (AddressGroupWithBLOBs addressGroupWithBLOBs4:addressGroupWithBLOBs1){
                    addressGroupWithBLOBs2.add(addressGroupWithBLOBs4);
                }
            }
            if(addressGroupWithBLOBsList.size()>0){
                for (AddressGroupWithBLOBs addressGroupWithBLOBs3:addressGroupWithBLOBsList){
                    addressGroupWithBLOBs2.add(addressGroupWithBLOBs3);
                }
            }
            Map<String, Object> param = new HashedMap();
            param.put("userId", users.getUserId());
            param.put("groupId", groupId);
            data = addressMapper.getUsersById(param);
            for (Address address:data){
                for(AddressGroupWithBLOBs addressGroupWithBLOBs:addressGroupWithBLOBs2){
                    if(address.getGroupId()==0){
                        addressList.add(address);
                        break;
                    }else if(address.getGroupId()==addressGroupWithBLOBs.getGroupId()){
                        addressList.add(address);
                    }

                }
            }
        }else {
            Map<String, Object> param = new HashedMap();
            param.put("userId", users.getUserId());
            param.put("groupId", groupId);
            addressList = addressMapper.getUsersById(param);
        }
        baseWrapper.setData(addressList);
        baseWrapper.setStatus(true);
        return baseWrapper;
    }

    @Override
    public BaseWrapper selectByPrimaryKey(String addId) {
        BaseWrapper baseWrapper = new BaseWrapper();
        String[] split = addId.split(",");
        addId  =   split[0];
        Map<String,Object>map = new HashMap<>();
        AddressWithBLOBs addressWithBLOBs = addressMapper.selectByPrimaryKey(Integer.parseInt(addId));
        if(addressWithBLOBs.getShareUser()!=null){
            StringBuffer userNames=new StringBuffer();
            String[] userIds = addressWithBLOBs.getShareUser().split(",");
            for (int i = 0; i < userIds.length; i++) {
                Users users = usersMapper.selectByUserId(userIds[i]);
                if(users!=null){
                    userNames.append(users.getUserName()+",");
                }
            }
            if(userNames!=null&&userNames.length()>0){
                addressWithBLOBs.setShareUserName(userNames.toString());
            }
        }
        Date birthday = addressWithBLOBs.getBirthday();
        String format = "";
        if (birthday!=null){
            SimpleDateFormat sdf = new SimpleDateFormat( " yyyy-MM-dd " );
            format = sdf.format(birthday);
        }
        Date addStart = addressWithBLOBs.getAddStart();
        if (addStart!=null){
            SimpleDateFormat sdf = new SimpleDateFormat( " yyyy-MM-dd " );
            String s1 = sdf.format(addStart);
            map.put("addStart",s1);

        }else {
            map.put("addStart","");
        }
        Date addEnd = addressWithBLOBs.getAddEnd();
        if (addEnd!=null){
            SimpleDateFormat sdf = new SimpleDateFormat( " yyyy-MM-dd " );
            String  s2 = sdf.format(addEnd);
            map.put("addEnd",s2);
        }else{
            map.put("addEnd","");
        }
        map.put("addressWithBLOBs",addressWithBLOBs);
        map.put("birthday",format);

        baseWrapper.setData(map);
        baseWrapper.setStatus(true);
        baseWrapper.setFlag(true);
        return baseWrapper;
    }

    /**
     * 添加联系人
     *
     * @param request
     * @return
     */
    @Override
    public BaseWrapper addUser(HttpServletRequest request, AddressWithBLOBs addressWithBLOBs, String birthday,String addStart , String  addEnd, MultipartFile file,String type,String shareUserId) {
        BaseWrapper baseWrapper = new BaseWrapper();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        String sqlType = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try {
            if (users == null || users.getUid() == null) {
                baseWrapper.setFlag(false);
                baseWrapper.setMsg(I18nUtils.getMessage("address.th.userInformationIsIncorrect"));
                return baseWrapper;
            }
            if (!ObjectUtils.isEmpty(file) && file.getSize() > 0) {
                String imageType = file.getContentType();
                boolean b = allowUpload(imageType);
                if (!b) {
                    baseWrapper.setFlag(false);
                    baseWrapper.setMsg(I18nUtils.getMessage("address.th.thePictureFormatIsIncorrect"));
                    return baseWrapper;
                }
                String fileName = file.getOriginalFilename();

                if (!FileUploadUtil.checkFilePicture(fileName)) {
                    baseWrapper.setFlag(false);
                    baseWrapper.setMsg(I18nUtils.getMessage("address.th.theSuffixOfTheUploadedFileIsNotAvailable"));
                    return baseWrapper;
                }
                String realPath = request.getSession().getServletContext().getRealPath("/");
                String resourcePath = "ui/img/address";
//                Users users = new Users();
                //上传图片并进行修改数据库数据
                String fileNames = FileUploadUtil.rename(file.getOriginalFilename());
                File dir = new File(realPath + resourcePath);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                File realfile = new File(dir, fileNames);
                file.transferTo(realfile);
                String fileName128 = FileUploadUtil.rename(fileNames, "s");
                addressWithBLOBs.setAttachmentId(fileName128);
            }
            if(!StringUtils.checkNull(birthday)){
                Date d = new SimpleDateFormat("yyyy-MM-dd").parse(birthday);
                addressWithBLOBs.setBirthday(d);
            }
            if (!StringUtils.checkNull(addStart) && !StringUtils.checkNull(addStart)){
                Date start = new SimpleDateFormat("yyyy-MM-dd").parse(addStart);
                Date end = new SimpleDateFormat("yyyy-MM-dd").parse(addEnd);
                addressWithBLOBs.setAddStart(start);
                addressWithBLOBs.setAddEnd(end);

            }
            if (!StringUtils.checkNull(addStart) ){
                Date start = new SimpleDateFormat("yyyy-MM-dd").parse(addStart);
                addressWithBLOBs.setAddStart(start);

            }
            //共享事务提醒
            if(!StringUtils.checkNull(type) && !StringUtils.checkNull(addressWithBLOBs.getShareUser())){
                // 判断是否需要进行催办提醒
                String title =  "您有新的通讯簿共享联系人。";
                String context = "共享联系人姓名:"+addressWithBLOBs.getPsnName()+",请尽快查看!";
                if (locale.equals("en_US")) {
                    title =  "You have new shared contacts in the address book。";
                    context = "Shared contact name:"+addressWithBLOBs.getPsnName()+",Please check as soon as possible!";
                } else if (locale.equals("zh_TW")) {
                    title =  "您有新的通訊簿共享聯繫人。";
                    context = "共享聯繫人姓名:"+addressWithBLOBs.getPsnName()+",請盡快查看!";
                }
                SmsBody smsBody = new SmsBody();
                smsBody.setSendTime(DateFormat.getTime(DateFormat.getCurrentTime()));
                smsBody.setSmsType("100");
                smsBody.setRemindUrl("/address/index");
                smsBody.setTitle(title);
                smsBody.setContent(title + context);
                smsBody.setFromId(users.getUserId());
                smsBody.setToId(shareUserId);
                smsBody.setIsAttach("0");
                smsService.saveSms(smsBody, shareUserId, "1", "1", smsBody.getTitle(), smsBody.getContent(), "xoa"+sqlType);
            }
            addressWithBLOBs.setUserId(users.getUserId());
            addressWithBLOBs.setShareUser(shareUserId);
            if (addressMapper.insertSelective(addressWithBLOBs) > 0) {
                baseWrapper.setStatus(true);
                baseWrapper.setFlag(true);
                baseWrapper.setData(addressWithBLOBs);
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return baseWrapper;
    }

    public BaseWrapper getNotUserById(HttpServletRequest request, String groupId, String PUBLIC_FLAG, String SHARE_TYPE, String TYPE) {
        BaseWrapper baseWrapper = new BaseWrapper();
        //获取当前登陆的用户user_id
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);

        Map<String, Object> param = new HashedMap();
        param.put("userId", users.getUserId());
        param.put("groupId", groupId);
        List<Address> data = addressMapper.getNotUserById(param);
        List<Address> addressList = new ArrayList<>();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userId","");
        List<AddressGroupWithBLOBs> addressGroupWithBLOBsList =addressGroupMapper.selectPublicGroup(map);
        boolean a=false;
        for(int x=0;x<data.size();x++){
            for (int y=0;y<addressGroupWithBLOBsList.size();y++){
                if(data.get(x).getGroupId()==addressGroupWithBLOBsList.get(y).getGroupId()){
                    a = true;
                }else {
                    a=false;
                }
                if(a){
                    data.remove(x);
                    x--;
                    break;
                }
            }
        }
        baseWrapper.setData(data);
        baseWrapper.setStatus(true);
        return baseWrapper;
    }

    public BaseWrapper updateUser(HttpServletRequest request, AddressWithBLOBs addressWithBLOBs, String birthday, MultipartFile file,String type,String shareUserId) {
        BaseWrapper baseWrapper = new BaseWrapper();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String sqlType = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        Users usersTemp = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try {
         String addStart =   request.getParameter("addStart");
         String addEnd=    request.getParameter("addEnd");
            if (usersTemp == null || usersTemp.getUid() == null) {
                baseWrapper.setFlag(false);
                baseWrapper.setMsg(I18nUtils.getMessage("address.th.userInformationIsIncorrect"));
                return baseWrapper;
            }
            if (!ObjectUtils.isEmpty(file) && file.getSize() > 0) {
                String imageType = file.getContentType();
                boolean b = allowUpload(imageType);
                if (!b) {
                    baseWrapper.setFlag(false);
                    baseWrapper.setMsg(I18nUtils.getMessage("address.th.thePictureFormatIsIncorrect"));
                    return baseWrapper;
                }
                String fileName = file.getOriginalFilename();

                if (!FileUploadUtil.checkFilePicture(fileName)) {
                    baseWrapper.setFlag(false);
                    baseWrapper.setMsg(I18nUtils.getMessage("address.th.theSuffixOfTheUploadedFileIsNotAvailable"));
                    return baseWrapper;
                }
                String realPath = request.getSession().getServletContext().getRealPath("/");
                String resourcePath = "ui/img/address";
//                Users users = new Users();
                //上传图片并进行修改数据库数据
                String fileNames = FileUploadUtil.rename(file.getOriginalFilename());
                File dir = new File(realPath + resourcePath);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                File realfile = new File(dir, fileNames);
                file.transferTo(realfile);
                String fileName128 = FileUploadUtil.rename(fileNames, "s");
                addressWithBLOBs.setAttachmentId(fileName128);
            }
            if (!StringUtils.checkNull(birthday)) {
                Date d = new SimpleDateFormat("yyyy-MM-dd").parse(birthday);
                addressWithBLOBs.setBirthday(d);
            }
            if (!StringUtils.checkNull(addStart)) {
                Date d = new SimpleDateFormat("yyyy-MM-dd").parse(addStart);
                addressWithBLOBs.setAddStart(d);
            }
            if (!StringUtils.checkNull(addEnd)) {
                Date d = new SimpleDateFormat("yyyy-MM-dd").parse(addEnd);
                addressWithBLOBs.setAddEnd(d);
            }
            //共享事务提醒
            if(!StringUtils.checkNull(type) && !StringUtils.checkNull(addressWithBLOBs.getShareUser())){
                // 判断是否需要进行催办提醒
                String title =  "您有新的通讯簿共享联系人。";
                String context = "共享联系人姓名:"+addressWithBLOBs.getPsnName()+",请尽快查看!";
                if (locale.equals("en_US")) {
                    title =  "You have new shared contacts in the address book。";
                    context = "Shared contact name:"+addressWithBLOBs.getPsnName()+",Please check as soon as possible!";
                } else if (locale.equals("zh_TW")) {
                    title =  "您有新的通訊簿共享聯繫人。";
                    context = "共享聯繫人姓名:"+addressWithBLOBs.getPsnName()+",請盡快查看!";
                }
                SmsBody smsBody = new SmsBody();
                smsBody.setSendTime(DateFormat.getTime(DateFormat.getCurrentTime()));
                smsBody.setSmsType("100");
                smsBody.setRemindUrl("/address/index");
                smsBody.setTitle(title);
                smsBody.setContent(title + context);
                smsBody.setFromId(usersTemp.getUserId());
                smsBody.setToId(shareUserId);
                smsBody.setIsAttach("0");
                smsService.saveSms(smsBody, shareUserId, "1", "1", smsBody.getTitle(), smsBody.getContent(), "xoa"+sqlType);
            }
            addressWithBLOBs.setUserId(usersTemp.getUserId());
            if (addressMapper.updateByPrimaryKey(addressWithBLOBs) > 0) {
                baseWrapper.setStatus(true);
                baseWrapper.setFlag(true);
                baseWrapper.setData(addressWithBLOBs);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return baseWrapper;
    }

    public BaseWrapper deleteUser(HttpServletRequest request, Integer addId) {
        BaseWrapper baseWrapper = new BaseWrapper();
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        if (addressMapper.deleteByPrimaryKey(addId) > 0) {
            baseWrapper.setStatus(true);
            baseWrapper.setFlag(true);
            if (locale.equals("zh_CN")) {
                baseWrapper.setData("删除成功");
            } else if (locale.equals("en_US")) {
                baseWrapper.setData("Deleted successfully");
            } else if (locale.equals("zh_TW")) {
                baseWrapper.setData("删除成功");
            }
        }
        return baseWrapper;
    }
    public Integer deleteUserss(HttpServletRequest request, String[] addId) {
        return addressMapper.deleteByPrimaryKeyss(addId);
    }


    @Override
    public BaseWrapper queryAddress(Integer groupId, String name) {
        BaseWrapper baseWrapper = new BaseWrapper();
        try {
            List<Address> addresses = addressMapper.queryAddress(groupId, name);
            baseWrapper.setStatus(true);
            baseWrapper.setFlag(true);
            baseWrapper.setData(addresses);
        } catch (Exception e) {
            e.printStackTrace();
            baseWrapper.setStatus(false);
            baseWrapper.setFlag(false);
        }
        return baseWrapper;
    }

    @Override
    public BaseWrapper getColleagues(HttpServletRequest request) {
        BaseWrapper baseWrapper = new BaseWrapper();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        boolean flag = false;
        HierarchicalGlobal hierarchicalGlobal = new HierarchicalGlobal();
        hierarchicalGlobal.setModelId("0132");
        HierarchicalGlobal global = hierarchicalGlobalMapper.selByModel(hierarchicalGlobal);

        String globalDepts = global.getGlobalDept();
        String globalPersons = global.getGlobalPerson();
        String globalPriv = global.getGlobalPriv();

        // 判断权限
        if (!StringUtils.checkNull(globalDepts)) {
            String[] split = globalDepts.split(",");
            if (split.length > 0) {
                for (String deptId : split) {
                    if (deptId.equals(user.getDeptId())) {
                        flag = true;
                    }
                }
            }
        } else if (!StringUtils.checkNull(globalPriv)) {
            String[] split = globalPriv.split(",");
            if (split.length > 0) {
                for (String userPriv : split) {
                    if (userPriv.equals(user.getUserPriv())) {
                        flag = true;
                    }
                }
            }
        } else if (!StringUtils.checkNull(globalPersons)) {
            String[] split = globalPersons.split(",");
            if (split.length > 0) {
                for (String userId : split) {
                    if (userId.equals(user.getUserId())) {
                        flag = true;
                    }
                }
            }
        }


        // flag如果为true 有权限 获取所有同事信息 false 获取本部门
        if (flag) {
            List<Address> alluser = addressMapper.getAllUsers(null);
            baseWrapper.setData(alluser);
            baseWrapper.setFlag(true);
            baseWrapper.setStatus(true);
        } else {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("deptId", user.getDeptId());
            List<Address> usersByDeptId = addressMapper.getAllUsers(map);
            baseWrapper.setData(usersByDeptId);
            baseWrapper.setFlag(true);
            baseWrapper.setStatus(true);
        }

        return baseWrapper;
    }

    @Override
    public ToJson<Address> importAddress(HttpServletRequest request, HttpServletResponse response, MultipartFile file) {
        ToJson<Address> json = new ToJson<>();
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        InputStream in=null;
        try {
            //判读当前系统
            //读取配置文件
            ResourceBundle rb = ResourceBundle.getBundle("upload");
            String osName = System.getProperty("os.name");
            StringBuffer path = new StringBuffer();
                StringBuffer buffer=new StringBuffer();
        if(osName.toLowerCase().startsWith("win")){
            //sb=sb.append(rb.getString("upload.win"));
            //判断路径是否是相对路径，如果是的话，加上运行的路径
            String uploadPath = rb.getString("upload.win");
            if(uploadPath.indexOf(":")==-1){
                //获取运行时的路径
                String basePath = this.getClass().getClassLoader().getResource(".").getPath()+ File.pathSeparator;
                //获取截取后的路径
                String str2 = "";
                if(basePath.indexOf("/xoa")!=-1){
                    //获取字符串的长度
                    int length = basePath.length();
                    //返回指定字符在此字符串中第一次出现处的索引
                    int index = basePath.indexOf("/xoa");
                    //从指定位置开始到指定位置结束截取字符串
                    str2=basePath.substring(0,index);
                }
                path = path.append(str2 + "/xoa");
            }
            path.append(uploadPath);
            buffer=buffer.append(rb.getString("upload.win"));
        }else{
            path=path.append(rb.getString("upload.linux"));
            buffer=buffer.append(rb.getString("upload.linux"));
        }
            // 判断是否为空文件
            if (file.isEmpty()) {
                json.setMsg(I18nUtils.getMessage("address.th.pleaseUploadTheFile"));
                json.setFlag(1);
                return json;
            } else {
                String fileName = file.getOriginalFilename();
                if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")) {
                    String uuid = UUID.randomUUID().toString().replaceAll("-", "");
                    int pos = fileName.indexOf(".");
                    String extName = fileName.substring(pos);
                    String newFileName = uuid + extName;
                    File dest = new File(path.toString(), newFileName);
                    file.transferTo(dest);
                    // 将文件上传成功后进行读取文件
                    // 进行读取的路径
                    String readPath = path.append(System.getProperty("file.separator")).append(newFileName).toString();
                    in = new FileInputStream(readPath);
                    HSSFWorkbook excelObj = new HSSFWorkbook(in);
                    HSSFSheet sheetObj = excelObj.getSheetAt(0);
                    Row row = sheetObj.getRow(0);
                    int colNum = row.getPhysicalNumberOfCells();
                    int lastRowNum = sheetObj.getLastRowNum();
                    Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
                    Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
//                    UserFunction userFunction = new UserFunction();
                    List<AddressWithBLOBs> addresseList=new ArrayList<>();
                    Map<String,AddressGroup> addressGroupMap=new HashMap();
                    Map param=new HashMap();
                    param.put("userId",users.getUserId());
                    param.put("type","0");
                    for (int i = 1; i <= lastRowNum; i++) {
                        AddressWithBLOBs address = new AddressWithBLOBs();
                        address.setUserId(users.getUserId());
                        row = sheetObj.getRow(i);
                        if (row != null) {
                            for (int j = 0; j < colNum; j++) {
                                Cell cell = row.getCell(j);
                                if (cell != null) {
                                    cell.setCellType(CellType.STRING);
                                    switch (j) {
                                        case 0:
                                            //所属组
                                            String group = cell.getStringCellValue();
                                            if(group==null||group.equals("")){
                                                address.setGroupId(0);
                                            }else {

                                                AddressGroup addressGroup=addressGroupMap.get(group);
                                                if(addressGroup==null){
                                                    param.put("groupName",group);
                                                    List<AddressGroup> addressGroupList = addressGroupMapper.selectGroupsByName(param);
                                                    if(addressGroupList!=null&&addressGroupList.size()>0){
                                                        addressGroup=addressGroupList.get(0);
                                                        addressGroupMap.put(group,addressGroup);
                                                    }else{
                                                        json.setMsg(I18nUtils.getMessage("address.th.noGroup1")+group+I18nUtils.getMessage("address.th.noGroup2")+I18nUtils.getMessage("address.th.noGroup3"));
                                                        json.setFlag(1);
                                                        return json;
                                                    }
                                                }
                                                address.setGroupId(addressGroup.getGroupId());
                                            }
                                            break;
                                        case 1:
                                            //联系人姓名
                                            address.setPsnName(cell.getStringCellValue());
                                            break;
                                        case 2:
                                            //性别(0-男,1-女)
                                            String sex = cell.getStringCellValue();
                                            if(sex.equals(I18nUtils.getMessage("userInfor.th.male"))){
                                                address.setSex("0");
                                            }else if (sex.equals(I18nUtils.getMessage("userInfor.th.female"))){
                                                address.setSex("1");
                                            }else {
                                                json.setMsg(I18nUtils.getMessage("address.th.genderCanOnlyBeSelectedAsMaleOrFemale"));
                                                json.setFlag(1);
                                                return json;
                                            }
                                            break;
                                        case 3:
                                            //昵称
                                            address.setNickName(cell.getStringCellValue());
                                            break;
                                        case 4:
                                            //生日
                                            String result = null;
                                            if(cell.getCellType() == CellType.NUMERIC) {
                                                short format = cell.getCellStyle().getDataFormat();
                                                SimpleDateFormat sdf = null;
                                                if (format == 14 || format == 31 || format == 57 || format == 58) {
                                                    //日期
                                                    sdf = new SimpleDateFormat("yyyy-MM-dd");
                                                } else if (format == 20 || format == 32) {
                                                    //时间
                                                    sdf = new SimpleDateFormat("HH:mm");
                                                }
                                                double v = cell.getNumericCellValue();
                                                Date dates = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(v);
                                                result = sdf.format(dates);
                                                address.setBirthday(dates);;
                                            }
                                            break;
                                        case 5:
                                            //职务
                                            address.setMinistration(cell.getStringCellValue());
                                            break;
                                        case 6:
                                            //配偶
                                            address.setMate(cell.getStringCellValue());
                                            break;
                                        case 7:
                                            //子女
                                            address.setChild(cell.getStringCellValue());
                                            break;
                                        case 8:
                                            //单位名称
                                            address.setDeptName(cell.getStringCellValue());
                                            break;
                                        case 9:
                                            //单位地址
                                            address.setAddDept(cell.getStringCellValue());
                                            break;
                                        case 10:
                                            //单位邮编
                                            address.setPostNoDept(cell.getStringCellValue());
                                            break;
                                        case 11:
                                            //工作电话
                                            address.setTelNoDept(cell.getStringCellValue());
                                            break;
                                        case 12:
                                            //工作传真
                                            address.setFaxNoDept(cell.getStringCellValue());
                                            break;
                                        case 13:
                                            //家庭住址
                                            address.setAddHome(cell.getStringCellValue());
                                            break;
                                        case 14:
                                            //家庭邮编
                                            address.setPostNoHome(cell.getStringCellValue());
                                            break;
                                        case 15:
                                            //家庭电话
                                            address.setTelNoHome(cell.getStringCellValue());
                                            break;
                                        case 16:
                                            //手机
                                            address.setMobilNo(cell.getStringCellValue());
                                            break;
                                        case 17:
                                            //小灵通
                                            address.setBpNo(cell.getStringCellValue());
                                            break;
                                        case 18:
                                            //电子邮件
                                            address.setEmail(cell.getStringCellValue());
                                            break;
                                        case 19:
                                            //QQ
                                            address.setOicqNo(cell.getStringCellValue());
                                            break;
                                        case 20:
                                            //MSN号码
                                            address.setIcqNo(cell.getStringCellValue());
                                            break;
                                        case 21:
                                            //备注
                                            address.setNotes(cell.getStringCellValue());
                                            break;
                                        default:
                                            json.setFlag(0);
                                            json.setMsg("err");
                                            break;
                                    }
                                }
                            }

                            addresseList.add(address);
                        }
                    }
                    if(addresseList!=null&&addresseList.size()>0){
                        int result=addressMapper.batchToAddress(addresseList);
                        json.setFlag(0);
                        json.setMsg(I18nUtils.getMessage("address.th.successfullyImported1")+result+I18nUtils.getMessage("address.th.successfullyImported2"));
                    }
                    dest.delete();
                } else {

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        } finally {
            try {
                if(in!=null){
                    in.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return json;
    }

    @Override
    public BaseWrapper exportAddress(HttpServletRequest request, HttpServletResponse response, Integer groupId) {
        BaseWrapper baseWrapper = new BaseWrapper();
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            I18nUtils.setLocale(locale);
            Map<String, Object> param = new HashedMap();
            param.put("userId", users.getUserId());
            param.put("groupId", groupId);
            List<Address> data = addressMapper.getUsersById(param);
            List<AddressGroup> groups = addressGroupMapper.getAllGroupsMap();
            Map<Integer,String> groupsMap = new HashMap<Integer,String>();

            for (AddressGroup addressGroup:groups) {
                groupsMap.put(addressGroup.getGroupId(),addressGroup.getGroupName());
            }

            for (Address a : data) {
                if (a.getGroupId() != null) {
                    a.setGroupName(groupsMap.get(a.getGroupId()));
                } else {
                    a.setGroupName(I18nUtils.getMessage("notice.th.all"));
                }
            }
            HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead(I18nUtils.getMessage("customer.contactInformation"), 9);
            String[] secondTitles = {I18nUtils.getMessage("user.th.Grouping"), I18nUtils.getMessage("userDetails.th.name"),
                    I18nUtils.getMessage("main.position"), I18nUtils.getMessage("workflow.th.nickname"),
                    I18nUtils.getMessage("main.email"), I18nUtils.getMessage("userDetails.th.MobilePhone"),
                    I18nUtils.getMessage("address.th.QQ"), I18nUtils.getMessage("userDetails.th.Gender"),
                    I18nUtils.getMessage("userDetails.th.Birthday"), I18nUtils.getMessage("address.th.spouse"),
                    I18nUtils.getMessage("address.th.children"), I18nUtils.getMessage("url.th.Familycode"),
                    I18nUtils.getMessage("hr.th.HomeAddress"), I18nUtils.getMessage("url.th.HomePhone"),
                    I18nUtils.getMessage("depatement.th.Unitname"), I18nUtils.getMessage("address.th.postcode"),
                    I18nUtils.getMessage("address.th.unitAddress"), I18nUtils.getMessage("userInfor.th.Workphone"),
                    I18nUtils.getMessage("url.th.Workfax"), I18nUtils.getMessage("system_setting.remark")};
            HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
            String[] beanProperty = {"groupName", "psnName", "ministration", "nickName", "email", "mobilNo", "oicqNo", "sex", "birthday", "mobilNo", "mate", "child", "postNoHome", "addHome", "telNoHome", "deptName", "postNoDept", "addDept", "telNoDept", "faxNoDept", "notes"};

            HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, data, beanProperty);
            ServletOutputStream out = response.getOutputStream();

            String filename = I18nUtils.getMessage("address.th.contactInformationSheet") + ".xls";
            filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("content-disposition", "attachment;filename=" + filename);
            workbook.write(out);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return baseWrapper;
    }

    // sql还未撰写完成
    /**
     * 作者:季佳伟
     * 日期: 2017/12/15
     * 说明: 查询外部即address里的联系人
     */
    @Override
    public ToJson<Address> selectAddress(HttpServletRequest request, Integer page,
                                         Integer pageSize, boolean useFlag, Address address, String export, HttpServletResponse response){
       ToJson<Address> json = new ToJson<>();
       //获取当前用户
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
       try {
           PageParams pageParams=new PageParams();
           pageParams.setPage(page);
           pageParams.setPageSize(pageSize);
           pageParams.setUseFlag(useFlag);
           String userId = users.getUserId();
           Map<String, Object> map = new HashMap<String, Object>();
           map.put("page", pageParams);
           map.put("address",address);
           map.put("userId",userId);
           List<Address> addressList = addressMapper.selectAddress(map);
           if(addressList !=null && addressList.size()>0) {
               for (Address address1 : addressList) {
                   if (address1.getGroupId() == 0) {
                       address1.setGroupName("默认");
                   } else {
                       AddressGroup addressGroup1= new AddressGroup();
                       addressGroup1.setGroupId(address1.getGroupId());
                       AddressGroup addressGroup = addressGroupMapper.selectGroup(addressGroup1);
                       address1.setGroupName(addressGroup.getGroupName());
                   }
               }
           }
           if (export == null){
               export="0";
           }
           if(export.equals("1")){
               HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead(I18nUtils.getMessage("customer.contactInformation"), 20);
               String[] secondTitles = {I18nUtils.getMessage("user.th.Grouping"), I18nUtils.getMessage("userDetails.th.name"),
                       I18nUtils.getMessage("main.position"), I18nUtils.getMessage("workflow.th.nickname"),
                       I18nUtils.getMessage("main.email"), I18nUtils.getMessage("userDetails.th.MobilePhone"),
                       I18nUtils.getMessage("address.th.QQ"), I18nUtils.getMessage("userDetails.th.Gender"),
                       I18nUtils.getMessage("userDetails.th.Birthday"), I18nUtils.getMessage("address.th.spouse"),
                       I18nUtils.getMessage("address.th.children"), I18nUtils.getMessage("url.th.Familycode"),
                       I18nUtils.getMessage("hr.th.HomeAddress"), I18nUtils.getMessage("url.th.HomePhone"),
                       I18nUtils.getMessage("depatement.th.Unitname"), I18nUtils.getMessage("address.th.postcode"),
                       I18nUtils.getMessage("address.th.unitAddress"), I18nUtils.getMessage("userInfor.th.Workphone"),
                       I18nUtils.getMessage("url.th.Workfax"), I18nUtils.getMessage("system_setting.remark")};
               HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
               String[] beanProperty = {"groupName", "psnName", "ministration", "nickName", "email", "mobilNo", "oicqNo", "sex", "birthday", "mobilNo", "mate", "child", "postNoHome", "addHome", "telNoHome", "deptName", "postNoDept", "addDept", "telNoDept", "faxNoDept", "notes"};
               HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, addressList, beanProperty);
               ServletOutputStream out = response.getOutputStream();
               String filename = I18nUtils.getMessage("address.th.contactInformationSheet") + ".xls";
               filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
               response.setContentType("application/vnd.ms-excel;charset=UTF-8");
               response.setHeader("content-disposition", "attachment;filename=" + filename);
               workbook.write(out);
               out.close();

           }
           json.setObj(addressList);
           json.setTotleNum(pageParams.getTotal());
           json.setFlag(0);
           json.setMsg("ok");
       }catch (Exception e){
           e.printStackTrace();
           json.setMsg(e.getMessage());
           json.setFlag(1);

       }
       return json;
    }
    /**
     * 作者: 季佳伟
     * 日期: 2017/12/15
     * 说明: 查询内部联系人
     */
    public ToJson<Users> selectUser(HttpServletRequest request, Integer page,
                                    Integer pageSize, boolean useFlag, Users user){
        ToJson<Users> json = new ToJson<>();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        try {
            List<Users> usersList=null;
            String[] deptId=null;
            PageParams pageParams=new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            Map<String, Object> map = new HashMap<String, Object>();
            if(user.getDeptIds()!=null) {
                 deptId = user.getDeptIds().split(",");
            }
            if(deptId!=null){
            for (int i=0;i<deptId.length;i++){
                user.setDeptId(Integer.parseInt(deptId[i]));
                map.put("page", pageParams);
                map.put("user",user);
                if(i>0){
                    usersList.addAll(addressMapper.selectUser(map));
                }else {
                    usersList=addressMapper.selectUser(map);
                }
            }
            }else {
                map.put("page", pageParams);
                map.put("user", user);
                usersList = addressMapper.selectUser(map);
            }
            for (Users u: usersList) {
                //getFatherDept 查询用户的顶级部门 判断是否又通讯录权限如果有放出
                if (StringUtils.checkNull(users.getDeptYj())){
                    u.setMobilNo("");
                    u.setBirthday(null);
//                    u.setBirthdayStr("");
                    u.setTelNoDept("");
                    u.setEmail("");
                }
                else {
                    String[] split = users.getDeptYj().split(",");
                    Department fatherDept = departmentService.getFatherDept(u.getDeptId());
                    if (fatherDept != null && !Arrays.asList(split).contains(fatherDept.getDeptId().toString())){
                        u.setMobilNo("");
                        u.setBirthday(null);
//                    u.setBirthdayStr("");
                        u.setTelNoDept("");
                        u.setEmail("");
                    }
                }

            }
            json.setObj(usersList);
            json.setTotleNum(pageParams.getTotal());
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setMsg(e.getMessage());
            json.setFlag(1);
        }
        return json;
    }
    public ToJson<Users> getUserInfoById(Integer uid, HttpServletRequest request){
        ToJson<Users> json = new ToJson<>();
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users loginUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            //获取最新登陆人一级部门数据
            Users loginUser1=addressMapper.loginUser(loginUser.getUserId());
            Users user = new Users();
//            看不懂这个逻辑，如果不为空后面的判断根本就走不到，还是还原成以前的判断吧
            user = addressMapper.getUserById(uid);
            if (Objects.isNull(loginUser1) || StringUtils.checkNull(loginUser1.getDeptYj())){
                /// 通讯簿需要获取手机号MobilNo
                if(user!=null){
                 user.setMobilNo("");
                user.setBirthday(null);
                user.setBirthdayStr("");
                user.setTelNoDept("");
                user.setEmail("");
            }
            }
            else {
                String[] split = loginUser1.getDeptYj().split(",");
                if(user!=null) {
                    Department fatherDept = departmentService.getFatherDept(user.getDeptId());
                if (fatherDept != null && !ArrayUtils.contains(split,fatherDept.getDeptId().toString())){
                    /// 通讯簿需要获取手机号MobilNo
                     user.setMobilNo("");
                    user.setBirthday(null);
                    user.setBirthdayStr("");
                    user.setTelNoDept("");
                    user.setEmail("");
                }
            }
            }
            json.setObject(user);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setMsg(e.getMessage());
            json.setFlag(1);
        }
        return json;

    }

    public ToJson<AddressWithBLOBs> importPublicAddressWithBLOBs(Integer groupId, MultipartFile file, HttpServletRequest request, HttpServletResponse response){
        ToJson<AddressWithBLOBs> json = new ToJson<>();
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        // 成功次数
        Integer successCount = 0;
        InputStream in=null;
        try {
                //判读当前系统
                //读取配置文件
                ResourceBundle rb = ResourceBundle.getBundle("upload");
                String osName = System.getProperty("os.name");
                StringBuffer path = new StringBuffer();
                if (osName.toLowerCase().startsWith("win")) {
                    path = path.append(rb.getString("upload.win"));
                } else {
                    path = path.append(rb.getString("upload.linux"));
                }
                String path1= path.toString();
                // 判断是否为空文件
                if (file.isEmpty()) {
                    json.setMsg(I18nUtils.getMessage("address.th.pleaseUploadTheFile"));
                    json.setFlag(1);
                    return json;
                } else {
                    String fileName = file.getOriginalFilename();
                    if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")) {
                        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
                        int pos = fileName.indexOf(".");
                        String extName = fileName.substring(pos);
                        String newFileName = uuid + extName;
                        if (!file.isEmpty()) {
                            try{
                                if(!new File(path1, newFileName).exists()){
                                    new File(path1, newFileName).mkdirs();
                                }
                                // 转存文件
                                file.transferTo(new File(path1,newFileName));
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
//                        File dest = new File(path.toString(), newFileName);
//                        file.transferTo(dest);
                        // 将文件上传成功后进行读取文件
                        // 进行读取的路径
                        String readPath = path.append(System.getProperty("file.separator")).append(newFileName).toString();
                        in = new FileInputStream(readPath);
                        HSSFWorkbook excelObj = new HSSFWorkbook(in);
                        HSSFSheet sheetObj = excelObj.getSheetAt(0);
                        Row row = sheetObj.getRow(0);
                        int colNum = row.getPhysicalNumberOfCells();
                        int lastRowNum = sheetObj.getLastRowNum();
                        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
                        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
                        AddressWithBLOBs address = null;
                        for (int i = 1; i <= lastRowNum; i++) {
                            address = new AddressWithBLOBs();
                            address.setGroupId(groupId);
                            address.setUserId(users.getUserId());
                            row = sheetObj.getRow(i);
                            if (row != null) {
                                for (int j = 0; j < colNum; j++) {
                                    Cell cell = row.getCell(j);
                                    String value = "";
                                    if (cell != null) {
                                        switch (j) {
                                            case 0:
                                                //联系人姓名
                                                address.setPsnName(cell.getStringCellValue());
                                                break;
                                            case 1:
                                                //性别(0-男,1-女)
                                                String sex = cell.getStringCellValue();
                                                if(sex.equals(I18nUtils.getMessage("userInfor.th.male"))){
                                                    address.setSex("0");
                                                }else if (sex.equals(I18nUtils.getMessage("userInfor.th.female"))){
                                                    address.setSex("1");
                                                }else {
                                                    address.setSex("");
                                                }
                                                break;
                                            case 2:
                                                //昵称
                                                address.setNickName(cell.getStringCellValue());
                                                break;
                                            case 3:
                                                //生日
                                                String result = null;
                                                if(cell.getCellType() == CellType.NUMERIC) {
                                                    short format = cell.getCellStyle().getDataFormat();
                                                    SimpleDateFormat sdf = null;
                                                    if (format == 14 || format == 31 || format == 57 || format == 58) {
                                                        //日期
                                                        sdf = new SimpleDateFormat("yyyy-MM-dd");
                                                    } else if (format == 20 || format == 32) {
                                                        //时间
                                                        sdf = new SimpleDateFormat("HH:mm");
                                                    }
                                                    double v = cell.getNumericCellValue();
                                                    Date dates = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(v);
                                                    result = sdf.format(dates);
                                                    address.setBirthday(dates);;
                                                }
                                                break;
                                            case 4:
                                                //职务
                                                address.setMinistration(cell.getStringCellValue());
                                                break;
                                            case 5:
                                                //配偶
                                                address.setMate(cell.getStringCellValue());
                                                break;
                                            case 6:
                                                //子女
                                                address.setChild(cell.getStringCellValue());
                                                break;
                                            case 7:
                                                //单位名称
                                                address.setDeptName(cell.getStringCellValue());
                                                break;
                                            case 8:
                                                //单位地址
                                                address.setAddDept(cell.getStringCellValue());
                                                break;
                                            case 9:
                                                //单位邮编
                                                BigDecimal big9=new BigDecimal(cell.getNumericCellValue());
                                                value = big9.toString();
                                                //解决1234.0  去掉后面的.0
                                                if(null!=value&&!"".equals(value.trim())){
                                                    String[] item = value.split("[.]");
                                                    if(1<item.length&&"0".equals(item[1])){
                                                        value=item[0];
                                                    }
                                                }
                                                address.setPostNoDept(value);
                                                break;
                                            case 10:
                                                //工作电话
                                                BigDecimal big=new BigDecimal(cell.getNumericCellValue());
                                                value = big.toString();
                                                //解决1234.0  去掉后面的.0
                                                if(null!=value&&!"".equals(value.trim())){
                                                    String[] item = value.split("[.]");
                                                    if(1<item.length&&"0".equals(item[1])){
                                                        value=item[0];
                                                    }
                                                }
                                                address.setTelNoDept(value);
                                                break;
                                            case 11:
                                                //工作传真
                                                BigDecimal big11=new BigDecimal(cell.getNumericCellValue());
                                                value = big11.toString();
                                                //解决1234.0  去掉后面的.0
                                                if(null!=value&&!"".equals(value.trim())){
                                                    String[] item = value.split("[.]");
                                                    if(1<item.length&&"0".equals(item[1])){
                                                        value=item[0];
                                                    }
                                                }
                                                address.setFaxNoDept(value);
                                                break;
                                            case 12:
                                                //家庭住址
                                                address.setAddHome(cell.getStringCellValue());
                                                break;
                                            case 13:
                                                //家庭邮编
                                                BigDecimal big13=new BigDecimal(cell.getNumericCellValue());
                                                value = big13.toString();
                                                //解决1234.0  去掉后面的.0
                                                if(null!=value&&!"".equals(value.trim())){
                                                    String[] item = value.split("[.]");
                                                    if(1<item.length&&"0".equals(item[1])){
                                                        value=item[0];
                                                    }
                                                }
                                                address.setPostNoHome(value);
                                                break;
                                            case 14:
                                                //家庭电话
                                                BigDecimal big14=new BigDecimal(cell.getNumericCellValue());
                                                value = big14.toString();
                                                //解决1234.0  去掉后面的.0
                                                if(null!=value&&!"".equals(value.trim())){
                                                    String[] item = value.split("[.]");
                                                    if(1<item.length&&"0".equals(item[1])){
                                                        value=item[0];
                                                    }
                                                }
                                                address.setTelNoHome(value);
                                                break;
                                            case 15:
                                                //手机
                                                BigDecimal big15=new BigDecimal(cell.getNumericCellValue());
                                                value = big15.toString();
                                                //解决1234.0  去掉后面的.0
                                                if(null!=value&&!"".equals(value.trim())){
                                                    String[] item = value.split("[.]");
                                                    if(1<item.length&&"0".equals(item[1])){
                                                        value=item[0];
                                                    }
                                                }
                                                address.setMobilNo(value);
                                                break;
                                            case 16:
                                                //小灵通
                                                BigDecimal big16=new BigDecimal(cell.getNumericCellValue());
                                                value = big16.toString();
                                                //解决1234.0  去掉后面的.0
                                                if(null!=value&&!"".equals(value.trim())){
                                                    String[] item = value.split("[.]");
                                                    if(1<item.length&&"0".equals(item[1])){
                                                        value=item[0];
                                                    }
                                                }
                                                address.setBpNo(value);
                                                break;
                                            case 17:
                                                //电子邮件
                                                address.setEmail(cell.getStringCellValue());
                                                break;
                                            case 18:
                                                //QQ
                                                BigDecimal big18=new BigDecimal(cell.getNumericCellValue());
                                                value = big18.toString();
                                                //解决1234.0  去掉后面的.0
                                                if(null!=value&&!"".equals(value.trim())){
                                                    String[] item = value.split("[.]");
                                                    if(1<item.length&&"0".equals(item[1])){
                                                        value=item[0];
                                                    }
                                                }
                                                address.setOicqNo(value);
                                                break;
                                            case 19:
                                                //MSN号码
                                                BigDecimal big19=new BigDecimal(cell.getNumericCellValue());
                                                value = big19.toString();
                                                //解决1234.0  去掉后面的.0
                                                if(null!=value&&!"".equals(value.trim())){
                                                    String[] item = value.split("[.]");
                                                    if(1<item.length&&"0".equals(item[1])){
                                                        value=item[0];
                                                    }
                                                }
                                                address.setIcqNo(value);
                                                break;
                                            case 20:
                                                //备注
                                                address.setNotes(cell.getStringCellValue());
                                                break;
                                            default:
                                                json.setFlag(0);
                                                json.setMsg("err");
                                                break;
                                        }
                                    }
                                }
                                int count=addressMapper.insertSelective(address);
                                if(count>0) {
                                    successCount = successCount + count;
                                }
                            }
                        }

                    }
                }
                if(successCount>0){
                    json.setTotleNum(successCount);
                    json.setMsg("ok");
                    json.setFlag(0);
                    return  json;
                }
            } catch (Exception e) {
                e.printStackTrace();
                json.setMsg("err");
                json.setFlag(1);
            } finally {
            try {
                if(in!=null){
                    in.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
            return json;


    }

    @Override
    public ToJson<Address> queryAdressByName(String trim) {
        ToJson<Address> toJson = new ToJson<>();
        try {
            List<Address> addresses = addressMapper.queryAdressByName(trim);
            toJson.setMsg("true");
            toJson.setFlag(0);
            toJson.setObj(addresses);
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg("false");
            toJson.setFlag(1);
        }
        return toJson;
    }

    /**
     * 查询共享人员
     * @param request
     * @param groupId
     * @param public_flag
     * @param share_type
     * @param type
     * @return
     */
    @Override
    public BaseWrapper getShareById(HttpServletRequest request, String groupId, String public_flag, String share_type, String type) {
        BaseWrapper baseWrapper = new BaseWrapper();
        //获取当前登陆的用户user_id
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        //查询当前用户的共享联系人
        List<Address>addressWithBLOBs = null;
        try {
            addressWithBLOBs = new ArrayList<>();
            String userName = users.getUserName();
            List<Address> addresses = addressMapper.selectStartById(userName);
            Date thisDate = new Date();
            //获取当前日期
            long time = thisDate.getTime();
            for (Address address : addresses) {
                Date addEnd = address.getAddEnd();
                //判断日期是否为空
                if (addEnd!=null){
                    long time1 = addEnd.getTime();
                    //判断是否超出共享日期
                    if (time<time1){
                        addressWithBLOBs.add(address);
                    }
                }else {
                    //为空代表无共享时间限制
                    addressWithBLOBs.add(address);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        baseWrapper.setData(addressWithBLOBs);
        baseWrapper.setStatus(true);
        return baseWrapper;
    }

    @Override
    public ToJson<Address> selectStartUser(HttpServletRequest request, Integer page, Integer pageSize, boolean useFlag, Address address, String export, HttpServletResponse response) {
        ToJson<Address> json = new ToJson<>();
        //获取当前用户
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try {
            PageParams pageParams=new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            String userId = users.getUserId();
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", pageParams);
            map.put("address",address);
            map.put("userId",userId);
            map.put("userName", users.getUserName());
            List<Address> addressList = addressMapper.selectStartAddress(map);
            if(addressList !=null && addressList.size()>0) {
                for (Address address1 : addressList) {
                    if (address1.getGroupId() == 0) {
                        address1.setGroupName("默认");
                    } else {
                        AddressGroup addressGroup1= new AddressGroup();
                        addressGroup1.setGroupId(address1.getGroupId());
                        AddressGroup addressGroup = addressGroupMapper.selectGroup(addressGroup1);
                        address1.setGroupName(addressGroup.getGroupName());
                    }
                }
            }
            if (export == null){
                export="0";
            }
            if(export.equals("1")){
                HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead(I18nUtils.getMessage("customer.contactInformation"), 20);
                String[] secondTitles = {I18nUtils.getMessage("user.th.Grouping"), I18nUtils.getMessage("userDetails.th.name"),
                        I18nUtils.getMessage("main.position"), I18nUtils.getMessage("workflow.th.nickname"),
                        I18nUtils.getMessage("main.email"), I18nUtils.getMessage("userDetails.th.MobilePhone"),
                        I18nUtils.getMessage("address.th.QQ"), I18nUtils.getMessage("userDetails.th.Gender"),
                        I18nUtils.getMessage("userDetails.th.Birthday"), I18nUtils.getMessage("address.th.spouse"),
                        I18nUtils.getMessage("address.th.children"), I18nUtils.getMessage("url.th.Familycode"),
                        I18nUtils.getMessage("hr.th.HomeAddress"), I18nUtils.getMessage("url.th.HomePhone"),
                        I18nUtils.getMessage("depatement.th.Unitname"), I18nUtils.getMessage("address.th.postcode"),
                        I18nUtils.getMessage("address.th.unitAddress"), I18nUtils.getMessage("userInfor.th.Workphone"),
                        I18nUtils.getMessage("url.th.Workfax"), I18nUtils.getMessage("system_setting.remark")};
                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                String[] beanProperty = {"groupName", "psnName", "ministration", "nickName", "email", "mobilNo", "oicqNo", "sex", "birthday", "mobilNo", "mate", "child", "postNoHome", "addHome", "telNoHome", "deptName", "postNoDept", "addDept", "telNoDept", "faxNoDept", "notes"};
                HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, addressList, beanProperty);
                ServletOutputStream out = response.getOutputStream();
                String filename = I18nUtils.getMessage("address.th.contactInformationSheet") + ".xls";
                filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel;charset=UTF-8");
                response.setHeader("content-disposition", "attachment;filename=" + filename);
                workbook.write(out);
                out.close();

            }
            json.setObj(addressList);
            json.setTotleNum(pageParams.getTotal());
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setMsg(e.getMessage());
            json.setFlag(1);

        }
        return json;
    }
}
