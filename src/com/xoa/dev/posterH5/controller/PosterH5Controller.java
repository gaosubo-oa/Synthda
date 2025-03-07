package com.xoa.dev.posterH5.controller;

import com.xoa.dev.posterH5.service.PosterH5Service;
import com.xoa.dev.posterH5.model.PosterH5;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 创建作者: 李彦洁
 * 创建日期: 2022/3/2 11:14
 * 类介绍:
 **/
@Controller
@RequestMapping("/poster")
public class PosterH5Controller {


    @Resource
    private PosterH5Service posterH5Service;

    @RequestMapping("/posterH5")
    public String antiepidemicH5() {
        return "/app/posterH5/posterH5";
    }

    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/2 12:53
     * 方法介绍:  数字医学项目海报生成
     * 参数说明:
     * 返回值说明: ToJson
     */
    @ResponseBody
    @RequestMapping("/posterGenerate")
    public ToJson posterGenerate(HttpServletRequest request, PosterH5 posterH5) throws IOException {
        return posterH5Service.posterGenerate(request,posterH5);
    }

    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/3 11:33
     * 方法介绍:   附件上传
     * 参数说明:   @param file:
     * 返回值说明: ToJson
     */
    @ResponseBody
    @RequestMapping("/upload")
    public ToJson upload(MultipartFile file){
        return posterH5Service.upload(file);
    }

    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/4 15:22
     * 方法介绍:   IO流读取图片
     * 参数说明:   @param imgUrl:
     * @param response:
     * 返回值说明: ToJson
     */
    @ResponseBody
    @RequestMapping("/IoReadImage")
    public ToJson IoReadImage(String imgUrl, HttpServletResponse response)throws IOException {
        return posterH5Service.IoReadImage(imgUrl,response);
    }
}
