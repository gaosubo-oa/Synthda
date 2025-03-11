package com.xoa.controller.login;

import com.alibaba.fastjson.JSONObject;
import com.ibatis.common.resources.Resources;
import com.xoa.dao.appoauser.AppOaUserMapper;
import com.xoa.dao.casConfig.CasConfigMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.common.SyslogMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.dingdingManage.UserDDMapMapper;
import com.xoa.dao.enclosure.AttachmentMapper;
import com.xoa.dao.qiyeWeixin.UserWeixinqyMapper;
import com.xoa.dao.sms.SmsBodyMapper;
import com.xoa.dao.sys.SysInterfaceMapper;
import com.xoa.dao.thirdSysConfig.ThirdSysConfigMapper;
import com.xoa.dao.users.OrgManageMapper;
import com.xoa.dao.users.UserExtMapper;
import com.xoa.dao.users.UserFunctionMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dao.version.VersionMapper;
import com.xoa.dao.weLink.UserWeLinkMapper;
import com.xoa.dev.qywx.service.QywxService;
import com.xoa.global.intercptor.CommonSessionContext;
import com.xoa.model.appoauser.AppOaUser;
import com.xoa.model.casConfig.CasConfig;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.Syslog;
import com.xoa.model.department.Department;
import com.xoa.model.dingdingManage.UserDDMap;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.qiyeWeixin.UserWeixinqy;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.sms.SmsBodyExtend;
import com.xoa.model.sys.InterfaceModel;
import com.xoa.model.thirdSysConfig.ThirdSysConfigWithBLOBs;
import com.xoa.model.users.OrgManage;
import com.xoa.model.users.UserExt;
import com.xoa.model.users.UserOnline;
import com.xoa.model.users.Users;
import com.xoa.model.weLink.UserWeLink;
import com.xoa.model.weLink.UserWeLinkExample;
import com.xoa.service.department.impl.DepartmentServiceImpl;
import com.xoa.service.sms.SmsService;
import com.xoa.service.sys.InterFaceService;
import com.xoa.service.sys.SysLogService;
import com.xoa.service.sys.SystemInfoService;
import com.xoa.service.sys.impl.SystemInfoServiceImpl;
import com.xoa.service.syspara.SysParaService;
import com.xoa.service.users.OrgManageService;
import com.xoa.service.users.UsersService;
import com.xoa.util.*;
import com.xoa.util.common.L;
import com.xoa.util.common.MobileCheck;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.ipUtil.IpAddr;
import com.xoa.util.ipUtil.MachineCode;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.RenderedImage;
import java.io.*;
import java.security.KeyPair;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

import static com.xoa.util.PHPPherialize.isChinese;

@Controller
@Scope(value = "prototype")
/**
 *
 * 创建作者:   王曰岐
 * 创建日期:   2017-4-18 下午3:11:29
 * 类介绍    :   登录控制器
 * 构造参数:   无
 *
 */
public class loginController {

    public static Map<String, Object> userCountMap = new HashedMap();
    @Resource
    private SmsService smsService;
    @Resource
    private UsersService usersService;
    @Resource
    private OrgManageService orgManageService;
    @Value("${app_login_path_php}")
    private String url;
    private String charset = "utf-8";
    @Autowired
    UserFunctionMapper userFunctionMapper;
    @Resource
    private SysInterfaceMapper sysInterfaceMapper;
    @Resource
    private SysLogService sysLogService;
    @Autowired
    private SysParaMapper sysParaMapper;
    @Autowired
    private OrgManageMapper orgManageMapper;
    @Autowired
    private UserExtMapper userExtMapper;
    @Resource
    private SyslogMapper syslogMapper;

    @Resource
    SysParaService sysParaService;
    @Resource
    SystemInfoService systemInfoService;
    @Resource
    UsersMapper usersMapper;
    @Resource
    InterFaceService interfaceService;
    @Resource
    private CasConfigMapper casConfigMapper;
    @Resource
    private UserWeixinqyMapper userWeixinqyMapper;

    @Resource
    private AppOaUserMapper appOaUserMapper;

    @Resource
    private UserDDMapMapper userDDMapMapper;
    @Resource
    private UserWeLinkMapper userWeLinkMapper;


    @Autowired
    private AttachmentMapper attachmentMapper;

    @Autowired
    private QywxService qywxService;

    @Autowired
    private DepartmentMapper departmentMapper;

    @Resource
    private ThirdSysConfigMapper thirdSysConfigMapper;

    @Resource
    private SmsBodyMapper smsBodyMapper;

    @Autowired
    private ThreadPoolTaskExecutor threadPoolTaskExecutor;

    @Resource
    private DepartmentServiceImpl departmentServiceImpl;

    @Resource
    private VersionMapper versionMapper;


    @RequestMapping(name = "index", value = {"/", ""})
    public String index(HttpServletRequest request, HttpServletResponse response) {
        CasConfig casConfig = null;
        try {
            //防止空表
            casConfig = casConfigMapper.selectOneCas();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (casConfig != null && casConfig.getCasStatus().equals("1")) {
            try {
                response.sendRedirect("xoaCas/interceptCas");
            } catch (IOException e) {
                e.printStackTrace();
            }
            return null;
        }
        String noProject = request.getParameter("noProject");

        if(StringUtils.checkNull(noProject)){
            SysPara myproject = sysParaMapper.querySysPara("MYPROJECT");
            if(myproject!=null&&"mpjis".equals(myproject.getParaValue())){
                return "redirect:http://zwfw.sd.gov.cn/JIS/front/login.do?uuid=8qge7wVdnN0L";
            }

            if(myproject!=null&&"MINHANG_EDU".equals(myproject.getParaValue())){
                ThirdSysConfigWithBLOBs mhSSOConfig = thirdSysConfigMapper.selectBySysName("闵行单点统一认证");
                String para4 = mhSSOConfig.getPara4();
                if("1".equals(para4)){
                    String client_id = mhSSOConfig.getPara1();
                    String redirect_uri = mhSSOConfig.getPara3();
                    return "redirect:https://cloud.mhedu.sh.cn/cas/oauth2.0/authorize?response_type=code&client_id="+client_id+"&redirect_uri="+redirect_uri;
                }
            }
        }


        List<InterfaceModel> interfaceModels = sysInterfaceMapper.getInterfaceInfo();
        String url = "";
        switch (Integer.parseInt(interfaceModels.get(0).getTemplate())) {
            case 1:
                url = "defaultIndex1";
                break;
            case 2:
                url = "defaultIndex2";
                break;
            case 3:
                url = "defaultIndex3";
                break;
            case 4:
                url = "defaultIndex4";
                break;
            case 5:
                url = "defaultIndex5";
                break;
            case 6:
                url = "defaultIndex6";
                break;
            case 7:
                url = "defaultIndex7";
                break;
            case 8:
                url = "defaultIndex8";
                break;
            case 9:
                url = "defaultIndex9";
                break;
            case 10:
                url = "defaultIndex10";
                break;
            case 11:
                url = "defaultIndex11";
                break;
            case 12:
                url = "defaultIndex12";
                break;
            case 13:
                url = "defaultIndex13";
                break;
            case 14:
                url = "defaultIndex14";
                break;
            case 15:
                url = "defaultIndex15";
                break;
            case 16:
                url = "defaultIndex16";
                break;
            case 17:
                url = "defaultIndex17";
                break;
            case 18:
                url = "defaultIndex18";
                break;
            case 19:
                url = "defaultIndex19";
                break;
            case 20:
                url = "defaultIndex20";
                break;
            case 25:
                url = "defaultIndex25";// 教育
                break;
            case 30: //计家EPM登录主题
                url = "defaultIndex30";
                break;
            case 89: //信创登录页面
                url = "defaultIndex89";
                break;
            case 100: //sw登录主题
                url = "defaultIndex100";
                break;
            default:
                url = "defaultIndex2";
        }

        return "forward:" + url;
    }

    /*@RequestMapping(name = "xoa", value = {"/xoa", "/xtd"})
    public String xoa(HttpServletRequest request, String url) {
        return "redirect:" + url;
    }*/

    /**
     * h5登录页
     */
    @RequestMapping("/h5")
    public String loginH5() {
        return "login/default/mobile/index";
    }

    /**
     * 创建作者: 王曰岐 创建日期: 2017-4-18 下午3:15:40 方法介绍: 处理登录过程 参数说明: @return
     *
     * @return String 返回登录的jsp路径
     */
    @RequestMapping("login/index")
    // URL的/index
    public String login() {
        return "login/index";
    }

    @RequestMapping("/cont")
    // URL的/cont
    public String cont() {
        return "app/main/cont";
    }

    @RequestMapping("/lunbo")
    public String lunbo() {
        return "app/main/lunbo";
    }
    //重置密码页
    @RequestMapping("/resetPsword")
    public String resetPsword() {
        return "login/default/resetPsword";
    }

    @RequestMapping("/defaultIndex1")//云端协同
    public String defaultIndex(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index1";
    }


    @RequestMapping("/defaultIndex2")//中国之梦
    public String defaultIndex2(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index2";
    }


    @RequestMapping("/defaultIndex3")//字节跳舞
    public String defaultIndex3(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index3";
    }

    @RequestMapping("/defaultIndex4")//金山银山
    public String defaultIndex4(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index4";
    }

    @RequestMapping("/defaultIndex5")//学生时代
    public String defaultIndex5(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setModel(model, request);

        return "login/default/index5";
    }

    @RequestMapping("/defaultIndex6")//环球视野
    public String defaultIndex6(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index6";
    }

    @RequestMapping("/defaultIndex7")//音乐时光
    public String defaultIndex7(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index7";
    }


    @RequestMapping("/defaultIndex8")//天外飞仙
    public String defaultIndex8(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index8";
    }


    @RequestMapping("/defaultIndex88")//春蚕登陆页
    public String defaultIndex88(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index88";
    }

    @RequestMapping("/defaultIndex9")//宇宙未来
    public String defaultIndex9(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index9";
    }


    @RequestMapping("/defaultIndex10")//深海豪情
    public String defaultIndex10(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index10";
    }


    @RequestMapping("/defaultIndex11")//城市之光
    public String defaultIndex11(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index11";
    }


    @RequestMapping("/defaultIndex12")//水墨印象
    public String defaultIndex12(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index12";
    }


    @RequestMapping("/defaultIndex13")//政务大红
    public String defaultIndex13(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index13";
    }


    @RequestMapping("/defaultIndex14")//政务水墨
    public String defaultIndex14(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index14";
    }

    @RequestMapping("/defaultIndex15")//中国梦
    public String defaultIndex15(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index15";
    }
    @RequestMapping("/defaultIndex16")//精彩时刻
    public String defaultIndex16(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index16";
    }

    @RequestMapping("/defaultIndex22")//精彩时刻(简约)
    public String defaultIndex22(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index22";
    }

    @RequestMapping("/defaultIndex17")//文明古国
    public String defaultIndex17(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index17";
    }
    @RequestMapping("/defaultIndex18")//和平世界
    public String defaultIndex18(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index18";
    }
    @RequestMapping("/defaultIndex19")//金色时代
    public String defaultIndex19(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index19";
    }

    @RequestMapping("/defaultIndex20")
    public String defaultIndex20(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/user/index20";
    }

    @RequestMapping("/defaultIndex25") // 教育登录页面
    public String defaultIndex25(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/user/index25";
    }

    @RequestMapping("/defaultIndex100")//sw精彩时刻
    public String defaultIndex100(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index2";
    }

    @RequestMapping("/defaultIndex89")//信创登录页
    public String defaultIndex89(Model model, HttpServletRequest request) {
        this.setCompany(request);
        this.setCompany(request);
        this.setModel(model, request);
        return "login/default/index89";
    }

    public void setModel(Model model, HttpServletRequest request) {
        List<SysPara> sysParaslistAndroid = sysParaService.getVersion();
        List<SysPara> sysParaslistIos = sysParaService.getVersionIos();
        List<InterfaceModel> interfaceModelList = interfaceService.getInterfaceInfo(request);
       /* Map<String, String> hashMap = systemInfoService.getAuthInfo(request);
        if(hashMap!=null&&hashMap.size()>0){
            Iterator i = hashMap.entrySet().iterator();
            while (i.hasNext()) {
                Map.Entry entry = (Map.Entry) i.next();
                if(entry.getKey().equals("module")){
                    model.addAttribute("module",entry.getValue()) ;
                    break;
                }

            }
        }*/
        if (interfaceModelList != null && interfaceModelList.size() > 0 &&
                interfaceModelList.get(0).getAttachment2() != null && interfaceModelList.get(0).getAttachment2().size() > 0) {
            InterfaceModel interfaceModel = interfaceModelList.get(0);
            Attachment attachment = interfaceModel.getAttachment2().get(0);
            if (PinYinUtil.checkChinese(attachment.getAttachName())) {
                String company = ContextHolder.getConsumerType();
                if (StringUtils.checkNull(company) || "xoanull".equals(company.toLowerCase())) {
                    List<OrgManage> org = orgManageMapper.queryId();
                    if (org != null && org.size() > 0) {
                        company = "xoa" + org.get(0).getOid().toString().trim();
                    }
                }
                String path = this.getPath() + System.getProperty("file.separator") + company +
                        System.getProperty("file.separator") + "interface" + System.getProperty("file.separator") + attachment.getYm() + System.getProperty("file.separator") + attachment.getAttachId() + "." + attachment.getAttachName();
                File f = new File(path);
                String newPath = path.replace(attachment.getAttachName().substring(0, attachment.getAttachName().indexOf(".")), "loginLogo");
                f.renameTo(new File(newPath));
                String stem = attachment.getAttachName().substring(0, attachment.getAttachName().indexOf("."));
                String attrul = attachment.getAttUrl().replace(stem, "loginLogo");
                interfaceModelList.get(0).getAttachment2().get(0).setAttUrl(attrul);
                interfaceModel.setAttachmentName2(interfaceModel.getAttachmentName2().replace(stem, "loginLogo"));
                sysInterfaceMapper.updateInterfaceInfo(interfaceModel);
                attachment.setAttachName(attachment.getAttachName().replace(stem, "loginLogo"));
                attachment.setAttachFile(attachment.getAttachName());
                attachmentMapper.updateByPrimaryKeySelective(attachment);
            }

            model.addAttribute("LogoImg", interfaceModelList.get(0).getAttachment2().get(0).getAttUrl());
            model.addAttribute("bannerFont", interfaceModelList.get(0).getBannerFont());
            model.addAttribute("bannerText", interfaceModelList.get(0).getBannerText());
        } else {
            model.addAttribute("LogoImg", null);
        }
        if (!StringUtils.checkNull(sysParaslistAndroid.get(0).getParaValue())) {
            model.addAttribute("versionAndroid", sysParaslistAndroid.get(0).getParaValue());
        } else {
            model.addAttribute("versionAndroid", "");
        }
        if (!StringUtils.checkNull(sysParaslistIos.get(0).getParaValue())) {
            model.addAttribute("versionIOS", sysParaslistIos.get(0).getParaValue());
        } else {
            model.addAttribute("versionIOS", "");
        }
    }


    @RequestMapping("/detailDemo")
    public String News(HttpServletRequest request, String newsId) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        return "/app/main/sciencePortal/portalDetail";
    }

