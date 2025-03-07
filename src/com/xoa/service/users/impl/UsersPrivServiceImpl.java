package com.xoa.service.users.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.users.UserFunctionMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.department.Department;
import com.xoa.model.users.RoleManager;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.Users;
import com.xoa.service.securityApproval.SecurityApprovalService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.MD5Utils;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.encrypt.EncryptSalt;
import com.xoa.util.page.PageParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月18日 下午6:32:17
 * 类介绍  :    角色权限
 * 构造参数:    无
 */
@Service
public class UsersPrivServiceImpl implements UsersPrivService {
    @Resource
    private UserPrivMapper userPrivMapper;
    @Resource
    UserFunctionMapper userFunctionMaper;
    @Resource
    UsersMapper usersMapper;
    @Autowired
    ThreadPoolTaskExecutor threadPoolTaskExecutor;
    @Autowired
    private SecurityApprovalService securityApprovalService;

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:32:42
     * 方法介绍:   根据privid串获取privName
     * 参数说明:   @param privId  角色id串
     * 参数说明:   @return
     *
     * @return String   角色名称串
     */
    @Override
    public String getPrivNameById(int... privId) {
        if(privId==null && privId.length==0){
            return "";
        }

        //定义用于拼接角色id的字符串
        StringBuffer param=new StringBuffer();
        for(int i=0;i<privId.length;i++){
            if(i<privId.length-1){
                param.append(privId[i]+",");
            }else{
                param.append(privId[i]);
            }
        }

        StringBuffer result = new StringBuffer();
        Map<String,Object> paramMap=new HashMap<>();
        paramMap.put("privIds",param);
        List<String> privNameList=userPrivMapper.getPrivNameByIds(paramMap);
        if(privNameList==null){
            return "";
        }
        for (int i = 0; i < privNameList.size(); i++) {
            if (i < privNameList.size() - 1) {
                result.append(privNameList.get(i)+",");
            } else {
                result.append(privNameList.get(i));
            }
        }
        return result.toString();
    }

