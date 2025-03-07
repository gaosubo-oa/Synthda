package com.xoa.controller.qrCodeLogin;

import com.xoa.service.qrCodeLogin.QrCodeLoginService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Controller
@RequestMapping("/qrCode")
public class QrCodeLoginController {

    @Resource
    private QrCodeLoginService qrCodeLoginService;


    /**
     * 创建人：hwx
     * 创建时间：2022年3月4日
     * 方法介绍：生成密钥数据
     */
    @RequestMapping(value = "/generateSecret", method = RequestMethod.POST)
    @ResponseBody
    public ToJson generateSecret(HttpServletRequest request) {
        return qrCodeLoginService.generateSecret(request);
    }


    /**
     * 创建人：hwx
     * 创建时间：2022年3月6日
     * 方法介绍：根据密钥生成二维码
     */
    @RequestMapping(value = "/generate", method = RequestMethod.POST)
    @ResponseBody
    public ToJson generate(HttpServletRequest request,String secret)  throws IOException {
        return qrCodeLoginService.generate(request,secret);
    }


    /**
     * 创建人：hwx
     * 创建时间：2022年3月6日
     * 方法介绍：解析app扫码后传的secret字符串
     */
    @RequestMapping(value = "/parsingSecret", method = RequestMethod.POST)
    @ResponseBody
    public ToJson parsingSecret(HttpServletRequest request,String secret) {
        return qrCodeLoginService.parsingSecret(request,secret);
    }


    /**
     * 创建人：hwx
     * 创建时间：2022年3月6日
     * 方法介绍：用于轮询登录二维码状态判断是否可以登录
     */
    @RequestMapping(value = "/query")
    @ResponseBody
    public ToJson queryQrCode(HttpServletRequest request,String secret,String loginId) {
        return qrCodeLoginService.queryQrCode(request,secret,loginId);
    }
}