    /**
     * 中科协用户帮助页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/helpDemo")
    public String helpDemo(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        return "/app/zgkxt/help";
    }

    /**
     * 中科协用户im页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/imDemo")
    public String imDemo(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        return "/app/zgkxt/im";
    }

    /**
     * 中科协用户d短信页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/mailDemo")
    public String mailDemo(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        return "/app/zgkxt/mail";
    }


    public void setCompany(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("company")) {
                    ContextHolder.setConsumerType("xoa" + cookie.getValue());
                }
                // get the cookie name
                // get the cookie value
            }
        }
    }


    @RequestMapping("/intranetBlue")//内网门户蓝
    public String intranetBlue() {
        return "app/main/intranetBlue";
    }

    @RequestMapping("/intranetRed")//内网门户红
    public String intranetRed() {
        return "app/main/intranetRed";
    }

    @RequestMapping("/sciencePorta")//中科协门户
    public String sciencePortal() {
        return "app/main/sciencePortal/sciencePorta";
    }

    @RequestMapping("/governmentPortal")//政务门户
    public String governmentPortal() {
        return "app/main/mupOAintranetRed";
    }

    @RequestMapping("/defaultIndexErr")//403拦截跳转页面
    public String defaultIndexErr() {
        /*String sysPara = null;
        try {
            sysPara = sysParaMapper.querySysPara("MYPROJECT").getParaValue();//防止有的产品没有myproject这个值
        }catch (Exception e){
            return "login/default/403";
        }
        if (sysPara != null && "BJYZ".equals(sysPara)) {
            String targetUrl = null;
            try {
                ThirdSysConfigWithBLOBs third = thirdSysConfigMapper.selectBySysName("毕节医专单点登录系统");
                targetUrl = third.getPara2();
            }catch (Exception e){
                return "login/default/403";
            }
            if(!StringUtils.checkNull(targetUrl)){//毕节医专单点登录系统
                return "redirect:"+targetUrl;
            }
        }else {
            return "login/default/403";
        }*/
        return "login/default/403";
    }
    @RequestMapping("/defaultIndexErrCas")//cas403拦截跳转页面
    public String defaultIndexErrCas() {
        return "login/default/errCas";
    }
    @RequestMapping("/defaultIndexError")//404拦截跳转页面

    public String defaultIndexError() {
        return "login/default/404";
    }

    @RequestMapping("/oa2xoa")
    public String oa2xoa(HttpServletRequest request) {
        try {
            String classpath = this.getClass().getResource("/").getPath();
            String webappRoot = classpath.replaceAll("WEB-INF/classes/", "ui/file/properties/");
            File file = new File(webappRoot + "jdbc.txt");
            String urltd_oa = new String();
            String unametd_oa = new String();
            String passwordtd_oa = new String();
            //判断文件是否存在
            if (file.isFile() && file.exists()) {

                InputStreamReader read = new InputStreamReader(
                        new FileInputStream(file));//考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt = null;
                int i = 1;
                while ((lineTxt = bufferedReader.readLine()) != null) {
                    if (i == 1) {
                        urltd_oa = lineTxt;
                    } else if (i == 2) {
                        unametd_oa = lineTxt;
                    } else {
                        passwordtd_oa = lineTxt;
                    }
                    i++;
                }
                read.close();
            }
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            String url = urltd_oa;
            String driver = props.getProperty("driverClassName");
            String username = unametd_oa;
            String password = passwordtd_oa;
            Class.forName(driver).newInstance();
            Connection conn = (Connection) DriverManager.getConnection(url, username, password);
            String sql = "SELECT VER FROM version ";
            Statement st = conn.createStatement();
            ResultSet resultSet = st.executeQuery(sql);
            Object object = new Object();
            //执行了多少条
            if (resultSet.next()) {
                object = resultSet.getObject(1);
            }
            String softVersion = SystemInfoServiceImpl.softVersion;
            if (!object.toString().equals(softVersion)) {
                return "app/common/updateDatebase";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "app/common/noupdateDatebase";
    }

    /**
     * 分公司登录窗口
     *
     * @return 登录窗口
     */
    @RequestMapping(value = "/branchOfLanding", method = RequestMethod.GET)
    // 登录窗口
    public String getCompanyAll(@RequestParam("loginId") String loginId,
                                HttpServletRequest request, HttpServletResponse response) {

        Cookie redisSessionCookie = new Cookie("redisSessionId", request.getSession().getId());
        SessionUtils.putSession(request.getSession(), "loginDateSouse", loginId, redisSessionCookie);
     /*   String LOCALE_SESSION_ATTRIBUTE_NAME = SessionLocaleResolver.class
                .getName() + ".LOCALE";
        Object locale = request.getSession().getAttribute(
                LOCALE_SESSION_ATTRIBUTE_NAME);*/
        return "login/" + loginId + "/login";
    }

    /**
     * 分公司登录窗口
     * @return 登录窗口
     */
    @RequestMapping(value = "/getCompanyAll", method = RequestMethod.GET)
    @ResponseBody
    public ToJson<OrgManage> logins(HttpServletRequest request, String locales) {
        String serverName = request.getServerName();
        Map<String, Object> map = new HashMap<String, Object>();
        String sqlType = "xoa1001";
        ContextHolder.setConsumerType(sqlType);
        if (locales == null) {
            locales = "en_US";
        }
        return orgManageService.queryId2(locales, serverName);
    }

    @RequestMapping("/mainmin")
    public String mainmin(HttpServletRequest request, Model model) {
        return "app/main/indexmin";
    }

    /**
     * 创建作者: 吴道全 创建日期: 2017-4-18 下午3:42:00 方法介绍: 跳转登录 参数说明: @return
     *
     * @return String
     */
    @RequestMapping("/main")
    // 登录窗口
    public String loginSuccess(HttpServletRequest request, Model model, HttpServletResponse response) {
        response.setHeader("Content-Type", "text/html;charset=utf-8");
        PrintWriter out = null;
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            String theme = SessionUtils.getSessionInfo(request.getSession(), "InterfaceModel", String.class, redisSessionCookie);
            model.addAttribute("theme", theme);
            List<InterfaceModel> interfaceModelList = interfaceService.getInterfaceInfo(request);
            if (interfaceModelList != null && interfaceModelList.size() > 0 &&
                    interfaceModelList.get(0).getAttachment() != null && interfaceModelList.get(0).getAttachment().size() > 0) {
                InterfaceModel interfaceModel = interfaceModelList.get(0);
                Attachment attachment = interfaceModel.getAttachment().get(0);

                String company = ContextHolder.getConsumerType();
                if (StringUtils.checkNull(company) || "xoanull".equals(company.toLowerCase())) {
                    List<OrgManage> org = orgManageMapper.queryId();
                    if (org != null && org.size() > 0) {
                        company = "xoa" + org.get(0).getOid().toString().trim();
                    }
                }

                String path = this.getPath() + System.getProperty("file.separator") + company +
                        System.getProperty("file.separator") + "interface" + System.getProperty("file.separator") + attachment.getYm() + System.getProperty("file.separator") + attachment.getAttachId() + "." + attachment.getAttachName();
                File f = new File(path);
                if (!f.exists()) {
                    interfaceModelList.get(0).setJudgeAttachmentUrl("/img/replaceImg/theme6/LOGOMain.png");
                }

                if (PinYinUtil.checkChinese(attachment.getAttachName())) {

                    String newPath = path.replace(attachment.getAttachName().substring(0, attachment.getAttachName().indexOf(".")), "mainLogo");
                    f.renameTo(new File(newPath));
                    String stem = attachment.getAttachName().substring(0, attachment.getAttachName().indexOf("."));
                    String attrul = attachment.getAttUrl().replace(stem, "mainLogo");
                    interfaceModelList.get(0).getAttachment().get(0).setAttUrl(attrul);
                    interfaceModel.setAttachmentName(interfaceModel.getAttachmentName().replace(stem, "mainLogo"));
                    sysInterfaceMapper.updateInterfaceInfo(interfaceModel);
                    attachment.setAttachName(attachment.getAttachName().replace(stem, "mainLogo"));
                    attachment.setAttachFile(attachment.getAttachName());
                    attachmentMapper.updateByPrimaryKeySelective(attachment);
                    interfaceModelList.get(0).setJudgeAttachmentUrl("/xs?" + attachment.getAttUrl().replaceAll("xoanull", company));
                }
            }
            //interfaceModel.setAttachment(attachment);
            model.addAttribute("LogoImg", interfaceModelList.get(0).getJudgeAttachmentUrl());
            model.addAttribute("bannerFont", interfaceModelList.get(0).getBannerFont());
            model.addAttribute("bannerText", interfaceModelList.get(0).getBannerText());
//        Cookie cookie= CookiesUtil.getCookieByName(request,"company");
//        CookiesUtil.setCookie(response,cookie.getName(),cookie.getValue());
//        Cookie cookie1= CookiesUtil.getCookieByName(request,"deptId");
//        CookiesUtil.setCookie(response,cookie1.getName(),cookie1.getValue());
//        Cookie cookie2= CookiesUtil.getCookieByName(request,"sex");
//        CookiesUtil.setCookie(response,cookie2.getName(),cookie2.getValue());
//        Cookie cookie3= CookiesUtil.getCookieByName(request,"uid");
//        CookiesUtil.setCookie(response,cookie3.getName(),cookie3.getValue());
//        Cookie cookie4= CookiesUtil.getCookieByName(request,"userName");
//        CookiesUtil.setCookie(response,cookie4.getName(),cookie4.getValue());
//        Cookie cookie5= CookiesUtil.getCookieByName(request,"userPriv");
//        CookiesUtil.setCookie(response,cookie5.getName(),cookie5.getValue());
//        Cookie cookie6= CookiesUtil.getCookieByName(request,"userPrivName");
//        CookiesUtil.setCookie(response,cookie6.getName(),cookie6.getValue());
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Integer uid = SessionUtils.getSessionInfo(request.getSession(), "uid", Integer.class, redisSessionId);
            Users user = usersMapper.getUsersByUid(uid);
            //2021.06.09修改 起始===============
            String functionIdStr = userFunctionMapper.getUserFuncIdStr(user.getUserId());
            SessionUtils.putSession(request.getSession(), "functionIdStr", functionIdStr, redisSessionCookie);
            //2021.06.09修改 结束===============
            if (user == null) {
                String err = "错误：用户数据错误，请联系管理员";
                try {
                    out = response.getWriter();
                    out.write(err);
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        out.flush();
                        out.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                return null;
            }
            SysPara myproject = sysParaMapper.querySysPara("MYPROJECT");
            Integer userDeptId = user.getDeptId();
            Department dpeartment = departmentMapper.getDeptById(userDeptId);
            if(myproject!=null&&"JIJIA".equals(myproject.getParaValue())&&dpeartment!=null&&new Integer(99999997).equals(dpeartment.getDeptParent())){ //如果是计家系统,部门是客户则跳转到客户下载页面
                return "/app/knowledge/clientManager/selectType";
            }else{
                ToJson<Syslog> modifyPwdLog = sysLogService.getModifyPwdLog(request);
                //判断一下是否是演示系统
                ToJson<Object> json = sysParaService.checkDemo();
                SysPara sysPara = sysParaMapper.selectget111();
                boolean flag = json.isFlag();
                if (flag == false) {
                    if (20 == (user.getTheme())) {
                        return "app/main/index20";
                    } else {
                        return "app/main/index";
                    }
                } else {
                    if (sysPara.getParaValue().equals("0") && user.getLastVisitTime() == null) {
                        if (20 == (user.getTheme())) {
                            return "app/main/index20";
                        } else {
                            return "app/main/index";
                        }
                    } else {
                        if (user.getLastVisitTime() != null) {
                            if (20 == (user.getTheme())) {
                                return "app/main/index20";
                            } else {
                                return "app/main/index";
                            }
                        } else {
                            if (modifyPwdLog.getObj().size() > 0) {
                                if (20 == (user.getTheme())) {
                                    return "app/main/index20";
                                } else {
                                    return "app/main/index";
                                }
                            }
                            return "app/url/modifyInfo";
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                out = response.getWriter();
                out.write(e.getMessage());
            } catch (IOException e1) {
                e1.printStackTrace();
            } finally {
                out.flush();
                out.close();
            }
        }
        return "";
    }


    /**
     * 创建作者: 吴道全 创建日期: 2017-4-18 下午3:42:00 方法介绍: 跳转登录 参数说明: @return
     * 中科协演示门户主页
     *
     * @return String
     */
    @RequestMapping("/maindemo")
    // 登录窗口
    public String loginSuccessdemo(HttpServletRequest request, Model model, HttpServletResponse response) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String theme = SessionUtils.getSessionInfo(request.getSession(), "InterfaceModel", String.class, redisSessionCookie);
        model.addAttribute("theme", theme);
        List<InterfaceModel> interfaceModelList = interfaceService.getInterfaceInfo(request);
        model.addAttribute("LogoImg", interfaceModelList.get(0).getJudgeAttachmentUrl());
        model.addAttribute("bannerFont", interfaceModelList.get(0).getBannerFont());
        model.addAttribute("bannerText", interfaceModelList.get(0).getBannerText());
//        Cookie cookie= CookiesUtil.getCookieByName(request,"company");
//        CookiesUtil.setCookie(response,cookie.getName(),cookie.getValue());
//        Cookie cookie1= CookiesUtil.getCookieByName(request,"deptId");
//        CookiesUtil.setCookie(response,cookie1.getName(),cookie1.getValue());
//        Cookie cookie2= CookiesUtil.getCookieByName(request,"sex");
//        CookiesUtil.setCookie(response,cookie2.getName(),cookie2.getValue());
//        Cookie cookie3= CookiesUtil.getCookieByName(request,"uid");
//        CookiesUtil.setCookie(response,cookie3.getName(),cookie3.getValue());
//        Cookie cookie4= CookiesUtil.getCookieByName(request,"userName");
//        CookiesUtil.setCookie(response,cookie4.getName(),cookie4.getValue());
//        Cookie cookie5= CookiesUtil.getCookieByName(request,"userPriv");
//        CookiesUtil.setCookie(response,cookie5.getName(),cookie5.getValue());
//        Cookie cookie6= CookiesUtil.getCookieByName(request,"userPrivName");
//        CookiesUtil.setCookie(response,cookie6.getName(),cookie6.getValue());
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Integer uid = SessionUtils.getSessionInfo(request.getSession(), "uid", Integer.class, redisSessionId);
        Users user = usersService.findUserByuid(uid);
        ToJson<Syslog> modifyPwdLog = sysLogService.getModifyPwdLog(request);
        //判断一下是否是演示系统
        ToJson<Object> json = sysParaService.checkDemo();
        SysPara sysPara = sysParaMapper.selectget111();
        boolean flag = json.isFlag();
        if (flag == false) {
            return "app/main/indexCT";
        } else {
            if (sysPara.getParaValue().equals("0") && user.getLastVisitTime() == null) {
                return "app/main/indexCT";
            } else {
                if (user.getLastVisitTime() != null) {
                    return "app/main/indexCT";
                } else {
                    if (modifyPwdLog.getObj().size() > 0) {
                        return "app/main/indexCT";
                    }
                    return "app/url/modifyInfo";
                }
            }
        }
    }

    /**
     * 分公司登录窗口
     * 张丽军
     *
     * @return 获取sessionId
     */
    @RequestMapping(value = "/getSessionId")
    public
    @ResponseBody
    ToJson<OrgManage> getSessionId(HttpServletRequest request, HttpServletResponse response) {
        ToJson<OrgManage> json = new ToJson<OrgManage>(0, null);
        CookiesUtil.setCookie(response, "redisSessionId", request.getSession().getId());
        Cookie redisSessionCookie = new Cookie("redisSessionId", request.getSession().getId());

        String ID = "";
        try {
            if (redisSessionCookie != null) {
                ID = redisSessionCookie.getValue();
            }
            json.setFlag(0);
            json.setMsg("ok");
            json.setId(ID);
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
        }

        return json;
    }
    //判断输入密码为什么字符
    Map map=new HashedMap();
    public Integer getNumByStr(String str){
        Integer strNum = 0;
        if(!StringUtils.checkNull(str)){
            /**中文字符 */
            int chCharacter = 0;

            /**空格 */
            int spaceCharacter = 0;
            /**数字 */
            int numberCharacter = 0;
            /**其他字符 */
            int otherCharacter = 0;
            /**大写英文字符 */
            int enCharacter = 0;
            /*小写字符*/
            int upCharacter=0;
            for (int i = 0; i < str.length(); i++) {
                char tmp = str.charAt(i);
                if ((tmp >= 'A' && tmp <= 'Z')){
                    enCharacter ++;
                }else if((tmp >= 'a' && tmp <= 'z')) {
                    upCharacter++;
                } else if ((tmp >= '0') && (tmp <= '9')) {
                    numberCharacter ++;
                } else if (tmp ==' ') {
                    spaceCharacter ++;
                } else if (isChinese(tmp)) {
                    chCharacter ++;
                } else {
                    otherCharacter ++;
                }
            }
            map.put("zifu",otherCharacter);
            map.put("shuzi",numberCharacter);
            map.put("xiaoxie",upCharacter);
            map.put("zimu",enCharacter+upCharacter);
            map.put("daxie",enCharacter);
            return chCharacter+upCharacter+((enCharacter/2)+(numberCharacter)/2)+(spaceCharacter/2)+otherCharacter;
        }else{
            return 0;
        }
    }


    /**
     * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:51:00 方法介绍: 匹配用户名和用户密码 参数说明: @param
     * username 用户名 参数说明: @param password 密码
     * 参数说明: @param request
     * 参数说明: @param userAgent mobile 移动   pc 网页
     * response 参数说明: @return 参数说明: @throws Exception
     *
     * @return String
     */
    @RequestMapping(value = "/login", produces = {"application/json;charset=UTF-8"})
    public
    @ResponseBody
    ToJson<Users> loginEnter(@RequestParam("username") String username,
                             String password, String loginId, String userAgent, String locales,
                             HttpServletRequest request, HttpServletResponse response, Integer h5Login) throws Exception {
        response.addHeader("Access-Control-Allow-Origin", "*");
        response.addHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
        response.addHeader("Access-Control-Max-Age", "1800");//30 min
        ToJson<Users> json = new ToJson<Users>(1, "err");
        CookiesUtil.setCookie(response, "redisSessionId", request.getSession().getId());
        Cookie redisSessionCookie = new Cookie("redisSessionId", request.getSession().getId());

        try {
            // 判断密码参数
            String xoacode = request.getParameter("xoacode");
            if (!StringUtils.checkNull(xoacode)) {
                password = xoacode;
            }

            //云OA的loginId为空时，根据云OA规则获取
            if (StringUtils.checkNull(loginId)) {
                loginId = this.queryCloudOALoginId(request);
            }

            List<OrgManage> org = orgManageMapper.queryId();

            //没有传登录组织ID 时 选默认组织
            if (StringUtils.checkNull(loginId)) {
                // List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    loginId = org.get(0).getOid().toString().trim();
                } else {
                    json.setMsg("无组织机构");
                    return json;
                }
            }

            // 判断是否是pc客户端 单独处理解密规则
            ContextHolder.setConsumerType("xoa" + loginId);
            if ("pc".equals(userAgent) && !StringUtils.checkNull(xoacode)) {
                password = new String(RSA.pcDecode(xoacode));
            }

            if (!StringUtils.checkNull(username) && username.length() == 88) {
                String privateKey = SessionUtils.getSessionInfo(request.getSession(), "privateKey", String.class, redisSessionCookie);
                //非对称加密算法解密
                password = RSA.decryptByPrivateKey(password, privateKey);
                username = RSA.decryptByPrivateKey(username, privateKey);
            }

            //获取token值，安卓华为有值，其它客户端为空或null
            String pushToken = request.getParameter("pushToken");

            // 判断是否是用于跳过验证码漏洞的伪造的userAgent
            if (request.getHeader("User-Agent").contains("Windows") && ("pc".equalsIgnoreCase(userAgent) || "android".equalsIgnoreCase(userAgent) || "ios".equalsIgnoreCase(userAgent))) {
                json.setMsg("请求头信息错误!");
                json.setFlag(1);
                json.setCode("100020");
                return json;
            }


            //判断是否开启验证码 主组织开启 默认其它组织也开启

            if (!StringUtils.checkNull(userAgent) && !"android".equals(userAgent.toLowerCase()) && !"ios".equals(userAgent.toLowerCase()) && !"pc".equals(userAgent.toLowerCase())) {
                String checkCode = CodeUtil.getCode(Integer.valueOf(loginId));
                //password = AESUtil.decryptToLogin(password, "sde=edrf-Effhgty", "vgb+.hnh-edcmjik");
                if ("1".equals(checkCode)) {
                    String graphic = request.getParameter("graphic");
                    String code = SessionUtils.getSessionInfo(request.getSession(), "graphic", String.class, redisSessionCookie);

                    if (StringUtils.checkNull(graphic) || StringUtils.checkNull(code) || !graphic.toLowerCase().equals(code)) {
                        SessionUtils.putSession(request.getSession(), "graphic", "", redisSessionCookie);
                        json.setMsg("验证码错误!");
                        json.setFlag(1);
                        json.setCode("100020");
                        return json;
                    }
                    SessionUtils.putSession(request.getSession(), "graphic", "", redisSessionCookie);
                }
            }

            // 移动设备型号信息
            String pdd = request.getParameter("pdd");
            // 获取企业微信和钉钉登陆判断参数
            String thirdPartyType = request.getParameter("thirdPartyType");
            if (StringUtils.checkNull(username)) {
                json.setCode(LoginState.LOGINPASSWORDERR);
                json.setMsg("用户名或密码错误");
                return json;
            }
            //移动端登录时，更新最新的华为Token
            Users userAll = usersMapper.selectUserByUserId(username);
            String mobileType = request.getParameter("mobileType");
            if ("android".equals(userAgent.toLowerCase()) || "ios".equals(userAgent.toLowerCase())) {
                if (userAll != null) {
                    userAll.setIcqNo(pushToken == null ? "" : pushToken);
                    userAll.setMobileType(mobileType == null ? "" : mobileType);
                    usersMapper.updateIcqNo(userAll);
                }
            }

            //加入操作日志处理
            Syslog sysLog = new Syslog();
            sysLog.setUserId("错误用户名");
            sysLog.setType(10);
            sysLog.setIp(IpAddr.getIpAddress(request));
            String clientVersion = request.getParameter("clientVersion");
            if ("iOS".equals(userAgent)) {
                //添加客户端类型
                sysLog.setRemark("USER_NAME=" + username + "(" + pdd + ")");
                sysLog.setClientType(3);
                //SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
                sysLog.setClientVersion(clientVersion);
            } else if ("android".equals(userAgent)) {
                sysLog.setRemark("USER_NAME=" + username + "(" + pdd + ")");
                sysLog.setClientType(4);
                //SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
                sysLog.setClientVersion(clientVersion);
            } else if ("pc".equals(userAgent)) {
                sysLog.setClientType(2);
                //SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
                sysLog.setClientVersion(clientVersion);
            } else {
                sysLog.setClientType(1);
                sysLog.setRemark("USER_NAME=" + username + "网页端" + "(" + request.getHeader("user-agent") + ")");
                if (clientVersion != null && clientVersion.length() > 0) {
                    sysLog.setClientVersion(clientVersion);
                } else {
                    sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
                }
            }
            ContextHolder.setConsumerType("xoa" + loginId);
            Users user = usersService.selectUserAllInfoByName(username, request, loginId, password, h5Login, thirdPartyType);
            if (user == null) {
                request.getSession().setAttribute("message", "errOne");
                sysLog.setTime(new Date(System.currentTimeMillis()));
                syslogMapper.save(sysLog);
                json.setMsg("用户名或密码错误");
                json.setCode(LoginState.LOGINPASSWORDERR);
                return json;
            }

            //根据loginId获取云OA组织属性
            OrgManage manage = orgManageMapper.selectOrgManageByOid("xoa1001", loginId);
            if(!Objects.isNull(manage)){
                Date date = new Date();
                //判断是否到提醒时间，提醒OA管理员服务结束
                if(!StringUtils.checkNull(manage.getRemindTime()) && date.compareTo(DateFormat.getDate(manage.getRemindTime())) > 0){
                    SmsBody smsBody = new SmsBody(user.getUserId(), "0", DateFormat.getTime(DateFormat.getCurrentTime()), "", "服务将在" + manage.getEndTime() + "到期");
                    List<Users> userPriv = usersMapper.getUsersByUserPriv("1");
                    String toIds = userPriv.stream().map(Users::getUserId).collect(Collectors.joining());
                    smsBody.setToId(user.getUserId());
                    smsBody.setBodyId(null);
                    smsBody.setRemindUrl("");
                    this.saveSms(smsBody, toIds, "1", "1", "服务到期提醒", "", loginId);//存储事物提醒并推送消息
                }

                //判断是否到结束时间，到结束时间限制或着超过限制人数只能 admin 登录
                Integer usedUsers = orgManageMapper.selectUsedUsers("xoa" + manage.getOid());
                if(((!StringUtils.checkNull(manage.getEndTime()) && date.compareTo(DateFormat.getDate(manage.getEndTime())) > 0)
                        || manage.getLicenseUsers() != null && manage.getLicenseUsers() != 0 && usedUsers > manage.getLicenseUsers()) && !"admin".equals(username)){
                    request.getSession().setAttribute("message", "errOne");
                    json.setMsg("登录失败，软件已过期");
                    json.setCode(LoginState.LOGINTIMEOUT);
                    return json;
                }
            }

            json.setBirthday(user.getBirthday());
            List<SysPara> list = sysParaMapper.selectAll();
            String pd = "", xts = "", cz = "", sips = "";
            for (SysPara sysPara : list) {
                if ("SEC_RETRY_BAN".equals(sysPara.getParaName()))
                    pd = sysPara.getParaValue();
                if ("SEC_RETRY_TIMES".equals(sysPara.getParaName()))
                    xts = sysPara.getParaValue();
                if ("SEC_BAN_TIME".equals(sysPara.getParaName()))
                    cz = sysPara.getParaValue();
                if ("SEC_INIT_PASS_SHOW".equals(sysPara.getParaName()))
                    sips = sysPara.getParaValue();
            }
            String userId = user.getUserId();
            //判断登陆者的密码是否为空 如果为空给出事务提示
            boolean bl = false;
            if (!"0".equals(sips)) {
                Users u = usersMapper.getPassWordByUserId(user.getUserId());
                if ((password.equals("") && u.getPassword().equals("tVHbkPWW57Hw.")) || (!StringUtils.checkNull(xoacode) && xoacode.equals("AA=="))) {

                    String title = null;
                    String context = "您的登录密码为空，存在风险，请尽快修改！";

                    String remindUrl = "/controlpanel/modifyInfo";
                    String smsType = "90";

                    SmsBody smsBody = new SmsBody(user.getUserId(), smsType, DateFormat.getTime(DateFormat.getCurrentTime()), remindUrl, context);
                    smsBody.setRemindUrl(remindUrl);
                    smsBody.setToId(user.getUserId());
                    smsBody.setBodyId(null);

                    Map<String, Object> smsMap = new HashMap<>();
                    smsMap.put("userId", user.getUserId());
                    smsMap.put("smsType", smsType);
                    smsMap.put("flag", "1");
                    List<SmsBodyExtend> willDocSendOrReceive = smsBodyMapper.getWillDocSendOrReceive(smsMap);
                    if (willDocSendOrReceive == null || willDocSendOrReceive.size() == 0) {
                        //事务提醒
                        this.saveSms(smsBody, user.getUserId(), "1", "1", title, context, "xoa" + loginId);//存储事物提醒并推送消息
                    }

                    bl = true;
                }
            }
            this.getNumByStr(password);
            SysPara sp = sysParaMapper.selectByParaNames("SEC_PASS_SAFE");
            SysPara sp1 = sysParaMapper.selectByParaNames("SEC_PASS_MIN");
            SysPara sp2 = sysParaMapper.selectByParaNames("SEC_PASS_MAX");
            Integer zimu = 0;
            Integer shuzi = 0;
            Integer zifu = 0;
            Integer daxie = 0;
            Integer xiaoxie = 0;
            if (map.containsKey("zimu")) {
                zimu = Integer.valueOf(String.valueOf(map.get("zimu")));
            }
            if (map.containsKey("shuzi")) {
                shuzi = Integer.valueOf(String.valueOf(map.get("shuzi")));
            }
            if (map.containsKey("zifu")) {
                zifu = Integer.valueOf(String.valueOf(map.get("zifu")));
            }
            if (map.containsKey("daxie")) {
                daxie = Integer.valueOf(String.valueOf(map.get("daxie")));
            }
            if (map.containsKey("xiaoxie")) {
                xiaoxie = Integer.valueOf(String.valueOf(map.get("xiaoxie")));
            }

            if (user.getPassword().equals("") && bl == false && !"0".equals(sips)) {
                if (password.length() < Integer.valueOf(sp1.getParaValue()) || password.length() > Integer.valueOf(sp2.getParaValue())) {
                    String title = null;
                    String context = "您的密码强度未达要求，存在风险，请尽快修改！";
                    String remindUrl = "/controlpanel/modifyInfo";
                    String smsType = "90";
                    SmsBody smsBody = new SmsBody(user.getUserId(), smsType, DateFormat.getTime(DateFormat.getCurrentTime()), remindUrl, context);
                    smsBody.setRemindUrl(remindUrl);
                    smsBody.setToId(user.getUserId());
                    smsBody.setBodyId(null);
                    //事务提醒
                    this.saveSms(smsBody, user.getUserId(), "1", "1", title, context, "xoa" + loginId);
                } else if ("1".equals(sp.getParaValue()) && (zimu == 0 || shuzi == 0)) {
                    String title = null;
                    String context = "您的密码强度未达要求，存在风险，请尽快修改！";
                    String remindUrl = "/controlpanel/modifyInfo";
                    String smsType = "90";
                    SmsBody smsBody = new SmsBody(user.getUserId(), smsType, DateFormat.getTime(DateFormat.getCurrentTime()), remindUrl, context);
                    smsBody.setRemindUrl(remindUrl);
                    smsBody.setToId(user.getUserId());
                    smsBody.setBodyId(null);
                    //事务提醒
                    this.saveSms(smsBody, user.getUserId(), "1", "1", title, context, "xoa" + loginId);//存储事物提醒并推送消息
                } else if ("2".equals(sp.getParaValue()) && (zimu == 0 || shuzi == 0 || zifu == 0)) {
                    String title = null;
                    String context = "您的密码强度未达要求，存在风险，请尽快修改！";
                    String remindUrl = "/controlpanel/modifyInfo";
                    String smsType = "90";
                    SmsBody smsBody = new SmsBody(user.getUserId(), smsType, DateFormat.getTime(DateFormat.getCurrentTime()), remindUrl, context);
                    smsBody.setRemindUrl(remindUrl);
                    smsBody.setToId(user.getUserId());
                    smsBody.setBodyId(null);
                    //事务提醒
                    this.saveSms(smsBody, user.getUserId(), "1", "1", title, context, "xoa" + loginId);//存储事物提醒并推送消息
                } else if ("3".equals(sp.getParaValue()) && (daxie == 0 || shuzi == 0 || xiaoxie == 0)) {
                    String title = null;
                    String context = "您的密码强度未达要求，存在风险，请尽快修改！";
                    String remindUrl = "/controlpanel/modifyInfo";
                    String smsType = "90";
                    SmsBody smsBody = new SmsBody(user.getUserId(), smsType, DateFormat.getTime(DateFormat.getCurrentTime()), remindUrl, context);
                    smsBody.setRemindUrl(remindUrl);
                    smsBody.setToId(user.getUserId());
                    smsBody.setBodyId(null);
                    //事务提醒
                    this.saveSms(smsBody, user.getUserId(), "1", "1", title, context, "xoa" + loginId);//存储事物提醒并推送消息
                } else if ("4".equals(sp.getParaValue()) && (daxie == 0 || shuzi == 0 || xiaoxie == 0 || zifu == 0)) {
                    String title = null;
                    String context = "您的密码强度未达要求，存在风险，请尽快修改！";
                    String remindUrl = "/controlpanel/modifyInfo";
                    String smsType = "90";
                    SmsBody smsBody = new SmsBody(user.getUserId(), smsType, DateFormat.getTime(DateFormat.getCurrentTime()), remindUrl, context);
                    smsBody.setRemindUrl(remindUrl);
                    smsBody.setToId(user.getUserId());
                    smsBody.setBodyId(null);
                    //事务提醒
                    this.saveSms(smsBody, user.getUserId(), "1", "1", title, context, "xoa" + loginId);//存储事物提醒并推送消息
                }
            }
            //登录错误重试数次后会被限制数分钟内不能登录。
            if ("1".equals(pd)) {
                //先判断登陆错误次数是否已达上限
                //得到几分钟后可操作
                UserExt userEx = userExtMapper.selUserExtByUserId(user.getUserId());
                if (Integer.parseInt(xts) <= Integer.parseInt(userEx.getLoginRestriction())) {
                    //if (false) {
                    //已达上限
                    long currentTime = System.currentTimeMillis();
                    SimpleDateFormat dateFormat = new SimpleDateFormat(
                            "yyyy-MM-dd HH:mm:ss");
                    String time = dateFormat.format(new Date(currentTime));
                    String tim = userEx.getLoginTime();
                    if ("".equals(tim) || tim == null) {
                        tim = "1990-01-01 00:00:01";
                    }
                    Date time1 = DateFormat.getDate(tim);
                    long c = (DateFormat.getDate(time).getTime() - time1.getTime());
                    long fz = c / 60000;
                    if (fz >= Integer.parseInt(cz)) {
                        userEx.setLoginRestriction("0");
                        userEx.setLoginTime("");
                        userExtMapper.updateUserExtByuidlogin(userEx);
                        int qk = 0;
                        json = login(json, qk, user, username, password, pd, cz, xts, request, loginId, locales);
                        return json;
                    } else {
                        sysLog.setUserId(user.getUserId() + "");
                        sysLog.setType(2);
                        sysLog.setTypeName("登录密码错误");
                        sysLog.setTime(new Date(System.currentTimeMillis()));
                        sysLog.setRemark("已锁定，密码或用户名错误超过" + Integer.parseInt(xts) + "次，请等待" + cz + "分钟后再重试" + password);
                        syslogMapper.save(sysLog);
                        json.setMsg("密码或用户名错误超过" + Integer.parseInt(xts) + "次，请等待" + cz + "分钟后再重试");
                        json.setCode(LoginState.LOGINLOCKERR);
                        return json;
                    }
                } else {
                    int qk = 0;
                    json = login(json, qk, user, username, password, pd, cz, xts, request, loginId, locales);
                    return json;
                }
            } else {

                int qk = 1;
                json = login(json, qk, user, username, password, pd, cz, xts, request, loginId, locales);
                return json;
            }
        }catch (Exception e){
            json.setCode(LoginState.LOGINPASSWORDERR);
            json.setMsg("系统异常");
            e.printStackTrace();
            L.e("loginController.loginEnter: " + e.getMessage());
        }
        return json;
    }


    @RequestMapping(value = "/jsonp/login", produces = {"application/json;charset=UTF-8"})
    public void jsnopLoginEnter(@RequestParam("username") String username,
                                @RequestParam("password") String password, String loginId, String userAgent, String locales,
                                String thirdAssessToken,
                                HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        response.addHeader("Access-Control-Allow-Origin", "*");
        response.addHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
        response.addHeader("Access-Control-Max-Age", "1800");//30 min

        CookiesUtil.setCookie(response, "redisSessionId", request.getSession().getId());
        Cookie redisSessionCookie = new Cookie("redisSessionId", request.getSession().getId());
        ToJson<Users> json = new ToJson<Users>(0, null);
        boolean jsonP = false;
        String cb = request.getParameter("callback");
        if (cb != null) {
            jsonP = true;
            response.setContentType("text/javascript");
        } else {
            response.setContentType("application/x-json");
        }
        PrintWriter out = null;
        out = response.getWriter();
        if (jsonP) {
            out.write(cb + "(");
        }

        if (StringUtils.checkNull(loginId)) {
            loginId = (String) request.getSession().getAttribute(
                    "loginDateSouse");
            if (StringUtils.checkNull(loginId)) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    loginId = org.get(0).getOid().toString().trim();
                }
            }
        }
        SessionUtils.putSession(request.getSession(), "loginDateSouse", loginId, redisSessionCookie);
        SessionUtils.putSession(request.getSession(), "LOCALE_SESSION_ATTRIBUTE_NAME", locales, redisSessionCookie);
        if(StringUtils.checkNull(password)){
            if(StringUtils.checkNull(thirdAssessToken)){
                json.setMsg("验证失败，无法登陆");
                json.setCode(LoginState.LOGINOUTERR);
                json.setFlag(1);
                out.append(JSONObject.toJSONString(json));
                if (jsonP) {
                    out.write(");");
                }
                out.flush();
                out.close();
                return;
            }
        }
        String assessCode = request.getParameter("assessCode");
        if(StringUtils.checkNull(assessCode)&&!StringUtils.checkNull(thirdAssessToken)){
            String code = CookiesUtil.getCookieByName(request, "thirdAssessToken").getValue();
            if (StringUtils.checkNull(thirdAssessToken) || StringUtils.checkNull(code) || !thirdAssessToken.equals(code)) {
                json.setMsg("验证失败，无法登陆");
                json.setCode(LoginState.LOGINOUTERR);
                json.setFlag(1);
                out.append(JSONObject.toJSONString(json));
                if (jsonP) {
                    out.write(");");
                }
                out.flush();
                out.close();
                return;
            }
            CookiesUtil.setCookie(response,"thirdAssessToken","");
        }
        // 获取企业微信和钉钉登陆判断参数
        String thirdPartyType = request.getParameter("thirdPartyType");

        // 企业微信
        if (!StringUtils.checkNull(thirdPartyType) && "1".equals(thirdPartyType)&&!StringUtils.checkNull(thirdAssessToken)) {
            UserWeixinqy userWeixinqy = userWeixinqyMapper.selUserByOpenId(username);
            if (userWeixinqy != null && !StringUtils.checkNull(userWeixinqy.getUserId())) {
                Users users = usersMapper.getUsersByuserId(userWeixinqy.getUserId());
                if (users != null && !StringUtils.checkNull(users.getByname())) {
                    username = users.getByname();
                }
            }
        }

        // 钉钉
        if (!StringUtils.checkNull(thirdPartyType) && "2".equals(thirdPartyType)&&!StringUtils.checkNull(thirdAssessToken)) {
            UserDDMap userDDMap = userDDMapMapper.selUserByOpenId(username);
            if (userDDMap != null && !StringUtils.checkNull(userDDMap.getOaUid())) {
                Users users = usersMapper.getUsersByuserId(userDDMap.getOaUid());
                if (users != null && !StringUtils.checkNull(users.getByname())) {
                    username = users.getByname();
                }
            }
        }

        // 华为welink
        if (!StringUtils.checkNull(thirdPartyType) && "3".equals(thirdPartyType)&&!StringUtils.checkNull(thirdAssessToken)) {
            UserWeLinkExample example = new UserWeLinkExample();
            UserWeLinkExample.Criteria criteria = example.createCriteria();
            criteria.andWlUserIdEqualTo(username);
            List<UserWeLink> userWeLinks = userWeLinkMapper.selectByExample(example);
            if (userWeLinks.size() > 0 && !StringUtils.checkNull(userWeLinks.get(0).getOaUserId())) {
                Users users = usersMapper.getUsersByuserId(userWeLinks.get(0).getOaUserId());
                if (users != null && !StringUtils.checkNull(users.getByname())) {
                    username = users.getByname();
                }
            }
        }


        if (StringUtils.checkNull(username)) {
            json.setFlag(1);
            json.setCode(LoginState.LOGINPASSWORDERR);
            json.setMsg("用户名或密码错误");
            // 这里主要关闭。
            out.append(JSONObject.toJSONString(json));
            if (jsonP) {
                out.write(");");
            }
            out.flush();
            out.close();
        }
        ContextHolder.setConsumerType("xoa" + loginId);
        Users user = usersService.selectUserAllInfoByName(username, request, loginId, password, 0, thirdPartyType);
        if (user == null) {
            request.getSession().setAttribute("message", "errOne");
            json.setMsg("用户名或密码错误");  //因为检测到用户登录账户 返回错误时的反馈信息中包含敏感内容
            json.setCode(LoginState.LOGINPASSWORDERR);
            json.setFlag(1);
            out.append(JSONObject.toJSONString(json));
            if (jsonP) {
                out.write(");");
            }
            out.flush();
            out.close();

        }
        Map<String, String> createMap = new HashMap<String, String>();
        createMap.put("userid", username);
        createMap.put("password", password);
        String httpOrgCreateTestRtn = null;
        Boolean isPassWordRight = usersService.checkPassWord(username, password);
        if (!StringUtils.checkNull(thirdPartyType)) {
            isPassWordRight = true;
        }
        if (isPassWordRight) {
            httpOrgCreateTestRtn = "ok\n\n";
        } else {
            httpOrgCreateTestRtn = "err\n\n";
        }
        if (httpOrgCreateTestRtn.trim().equals("ok")) {

            if (MobileCheck.isMobileDevice(request.getHeader("user-agent"))) {
                if (user.getNotMobileLogin() == 1) {
                    request.getSession().setAttribute("message", "禁止登录");
                    json.setMsg("用户禁止登录");
                    json.setCode(LoginState.LOGINOUTERR);
                    json.setFlag(1);
                    out.append(JSONObject.toJSONString(json));
                    if (jsonP) {
                        out.write(");");
                    }
                    out.flush();
                    out.close();
                }
            } else {
                if (user.getNotLogin() == 1) {
                    request.getSession().setAttribute("message", "禁止登录");
                    json.setMsg("用户禁止登录");
                    json.setCode(LoginState.LOGINOUTERR);
                    json.setFlag(1);
                    out.append(JSONObject.toJSONString(json));
                    if (jsonP) {
                        out.write(");");
                    }
                    out.flush();
                    out.close();
                }
            }
            SessionUtils.putSession(request.getSession(), user, redisSessionCookie);
            Map<String, Object> params = new HashMap<String, Object>();
            String functionIdStr = userFunctionMapper.getUserFuncIdStr(user.getUserId());
            params.put("paraName", user.getPara().getParaName());
            params.put("paraValue", user.getPara().getParaValue());
            params.put("functionIdStr", functionIdStr);


            json.setMsg(request.getSession().getId());
            json.setToken(request.getSession().getId());

            List<InterfaceModel> interfaceModels = sysInterfaceMapper.getInterfaceInfo();
            if (0 == user.getTheme()) {
                user.setTheme(Integer.parseInt(interfaceModels.get(0).getTheme()));
            }
            String theme = "theme" + user.getTheme();
//            SessionUtils.putSession(request.getSession(), "InterfaceModel", theme,redisSessionCookie);
            params.put("InterfaceModel", theme);
            SessionUtils.putSession(request.getSession(), params, redisSessionCookie);

            if (StringUtils.checkNull(interfaceModels.get(0).getIeTitle())) {
                user.setInterfaceTitle("");
            } else {
                user.setInterfaceTitle(interfaceModels.get(0).getIeTitle());
            }

            user.setAppPropulsionId(this.getMachineCode12());
            json.setObject(user);
            json.setFlag(0);
            user.setLastVisitTime(new Date());
            usersService.updateLoginTime(user);

        } else if (httpOrgCreateTestRtn.trim().equals("err")) {
            usersService.insetErrLog(username);
            request.getSession().setAttribute("message", "errOne");
            json.setMsg(" 用户名或密码错误");
            json.setCode(LoginState.LOGINPASSWORDERR);
            json.setFlag(1);
            out.append(JSONObject.toJSONString(json));
            if (jsonP) {
                out.write(");");
            }
            out.flush();
            out.close();
        }
        out.append(JSONObject.toJSONString(json));
        if (jsonP) {
            out.write(");");
        }
        out.flush();
        out.close();

    }


    /**
     *
     * @param username
     * @param password
     * @param loginId
     * @param locales
     * @param thirdAssessToken
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/jsonp/v1/login", produces = {"application/json;charset=UTF-8"})
    public void jsnopLoginEnter1(@RequestParam("username") String username,
                                 @RequestParam(value = "password",defaultValue = "") String password,
                                 String loginId, String locales,String thirdAssessToken,
                                 HttpServletRequest request, HttpServletResponse response) throws Exception{
        response.addHeader("Access-Control-Allow-Origin", "*");
        response.addHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
        response.addHeader("Access-Control-Max-Age", "1800");//30 min

        CookiesUtil.setCookie(response, "redisSessionId", request.getSession().getId());
        Cookie redisSessionCookie = new Cookie("redisSessionId", request.getSession().getId());
        ToJson<Users> json = new ToJson<Users>(0, null);
        boolean jsonP = false;
        PrintWriter out = null;
        try {
            out = response.getWriter();

            String cb = request.getParameter("callback");
            if (cb != null) {
                jsonP = true;
                response.setContentType("text/javascript");
            } else {
                response.setContentType("application/x-json");
            }

            if (jsonP) {
                out.write(cb + "(");
            }


            // 获取登陆判断参数
            String thirdPartyType = request.getParameter("thirdPartyType");

            if (StringUtils.checkNull(loginId)) {
                loginId = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                if (StringUtils.checkNull(loginId)){
                    OrgManage org = orgManageMapper.selFirstOrg();
                    loginId = org != null && org.getOid() != null ? org.getOid().toString().trim() : "1001";
                }
            }

            //第一次登录oa时，存app用户信息到一个公共表,第一次登录如查不到这个表有记录，需要遍历所有oa数据库，找到oa用户，然后验证码验证手机号是他本人的
            if (!StringUtils.checkNull(thirdPartyType) && "3".equals(thirdPartyType) ) {
                AppOaUser appOaUser = appOaUserMapper.selUserByOpenId(username);
                if (appOaUser != null && !StringUtils.checkNull(appOaUser.getUserId()) && !StringUtils.checkNull(appOaUser.getOid()) ) {
                    if ( !loginId.equals(appOaUser.getOid()) ){
                        loginId = appOaUser.getOid();
                        ContextHolder.setConsumerType("xoa" + loginId);
                    }
                    Users users = usersMapper.getUsersByuserId(appOaUser.getUserId());
                    username = users != null && !StringUtils.checkNull(users.getByname()) ? users.getByname() : "";
                }
                else {
                    boolean isOUsr = true;
                    List<OrgManage> orgList = orgManageMapper.queryId();
                    for (OrgManage org : orgList) {
                        ContextHolder.setConsumerType("xoa" + org.getOid());
                        Users users = usersMapper.selectUserByMobilNo(username);
                        if (users != null){
                            if ( !loginId.equals(String.valueOf(org.getOid())) ){
                                ContextHolder.setConsumerType("xoa" + loginId);
                                loginId = String.valueOf(org.getOid());
                            }
                            AppOaUser appOaUser1 = new AppOaUser();
                            appOaUser1.setUserId(users.getUserId());
                            appOaUser1.setAppId(thirdAssessToken);
                            appOaUser1.setMobilNo(username);
                            appOaUser1.setOid(org.getOid().toString());
                            appOaUserMapper.insertSelective(appOaUser1);
                            username = !StringUtils.checkNull(users.getByname()) ? users.getByname() : "";
                            isOUsr = false;
                            break;
                        }
                    }

                    if (isOUsr){
                        username = "";
                    }

                }
            }

            SessionUtils.putSession(request.getSession(), "loginDateSouse", loginId, redisSessionCookie);
            SessionUtils.putSession(request.getSession(), "LOCALE_SESSION_ATTRIBUTE_NAME", locales, redisSessionCookie);

            if (StringUtils.checkNull(username)) {
                json.setFlag(1);
                json.setCode(LoginState.LOGINPASSWORDERR);
                json.setMsg("用户名或密码错误");
                return;
            }

            ContextHolder.setConsumerType("xoa" + loginId);
            Users user = usersService.selectUserAllInfoByName(username, request, loginId, password, 0, thirdPartyType);
            if (user == null) {
                request.getSession().setAttribute("message", "errOne");
                json.setMsg("用户名或密码错误");  //因为检测到用户登录账户 返回错误时的反馈信息中包含敏感内容
                json.setCode(LoginState.LOGINPASSWORDERR);
                json.setFlag(1);
                return;
            }

            Map<String, String> createMap = new HashMap<String, String>();
            createMap.put("userid", username);
            createMap.put("password", password);
            String httpOrgCreateTestRtn = null;
            Boolean isPassWordRight = usersService.checkPassWord(username, password);
            if (!StringUtils.checkNull(thirdPartyType)) {
                isPassWordRight = true;
            }
            if (isPassWordRight) {
                httpOrgCreateTestRtn = "ok\n\n";
            } else {
                httpOrgCreateTestRtn = "err\n\n";
            }
            if (httpOrgCreateTestRtn.trim().equals("ok")) {

                if (MobileCheck.isMobileDevice(request.getHeader("user-agent"))) {
                    if (user.getNotMobileLogin() == 1) {
                        request.getSession().setAttribute("message", "禁止登录");
                        json.setMsg("用户禁止登录");
                        json.setCode(LoginState.LOGINOUTERR);
                        json.setFlag(1);
                        return;
                    }
                } else {
                    if ( user.getNotLogin() == 1) {
                        request.getSession().setAttribute("message", "禁止登录");
                        json.setMsg("用户禁止登录");
                        json.setCode(LoginState.LOGINOUTERR);
                        json.setFlag(1);
                        return;
                    }
                }
                SessionUtils.putSession(request.getSession(), user, redisSessionCookie);
                Map<String, Object> params = new HashMap<String, Object>();
                String functionIdStr = userFunctionMapper.getUserFuncIdStr(user.getUserId());
                params.put("paraName", user.getPara().getParaName());
                params.put("paraValue", user.getPara().getParaValue());
                params.put("functionIdStr", functionIdStr);


                json.setMsg(request.getSession().getId());
                json.setToken(request.getSession().getId());

                List<InterfaceModel> interfaceModels = sysInterfaceMapper.getInterfaceInfo();
                if (0 == user.getTheme()) {
                    user.setTheme(Integer.parseInt(interfaceModels.get(0).getTheme()));
                }
                String theme = "theme" + user.getTheme();
                params.put("InterfaceModel", theme);
                SessionUtils.putSession(request.getSession(), params, redisSessionCookie);

                if (StringUtils.checkNull(interfaceModels.get(0).getIeTitle())) {
                    user.setInterfaceTitle("");
                } else {
                    user.setInterfaceTitle(interfaceModels.get(0).getIeTitle());
                }

                user.setAppPropulsionId(this.getMachineCode12());
                json.setObject(user);
                json.setFlag(0);
                user.setLastVisitTime(new Date());
                usersService.updateLoginTime(user);
            }
            else if (httpOrgCreateTestRtn.trim().equals("err")) {
                usersService.insetErrLog(username);
                request.getSession().setAttribute("message", "errOne");
                json.setMsg(" 用户名或密码错误");
                json.setCode(LoginState.LOGINPASSWORDERR);
                json.setFlag(1);
                return;
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        finally {
            if (out != null){
                out.append(JSONObject.toJSONString(json));
                if (jsonP) {
                    out.write(");");
                }
                out.flush();
                out.close();
            }
        }
        return;
    }


    @RequestMapping(value = "/logOut", produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public BaseWrapper logOut(HttpServletRequest request) {
        BaseWrapper wrapper = new BaseWrapper();

        //获取要退出的用户
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String userId = user.getUserId();

        //加入操作日志处理
        Syslog sysLog = new Syslog();
        sysLog.setUserId(user.getUserId() + "");
        sysLog.setType(22);
        sysLog.setTypeName("退出系统");
        sysLog.setIp(IpAddr.getIpAddress(request));
        sysLog.setRemark("");
        String userAgent = request.getParameter("userAgent");
        if ("iOS".equals(userAgent)) {
            //添加客户端类型
            sysLog.setClientType(3);
            SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else if ("android".equals(userAgent)) {
            sysLog.setClientType(4);
            SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else if ("pc".equals(userAgent)) {
            sysLog.setClientType(2);
            SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else {
            sysLog.setClientType(1);
            String clientVersion = request.getParameter("clientVersion");
            if (clientVersion != null && clientVersion.length() > 0) {
                sysLog.setClientVersion(clientVersion);
            } else {
                sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
            }
        }

        Map<String, Object> userCountMap = loginController.userCountMap;
        UserOnline userOnline = (UserOnline) userCountMap.get(user.getUserId());
        Users users = usersMapper.selectUserByUserId2(user.getUserId());
        if (userOnline != null) {
            //判断是哪端的注销
            if ("iOS".equals(userAgent)) {
                userOnline.setIostime(0);
                userOnline.setIOSsid("");
            } else if ("android".equals(userAgent)) {
                userOnline.setAndroidsid("");
                userOnline.setAndroidtime(0);
                users.setIcqNo(null);
                usersMapper.updateIcqNo(users);
            } else if ("pc".equals(userAgent)) {
                userOnline.setPCsid("");
                userOnline.setPCtime(0);
            } else {
                userOnline.setWebsid("");
                userOnline.setWebtime(0);
            }
            //如果各端的人数都下线了，择才从静态map从移除userId
            if (StringUtils.checkNull(userOnline.getWebsid()) && StringUtils.checkNull(userOnline.getAndroidsid()) && StringUtils.checkNull(userOnline.getPCsid()) && StringUtils.checkNull(userOnline.getIOSsid())) {
                if (!StringUtils.checkNull(userId)) {
                    loginController.userCountMap.remove(userId);
                }
            }
        }
        request.getSession().invalidate();//让SESSION失效
        SessionUtils.cleanUserSession(request.getSession(), redisSessionId);
        sysLog.setRemark("退出系统");
        sysLog.setTime(new Date(System.currentTimeMillis()));
        syslogMapper.save(sysLog);
        wrapper.setFlag(true);
        wrapper.setStatus(true);
        wrapper.setMsg("注销成功");
        return wrapper;


    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/6 23:08
     * @函数介绍: 判断密码是否正确
     * @参数说明: @param user
     * @return: jaon
     **/
    @ResponseBody
    @RequestMapping("/checkPassword")
    public ToJson<Object> checkPassword(HttpServletRequest request, String userName, String password) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<Object> json = new ToJson<Object>(0, null);
        try {
            Boolean isPassWordRight = usersService.checkPassWord(userName, password);

            if (isPassWordRight != null && isPassWordRight) {
                json.setFlag(0);
                json.setMsg("OK");
            } else {
                json.setFlag(1);
            }
        } catch (Exception e) {

            json.setMsg(e.getMessage());
        }
        return json;

    }

    /**
     * @创建作者: 王曰岐
     * @函数介绍: 多语言管理
     * @参数说明: @param user
     * @return: jaon
     **/
    @ResponseBody
    @RequestMapping("/login/multilingual")
    public ToJson<Object> multilingual(String locales, HttpServletRequest request) {
        ToJson<Object> toJson = new ToJson<Object>();
        CommonSessionContext myContext = CommonSessionContext.getInstance();
        Cookie redisSessionCookie = new Cookie("redisSessionId", request.getSession().getId());
        if (!StringUtils.checkNull(locales)) {
            HttpSession session = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().contains("JSESSIONID1")) {
                        String sessionId = cookie.getValue();
                        session = myContext.getSession(sessionId);
                        SessionUtils.putSession(session, "LOCALE_SESSION_ATTRIBUTE_NAME", locales, redisSessionCookie);
                    }
                }
            }


            toJson.setFlag(0);
            toJson.setMsg("ok");
            toJson.setObject(locales);


        }
        return toJson;
    }

    //正常登陆方法
    public ToJson<Users> login(ToJson json, int qk, Users user, String username, String password, String pd, String cz, String xts, HttpServletRequest request, String loginId, String locales) {
        Cookie redisSessionCookie = new Cookie("redisSessionId", request.getSession().getId());
        //加入操作日志处理
        Syslog sysLog = new Syslog();
        sysLog.setUserId(user.getUserId() + "");
        sysLog.setType(2);
        sysLog.setTypeName("登录密码错误");
        sysLog.setIp(IpAddr.getIpAddress(request));
        sysLog.setRemark("");
        String userAgent1 = request.getParameter("userAgent");
        String clientVersion = request.getParameter("clientVersion");
        if ("iOS".equals(userAgent1)) {
            //添加客户端类型
            sysLog.setClientType(3);
            //SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
            sysLog.setClientVersion(clientVersion);
        } else if ("android".equals(userAgent1)) {
            sysLog.setClientType(4);
            //SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
            sysLog.setClientVersion(clientVersion);
        } else if ("pc".equals(userAgent1)) {
            sysLog.setClientType(2);
            SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else {
            sysLog.setClientType(1);
            if (clientVersion != null && clientVersion.length() > 0) {
                sysLog.setClientVersion(clientVersion);
            } else {
                sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
            }
        }
        Map<String, String> createMap = new HashMap<String, String>();
        createMap.put("userid", username);
        createMap.put("password", password);
        String httpOrgCreateTestRtn = null;
        if (user.getIsPassWordRight().equals("ok")) {
            httpOrgCreateTestRtn = "ok\n\n";
        } else {
            httpOrgCreateTestRtn = "err\n\n";
        }
        if (httpOrgCreateTestRtn.trim().equals("ok")) {

            if (MobileCheck.isMobileDevice(request.getHeader("user-agent"))) {
                if (user.getNotMobileLogin() == 1) {
                    request.getSession().setAttribute("message", "禁止登录");
                    json.setMsg("用户禁止登录");
                    json.setCode(LoginState.LOGINOUTERR);
                    json.setFlag(1);
                    return json;
                }
            } else {
                if (user.getNotLogin() == 1) {
                    request.getSession().setAttribute("message", "禁止登录");
                    json.setMsg("用户禁止登录");
                    json.setCode(LoginState.LOGINOUTERR);
                    json.setFlag(1);
                    return json;

                }
            }

            // 判断分支机构是否开启
            SysPara isOrgScope = sysParaMapper.querySysPara("ORG_SCOPE");
            if (isOrgScope != null && !StringUtils.checkNull(isOrgScope.getParaValue()) &&  "1".equals(isOrgScope.getParaValue())) {
                // 获取当前用户所在的分支机构 写入session
                Department department = departmentServiceImpl.queryDeptParent(user.getDeptId());
                if (department != null) {
                    // 是分支机构用户，则存入当前用户所在的分支机构ID
                    user.setBranchDeptId(department.getDeptId());
                }
            }

            SessionUtils.putSession(request.getSession(), user, redisSessionCookie);

//            SessionUtils.putSession(request.getSession(), "loginDateSouse", loginId,redisSessionCookie);//组织id
//            SessionUtils.putSession(request.getSession(), "LOCALE_SESSION_ATTRIBUTE_NAME", locales,redisSessionCookie);//语言


            Map<String, Object> params = new HashMap<String, Object>();
            params.put("paraName", "IM_WINDOW_CAPTION");
            params.put("paraValue", user.getPara().getParaValue());
            params.put("loginDateSouse", loginId);//组织id
            params.put("LOCALE_SESSION_ATTRIBUTE_NAME", locales);//语言

            request.getSession().setAttribute("IS_SHOW_JMJ", "1");


            String functionIdStr = userFunctionMapper.getUserFuncIdStr(user.getUserId());
            params.put("functionIdStr", functionIdStr);

            List<InterfaceModel> interfaceModels = sysInterfaceMapper.getInterfaceInfo();
            if (0 == user.getTheme() || null == user.getTheme()) {
                user.setTheme(Integer.parseInt(interfaceModels.get(0).getTheme()));
            }

            String theme = "theme" + user.getTheme();
            params.put("InterfaceModel", theme);

            SessionUtils.putSession(request.getSession(), params, redisSessionCookie);

            //判断是否设置系统会话过期时间，根据配置设置session失效时间
            SysPara sessionTime = sysParaMapper.querySysPara("SYS_SESSION_TIME");
            if(!Objects.isNull(sessionTime) && !"0".equals(sessionTime.getParaValue())){
                request.getSession().setMaxInactiveInterval(Integer.valueOf(sessionTime.getParaValue()) * 60);
                request.getSession().setAttribute("expiryTimeSet", request.getSession().getMaxInactiveInterval() * 1000);
            }
//            SessionUtils.putSession(request.getSession(), "functionIdStr", functionIdStr,redisSessionCookie);
            String isFriends = "0";
            //取即时通讯好友部门判断
            SysPara sysPara = new SysPara();
            List<SysPara> sysParas = sysParaMapper.getTheSysParam("ISIMFRIENDS");
            if (sysParas != null && sysParas.size() >= 1) {
                sysPara = sysParas.get(0);
            }
            if (!"".equals(sysPara.getParaValue())) {
                if ("1".equals(sysPara.getParaValue())) {
                    isFriends = "1";
                }
            }
            user.setIsFriends(isFriends);
            //即时通讯完

            json.setMsg(request.getSession().getId());
            json.setToken(request.getSession().getId());
            //                }


            if (StringUtils.checkNull(interfaceModels.get(0).getIeTitle())) {
                user.setInterfaceTitle("");
            } else {
                user.setInterfaceTitle(interfaceModels.get(0).getIeTitle());
            }
            user.setAppPropulsionId(this.getMachineCode12());

            //添加登录权限
            if (qk == 0) {
                //登录成功清空登录值
                UserExt userExt = userExtMapper.selUserExtByUserId(user.getUserId());
                userExt.setLoginRestriction(String.valueOf(0));
                userExt.setLoginTime("");
                userExtMapper.updateUserExtByuidlogin(userExt);
            }
            //获取当前用户的登录日志
            ToJson<Syslog> modifyPwdLog = sysLogService.getLoginLog(request);

            if (user.getLastVisitTime() != null) {
                user.setLastVisitTime(new Date());
                usersService.updateLoginTime(user);
            } /*else {
                //判断他的size小于等于1，因为在查用户user信息时写入log日志的，因此第一次登录size为1
                if (modifyPwdLog.getObj() == null || modifyPwdLog.getObj().size() <= 1) {
                    json.setCode("FirstLogin");
                } else {
                    user.setLastVisitTime(new Date());
                    usersService.updateLoginTime(user);
                }
            }*/

            if (StringUtils.checkNull(loginId)) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    loginId = org.get(0).getOid().toString().trim();
                }
            }
            user.setCompanyId(loginId);
            //判断用户头像
            if (StringUtils.checkNull(user.getAvatar())) {
                if (!StringUtils.checkNull(user.getSex())) {
                    user.setAvatar(user.getSex());
                } else {
                    user.setAvatar("0");
                }

            } else {
                if (user.getAvatar().equals("0") || user.getAvatar().equals("1")) {
                    if (!StringUtils.checkNull(user.getSex())) {
                        user.setAvatar(user.getSex());
                    } else {
                        user.setAvatar("0");
                    }
                } else {
                    //判断用户头像是否找得到
                    String classpath = this.getClass().getResource("/").getPath();
                    String webappRoot = classpath.replaceAll("WEB-INF/classes/", "ui/img/user/");
                    File file_avtor = new File(webappRoot + user.getAvatar());
                    if (!file_avtor.exists()) {
                        user.setAvatar(user.getSex());
                    }
                }
            }
            json.setObject(user);
            json.setFlag(0);

            //做一下在线人数

            String userAgent = request.getParameter("userAgent");
            //通过userId查询用户是否存在于静态map中
            UserOnline userOnline = (UserOnline) userCountMap.get(user.getUserId());
            //如果不存在
            if (userOnline == null) {
                //声明一个新的用户在线数据
                UserOnline userOnlineInfo = new UserOnline();
                userOnlineInfo.setRedisSessionId(request.getSession().getId());
                if ("iOS".equals(userAgent)) {
                    userOnlineInfo.setClient(5);
                    try {
                        String format = DateFormatUtils.formatDate(new Date());
                        Integer nowTime = DateFormatUtils.getNowDateTime(format);
                        userOnlineInfo.setIostime(nowTime);
                        userOnlineInfo.setIOSsid(request.getSession().getId());
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                } else if ("android".equals(userAgent)) {
                    userOnlineInfo.setClient(6);
                    try {
                        String format = DateFormatUtils.formatDate(new Date());
                        Integer nowTime = DateFormatUtils.getNowDateTime(format);
                        userOnlineInfo.setAndroidtime(nowTime);
                        userOnlineInfo.setAndroidsid(request.getSession().getId());
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                } else if ("pc".equals(userAgent)) {
                    try {
                        String format = DateFormatUtils.formatDate(new Date());
                        Integer nowTime = DateFormatUtils.getNowDateTime(format);
                        userOnlineInfo.setClient(2);
                        userOnlineInfo.setPCtime(nowTime);
                        userOnlineInfo.setPCsid(request.getSession().getId());
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                } else {
                    try {
                        String format = DateFormatUtils.formatDate(new Date());
                        Integer nowTime = DateFormatUtils.getNowDateTime(format);
                        userOnlineInfo.setClient(1);
                        userOnlineInfo.setWebsid(request.getSession().getId());
                        userOnlineInfo.setWebtime(nowTime);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                }
                userOnlineInfo.setUid(user.getUid().toString());
                userCountMap.put(user.getUserId(), userOnlineInfo);
            }
            //如果存在
            else {

                //判断是否设置用户唯一登录，登录时是否顶替
                SysPara loginDisplace = sysParaMapper.querySysPara("LOGIN_DISPLACE");
                if(!Objects.isNull(loginDisplace) && !"0".equals(loginDisplace.getParaValue())){
                    CommonSessionContext myContext = CommonSessionContext.getInstance();
                    HttpSession session = myContext.getSession(userOnline.getRedisSessionId());
                    if(!Objects.isNull(session)) {
                        SessionUtils.cleanUserSession(session, null);
                        session.invalidate();//让SESSION失效
                        //记录日志
                        Syslog log = new Syslog();
                        log.setUserId(user.getUserId() + "");
                        log.setType(22);
                        log.setTypeName("顶替退出系统");
                        log.setIp(IpAddr.getIpAddress(request));
                        log.setRemark("");
                        log.setRemark("顶替退出系统");
                        log.setTime(new Date(System.currentTimeMillis()));
                        syslogMapper.save(log);
                    }
                }

                userOnline.setRedisSessionId(request.getSession().getId());
                //判断是哪个端的登录
                if ("iOS".equals(userAgent)) {
                    if (userOnline.getIostime() != 0) {
                        //更新一下静态资源map
                        try {
                            String format = DateFormatUtils.formatDate(new Date());
                            Integer nowTime = DateFormatUtils.getNowDateTime(format);
                            userOnline.setIostime(nowTime);
                            userCountMap.put(user.getUserId(), userOnline);
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                    } else {
                        try {
                            //更新一下静态资源map
                            String format = DateFormatUtils.formatDate(new Date());
                            Integer nowTime = DateFormatUtils.getNowDateTime(format);
                            userOnline.setIostime(nowTime);
                            userOnline.setIOSsid(request.getSession().getId());
                            userCountMap.put(user.getUserId(), userOnline);
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                    }
                } else if ("android".equals(userAgent)) {
                    if (userOnline.getAndroidtime() != 0) {
                        try {
                            String format = DateFormatUtils.formatDate(new Date());
                            Integer nowTime = DateFormatUtils.getNowDateTime(format);
                            userOnline.setAndroidtime(nowTime);
                            userCountMap.put(user.getUserId(), userOnline);
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                    } else {
                        try {
                            String format = DateFormatUtils.formatDate(new Date());
                            Integer nowTime = DateFormatUtils.getNowDateTime(format);
                            userOnline.setAndroidtime(nowTime);
                            userOnline.setAndroidsid(request.getSession().getId());
                            userCountMap.put(user.getUserId(), userOnline);
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                    }
                } else if ("pc".equals(userAgent)) {
                    if (!userOnline.getPCsid().equals("")) {
                        try {
                            String format = DateFormatUtils.formatDate(new Date());
                            Integer nowTime = DateFormatUtils.getNowDateTime(format);
                            userOnline.setPCtime(nowTime);
                            userCountMap.put(user.getUserId(), userOnline);
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                    } else {
                        try {
                            String format = DateFormatUtils.formatDate(new Date());
                            Integer nowTime = DateFormatUtils.getNowDateTime(format);
                            userOnline.setPCtime(nowTime);
                            userOnline.setPCsid(request.getSession().getId());
                            userCountMap.put(user.getUserId(), userOnline);
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    if (!userOnline.getWebsid().equals("")) {
                        try {
                            String format = DateFormatUtils.formatDate(new Date());
                            Integer nowTime = DateFormatUtils.getNowDateTime(format);
                            userOnline.setWebtime(nowTime);
                            userCountMap.put(user.getUserId(), userOnline);
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                    } else {
                        try {
                            String format = DateFormatUtils.formatDate(new Date());
                            Integer nowTime = DateFormatUtils.getNowDateTime(format);
                            userOnline.setWebtime(nowTime);
                            userOnline.setWebsid(request.getSession().getId());
                            userCountMap.put(user.getUserId(), userOnline);
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }

        } else if (httpOrgCreateTestRtn.trim().equals("err")) {
            //如果有限制登录失败后次数加一
            if (qk == 0) {
                int count = sysLogService.getSbcsByUserId(username, cz, xts);
            }
            json.setMsg("用户名或密码错误");
            sysLog.setRemark(password);
            sysLog.setTime(new Date(System.currentTimeMillis()));
            syslogMapper.save(sysLog);
            json.setCode(LoginState.LOGINPASSWORDERR);
            json.setFlag(1);

        }
        return json;
    }

    /**
     * @创建作者:李然 Lr
     * @方法描述：增加登录时检索注册文件是否过期
     * @创建时间：17:10 2019/6/27
     **/
    public ToJson examineRegister(HttpServletRequest request, Map<String, String> m) throws ParseException {
        ToJson json = new ToJson(0, "ok");

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Object locale = SessionUtils.getSessionInfo(request.getSession(), "LOCALE_SESSION_ATTRIBUTE_NAME", Object.class, redisSessionCookie);
        String realPath = request.getSession().getServletContext().getRealPath("/");
        if (m == null) {
            m = systemInfoService.getSystemInfo(realPath, locale, request);
        }
        String useEndDate = m.get("useEndDate");
        String endLecDateStr = m.get("endLecDateStr");
        String isAuthStr = m.get("isSoftAuth");
        String usercount = m.get("usercount");
        L.s(useEndDate, "0=||===========>", endLecDateStr);
        if (checkTimeOut(useEndDate, endLecDateStr, isAuthStr, usercount)) {
            //if(true){
            json.setCode(LoginState.LOGINTIMEOUT);
            json.setMsg("OA试用版软件已过期，请联系管理员。" +
                    "本机机器码是：" + m.get("authorizationCode"));
            json.setFlag(1);
            return json;
        }
        return json;
    }

    private boolean checkTimeOut(String useEndDate, String endLecDateStr, String isAuthStr, String usercount) {
        //是否拦截
        boolean result = false;
        SimpleDateFormat sdf = new SimpleDateFormat(
                "yyyy-MM-dd");
        //如果截止时间不为空。
        if (!StringUtils.checkNull(endLecDateStr)) {
            try {
                Date endDate = sdf.parse(endLecDateStr);
                //那么判断当前时间是否大于截止时间，如果大于  ==true
                if (new Date().getTime() > endDate.getTime()) {
                    result = true;
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }


        return result;
    }


    public String getPath() {
        //读取配置文件
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String osName = System.getProperty("os.name");
        StringBuffer sb = new StringBuffer();
        if (osName.toLowerCase().startsWith("win")) {
            //sb=sb.append(rb.getString("upload.win"));
            //判断路径是否是相对路径，如果是的话，加上运行的路径
            String uploadPath = rb.getString("upload.win");
            if (uploadPath.indexOf(":") == -1) {
                //获取运行时的路径
                String basePath = this.getClass().getClassLoader().getResource(".").getPath() + File.pathSeparator;
                //获取截取后的路径
                String str2 = "";
                if (basePath.indexOf("/xoa") != -1) {
                    //获取字符串的长度
                    int length = basePath.length();
                    //返回指定字符在此字符串中第一次出现处的索引
                    int index = basePath.indexOf("/xoa");
                    //从指定位置开始到指定位置结束截取字符串
                    str2 = basePath.substring(0, index);
                }
                sb = sb.append(str2 + "/xoa");
            }
            sb.append(uploadPath);
        } else {
            sb = sb.append(rb.getString("upload.linux"));
        }
        return sb.toString();
    }


    public String getMachineCode12() {
        String machineCode = null;
        try {
            SysPara para = sysParaMapper.querySysPara("PUSH_MNO");
            if (para != null && !StringUtils.checkNull(para.getParaValue())) {
                machineCode = para.getParaValue().substring(0, 12);
            } else {
                machineCode = MachineCode.get16CharMacs() == null ? "" : MachineCode.get16CharMacs().get(0);
                SysPara sysPara = new SysPara();
                sysPara.setParaName("PUSH_MNO");
                String jiqima = MachineCode.get16CharMacsType().get(0);
                sysPara.setParaValue(jiqima);
                if (para == null) {
                    sysParaMapper.insertSysPara(sysPara);
                } else {
                    if (StringUtils.checkNull(para.getParaValue())) {
                        sysParaMapper.updateSysPara(sysPara);
                    }
                }

            }
        } catch (Exception e) {
        }
        return machineCode;
    }


    /**
     * 后台验证输入的验证码
     *
     * @param request
     * @param response
     */
    @RequestMapping("/GetCodeImgServlet")
    public void GetCodeImgServlet(HttpServletRequest request, HttpServletResponse response) {
        // 调用工具类生成的验证码和验证码图片
        Map<String, Object> codeMap = CodeUtil.generateCodeAndPic();
        //把验证码保存到session中
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        SessionUtils.putSession(request.getSession(), "graphic", codeMap.get("code").toString().toLowerCase(), redisSessionCookie);

        //禁止图片缓存
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", -1);
        //响应格式
        response.setContentType("image/jpeg;charset=utf-8");
        // 将图像输出到Servlet输出流中。
        try (ServletOutputStream sos = response.getOutputStream()) {
            ImageIO.write((RenderedImage) codeMap.get("codePic"), "jpeg", sos);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    /**
     * 非对称加密获取公钥
     * @return
     */
    @RequestMapping("/getPublicKey")
    @ResponseBody
    public String getPublicKey(HttpServletRequest request)throws Exception {
        KeyPair keyPair = RSA.getKeyPair();
        //公钥
        String publicKey = RSA.getPublicKey(keyPair);
        String privateKey = RSA.getPrivateKey(keyPair);
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        SessionUtils.putSession(request.getSession(), "privateKey", privateKey, redisSessionCookie);
        return publicKey;
    }




    public String getMachineCode16(){
        //机器码16位
        String machineCode = null;
        try {
            SysPara para = sysParaMapper.querySysPara("PUSH_MNO");
            if (para != null && !StringUtils.checkNull(para.getParaValue())) {
                machineCode = para.getParaValue();
            } else {
                machineCode = MachineCode.get16CharMacsType() == null ? "" : MachineCode.get16CharMacsType().get(0);
                SysPara sysPara = new SysPara();
                sysPara.setParaName("PUSH_MNO");
                sysPara.setParaValue(machineCode);
                if (para==null){
                    sysParaMapper.insertSysPara(sysPara);
                }else{
                    if (StringUtils.checkNull(para.getParaValue())){
                        sysParaMapper.updateSysPara(sysPara);
                    }
                }

            }
        }catch (Exception e){

        }
        return machineCode;
    }


    /**
     * 判断密码是否在有效期内和密码强度
     * @return
     */
    @RequestMapping("/checkPass")
    @ResponseBody
    public ToJson checkPass(String username,String password,HttpServletRequest request) {
        ToJson toJson = new ToJson(1,"err");

        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user=SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            List<String> item = new ArrayList<>();
            item.add("PASSWORD_STRENGTH_CHECK");
            item.add("PASSWORD_VALIDITY_CHECK");
            List<SysPara> sysParaList = sysParaMapper.getSysParaList(item);
            for (SysPara sysPara : sysParaList) {
                //设置了判断密码有效期，判断是否在有效期内
                if("PASSWORD_VALIDITY_CHECK".equals(sysPara.getParaName()) && !"0".equals(sysPara.getParaValue())){

                    Users users = usersMapper.selectUserByUId(user.getUid());
                    if(Objects.isNull(users.getLastPassTime())){
                        usersMapper.updateLastPassTime(user.getUid());
                        users.setLastPassTime(new Date());
                    }
                    Calendar calendar = new GregorianCalendar();
                    calendar.setTime(users.getLastPassTime());
                    calendar.add(calendar.DATE, Integer.parseInt(sysPara.getParaValue()));//
                    if (!DateFormat.isEffectiveDate(new Date(), users.getLastPassTime(), calendar.getTime())) {
                        toJson.setMsg("密码已过有效期，请修改密码后重新登录");
                        return toJson;
                    }
                }

                //开启了密码强度不够强制修改密码
                if("PASSWORD_STRENGTH_CHECK".equals(sysPara.getParaName()) && "1".equals(sysPara.getParaValue())){
                    if(!StringUtils.checkNull(username)&&username.length()==88){
                        String privateKey = SessionUtils.getSessionInfo(request.getSession(), "privateKey", String.class, redisSessionCookie);
                        //非对称加密算法解密
                        password = RSA.decryptByPrivateKey(password, privateKey);
                    }
                    SysPara sp = sysParaMapper.selectByParaNames("SEC_PASS_SAFE");
                    SysPara sp1 = sysParaMapper.selectByParaNames("SEC_PASS_MIN");
                    SysPara sp2 = sysParaMapper.selectByParaNames("SEC_PASS_MAX");
                    Integer zimu = 0;
                    Integer shuzi = 0;
                    Integer zifu = 0;
                    Integer daxie = 0;
                    Integer xiaoxie = 0;
                    getNumByStr(password);
                    if (map.containsKey("zimu")) {
                        zimu = Integer.valueOf(String.valueOf(map.get("zimu")));
                    }
                    if (map.containsKey("shuzi")) {
                        shuzi = Integer.valueOf(String.valueOf(map.get("shuzi")));
                    }
                    if (map.containsKey("zifu")) {
                        zifu = Integer.valueOf(String.valueOf(map.get("zifu")));
                    }
                    if (map.containsKey("daxie")) {
                        daxie = Integer.valueOf(String.valueOf(map.get("daxie")));
                    }
                    if (map.containsKey("xiaoxie")) {
                        xiaoxie = Integer.valueOf(String.valueOf(map.get("xiaoxie")));
                    }

                    if ((password.length() < Integer.valueOf(sp1.getParaValue()) || password.length() > Integer.valueOf(sp2.getParaValue()))
                            || ("1".equals(sp.getParaValue()) && (zimu == 0 || shuzi == 0))
                            || ("2".equals(sp.getParaValue()) && (zimu == 0 || shuzi == 0 || zifu == 0))
                            || ("3".equals(sp.getParaValue()) && (daxie == 0 || shuzi == 0 || xiaoxie == 0))
                            || ("4".equals(sp.getParaValue()) && (daxie == 0 || shuzi == 0 || xiaoxie == 0 || zifu == 0))) {
                        toJson.setMsg("您的密码强度未达要求，存在风险，请修改后登录");
                        return toJson;
                    }
                }
            }

            toJson.setMsg("ok");
            toJson.setFlag(0);
        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }


    /**
     * 添加提醒事务
     * @param
     */
    public void saveSms(SmsBody smsBody, String toIds,String remind,String tuisong,String title,String context,String sqlType) {
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                smsService.saveSms(smsBody, toIds, remind, tuisong, title, context, sqlType);
            }
        });
    }


    /**
     * 获取云OA组织的loginId
     */
    public String queryCloudOALoginId(HttpServletRequest request) {
        //loginId参数为空时，查询是否是云OA
        ContextHolder.setConsumerType("xoa1001");
        SysPara sysParaCloudOa = sysParaMapper.querySysPara("CLOUD_OA");
        String loginId = "";
        if (!Objects.isNull(sysParaCloudOa) && "1".equals(sysParaCloudOa.getParaValue())) {
            if ("oa.8oa.cn".equals(request.getServerName())) {
                loginId = "1001";
            } else {
                String[] split = request.getServerName().split("\\.");
                if (split[0].length() == 4) {
                    loginId = split[0];
                }
            }
        }
        return loginId;
    }
}
