/**
 * IDaas 单点登录，需要 IDaas 提供的令牌 PublicKey 对 ID_Topic 进行解码
 * PublicKey 由 IDaas 提供，记录在
 */
package com.xoa.util.alidass;

import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.idsmanager.dingdang.jwt.DingdangUserRetriever;
import com.xoa.dao.alidaas.*;
import com.xoa.dao.sys.SysInterfaceMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.alidaas.*;
import com.xoa.model.sys.InterfaceModel;
import com.xoa.model.users.Users;
import com.xoa.util.CookiesUtil;
import com.xoa.util.PinYinUtil;
import com.xoa.util.common.L;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.ServletInputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

/**
 * @author ZhuYiZe
 * @date 2020/11/9 9:55
 * @describe
 **/
@Component
public class IDaasUtil {

    @Autowired
    private AlidaasSetMapper alidaasSetMapper;

    @Autowired
    private SysUserMapper sysUserMapper;

    @Autowired
    private SysUserFunctionMapper sysUserFunctionMapper;

    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private SysInterfaceMapper sysInterfaceMapper;

    @Autowired
    private UserAlidaasMapper userAlidaasMapper;

    @Autowired
    private SysDepartmentMapper sysDepartmentMapper;

    @Autowired
    private UserAlidaasDeptMapper userAlidaasDeptMapper;

    @Autowired
    private SysUserPrivMapper sysUserPrivMapper;

    @Autowired
    private SysUserExtMapper sysUserExtMapper;


    /**
     * @author ZhuYiZe
     * @date 2020/11/9 12:55
     * @describe 获取配置数据
     * @param company 数据库
     * @return List<AlidaasSet>
     */
    public List<AlidaasSet> getAlidaasSet(String company) {
        Map map = new HashMap<>();
        map.put("company", company);
        // 查询配置数据
        return alidaasSetMapper.getAllSetingConmany(map);
    }


    /**
     * @author ZhuYiZe
     * @date 2020/11/9 16:06
     * @describe 解码 IDaas 人员认证信息
     * @param id_token token
     * @param publicKey 令牌
     * @return Map<String, Map>
     */
    public Map<String, Map> analysisIdToken(String id_token, String publicKey) {
        // 解析id_token 并验证代码
        DingdangUserRetriever retriever = new DingdangUserRetriever( id_token, publicKey);
        DingdangUserRetriever.User user = null;
        Map<String, DingdangUserRetriever.User> userMap = new HashMap<>();
        Map<String, Boolean> msgMap = new HashMap<>();
        Map<String, Map> resultMap = new HashMap<>();
        try {
            // 获取用户信息
            user = retriever.retrieve();
            userMap.put("idaasUser", user);
            msgMap.put("flag", true);
            resultMap.put("userMap", userMap);
            resultMap.put("msgMap", msgMap);
        } catch (Exception e) {
            L.e("Retrieve SSO user failed", e);
            msgMap.put("flag", false);
            resultMap.put("msgMap", msgMap);
        }
        return resultMap;
    }


