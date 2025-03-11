package com.xoa.service.qrCodeLogin;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.common.SyslogMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.duties.DutiesManagementMapper;
import com.xoa.dao.position.PositionManagementMapper;
import com.xoa.dao.qrCodeLogin.QrCodeLoginMapper;
import com.xoa.dao.users.OrgManageMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.Syslog;
import com.xoa.model.department.Department;
import com.xoa.model.duties.UserPost;
import com.xoa.model.position.UserJob;
import com.xoa.model.qrCodeLogin.QrCodeLogin;
import com.xoa.model.users.OrgManage;
import com.xoa.model.users.Users;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.ipUtil.IpAddr;
import com.xoa.util.systeminfo.Base64;
import io.jsonwebtoken.*;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class QrCodeLoginService {

    @Resource
    private UsersMapper usersMapper;
    @Resource
    private QrCodeLoginMapper qrCodeLoginMapper;
    @Resource
    private com.xoa.controller.login.loginController loginController;
    @Resource
    private DutiesManagementMapper dutiesManagementMapper;
    @Resource
    private PositionManagementMapper positionManagementMapper;
    @Resource
    private OrgManageMapper orgManageMapper;
    @Resource
    private DepartmentMapper departmentMapper;
    @Resource
    private SysParaMapper sysParaMapper;
    @Resource
    private SyslogMapper syslogMapper;

    private static String paraName = "QRCODE_LOGIN_SECRET_KEY";

    public ToJson generateSecret(HttpServletRequest request) {

        ToJson toJson = new ToJson(1,"err");

        try {
            SysPara sysPara = sysParaMapper.selectByParaNames("QRCODE_LOGIN_SET");
            if(Objects.isNull(sysPara) || !"1".equals(sysPara.getParaValue())){
                toJson.setMsg("未开启扫码登录");
                return toJson;
            }

            SysPara secretKey = sysParaMapper.selectByParaNames(paraName);
            if(Objects.isNull(secretKey) || StringUtils.checkNull(secretKey.getParaValue())){
                toJson.setMsg("未设置扫码登录参数");
                return toJson;
            }
            long millis = System.currentTimeMillis();
            HashMap<String, Object> map = new HashMap<>();
            map.put("millis",millis);
            String secret = Jwts.builder()
                    .setClaims(map)
                    .setExpiration(new Date(millis + 60*1000))
                    .signWith(SignatureAlgorithm.HS512, secretKey.getParaValue())
                    .compact();

            //将生成的字符串存入扫码登录记录表
            QrCodeLogin qrCodeLogin = new QrCodeLogin();
            qrCodeLogin.setSecretKey(secret);
            qrCodeLogin.setKeyCreateTime(new Date(millis));
            qrCodeLoginMapper.insertSelective(qrCodeLogin);

            toJson.setData(secret);
            toJson.setFlag(0);
            toJson.setMsg("success");

        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
            L.e("QrCodeLoginController.generateSecret"+e);
        }
        return toJson;
    }


    public ToJson generate(HttpServletRequest request, String secret) throws IOException {

        ToJson toJson = new ToJson(1,"err");
        ByteArrayOutputStream outputStream = null;

        try {
            /*// 组织
            String company = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));*/
            //当前年月
            String ym = new SimpleDateFormat("yyMM").format(new Date());
            ResourceBundle rb = ResourceBundle.getBundle("upload");
            String os = System.getProperty("os.name");
            StringBuffer sb = new StringBuffer();
            if (os.toLowerCase().startsWith("win")) {
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
            if (StringUtils.checkNull(sb.toString())) {
                String a = request.getRealPath("");
                sb.append(a);
                sb.append(System.getProperty("file.separator")).
                        //append(System.getProperty("file.separator")).
                                append(System.getProperty("file.separator")).
                        append("qr_code_login").append(System.getProperty("file.separator"))
                        .append(ym).append(System.getProperty("file.separator"));
            } else {
                sb.append(System.getProperty("file.separator")).
                        //append(System.getProperty("file.separator")).
                                append(System.getProperty("file.separator")).
                        append("qr_code_login").append(System.getProperty("file.separator")).
                        append(ym).append(System.getProperty("file.separator"));
            }

            QRCodeWriter qrCodeWriter1 = new QRCodeWriter();
            //设置二维码标识以及内容
            String contents = "{\"mark\":\"SID_QRCODELOGIN\",\"secret\":\""+secret+"\"}";
            //设置二维码图片宽高
            BitMatrix bitMatrix1 = qrCodeWriter1.encode(contents, BarcodeFormat.QR_CODE,600, 600);
            String pathStr = sb.append(System.currentTimeMillis()).toString();
            pathStr = pathStr.startsWith("/") ? pathStr.substring(1) : pathStr;
            //输出到指定路径
            File file = new File(pathStr);
            if(!file.exists()){
                file.mkdirs();
            }
            MatrixToImageWriter.writeToPath(bitMatrix1,"PNG",file.toPath());
            // 写到输出流
            outputStream = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix1, "PNG", outputStream);
            //转换为base64
            String qrCodeBase64 = "data:image/jpeg;base64," +Base64.encodeBase64String(outputStream.toByteArray());

            toJson.setData(qrCodeBase64);
            toJson.setFlag(0);
            toJson.setMsg("success");
        }catch (Exception e) {
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
            L.e("QrCodeLoginController.generate"+e);
        }finally {
            outputStream.close();
        }
        return toJson;
    }


    public ToJson parsingSecret(HttpServletRequest request, String secret) {

        ToJson toJson = new ToJson(1,"err");

        try {
            //获取当前用户信息
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            if(Objects.isNull(user) || StringUtils.checkNull(user.getUserId())){
                toJson.setMsg("用户信息为空");
                return toJson;
            }

            SysPara secretKey = sysParaMapper.selectByParaNames(paraName);
            if(Objects.isNull(secretKey) || StringUtils.checkNull(secretKey.getParaValue())){
                toJson.setMsg("未设置扫码登录参数");
            }

            Jwts.parser().setSigningKey(secretKey.getParaValue())
                    .parseClaimsJws(secret)
                    .getBody();

            QrCodeLogin qrCodeLogin = qrCodeLoginMapper.selectBySecretKey(secret);

            //查询是否已经存在userId
            if(Objects.isNull(qrCodeLogin) || !StringUtils.checkNull(qrCodeLogin.getUserId())){
                toJson.setMsg("二维码错误");
                return toJson;
            }

            //根据userId查询用户信息对比
            Users users = usersMapper.getUserId(user.getUserId());
            if(!Objects.isNull(users) || !user.getUserId().equals(users.getUserId())){
                qrCodeLogin.setUserId(users.getUserId());
                qrCodeLoginMapper.updateByPrimaryKeySelective(qrCodeLogin);
                toJson.setFlag(0);
                toJson.setMsg("success");
                return toJson;
            }

        } catch (SignatureException | MalformedJwtException e) {
            // 解析错误
            toJson.setMsg("secret err");
            return toJson;

        } catch (ExpiredJwtException e) {
            toJson.setMsg("二维码已过期");
            return toJson;

        } catch (Exception e) {
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
            L.e("QrCodeLoginController.parsingSecret"+e);
        }
        return toJson;
    }

    public ToJson queryQrCode(HttpServletRequest request, String secret,String loginId) {

        ToJson toJson = new ToJson(1,"err");

        try {

            QrCodeLogin qrCodeLogin = qrCodeLoginMapper.selectBySecretKey(secret);
            if(Objects.isNull(qrCodeLogin) || StringUtils.checkNull(qrCodeLogin.getSecretKey())){
                toJson.setCode("10000");
                toJson.setMsg("secretKey错误");
                return toJson;
            }

            SysPara secretKey = sysParaMapper.selectByParaNames(paraName);
            if(Objects.isNull(secretKey) || StringUtils.checkNull(secretKey.getParaValue())){
                toJson.setMsg("未设置扫码登录参数");
            }
            Jwts.parser().setSigningKey(secretKey.getParaValue())
                    .parseClaimsJws(secret)
                    .getBody();

            //查询是否已经存在userId
            if(StringUtils.checkNull(qrCodeLogin.getUserId())){
                toJson.setMsg("二维码未被扫描或用户未同意登录");
                toJson.setCode("10001");
                return toJson;
            }

            Users user = this.selectUserAllInfoByName(qrCodeLogin.getUserId(), request, loginId);
            if(Objects.isNull(user)){
                toJson.setMsg("用户不存在");
                toJson.setCode("10005");
                return toJson;
            }
            loginController.login(toJson, 1, user, user.getUserName(), "", "", "", "", request, loginId, null);
            toJson.setBirthday(user.getBirthday());
            return toJson;

        } catch (SignatureException | MalformedJwtException e) {
            // 解析错误
            toJson.setMsg("secret err");
            toJson.setCode("10002");
            return toJson;

        } catch (ExpiredJwtException e) {
            toJson.setMsg("二维码已过期");
            toJson.setCode("10003");
            return toJson;

        } catch (Exception e) {
            toJson.setMsg(e.getMessage());
            toJson.setCode("10004");
            e.printStackTrace();
            L.e("QrCodeLoginController.queryQrCode"+e);
        }
        return toJson;
    }


    private Users selectUserAllInfoByName(String userId, HttpServletRequest req, String loginId) {
        Users users = usersMapper.getByUserId(userId);
        Users user = usersMapper.selectUserAllInfoByName(users.getByname());
        if (user != null) {
            //增加职务和岗位
            Integer postId = user.getPostId();
            if (postId != null) {
                UserPost userPost = dutiesManagementMapper.getUserPostId(postId);
                if (userPost != null) {
                    user.setPostName(userPost.getPostName());
                }
            }
            Integer jobId = user.getJobId();
            if (jobId != null) {
                UserJob userJob = positionManagementMapper.getUserjobId(jobId);
                if (userJob != null) {
                    user.setJobName(userJob.getJobName());
                }
            }

            user.setIsPassWordRight("ok");

            //多组织公司名称 ，不能调用已经注释的，里面只有一个公司,读取公司名称时要切库切到1001，切换之后要切到选择的库
            OrgManage orgManageById = null;
            if (!StringUtils.checkNull(loginId)) {
                ContextHolder.setConsumerType("xoa1001");
                orgManageById = orgManageMapper.getOrgManageById(Integer.valueOf(loginId));
            }
            //没有传的默认为1001
            else {
                ContextHolder.setConsumerType("xoa1001");
                orgManageById = orgManageMapper.getOrgManageById(Integer.valueOf(1001));
            }
            user.setCompanyName(orgManageById == null ? "" : orgManageById.getName());
            //查询公司名称后要切回来
            ContextHolder.setConsumerType("xoa" + loginId);
            if (user.getDeptId() != null) {
                Department dep = departmentMapper.getDeptById(user.getDeptId());
                if (dep != null) {
                    user.setDeptName(dep.getDeptName());
                }
            }

            Syslog sysLog = new Syslog();
            sysLog.setLogId(0);
            sysLog.setUserId(user.getUserId());
            SysPara sysParaHost = sysParaMapper.querySysPara("IM_HOST");
            //根据商量先获取数据库IM_STUTES的字段是1则返回手动配置的IP地址 是0的情况下让手机端自己获取ip和端口,返回为空
            SysPara sysParaStutes = sysParaMapper.querySysPara("IM_STUTES");
            SysPara sysParaPort = sysParaMapper.querySysPara("IM_PORT");

            if (sysParaStutes != null && !StringUtils.checkNull(sysParaStutes.getParaValue()).booleanValue()) {
                if ("1".equals(sysParaStutes.getParaValue())) {
                    user.setGimPort(sysParaPort.getParaValue());
                    user.setGimHost(sysParaHost.getParaValue());
                    user.setImRegisterIp(sysParaHost.getParaValue());
                } else {
                    user.setGimPort("");
                    user.setGimHost("");
                    user.setImRegisterIp("");
                }

            }

            //判断生日
            if ( user.getBirthday() == null && ( !StringUtils.checkNull(user.getIdNumber()) && user.getIdNumber().length() == 18 ) ){
                String y = user.getIdNumber().substring(6, 10);
                String m = user.getIdNumber().substring(10, 12);
                String d = user.getIdNumber().substring(12, 14);
                user.setBirthday(DateFormat.getDates(y + "-" + m + "-" + d ));
            }

            sysLog.setTime(new Date());
            sysLog.setIp(IpAddr.getIpAddress(req));
            sysLog.setType(1);
            sysLog.setRemark("网页端" + "(" + req.getHeader("user-agent") + ")");
            sysLog.setClientType(5);
            sysLog.setClientVersion("网页端扫码登录");

            //添加完字段的
            syslogMapper.save2(sysLog);
        }

        if (user != null) {
            user.setPassword("");
            user.setIdNumber("");
        }
        return user;
    }
}