    @Override
    public String getPrivNameById(String privId) {
        if(StringUtils.checkNull(privId)){
            return "";
        }
        StringBuffer result = new StringBuffer();
        if (",".equals(String.valueOf(privId.charAt(privId.length()-1)))){
            privId=privId.substring(0, privId.length() - 1);
        }
        Map<String,Object> paramMap=new HashMap<>();
        paramMap.put("privIds",privId);
        List<String> privNameList=userPrivMapper.getPrivNameByIds(paramMap);
        if(privNameList==null || privNameList.isEmpty()){
            return "";
        }
        for (int i = 0; i < privNameList.size(); i++) {
            if (i < privNameList.size() - 1) {
                result.append(privNameList.get(i)+",");
            } else {
                result.append(privNameList.get(i));
            }
        }
        return result.toString();
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2016年6月3日 下午4:02:05
     * 方法介绍:   根据privid串获取privName
     * 参数说明:   @param privId  privId
     * 参数说明:   @return
     *
     * @return List<String>  返回角色串
     */
    @SuppressWarnings("all")
    @Override
    public String getPrivNameByPrivId(String privId,String flag) {
        if (StringUtils.checkNull(privId) || flag==null) {
            return null;
        }
        String[] temp = privId.split(flag);
        //定义用于角色
        StringBuffer param=new StringBuffer();
        for(int i=0;i<temp.length;i++){
            if(i<temp.length-1){
                param.append(temp[i]+",");
            }else{
                param.append(temp[i]);
            }
        }

        StringBuffer result = new StringBuffer();
        Map<String,Object> paramMap=new HashMap<>();
        paramMap.put("privIds",param);
        List<String> privNameList=userPrivMapper.getPrivNameByIds(paramMap);
        if(privNameList==null){
            return "";
        }
        for (int i = 0; i < privNameList.size(); i++) {
            if (i < privNameList.size() - 1) {
                result.append(privNameList.get(i)+",");
            } else {
                result.append(privNameList.get(i));
            }
        }
        return result.toString();
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:32:47
     * 方法介绍:   格局userpriv获取用户权限
     * 参数说明:   @param up 角色主键
     * 参数说明:   @return
     *
     * @return UserPriv    返回角色信息
     */
    @Override
    public UserPriv selectByPrimaryKey(int up) {
        UserPriv userPriv = userPrivMapper.selectByPrimaryKey(up);
        return userPriv;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:32:51
     * 方法介绍:   格局userpriv删除用户
     * 参数说明:   @param userPriv  角色主键
     *
     * @return void   无
     */
    @Override
    public void deleteByPrimaryKey(int userPriv) {

        userPrivMapper.deleteByPrimaryKey(userPriv);

        List<Users> usersByUSER_priv_other = usersMapper.getUsersByUSER_PRIV_OTHER(String.valueOf(userPriv));
        for (Users user:usersByUSER_priv_other) {
            String userPrivOther = user.getUserPrivOther();
            String[] split = userPrivOther.split(",");
            StringBuilder newPrivOther = new StringBuilder();
            for (String str:split) {
                if(!str.equals(String.valueOf(userPriv))){
                    newPrivOther.append(str).append(",");
                }
            }
            user.setUserPrivOther(newPrivOther.toString());
            usersMapper.editUser(user);
        }

    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:32:58
     * 方法介绍:   userpriv保存
     * 参数说明:   @param record 角色信息
     *
     * @return void   无
     */
    @Override
    public int insertSelective(UserPriv record) {
        int count=0;
        if(!StringUtils.checkNull(record.getPrivName())){
            UserPriv priv=userPrivMapper.getUserPrivByName(record.getPrivName());
            if(priv!=null){
                count=2;
            }else{
                count=userPrivMapper.insertSelective(record);
            }
        }
        return count;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:33:03
     * 方法介绍:   获取所有userPriv
     * 参数说明:   @param maps  集合
     * 参数说明:   @param page  当前页面
     * 参数说明:   @param pageSize  页面大小
     * 参数说明:   @param useFlag  是否开启分页
     * 参数说明:   @return
     *
     * @return List<UserPriv>   返回角色
     */
    @Override
    public List<UserPriv> getAllPriv(Map<String, Object> maps, Integer page,
                                     Integer pageSize, boolean useFlag) {
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        List<UserPriv> list = userPrivMapper.getAlluserPriv(maps);
        return list;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:33:07
     * 方法介绍:   多条件查询userPriv
     * 参数说明:   @param priv 角色
     * 参数说明:   @return
     *
     * @return List<UserPriv>   返回角色信息
     */
    @Override
    public List<UserPriv> getPrivByMany(UserPriv priv) {
        List<UserPriv> list = userPrivMapper.getPrivByMany(priv);
        return list;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/30 10:45
     * @函数介绍: 查询所有用户Priv
     * @return: List<UserPriv></UserPriv>
     **/
    @Override
    public List<UserPriv> getAllUserPriv() {
        Map<String, Object> map = new HashMap<String, Object>();
        List<UserPriv> userPrivList=userPrivMapper.getAlluserPriv(map);

        //查询角色所属部门
        Map<String,String> deptMap = new HashMap();
        String deptIds = userPrivList.stream()
                .map(UserPriv::getPrivDeptId)
                .filter(deptId -> (!Objects.isNull(deptId) && deptId != 0))
                .map(String::valueOf)
                .collect(Collectors.joining(","));
        if(!StringUtils.checkNull(deptIds)) {
            List<Department> depts = departmentMapper.selDeptByIds(deptIds.split(","));
            for (Department dept : depts) {
                deptMap.put(dept.getDeptId().toString(),dept.getDeptName());
            }
        }

        //查出所有用户
        List<Users> usersByPrivIds = usersMapper.getUsersByPrivIdsAndPrivOtherIds(null);

        for(UserPriv userPriv:userPrivList){

            // 根据部门id查出名字
            String userPrivDeptName = deptMap.get(userPriv.getPrivDeptId());
            userPriv.setPrivDeptName(StringUtils.checkNull(userPrivDeptName) ? "" : userPrivDeptName);

            //全部主角色用户计数器
            int alltheMainRoleallUsersCount=0;
            //全部禁止登陆用户计数器
            int allnoLoginUsersCount=0;
            //全部辅助角色用户计数器
            int allauxiliaryRoleUserCount=0;

            for (Users user : usersByPrivIds) {
                boolean allnoLoginUsersFlag = true;
                if (userPriv.getUserPriv().equals(user.getUserPriv())) {
                    alltheMainRoleallUsersCount++;
                    if (user.getNotLogin() == 1) {
                        allnoLoginUsersCount++;
                        //同一个用户这里增加过计数器，下面的判断中就不增加了
                        allnoLoginUsersFlag = false;
                    }
                }
                if (!StringUtils.checkNull(user.getUserPrivOther()) && Arrays.asList(user.getUserPrivOther().split(",")).contains(userPriv.getUserPriv().toString())) {
                    allauxiliaryRoleUserCount++;
                    if (allnoLoginUsersFlag && user.getNotLogin() == 1) {
                        allnoLoginUsersCount++;
                    }
                }
            }

            userPriv.setShowCount(alltheMainRoleallUsersCount+"("+allnoLoginUsersCount+")/"+allauxiliaryRoleUserCount);
        }

        //将上边循环中更新用户表的用户角色和角色名称操作异步处理
        /*this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                Map<String, Object> m = new HashMap<String, Object>();
                for(UserPriv userPriv:userPrivList) {
                    m.put("userPriv", userPriv.getUserPriv());
                    m.put("userPrivNo", userPriv.getPrivNo());
                    m.put("userPrivName", userPriv.getPrivName());
                    int count1 = usersMapper.updatePriv(m);
                }
            }
        });*/

        //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
        securityApprovalService.removeSecrecyUsers(null,userPrivList);

        return userPrivList;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/1 13:54
     * @函数介绍: 根据funcIdStr查询角色名称
     * @参数说明: @param fid, 某个功能的id,对应sys_function表中的FUNC_ID
     * @return: XXType(value introduce)
     */
    @Override
    public List<UserPriv> getUserPrivNameByFuncId(String fid) {
        List<UserPriv> userPrivList = userPrivMapper.getUserPrivNameByFuncId(fid);
        return userPrivList;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/1 19:43
     * @函数介绍: 修改角色权限（serPriv 的funcIdStr）,数据库原有字段基础上如果存在就不在拼接，否则
     * @参数说明: String privids
     * @参数说明: String funcId
     * @return: XXType(value introduce)
     */
    @Override
    public void updateUserPrivfuncIdStr(String privids, String funcId) {
        String[] prividArr = null;
        if (privids != null && privids != "") {
            prividArr = privids.split(",");
        }

        if (prividArr != null && prividArr.length > 0) {
            for (String id : prividArr) {
                String funcIdStr = userPrivMapper.getUserPrivfuncIdStr(id);
                if (funcIdStr != null && !"".equals(funcIdStr) && funcId != null) {
                    //已结添加
                    if (funcIdStr.contains("".concat(funcId).concat(",")) || funcIdStr.startsWith(funcId.concat(","))) {
                        //do nothing
                        //未添加添加
                    } else {
                        funcIdStr = funcIdStr.concat(funcId).concat(",");
                        Map<String, Object> hashMap = new HashMap<String, Object>();
                        hashMap.put("id", id);
                        hashMap.put("funcIdStr", funcIdStr);
                        userPrivMapper.updateUserPrivFuncIdStr(hashMap);
                    }
                } else {
                    if (funcId != null && "".equals(funcIdStr)) {
                        funcIdStr = ",";
                        funcIdStr = funcIdStr.concat(funcId).concat(",");
                        Map<String, Object> hashMap = new HashMap<String, Object>();
                        hashMap.put("id", id);
                        hashMap.put("funcIdStr", funcIdStr);
                        userPrivMapper.updateUserPrivFuncIdStr(hashMap);
                    } else if (funcId != null) {
                        funcIdStr = "";
                        Map<String, Object> hashMap = new HashMap<String, Object>();
                        hashMap.put("id", id);
                        funcIdStr = funcIdStr.concat(funcId).concat(",");
                        hashMap.put("funcIdStr", funcIdStr);
                        userPrivMapper.updateUserPrivFuncIdStr(hashMap);
                    }
                }
            }
        }
        List<Users> users = usersMapper.getUsersByPrivIds(prividArr);
        if(users!=null&&users.size()>0){
            for(Users user:users){
            /*    if(StringUtils.checkNull(userFunctionMaper.getUid(user.getUserId()))){
                    int b=   userFunctionMaper.addByUserId(user.getUid(),user.getUserId(),funcId);
                }else{
                    int a =  userFunctionMaper.updateByUserId(user.getUserId(),funcId);
                }*/
                getFuncByuserPrivOther(user.getUserPriv()+",",user.getUserId());
            }
        }
    }

    /**
     * @param privids
     * @param funcIds
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/1 19:43
     * @函数介绍: 修改角色权限（serPriv 的funcIdStr）
     * @参数说明: String privids
     * @参数说明: String funcId
     * @return: void
     */
    @Override
    public void deleteUserPriv(String privids, String funcIds) {
        String[] prividArr = null;
        if (!StringUtils.checkNull(privids)) {
            prividArr = privids.split(",");
        }
        if (prividArr != null && prividArr.length > 0) {
            for (String id : prividArr) {
                String funcIdStr = userPrivMapper.getUserPrivfuncIdStr(id);
                if (!StringUtils.checkNull(funcIdStr) && !StringUtils.checkNull(funcIds)) {
                    String[] funcIdArray = funcIdStr.split(",");
                    List<String> deleteFuncIdList = Arrays.asList(funcIds.split(","));
                    StringBuilder funcIdBuffer = new StringBuilder();
                    for (String funcId : funcIdArray) {
                        // 判断是否包含
                        if (!deleteFuncIdList.contains(funcId)) {
                            funcIdBuffer.append(funcId).append(",");
                        }
                    }

                    Map<String, Object> hashMap = new HashMap<>();
                    hashMap.put("id", id);
                    hashMap.put("funcIdStr", funcIdBuffer.toString());
                    userPrivMapper.updateUserPrivFuncIdStr(hashMap);
                }
            }
        }
        List<Users> users = usersMapper.getUsersByPrivIds(prividArr);
        if (!CollectionUtils.isEmpty(users)) {
            for (Users user : users) {
            /*    if(StringUtils.checkNull(userFunctionMaper.getUid(user.getUserId()))){
                    int b=   userFunctionMaper.addByUserId(user.getUid(),user.getUserId(),funcId);
                }else{
                    int a =  userFunctionMaper.updateByUserId(user.getUserId(),funcId);
                }*/
                getFuncByuserPrivOther(user.getUserPriv() + ",", user.getUserId());
            }
        }
    }



    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午11：40：00
     * 方法介绍:   根据privid修改角色信息
     * 参数说明    @param record
     * @return void
     */
    @Transactional
    public int updateUserPriv(UserPriv record) {
        int count=0;
        Map<String, Object> m = new HashMap<String, Object>();
        m.put("userPriv", record.getUserPriv());
        m.put("userPrivNo", record.getPrivNo());
        m.put("userPrivName", record.getPrivName());
        if(record.getFuncIdStr()==null){
            UserPriv oldPriv=userPrivMapper.selectByPrimaryKey(record.getUserPriv());
            UserPriv newPriv=userPrivMapper.getUserPrivByName(record.getPrivName());
            if(newPriv!=null && !oldPriv.getPrivName().equals(newPriv.getPrivName())){
                count=2;
                return count;
            }
        }
        count=userPrivMapper.updateByPrimaryKeySelective(record);
        //修改用户表的角色信息
        if(record.getPrivNo()!=null){
            int count1 = usersMapper.updatePriv(m);
        }

       /* if(!StringUtils.checkNull(record.getPrivName())&&record.getPrivNo()!=null){
            userPrivMapper.updateUserByPriv(record);
        }*/
       Map<String, Object> map = new HashMap<String, Object>();
       map.put("userPrivAll", record.getUserPriv());
        String[] privs= new String[1];
        privs[0]=record.getUserPriv()+"";
        if(record.getFuncIdStr()!=null){
            //根据角色编号获取主角色和辅助角色为该角色的用户
            List<Users> allUsers = usersMapper.getdepId(map);

            if(allUsers!=null && allUsers.size()>0){
                for(Users user : allUsers){
                    /*if(StringUtils.checkNull(userFunctionMaper.getUid(user.getUserId()))){
                        int b=   userFunctionMaper.addByUserId(user.getUid(),user.getUserId(),record.getFuncIdStr());
                    }else{
                        int a =  userFunctionMaper.updateByUserId(user.getUserId(),record.getFuncIdStr());
                    }*/
                    this.getFuncByuserPrivAll( user.getUserId());
                }
            }


            List<Users> users = usersMapper.getUsersByPrivIds(privs);
            if(users!=null&&users.size()>0){
                for(Users user:users){
                    /*if(StringUtils.checkNull(userFunctionMaper.getUid(user.getUserId()))){
                        int b=   userFunctionMaper.addByUserId(user.getUid(),user.getUserId(),record.getFuncIdStr());
                    }else{
                        int a =  userFunctionMaper.updateByUserId(user.getUserId(),record.getFuncIdStr());
                    }*/
                    getFuncByuserPrivOther(record.getUserPriv()+",",user.getUserId());
                }
            }
        }
        return count;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午13：41：00
     * 方法介绍:   克隆操作
     * 参数说明    @param record
     * @return void
     */
    @Transactional
    public void copyUserPriv(UserPriv record) {
        UserPriv userPriv=userPrivMapper.selectByPrimaryKey(record.getUserPriv());
        userPriv.setPrivName(record.getPrivName());
        userPriv.setPrivNo(record.getPrivNo());
        UserPriv newUserPriv1=new UserPriv();
        newUserPriv1.setPrivNo(userPriv.getPrivNo());
        newUserPriv1.setPrivName(userPriv.getPrivName());
        newUserPriv1.setFuncIdStr(userPriv.getFuncIdStr());
        newUserPriv1.setIsGlobal(userPriv.getIsGlobal());
        newUserPriv1.setPrivDeptId(userPriv.getPrivDeptId());
        newUserPriv1.setPrivType(userPriv.getPrivType());
        if (record.getPrivTypeId() != null) {
            newUserPriv1.setPrivTypeId(record.getPrivTypeId());
        } else {
            newUserPriv1.setPrivTypeId(userPriv.getPrivTypeId());
        }

        userPrivMapper.insertSelective(newUserPriv1);
    }
    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午15:15:05
     * 方法介绍:   查询超级密码是否正确
     * 参数说明:   @param password
     * 参数说明:   @return 返回匹配条数
     */
    public int checkSuperPass(String password){
        if (password != null && password != "") {
            String truePassword = userPrivMapper.getSuperPass();
            String md5Password = MD5Utils.md5Crypt(password.getBytes(), truePassword);
            if (md5Password != null && md5Password.equals(truePassword)) {
                return 1;
            }
        }
        return 0;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午16:05:09
     * 方法介绍:   修改超级密码
     * 参数说明:   @param password
     * 参数说明:   @return void
     */
    @Transactional
    public void updateSuperPass(String newPwd){
        String md5Pwd=getEncryptString(newPwd);
        userPrivMapper.updateSuperPass(md5Pwd);
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/7 10:47
     * @函数介绍: 加密一个字符串，MD5加密，EncryptSalt类产生一个字符串作为加盐加密
     * 注意业务需要，空字符串要得到固定的加密结果（tVHbkPWW57Hw.）
     * @参数说明: @param String 要加密的字符串
     * @return: String 加密过后的字符串
     */
    @Override
    public String getEncryptString(String password) {
        String md5WithSalt = null;
        //非空字符串
        if (password != null && !"".equals(password.trim())) {
            md5WithSalt = MD5Utils.md5Crypt(password.trim().getBytes(), "$1$".concat(EncryptSalt.getRandomSalt(12)));
        }
        //“”字符串加密要得到tVHbkPWW57Hw.作为加密后结果
        if (password != null && "".equals(password.trim())) {
            md5WithSalt = "tVHbkPWW57Hw.";
        }
        return md5WithSalt;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月16日 下午17:31:00
     * 方法介绍:   根据角色名称删除权限
     * 参数说明:   @param privName 角色名称
     * 参数说明:   @return void
     */
    @Transactional
    public void delPriByName(String privName){
        userPrivMapper.delPriByName(privName);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月16日 下午19:20:05
     * 方法介绍:   根据id修改排序号
     * 参数说明:   @param userPriv
     * 参数说明:   @return void
     */
    @Override
    @Transactional
    public ToJson<UserPriv> updNoByPrivId(UserPriv userPrivs){
        ToJson<UserPriv> toJson = new ToJson<UserPriv>(1,"error");
        try {
            JSONArray jsonArray =   JSONArray.parseArray(userPrivs.getMapList());
            for(int i=0,len = jsonArray.size();i<len; i++){
                JSONObject jsonJ = jsonArray.getJSONObject(i);
                // 角色ID
               String userPriv =  jsonJ.getString("userPriv");
                String privNo = jsonJ.getString("privNo");
                if(!StringUtils.checkNull(userPriv)&&!StringUtils.checkNull(privNo)) {
                    userPrivs.setUserPriv(Integer.valueOf(userPriv));
                    userPrivs.setPrivNo(Short.valueOf(privNo));
                    userPrivMapper.updateByPrimaryKeySelective(userPrivs);
                }else{
                return toJson;
                }
            }
            toJson.setFlag(0);
            toJson.setMsg("ok");
        }catch (Exception e){
            L.e("UsersPrivServiceImpl updNoByPrivId:"+e);
        }
            return  toJson;
    }

    @Override
    public ToJson selectHavePriv(){
        ToJson toJson = new ToJson(1,"error");
        try{
            List<Users> users = usersMapper.selectHavePriv();
            toJson.setData(users);
            toJson.setFlag(0);
            toJson.setMsg("ok");
        }catch (Exception e){
            toJson.setData(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson selectHaveDept(HttpServletRequest request){
        ToJson toJson = new ToJson(1,"error");
        try{
            List<Users> users = usersMapper.selectHaveDept();
            toJson.setData(users);
            toJson.setFlag(0);
            toJson.setMsg("ok");
        }catch (Exception e){
            toJson.setData(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson selectPriv(String userId) {
        ToJson toJson = new ToJson(1,"error");
        try{
            String userPrivOther = userPrivMapper.getUserFunByUserId(userId);
            String ss[] = userPrivOther.split(",");
            List<UserPriv> list = new ArrayList<>();
            for (int i = 0; i<ss.length; i++){
                String privNameById = userPrivMapper.getPrivNameById(Integer.valueOf(ss[i]));
                UserPriv userPriv = new UserPriv();
                userPriv.setPrivName(privNameById);
                userPriv.setUserPriv(Integer.valueOf(ss[i]));
                list.add(userPriv);
            }
            toJson.setData(list);
            toJson.setMsg("ok");
            toJson.setFlag(0);
        }catch (Exception e){
            toJson.setData(e.getMessage());
        }
        return toJson;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月19日 下午13:38:05
     * 方法介绍:   给用户添加辅助角色
     */
    @Transactional
    public ToJson addUserFunByUID(String userId, String funcIds){
        ToJson toJson = new ToJson(1,"error");
        try {
            String[] userIdArr = null;
            if (!StringUtils.checkNull(userId)) {
                userIdArr = userId.split(",");
            }
            Map<String, Object> hashMap = new HashMap<String, Object>();
            if (userIdArr != null && userIdArr.length > 0) {
                for (String id : userIdArr) {
                    String userPrivOther = userPrivMapper.getUserFunByUserId(id);
                    /*StringBuffer sb = new StringBuffer();
                    if(!StringUtils.checkNull(userPrivOther)){
                        String[] funcIdStrs = userPrivOther.split(",");
                        for(int i = 0 , len = funcIdStrs.length;i<len;i++) {
                            if (!userPrivOther.contains(funcIdStrs[i])){
                                sb.append(funcIdStrs[i]);
                                sb.append(",");
                            }
                        }
                        sb.append(funcIds);
                    }else{
                        sb.append(funcIds);
                    }*/
                    //修改辅助角色，并且使其不能重复
                    String newPriv="";
                    if (userPrivOther == null) {
                        userPrivOther="";
                    }
                    if (funcIds != null) {
                        newPriv=userPrivOther+funcIds;
                    }else {
                        newPriv=userPrivOther;
                    }
                    TreeSet<String> ts=new TreeSet<>();
                    int len=newPriv.split(",").length;
                    String ss[]=newPriv.split(",");
                    for(int i=0;i<len;i++){
                        ts.add(ss[i]+"");
                    }

                    //2.循环遍历TreeSet
                    Iterator<String> i=ts.iterator();
                    StringBuilder sb=new StringBuilder();
                    while(i.hasNext()){
                        sb.append(i.next()+",");
                    }

                    hashMap.put("id", id);
                    hashMap.put("funcIdStr", sb.toString());
                    userPrivMapper.updateFunByUserId(hashMap);
                    getFuncByuserPrivOther(sb.toString(),id);
                }
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        }catch (Exception e){
            L.e("UserPrivServiceImpl addUserFunByUID:"+e);
        }
        return toJson;

    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月19日 下午14:09:10
     * 方法介绍:   给用户删除辅助角色
     */
    @Override
    @Transactional
    public void deleteUserFunByUID(String userId, String funcIds) {
//        String[] userIdArr = null;
//        String[] funcIdArr = null;
//        if (userId != null && userId != "") {
//            userIdArr = userId.split("");
//        }
//        if (userIdArr != null && userIdArr.length > 0) {
//            for (String id : userIdArr) {
//                String funcIdStr = userPrivMapper.getUserFunByUserId(id);
//                if (!StringUtils.checkNull(funcIdStr) && !StringUtils.checkNull(funcIds)) {
//                    String[] funcIdArray = funcIds.split(",");
//                    for (String funcId : funcIdArray) {
//                        //包含
//                        if (funcIdStr.contains(",".concat(funcId).concat(",")) || funcIdStr.startsWith(funcId.concat(","))|| funcIdStr.endsWith(",".concat(funcId))) {
//                            if(funcIdStr.endsWith(",".concat(funcId))){
//                                funcIdStr = funcIdStr.replace(",".concat(funcId), ",");
//                            }else {
//                                funcIdStr = funcIdStr.replace(funcId.concat(","), "");
//                            }
//                        }
//                    }
//                    Map<String, Object> hashMap = new HashMap<String, Object>();
//                    hashMap.put("id", id);
//                    hashMap.put("funcIdStr", funcIdStr);
//                    userPrivMapper.updateFunByUserId(hashMap);
//                    getFuncByuserPrivOther(funcIdStr,id);
//                }
//            }
//
//        }
        try{
            String funcIdStr = userPrivMapper.getUserFunByUserId(userId);
            if (!StringUtils.checkNull(funcIdStr) && !StringUtils.checkNull(funcIds)) {
                String[] funcIdArray = funcIds.split(",");
                for (String funcId : funcIdArray) {
                    //包含
                    if (funcIdStr.contains(",".concat(funcId).concat(",")) || funcIdStr.startsWith(funcId.concat(","))|| funcIdStr.endsWith(",".concat(funcId))) {
                        if(funcIdStr.endsWith(",".concat(funcId))){
                            funcIdStr = funcIdStr.replace(",".concat(funcId), ",");
                        }else {
                            funcIdStr = funcIdStr.replace(funcId.concat(","), "");
                        }
                    }
                }
                Map<String, Object> hashMap = new HashMap<String, Object>();
                hashMap.put("id", userId);
                hashMap.put("funcIdStr", funcIdStr);
                userPrivMapper.updateFunByUserId(hashMap);
                getFuncByuserPrivOther(funcIdStr, userId);
            }
        }catch (Exception e){
            System.out.println(e.getMessage());
        }


    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午9:29:00
     * 方法介绍:   添加人力资源管理角色规则
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     * @return     int 插入条数
     */
    @Override
    @Transactional
    public  int insertRoleManager(RoleManager roleManager){
        int count=0;
        count=userPrivMapper.insertRoleManager(roleManager);
        return count;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午9:50:00
     * 方法介绍:  根据id进行修改人力资源角色
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     * @return     int 进行修改的条数
     */
    @Override
    @Transactional
    public int updateRoleManager(RoleManager roleManager){
        int count=0;
        count=userPrivMapper.updateRoleManager(roleManager);
        return count;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午9:55:00
     * 方法介绍:  根据id进行删除人力资源角色管理
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     * @return     int 进行删除的条数
     */
    @Override
    @Transactional
    public int deleteRoleManagerById(int roleManagerId){
        int count=0;
        count=userPrivMapper.deleteRoleManagerById(roleManagerId);
        return count;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午10:15:00
     * 方法介绍:  根据id进行查询人力资源角色管理
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     * @return     RoleManager 查询出来的结果
     */
    @Override
    public RoleManager getRoleManagerById(int roleManagerId){
        RoleManager roleManager=new RoleManager();
        roleManager=userPrivMapper.getRoleManagerById(roleManagerId);
        return roleManager;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午10:14:00
     * 方法介绍:  查询出所有的人力资源角色管理信息
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     * @return     RoleManager 查询出来的结果
     */
    @Override
    public List<RoleManager> getAllRoleManager(){
        List<RoleManager> roleManagerList=userPrivMapper.getAllRoleManager();
        for(RoleManager roleManager:roleManagerList){
            String[] roleManagerArray=roleManager.getRoleManager().split(",");
            StringBuffer userName=new StringBuffer();
            for (String str:roleManagerArray){
                String userName1=userPrivMapper.getUserNameByUserId(str);
                if(userName1!=null){
                    userName.append(userName1+",");
                }
            }
            roleManager.setRoleManagerText(userName.toString());
            String[] hrPrivArray=roleManager.getUserPriv().split(",");
            StringBuffer privName=new StringBuffer();
            for (String str:hrPrivArray){
                String privName1=userPrivMapper.getPrivNameByPrivId(Integer.valueOf(str));
                if(privName1!=null){
                    privName.append(privName1+",");
                }
            }
            roleManager.setUserPrivText(privName.toString());
        }
        return roleManagerList;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午13:30:00
     * 方法介绍:   通过权限id获取权限名称
     * 参数说明:   @param funcId 权限id
     * 参数说明:   @return
     * @return     int
     */
    public String getFunNameByFunId(String funcId){
        return userPrivMapper.getFunNameByFunId(funcId);
    }
    public Map<String,HashMap<String,String>> getFunIdAndFunName(){
        return userPrivMapper.getFunIdAndFunName();
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午13:30:00
     * 方法介绍:   通过权限name获取权限id
     * 参数说明:   @param funcName 权限name
     * 参数说明:   @return
     * @return     int
     */
    public List<String> getFunIdByFunName(String funcName){
        return userPrivMapper.getFunIdByFunName(funcName);
    }

    /**

     * @创建作者: 韩成冰
     * @创建日期: 2017/6/22 13:02
     * @函数介绍: 查询UserPriv
     * @参数说明: @param userPriv
     * @return: XXType(value introduce)
     */
    @Override
    public UserPriv getUserPriv(Integer userPriv) {

        return userPrivMapper.getUserPriv(userPriv);
    }

    @Override
    public List<UserPriv> getPrivBySearch(Map<String, Object> maps){
        return userPrivMapper.getPrivBySearch(maps);
    }

    /**
     * 根据角色设置权限
     */
    public void getFuncByuserPrivOther(String userPriv,String userId){
        String[] userPrivArray=userPriv.split(",");
        StringBuffer buf=new StringBuffer();

        for(int i=0;i<userPrivArray.length;i++){
            String funStr=userPrivMapper.getUserPrivfuncIdStr(userPrivArray[i]);
            if(!StringUtils.checkNull(funStr)){
                buf.append(funStr);
            }
        }


        List<UserPriv> tempList = userPrivMapper.getUserPrivAllByUserId(userId);
        if (tempList != null && tempList.size()>0){
            for (int i=0,lenth = tempList.size() ; i<lenth; i++){
                UserPriv userPriv1 = tempList.get(i);
                buf.append(userPriv1.getFuncIdStr());
            }
        }


       /* UserPriv temp=userPrivMapper.getUserPrivByUserId(userId);
        if(temp!=null){
            buf.append(temp.getFuncIdStr());
        }*/
        TreeSet<String> ts=new TreeSet<>();
        int len1=buf.toString().split(",").length;
        String ss[]=buf.toString().split(",");
        for(int i1=0;i1<len1;i1++){
            ts.add(ss[i1]);
        }

        //2.循环遍历TreeSet
        Iterator<String> i1=ts.iterator();
        StringBuilder sb1=new StringBuilder();
        while(i1.hasNext()){
            sb1.append(i1.next()+",");
        }
        Users user = usersMapper.findUsersByuserId(userId);
        if (user != null){
            if(userFunctionMaper.selectByUid(user.getUid()) != null){
                int a =  userFunctionMaper.updateByUid(user.getUid(), sb1.toString());
            }else{
                int b=   userFunctionMaper.addByUserId(user.getUid(),userId,sb1.toString());
            }
        }

    }

    @Override
    public ToJson<UserPriv> getUserPrivName(HttpServletRequest request,int userPriv) {
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, "error");
        try {
            UserPriv userPriv1 =userPrivMapper.getPrivName(userPriv);
            json.setObject(userPriv1);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            // e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("UserPrivController getUserPrivName:"+e);
        }
        return json;
    }


    /**
     * 根据角色设置权限(改 兼容主角色和辅助角色)
     */
    public void getFuncByuserPrivAll(String userId){
        StringBuffer buf=new StringBuffer();
         /*   String funStr = userPrivMapper.getUserPrivfuncIdStr(userPriv);
            if(!StringUtils.checkNull(funStr)){
                buf.append(funStr);
            }*/
        //获取对应的
        List<UserPriv> tempList = userPrivMapper.getUserPrivAllByUserId(userId);
            if (tempList != null && tempList.size()>0){
                for (int i=0,lenth = tempList.size() ; i<lenth; i++){
                    UserPriv userPriv1 = tempList.get(i);
                    buf.append(userPriv1.getFuncIdStr());
                }
            }
        /*
        UserPriv temp = userPrivMapper.getUserPrivByUserId(users.getUserId());
        if(temp!=null){
            buf.append(temp.getFuncIdStr());
        }*/

        TreeSet<String> ts=new TreeSet<>();
        int len1=buf.toString().split(",").length;
        String ss[]=buf.toString().split(",");
        for(int i1=0;i1<len1;i1++){
            ts.add(ss[i1]);
        }

        //2.循环遍历TreeSet
        Iterator<String> i1=ts.iterator();
        StringBuilder sb1=new StringBuilder();
        while(i1.hasNext()){
            sb1.append(i1.next()+",");
        }
        Users user = usersMapper.findUsersByuserId(userId);
        if (user != null){
            if(userFunctionMaper.selectByUid(user.getUid()) != null){
                int a =  userFunctionMaper.updateByUid(user.getUid(), sb1.toString());
            }else{
                int b=   userFunctionMaper.addByUserId(user.getUid(),userId,sb1.toString());
            }
        }

    }



    @Resource
    DepartmentMapper departmentMapper;
//角色Id
    public Map getUsersByUserPriv( String userPriv) {

        ToJson<Object> departmentToJson = new ToJson<Object>();
        //查出所有部门
        List<Department> departmentList = departmentMapper.getDatagrid();
        //主角色用户 根据角色Id查出所有用户
        List<Users> users=usersMapper.getUsersByUserPriv(userPriv);

        //辅助角色用户
        List<Users> fuzhuusers=usersMapper.getUsersByUSER_PRIV_OTHER(userPriv);
        // usersMapper.ge

        //全部主角色用户计数器
        int alltheMainRoleallUsersCount=0;
        //全部禁止登陆用户计数器
        int allnoLoginUsersCount=0;
        //全部辅助角色用户计数器
        int allauxiliaryRoleUserCount=0;





        for(Department d:departmentList){

            //遍历主角色用户们
                      StringBuilder theMainRoleallUsers=new StringBuilder();
            StringBuilder noLoginUsers=new StringBuilder();

            //部门主角色用户计数器
            int theMainRoleallUsersCount=0;
            //部门禁止登陆用户计数器
            int noLoginUsersCount=0;

            for(Users u:users){
                if(u!=null&&u.getDeptId()!=null){
                    if(u.getDeptId().equals(d.getDeptId())){
                        theMainRoleallUsers.append(u.getUserName()+",");
                        theMainRoleallUsersCount++;

                        //判断主角色用户们是否是禁止登陆用户
                        // NOT_LOGIN         	禁止登录OA系统(1-禁止,0-不禁止)
                        if(u.getNotLogin()!=null && u.getNotLogin()==1){
                            noLoginUsers.append(u.getUserName()+",");
                            noLoginUsersCount++;
                        }
                    }
                }
            }
            d.setTheMainRoleallUsers(theMainRoleallUsers.toString());
            d.setNoLoginUsers(noLoginUsers.toString());
            d.setTheMainRoleallUsersCount(theMainRoleallUsersCount);

            //总计数器累计加
            alltheMainRoleallUsersCount=alltheMainRoleallUsersCount+theMainRoleallUsersCount;
            d.setNoLoginUsersCount(noLoginUsersCount);
            allnoLoginUsersCount=allnoLoginUsersCount+ noLoginUsersCount;

            //遍历辅助角色用户
            StringBuilder auxiliaryRoleUser=new StringBuilder();
            //部门辅助角色用户计数器
            int auxiliaryRoleUserCount=0;
            for(Users u:fuzhuusers){
                if(u.getDeptId().intValue()==d.getDeptId().intValue()){
                    auxiliaryRoleUser.append(u.getUserName()+",");
                    auxiliaryRoleUserCount++;
                }
            }
            d.setAuxiliaryRoleUser(auxiliaryRoleUser.toString());
            d.setAuxiliaryRoleUserCount(auxiliaryRoleUserCount);
            //总计数器累加
            allauxiliaryRoleUserCount=allauxiliaryRoleUserCount+auxiliaryRoleUserCount;
        }

        Map map=new HashMap();

        map.put("alltheMainRoleallUsersCount",alltheMainRoleallUsersCount);
        map.put("allnoLoginUsersCount",allnoLoginUsersCount);
        map.put("allauxiliaryRoleUserCount",allauxiliaryRoleUserCount);
  return map;

    }

    //根据角色名称模糊查询
    @Override
    public ToJson selectUserPrivsByPrivName(String privName) {
        ToJson toJson = new ToJson(1, "error");
        try {
            List<UserPriv> userPrivsByPrivName = userPrivMapper.getUserPrivsByPrivName(privName);
            userPrivsByPrivName.forEach(userPriv -> {
                Map<String,Integer> map1=getUsersByUserPriv(userPriv.getUserPriv()+"");
                //全部主角色用户计数器
                int alltheMainRoleallUsersCount=map1.get("alltheMainRoleallUsersCount");;
                //全部禁止登陆用户计数器
                int allnoLoginUsersCount=map1.get("allnoLoginUsersCount");
                //全部辅助角色用户计数器
                int allauxiliaryRoleUserCount=map1.get("allauxiliaryRoleUserCount");

                userPriv.setShowCount(alltheMainRoleallUsersCount+"("+allnoLoginUsersCount+")/"+allauxiliaryRoleUserCount);
            });
            //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
            securityApprovalService.removeSecrecyUsers(null,userPrivsByPrivName);
            toJson.setObj(userPrivsByPrivName);
            toJson.setFlag(0);
            toJson.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }

        return toJson;
    }

    @Override
    public ToJson<UserPriv> selectIsZhongGaoGuan(HttpServletRequest request) {
        ToJson<UserPriv> json = new ToJson<>(1, "error");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if (users != null && !StringUtils.checkNull(users.getUserId())){
            UserPriv userPriv = userPrivMapper.getUserPrivByName("中高管工作日志模板");
            if (userPriv != null){
                Users user = usersMapper.getByUserId(users.getUserId());
                if (user != null){
                    if (Arrays.asList(user.getUserPrivOther().split(",")).contains(userPriv.getUserPriv().toString())) {
                        userPriv.setIsZhongGaoGuan("1");
                    } else {
                        userPriv.setIsZhongGaoGuan("0");
                    }
                }
            }
            json.setFlag(0);
            json.setMsg("ok");
            json.setObject(userPriv);
        }
        return json;
    }

    @Override
    public UserPriv findUserPrivAndTypeFuncIdStr(int userPriv) {
        return userPrivMapper.findUserPrivAndTypeFuncIdStr(userPriv);
    }

}


