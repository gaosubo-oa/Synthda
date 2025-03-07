package com.xoa.service.verification.impl;

import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.common.SyslogMapper;
import com.xoa.dao.users.UserExtMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dao.verification.MobileVerify.MobileVerifyMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.Syslog;
import com.xoa.model.users.UserExt;
import com.xoa.model.users.Users;
import com.xoa.model.verification.MobileVerify.MobileVerify;
import com.xoa.service.smsDelivery.Sms2PrivService;
import com.xoa.service.sys.impl.SystemInfoServiceImpl;
import com.xoa.service.verification.VerificationCodeService;
import com.xoa.util.DateFormat;
import com.xoa.util.I18nUtils;
import com.xoa.util.MD5Utils;
import com.xoa.util.ToJson;
import com.xoa.util.encrypt.EncryptSalt;
import com.xoa.util.ipUtil.IpAddr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.util.*;

@Service
public class VerificationCodeImpl implements VerificationCodeService {


   @Autowired
   private UsersMapper usersMapper;

   @Autowired
   private Sms2PrivService sms2PrivService;

   @Autowired
   private SyslogMapper syslogMapper;

   @Autowired
   private SysParaMapper sysParaMapper;

    @Autowired
    private UserExtMapper userExtMapper;

    @Autowired
    private MobileVerifyMapper mobileVerifyMapper;


    /**
     *
     * @作者 李卫卫
     * @创建日期 15:52 2020/12/4
     * @类介绍  短信接收验证码
     * @参数   Mobile 手机号   byname 用户名
     * @return limsJson
     */

    @Override
    public ToJson smsNoCode(HttpServletRequest request, String mobilNo,String byname) {
        ToJson toJson = new ToJson(1,"err");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try {
            Users users = usersMapper.selectByMobil(mobilNo,byname);//通过手机号查询是否有该用户

            if(users==null){
                toJson.setMsg(I18nUtils.getMessage("vote.th.userDoesNotExist"));
                toJson.setFlag(1);
                return toJson;
            }
            //获取随机8位数
            List<Integer> list = getRandomNumberStr();

            String numberStr = "";
            for (Integer num:list) {
                numberStr += num;
            }

            // 拼接上验证次数 默认验证0次 超过3次重新刷新验证码
            numberStr+="_0";

            //获取前3分钟
            Calendar nowTime = Calendar.getInstance();
            nowTime.add(Calendar.MINUTE, 3);
            Date codeTime = nowTime.getTime();

            //当前日期
            Date date = new Date();
            if(users!=null){
                MobileVerify mobileVerify = mobileVerifyMapper.getMobileVerify(users.getUserId(), users.getMobilNo());
                if(mobileVerify!=null){
                    String[] codes = mobileVerify.getVerifyCode().split("_");
                    if(date.getTime() < mobileVerify.getCodeTime().getTime()){
                        if (codes.length>1&&Integer.parseInt(codes[1])>=3){
                            toJson.setFlag(0);
                            toJson.setMsg(I18nUtils.getMessage("vote.th.verificationCodeErrorExceedsThreeTimes"));
                            return toJson;
                        }
                        toJson.setFlag(0);
                        toJson.setMsg(I18nUtils.getMessage("vote.th.theVerificationCodeIsValidForThreeMinutes"));
                        return toJson;
                    }else {
                        mobileVerify.setUserId(users.getUserId());//用户名
                        mobileVerify.setMobilNo(users.getMobilNo());//手机号
                        mobileVerify.setCodeTime(codeTime);//时间
                        mobileVerify.setVerifyCode(numberStr);//验证码
                        mobileVerifyMapper.updateByPrimaryKeySelective(mobileVerify);
                    }
                }else {
                    MobileVerify mobileVerifys = new MobileVerify();
                    mobileVerifys.setUserId(users.getUserId());//用户名
                    mobileVerifys.setMobilNo(users.getMobilNo());//手机号
                    mobileVerifys.setCodeTime(codeTime);//时间
                    mobileVerifys.setVerifyCode(numberStr);//验证码
                    mobileVerifyMapper.insert(mobileVerifys);
                }

            }
            //发送短信
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append("您的验证码为:");
            stringBuffer.append(numberStr.split("_")[0]);
            stringBuffer.append("，请在1分钟内输入进行验证（请勿将验证码告诉他人哦）。");

            ToJson toJson1 = sms2PrivService.smsSenderMobiles(stringBuffer, mobilNo);
            return  toJson1;
        }catch (Exception e){
          toJson.setFlag(1);
          toJson.setMsg(I18nUtils.getMessage("vote.th.thereIsAProblemWithTheProgram") + "：" + e.getMessage());
          e.printStackTrace();
        }
        return toJson;
    }


    /**
     *
     * @作者 李卫卫
     * @创建日期 16:47 2020/12/4
     * @类介绍 修改OA用户登录密码
     * @参数  新密码 newPwd 手机号 Mobile  用户名 byname  验证码 numberStr
     * @return limsJson
     */