    /**
     * @author ZhuYiZe
     * @date 2020/11/24 16:06
     * @describe 登录
     * @param request
     * @param response
     * @param company
     * @param loginId
     * @param idUser
     * @param id_token
     */
    public void doLogin(HttpServletRequest request, HttpServletResponse response, String company, String loginId,
                        IDaasUser idUser, String id_token, String loginUrl) throws IOException {
        response.addHeader("Access-Control-Allow-Origin", "*");
        response.addHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
        response.addHeader("Access-Control-Max-Age", "1800");//30 min

        // 12.1、存入cookie信息
        Cookie redisSessionCookie = new Cookie("redisSessionId",request.getSession().getId());
        CookiesUtil.setCookie(response, "redisSessionId", request.getSession().getId());
        CookiesUtil.setCookie(response, "company", loginId);
        CookiesUtil.setCookie(response, "language", "zh_CN");
        CookiesUtil.setCookie(response, "uid", String.valueOf(idUser.getUid()));
        CookiesUtil.setCookie(response, "userId", idUser.getUserId());
        CookiesUtil.setCookie(response, "userName", idUser.getUserName());
        CookiesUtil.setCookie(response, "userPriv", String.valueOf(idUser.getUserPriv()));
        if (isNotNull(idUser.getUserPrivName()))
            CookiesUtil.setCookie(response, "userPrivName", idUser.getUserPrivName());
        CookiesUtil.setCookie(response, "deptId", idUser.getDeptId());
        CookiesUtil.setCookie(response, "sex", idUser.getSex());
        if (idUser.getBpNo() == null || "".equals(idUser.getBpNo())) {
            CookiesUtil.setCookie(response, "color", "0");
        } else {
            CookiesUtil.setCookie(response, "color", idUser.getBpNo());
        }

        // 12.2、存入session信息
        request.getSession().setAttribute("loginDateSouse", loginId);
        request.getSession().setAttribute("InterfaceModel", "theme" + idUser.getTheme());
        request.getSession().setAttribute("id_token", id_token);
        Map<String, Object> m = new HashMap<>();
        m.put("company", company);
        m.put("userId", idUser.getUserId());
        String functionIdStr = sysUserFunctionMapper.customSelectCompany(m);
        request.getSession().setAttribute("functionIdStr", functionIdStr);
        m.put("uid", idUser.getUid());
        Users users = usersMapper.selectUserByUIdCompany(m);
        SessionUtils.putSession(request.getSession(), users, redisSessionCookie);

        // 12.4、页面重定向
        response.sendRedirect(loginUrl);
    }


