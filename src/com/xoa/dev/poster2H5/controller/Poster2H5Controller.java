package com.xoa.dev.poster2H5.controller;

import com.xoa.dev.poster2H5.model.Poster2H5;
import com.xoa.dev.poster2H5.service.Poster2H5Service;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 创建作者: 李彦洁
 * 创建日期: 2022/3/7 9:53
 * 类介绍:
 **/
@Controller
@RequestMapping("/poster2")
public class Poster2H5Controller {

    @Resource
    private Poster2H5Service poster2H5Service;

    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/7 11:09
     * 方法介绍:   第二版海报生成H5页面映射
     * 参数说明:   @param :
     * 返回值说明: String
     */
    @RequestMapping("/posterH52")
    public String PosterH52() {
        return "app/posterH52/posterH52";
    }

    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/7 16:17
     * 方法介绍:   海报生成
     * 参数说明:   @param request:
     * @param poster2H5:
     * 返回值说明: ToJson
     */
    @ResponseBody
    @RequestMapping("/posterGenerate")
    public ToJson posterGenerate(HttpServletRequest request, Poster2H5 poster2H5){
        return poster2H5Service.posterGenerate(request,poster2H5);
    }

    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/7 16:17
     * 方法介绍:   公司logo图片上传
     * 参数说明:   @param file:
     * 返回值说明: ToJson
     */
    @ResponseBody
    @RequestMapping("/upload")
    public ToJson upload(MultipartFile file){
        return poster2H5Service.upload(file);
    }

}