    @Override
    public ToJson editPwd(HttpServletRequest request, String newPwd,String mobilNo,String byname,String numberStr) {
        ToJson toJson = new ToJson(1,"err");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try {
            Users users = usersMapper.selectByMobil(mobilNo,byname);//通过手机号以及用户名查询是否有该用户
            MobileVerify mobileVerify = mobileVerifyMapper.getMobileVerify(users.getUserId(), mobilNo);
            if(mobileVerify == null){
                toJson.setMsg(I18nUtils.getMessage("vote.th.pleaseCheckWhetherTheEnteredVerificationCodeIsCorrect"));
                toJson.setFlag(1);
                return toJson;
            }
            //当前日期
            Date date = new Date();
            if(mobileVerify.getCodeTime().getTime()<date.getTime()){
                toJson.setFlag(1);
                toJson.setMsg(I18nUtils.getMessage("vote.th.theVerificationCodeHasExpired"));
                return toJson;
            }

            String[] codes = mobileVerify.getVerifyCode().split("_");

            if(Integer.parseInt(codes[1])>=3){
                toJson.setFlag(1);
                toJson.setMsg(I18nUtils.getMessage("vote.th.verificationCodeErrorExceedsThreeTimes"));
                return toJson;
            }

            if(!codes[0].equals(numberStr)){
                toJson.setFlag(1);
                toJson.setMsg(I18nUtils.getMessage("vote.th.verificationCodeError"));
                mobileVerify.setVerifyCode(codes[0]+="_"+(Integer.parseInt(codes[1])+1));
                mobileVerifyMapper.updateByPrimaryKey(mobileVerify);
                return toJson;
            }

            String encryPwd = getEncryptString(newPwd);
            String lastPassTime = DateFormat.getCurrentTime();
            Map<String, String> map = new HashMap<String, String>();
            map.put("pwd", encryPwd);
            map.put("uid", users.getUserId());
            map.put("lastPassTime", lastPassTime);
            int total = usersMapper.updatePwd(map);
            if (total > 0) {
                UserExt userEx = userExtMapper.queryUserExtByByName(users.getByname());//
                userEx.setLoginRestriction("0");
                userEx.setLoginTime("");
                userExtMapper.updateUserExtByuidlogin(userEx);
                //将修改登录密码添加到日志中
                Syslog syslog = new Syslog();
                syslog.setUserId(users.getUserId() + "");
                syslog.setType(23);
                syslog.setTypeName("手机短信重置密码");
                syslog.setRemark("");
                String userAgent = request.getParameter("userAgent");
                if ("iOS".equals(userAgent)) {
                    //添加客户端类型
                    syslog.setRemark("iOS端");
                    syslog.setClientType(3);
                    SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
                    syslog.setClientVersion(Version.getParaValue());
                } else if ("android".equals(userAgent)) {
                    syslog.setRemark("安卓端");
                    syslog.setClientType(4);
                    SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
                    syslog.setClientVersion(Version.getParaValue());
                } else if ("pc".equals(userAgent)) {
                    syslog.setRemark("pc端");
                    syslog.setClientType(2);
                    SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
                    syslog.setClientVersion(Version.getParaValue());
                } else {
                    syslog.setRemark("网页端");
                    syslog.setClientType(1);
                    String clientVersion = request.getParameter("clientVersion");
                    if (clientVersion != null && clientVersion.length() > 0) {
                        syslog.setClientVersion(clientVersion);
                    } else {
                        syslog.setClientVersion(SystemInfoServiceImpl.softVersion);
                    }
                }
                syslog.setIp(IpAddr.getIpAddress(request));
                syslog.setTime(new Date(System.currentTimeMillis()));
                syslogMapper.save(syslog);
                toJson.setMsg(I18nUtils.getMessage("vote.th.passwordResetSuccessfully"));
                toJson.setFlag(0);
            }
        }catch (Exception e){
            toJson.setFlag(1);
            toJson.setMsg(I18nUtils.getMessage("vote.th.thereIsAProblemWithTheProgram") + "：" + e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    /**
     *
     * @作者 李卫卫
     * @创建日期 16:58 2020/12/4
     * @类介绍 检查验证码是否一致
     * @参数 验证码 numberStr  手机号Mobile  用户名byname
     * @return limsJson
     */

    @Override
    public ToJson inspectCode(HttpServletRequest request, String numberStr, String Mobile, String byname) {
        ToJson toJson = new ToJson(1,"err");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try {
            Users users = usersMapper.selectByMobil(Mobile,byname);

            //修改为只验证用户名和手机号是否存在和匹配，验证码校验放在重置密码接口
            if(Objects.isNull(users)){
                toJson.setFlag(1);
                toJson.setMsg(I18nUtils.getMessage("vote.th.theUserDoesNotExistCheckUsernameAndMobileNumber"));
            }else {
                toJson.setFlag(0);
                toJson.setMsg(I18nUtils.getMessage("vote.th.verificationPassed"));
            }

        }catch (Exception e){
            toJson.setFlag(1);
            toJson.setMsg(I18nUtils.getMessage("vote.th.thereIsAProblemWithTheProgram") + "：" + e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }


    /**
     * 获取8位随机数字字符串，且8位数字不重复
     *
     * @return Set<Integer>
     */
    private static List<Integer> getRandomNumberStr(){
        // SET集合
        List<Integer> list = new ArrayList<>();

        while(list.size() < 8){
            Random r = new Random();

            // nextInt(n)返回 0<= x <n之间均匀分布的 int 值
            while (list.size() < 8){
                list.add(r.nextInt(10));
            }
        }

        return list;
    }

    /**
     * @函数介绍: 加密一个字符串，MD5加密，EncryptSalt类产生一个字符串作为加盐加密
     * 注意业务需要，空字符串要得到固定的加密结果（tVHbkPWW57Hw.）
     * @参数说明: @param String 要加密的字符串
     * @return: String 加密过后的字符串
     */
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
}