    /**
     * @author ZhuYiZe
     * @date 2020/11/16 13:07
     * @describe 获取 request body 中的数据
     * @param request
     * @return String
     */
    //方式一
    public String ReadAsChars(HttpServletRequest request) {
        BufferedReader br = null;
        StringBuilder sb = new StringBuilder("");
        try {
            br = request.getReader();
            String str;
            while ((str = br.readLine()) != null) {
                sb.append(str);
            }
            br.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (null != br) {
                try {
                    br.close();
                }
                catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return sb.toString();
    }

    // 方法二
    public String ReadAsChars2(HttpServletRequest request) {
        InputStream is = null;
        StringBuilder sb = new StringBuilder();
        try {
            is = request.getInputStream();
            byte[] b = new byte[4096];
            for (int n; (n = is.read(b)) != -1;) {
                sb.append(new String(b, 0, n));
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (null != is) {
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return sb.toString();
    }

    // 二进制读取
    public byte[] readAsBytes(HttpServletRequest request) {
        int len = request.getContentLength();
        byte[] buffer = new byte[len];
        ServletInputStream in = null;
        try {
            in = request.getInputStream();
            in.read(buffer, 0, len);
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (null != in) {
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return buffer;
    }


    /**
     * @author ZhuYiZe
     * @date 2020/11/16 14:44
     * @describe 数据格式转换
     * @param body 需要转换的数据
     * @return IDaasUser
     */
    public IDaasSynUser formatConversionPer(String body) {
        IDaasSynUser iDaasSynUser = null;
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            iDaasSynUser = objectMapper.convertValue(JSONObject.parse(body), IDaasSynUser.class);
        } catch (Exception e) {
            e.printStackTrace();
            return new IDaasSynUser();
        }
        return iDaasSynUser;
    }

    public IDaasSynDeptment formatConversionDep(String body) {
        IDaasSynDeptment iDaasSynDeptment = null;
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            iDaasSynDeptment = objectMapper.convertValue(JSONObject.parse(body), IDaasSynDeptment.class);
        } catch (Exception e) {
            e.printStackTrace();
            return new IDaasSynDeptment();
        }
        return iDaasSynDeptment;
    }


    /**
     * @author ZhuYiZe
     * @date 2020/11/16 20:34
     * @describe 封装返回消息
     * @param errorNumber 状态码
     * @param message 返回消息
     * @return String
     */
    public Map<String, Object> resultMsg(Integer errorNumber, String message) {
        Map<String, Object> map = new HashMap<>();
        List<String> list = new ArrayList<>();
        map.put("errorNumber", errorNumber);
        if (message != null || !("".equals(message))) list.add(message);
        map.put("errors", list);
        return  map;
    }


    /**
     * @author ZhuYiZe
     * @date 2020/11/16 16:50
     * @describe 新增用户
     * @param iDaasSynUser idaas 提供的用户信息
     * @param company 数据库名称
     * @return int
     */
    public int addNewUser(IDaasSynUser iDaasSynUser, String company) {
        // 设置默认值
        SysUserWithBLOBs users = new SysUserWithBLOBs();
        users.setCompany(company);
        users.setUseingKey("0");
        users.setUsingFinger("0");
        users.setPassword("tVHbkPWW57Hw.");
        users.setPostPriv("0");
        users.setEmail("");
        users.setMobilNo("");
        users.setSex("0");
        users.setMobilNoHidden("0");
        users.setIsLunar("0");
        users.setTelNoDept("");
        users.setNotLogin(0);
        users.setNotViewUser("0");
        users.setNotViewTable("0");
        users.setNotMobileLogin(0);
        users.setDeptYj("");
        users.setIdNumber("");
        users.setUserNo((short) 10);
        users.setTraNumber("");
        users.setSubject("01");
        users.setRoomNum("");
        users.setTheme(11);
        users.setMenuImage("0");
        users.setShowRss("1");
        users.setLimitLogin("0");
        users.setSecretLevel(0);
        users.setMytableLeft("ALL");
        users.setMytableRight("ALL");
        users.setAvatar("0");

        // 填写IDaas人员信息
        if (iDaasSynUser.getDisplayName() != null && !("".equals(iDaasSynUser.getDisplayName()))) {
            users.setUserName(iDaasSynUser.getDisplayName());
            // 添加用户姓名索引
            String fistSpell = PinYinUtil.getFirstSpell(iDaasSynUser.getDisplayName());
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < fistSpell.length(); i++) {
                sb.append(fistSpell.charAt(i) + "*");
            }
            users.setUserNameIndex(sb.toString());
        }

        if (iDaasSynUser.getUserName() != null && !("".equals(iDaasSynUser.getUserName())))
            users.setByname(iDaasSynUser.getUserName());

        if (iDaasSynUser.getEmails().size() > 0 &&
                iDaasSynUser.getEmails().get(0) != null &&
                iDaasSynUser.getEmails().get(0).getValue() != null &&
                !("").equals(iDaasSynUser.getEmails().get(0).getValue()))
            users.setEmail(iDaasSynUser.getEmails().get(0).getValue());

        if(iDaasSynUser.getPhoneNumbers().size() > 0 &&
                iDaasSynUser.getPhoneNumbers().get(0) != null &&
                iDaasSynUser.getPhoneNumbers().get(0).getValue() != null &&
                !("".equals(iDaasSynUser.getPhoneNumbers().get(0).getValue())))
            users.setMobilNo(iDaasSynUser.getPhoneNumbers().get(0).getValue());

        if (iDaasSynUser.getLocked())  users.setNotLogin(1);

        // 获取添加用户的机构组织
        List<IDaasSynUserMap> belongs = iDaasSynUser.getBelongs();
        List<Integer> depts = new ArrayList<>();
        for (IDaasSynUserMap belong : belongs) {
            if ( belong.getBelongOuUuid() != null && !("".equals( belong.getBelongOuUuid()))) {
                Map param = new HashMap<>();
                param.put("organizationUuid", belong.getBelongOuUuid());
                param.put("company", company);
                UserAlidaasDept dept = userAlidaasDeptMapper.getIDaasUserDept(param);
                if (dept != null) depts.add(dept.getDeptId());
            }
        }
        // 如果没有组织机构，不允许登录
        if (depts.size() > 0) {
            users.setDeptId(depts.get(0));
        } else {
            users.setNotLogin(1);
            users.setNotMobileLogin(1);
        }

        // 设置权限
        if (iDaasSynUser.getAdmin()) {
            Map map = new HashMap<>();
            map.put("company", company);
            List<SysUserPriv> userPrivList = sysUserPrivMapper.getAllUserPrivCompany(map);
            String priv = "";
            for (SysUserPriv sysUserPriv : userPrivList) {
                if (String.valueOf(sysUserPriv.getPrivNo()).equals("1")) {
                    users.setUserPriv(sysUserPriv.getUserPriv());
                    users.setUserPrivNo((short) 1);
                    users.setUserPrivName(sysUserPriv.getPrivName());
                } else {
                    priv += sysUserPriv.getUserPriv();
                }
            }
            users.setUserPrivOther(priv);
        }

        // 设置主题
        List<InterfaceModel> interfaceModels = sysInterfaceMapper.getInterfaceInfo();
        if (interfaceModels.size() > 0)
            users.setTheme(Integer.parseInt(interfaceModels.get(0).getTheme()));

        // 存入数据
        int count1 = 0;
        try {
            count1 = sysUserMapper.insertSelectiveCompany(users);
        } catch (Exception e) {
            e.printStackTrace();
            return 1;
        }
        if (count1 == 0) return 1;
        SysUserWithBLOBs user = new SysUserWithBLOBs();
        user.setUid(users.getUid());
        user.setUserId(String.valueOf(users.getUid()));
        user.setCompany(company);
        int count2 = 0;
        try {
            count2 = sysUserMapper.updateByPrimaryKeySelectiveCompany(user);
        } catch (Exception e) {
            sysUserMapper.deleteByPrimaryKeyCompany(user);
            e.printStackTrace();
            return 1;
        }
        if (count2 == 0) {
            sysUserMapper.deleteByPrimaryKeyCompany(user);
            return 1;
        }
        UserAlidaas userAlidaas = new UserAlidaas();
        userAlidaas.setUserId(String.valueOf(users.getUid()));
        userAlidaas.setExternalid(iDaasSynUser.getExternalId());
        userAlidaas.setCompany(company);
        int count3 = 0;
        try {
            count3 = userAlidaasMapper.insertSelectiveCompany(userAlidaas);
        } catch (Exception e) {
            sysUserMapper.deleteByPrimaryKeyCompany(user);
            e.printStackTrace();
            return 1;
        }
        if (count3 == 0) {
            sysUserMapper.deleteByPrimaryKeyCompany(user);
            return 1;
        }
        SysUserExtWithBLOBs sysUserExt = new SysUserExtWithBLOBs();
        sysUserExt.setUid(user.getUid());
        sysUserExt.setUserId(user.getUserId());
        sysUserExt.setEmailRecentLinkman("");
        sysUserExt.setNickName("");
        sysUserExt.setUsePop3(0);
        sysUserExt.setBbsSignature("");
        sysUserExt.setConcernUser("");
        sysUserExt.setuFuncIdStr("");
        sysUserExt.setLoginTime("");
        sysUserExt.setCompany(company);
        int count4 = 0;
        try {
            count4 = sysUserExtMapper.insertSelectiveCompany(sysUserExt);
        } catch (Exception e) {
            sysUserMapper.deleteByPrimaryKeyCompany(user);
            userAlidaasMapper.deleteCompany(userAlidaas);
            e.printStackTrace();
            return 1;
        }
        if (count4 == 0) {
            sysUserMapper.deleteByPrimaryKeyCompany(user);
            userAlidaasMapper.deleteCompany(userAlidaas);
            return 1;
        }
        return 0;
    }


    /**
     * @author ZhuYiZe
     * @date 2020/11/20 16:31
     * @describe 修改用户
     * @param iDaasSynUser idaas 提供的用户信息
     * @param company 数据库名称
     * @return int
     */
    public int updateUser(IDaasSynUser iDaasSynUser, IDaasUser iDaasUser, String company) {
        SysUserWithBLOBs users = new SysUserWithBLOBs();
        users.setCompany(company);
        users.setUid(iDaasUser.getUid());
        // 填写IDaas人员信息
        if (iDaasSynUser.getDisplayName() != null && !("".equals(iDaasSynUser.getDisplayName()))) {
            users.setUserName(iDaasSynUser.getDisplayName());
            // 添加用户姓名索引
            String fistSpell = PinYinUtil.getFirstSpell(iDaasSynUser.getDisplayName());
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < fistSpell.length(); i++) {
                sb.append(fistSpell.charAt(i) + "*");
            }
            users.setUserNameIndex(sb.toString());
        }

        if (iDaasSynUser.getUserName() != null && !("".equals(iDaasSynUser.getUserName())))
            users.setByname(iDaasSynUser.getUserName());

        if (iDaasSynUser.getEmails().size() > 0 &&
                iDaasSynUser.getEmails().get(0) != null &&
                iDaasSynUser.getEmails().get(0).getValue() != null &&
                !("").equals(iDaasSynUser.getEmails().get(0).getValue())) {
            users.setEmail(iDaasSynUser.getEmails().get(0).getValue());
        } else {
            users.setEmail("");
        }


        if(iDaasSynUser.getPhoneNumbers().size() > 0 &&
                iDaasSynUser.getPhoneNumbers().get(0) != null &&
                iDaasSynUser.getPhoneNumbers().get(0).getValue() != null &&
                !("".equals(iDaasSynUser.getPhoneNumbers().get(0).getValue()))) {
            users.setMobilNo(iDaasSynUser.getPhoneNumbers().get(0).getValue());
        } else {
            users.setMobilNo("");
        }


        if (iDaasSynUser.getLocked()) {
            users.setNotLogin(1);
        } else {
            users.setNotLogin(0);
        }

        // 获取添加用户的机构组织
        List<IDaasSynUserMap> belongs = iDaasSynUser.getBelongs();
        List<Integer> depts = new ArrayList<>();
        for (IDaasSynUserMap belong : belongs) {
            if ( belong.getBelongOuUuid() != null && !("".equals( belong.getBelongOuUuid()))) {
                Map param = new HashMap<>();
                param.put("organizationUuid", belong.getBelongOuUuid());
                param.put("company", company);
                UserAlidaasDept dept = userAlidaasDeptMapper.getIDaasUserDept(param);
                if (dept != null) depts.add(dept.getDeptId());
            }
        }
        // 如果没有组织机构，不允许登录
        if (depts.size() > 0) {
            users.setDeptId(depts.get(0));
        } else {
            users.setNotLogin(1);
            users.setNotMobileLogin(1);
        }

        // 设置权限
        if (iDaasSynUser.getAdmin()) {
            Map map = new HashMap<>();
            map.put("company", company);
            List<SysUserPriv> userPrivList = sysUserPrivMapper.getAllUserPrivCompany(map);
            String priv = "";
            for (SysUserPriv sysUserPriv : userPrivList) {
                if (String.valueOf(sysUserPriv.getPrivNo()).equals("1")) {
                    users.setUserPriv(sysUserPriv.getUserPriv());
                    users.setUserPrivNo((short) 1);
                    users.setUserPrivName(sysUserPriv.getPrivName());
                } else {
                    priv += sysUserPriv.getUserPriv();
                }
            }
            users.setUserPrivOther(priv);
        }

        // 修改用户
        int count = 0;
        try {
            count = sysUserMapper.updateByPrimaryKeySelectiveCompany(users);
        } catch (Exception e) {
            e.printStackTrace();
            return 1;
        }
        if (count == 0) return 1;
        return 0;
    }


    /**
     * @author ZhuYiZe
     * @date 2020/11/20 117:50
     * @describe 离职
     * @param sysUser 离职人员信息
     * @param company 数据库名称
     * @return int
     */
    public int delUser(IDaasUser sysUser, String company) {
        SysUserWithBLOBs users = new SysUserWithBLOBs();
        users.setCompany(company);
        users.setUid(sysUser.getUid());
        users.setDeptId(0);
        users.setDeptIdOther("");
        users.setNotLogin(1);
        users.setWeatherCity("0");
        users.setNotMobileLogin(1);
        int code = 0;
        try {
            code = sysUserMapper.updateByPrimaryKeySelectiveCompany(users);
        } catch (Exception e) {
            e.printStackTrace();
            return 1;
        }
        if (code == 0) return 1;
        return 0;
    }


    /**
     * @author ZhuYiZe
     * @date 2020/11/19 12:22
     * @describe 新增组织机构
     * @param iDaasSynDeptment idaas 提供的组织机构信息
     * @param company 数据库名称
     * @return int
     */
    public int addNewDept(IDaasSynDeptment iDaasSynDeptment, String company) {
        SysDepartmentWithBLOBs department = new SysDepartmentWithBLOBs();
        if (iDaasSynDeptment.getOrganization() != null) {
            department.setDeptName(iDaasSynDeptment.getOrganization());
        } else {
            department.setDeptName("");
        }
        if (iDaasSynDeptment.getLevelNumber() != null) {
            department.setDeptNo(String.valueOf(iDaasSynDeptment.getLevelNumber()));
        } else {
            department.setDeptNo("0");
        }
        department.setgDept(0);
        department.setClassifyOrg(0);
        department.setDeptAddress("");
        department.setManager("");
        department.setAssistantId("");
        department.setLeader1("");
        department.setLeader2("");
        department.setDeptFunc("");
        department.setIsOrg("");
        department.setOrgAdmin("");
        department.setDeptEmailAuditsIds("");
        department.setCompany(company);
        // 查找父类
        Map map = new HashMap<>();
        map.put("company", company);
        map.put("organizationUuid", iDaasSynDeptment.getParentUuid());
        UserAlidaasDept parentData = userAlidaasDeptMapper.getIDaasUserDept(map);
        if (parentData == null) {
            department.setDeptParent(0);
        } else {
            department.setDeptParent(parentData.getDeptId());
        }
        // 存入数据
        int count1 = 0;
        try {
            count1 = sysDepartmentMapper.insertSelectiveCompany(department);
        } catch (Exception e) {
            e.printStackTrace();
            return 1;
        }
        if (count1 == 0) return 1;
        // 存入关系表数据
        UserAlidaasDept userAlidaasDept = new UserAlidaasDept();
        userAlidaasDept.setCompany(company);
        userAlidaasDept.setDeptId(department.getDeptId());
        userAlidaasDept.setOrganizationUuid(iDaasSynDeptment.getOrganizationUuid());
        userAlidaasDept.setType(iDaasSynDeptment.getType());
        int count2 = 0;
        try {
            count2 = userAlidaasDeptMapper.insertSelectiveCompany(userAlidaasDept);
        } catch (Exception e) {
            Map param = new HashMap<>();
            param.put("deptId", department.getDeptId());
            param.put("company", company);
            sysDepartmentMapper.deleteByPrimaryKeyCompany(param);
            e.printStackTrace();
            return 1;
        }
        // 如果记录没创建成功，删除记录
        if (count2 == 0) {
            Map param = new HashMap<>();
            param.put("deptId", department.getDeptId());
            param.put("company", company);
            sysDepartmentMapper.deleteByPrimaryKeyCompany(param);
            return 1;
        }
        return 0;
    }


    /**
     * @author ZhuYiZe
     * @date 2020/11/19 13:41
     * @describe 修改组织机构
     * @param iDaasSynDeptment idaas 提供的组织机构信息
     * @param company 数据库名称
     * @return int
     */
    public int updateDept(IDaasSynDeptment iDaasSynDeptment, String company) {
        SysDepartmentWithBLOBs department = new SysDepartmentWithBLOBs();
        Map<String, Object> param = new HashMap<>();
        param.put("company", company);
        param.put("organizationUuid", iDaasSynDeptment.getParentUuid());
        UserAlidaasDept parentData = userAlidaasDeptMapper.getIDaasUserDept(param);
        if (parentData == null) {
            department.setDeptParent(0);
        } else {
            department.setDeptParent(parentData.getDeptId());
        }
        param.put("organizationUuid", iDaasSynDeptment.getOrganizationUuid());
        UserAlidaasDept myself = userAlidaasDeptMapper.getIDaasUserDept(param);
        department.setDeptId(myself.getDeptId());
        if (iDaasSynDeptment.getOrganization() != null && !("".equals(iDaasSynDeptment.getOrganization())))
            department.setDeptName(iDaasSynDeptment.getOrganization());
        if (iDaasSynDeptment.getLevelNumber() != null && !("".equals(iDaasSynDeptment.getLevelNumber())))
            department.setDeptNo(String.valueOf(iDaasSynDeptment.getLevelNumber()));
        department.setCompany(company);
        try {
            int count1 = sysDepartmentMapper.updateByPrimaryKeySelectiveCompany(department);
            if (count1 > 0) return 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 1;
        }
        return 1;
    }


    /**
     * @author ZhuYiZe
     * @date 2020/11/19 17:01
     * @describe 删除组织机构
     * @param userAlidaasDept 组织机构信息
     * @param company idaas 提供的组织机构信息
     * @param company 数据库名称
     * @return int
     */
    public int delDept(String company, UserAlidaasDept userAlidaasDept) {
        Map param = new HashMap<>();
        param.put("deptId", userAlidaasDept.getDeptId());
        param.put("company", company);
        int count1 = sysDepartmentMapper.deleteByPrimaryKeyCompany(param);
        if (count1 == 0) return 1;
        userAlidaasDeptMapper.deleteByDeptIdCompany(param);
        return 0;
    }



    /**
     * @author ZhuYiZe
     * @date 2020/11/9 14:27
     * @describe 空判断
     * @return boolean
     */
    public boolean isNull(Collection coll) {
        if (coll == null || coll.isEmpty()) return true;
        return false;
    }

    public boolean isNull(String str) {
        if (str == null || "".equals(str)) return true;
        return false;
    }


    /**
     * @author ZhuYiZe
     * @date 2020/11/9 14:27
     * @describe 非空判断
     * @return boolean
     */
    public boolean isNotNull(Collection coll) {
        if (coll != null && !(coll.isEmpty())) return true;
        return false;
    }

    public boolean isNotNull(String str) {
        if (str != null && !("".equals(str))) return true;
        return false;
    }


    /**
     * @author ZhuYiZe
     * @date 2020/11/9 14:27
     * @describe 数据判空
     * @return boolean
     */
    public boolean checkIDaasUser(DingdangUserRetriever.User user) {
        if (user == null) return false;
        return true;
    }

    public boolean checkIDaasUser(String str) {
        if (str == null || "".equals(str)) return false;
        return true;
    }

    public Map<String, Map> checkIDaasUser(String company, String externalId) {
        Map<String, Object> param = new HashMap<>();
        param.put("company", company);
        param.put("externalId", externalId);
        IDaasUser sysUsers = sysUserMapper.getIDaasUser(param);
        param.clear();
        Map<String, Map> resyltMap = new HashMap<>();
        Map<String, Boolean> flagMap = new HashMap<>();
        if (sysUsers == null) {
            flagMap.put("flag", false);
            resyltMap.put("flagMap", flagMap);
        } else {
            Map<String, IDaasUser> sysUserMap = new HashMap<>();
            flagMap.put("flag", true);
            sysUserMap.put("sysUsers", sysUsers);
            resyltMap.put("sysUserMap", sysUserMap);
            resyltMap.put("flagMap", flagMap);
        }
        return resyltMap;
    }
}
