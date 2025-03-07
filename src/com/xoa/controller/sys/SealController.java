package com.xoa.controller.sys;
import com.xoa.model.sys.SealLog;
import com.xoa.model.sys.SealWithBLOBs;
import com.xoa.service.sys.SealService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/8/17 16:49
 * 类介绍  :
 * 构造参数:
 */
@Controller
@RequestMapping("/seal")
public class SealController {
    @Resource
    private SealService sealService;

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/17 13:54
     * @函数介绍: 添加印章信息
     * @参数说明: @param request
     * @return: json
     **/
    @RequestMapping("/addSealObject")
    @ResponseBody
    public ToJson<Object> addSealObject(HttpServletRequest request,SealWithBLOBs seal){
        return sealService.addSealObject(request,seal);
    }
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/17 16:54
     * @函数介绍: 设置印章权限
     * @参数说明: @param request
     * @return: json
     **/
    @RequestMapping("/editSealObject")
    @ResponseBody
    public ToJson<Object> editSealObject(HttpServletRequest request,SealWithBLOBs seal){
        return sealService.editSealObject(request,seal);
    }


    /**
    * @创建作者:李然  Lr
    * @方法描述：公共修改印章.生成日志
    * @创建时间：16:41 2019/6/23
    **/
    @RequestMapping("/updateSeal")
    @ResponseBody
    public ToJson<Object> updateSeal(HttpServletRequest request,SealWithBLOBs seal,SealLog sealLog){
        return sealService.updateSeal(request,seal,sealLog);
    }


    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/18 14:54
     * @函数介绍: 印章列表展示
     * @参数说明: @param request
     * @return: json
     **/
    @RequestMapping("/getAllSealInfo")
    @ResponseBody
    public ToJson<SealWithBLOBs> getAllSealInfo(HttpServletRequest request,SealWithBLOBs sealWithBLOBs,String startTime,String endTime){
        return sealService.getAllSealInfo(request,sealWithBLOBs,startTime,endTime);
    }
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/18 14:54
     * @函数介绍: 查询印章权限详情
     * @参数说明: @param request
     * @return: json
     **/
    @RequestMapping("/getSealById")
    @ResponseBody
    public ToJson<SealWithBLOBs> getSealById(String id){
        return sealService.getSealById(id);
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/19 14:54
     * @函数介绍: 批量删除印章信息
     * @参数说明: @param request
     * @return: json
     **/
    @RequestMapping("/deleteSeal")
    @ResponseBody
    public ToJson<Object> deleteSeal(HttpServletRequest request,@RequestParam("ids[]") String[] ids){
        return sealService.deleteSeal(request,ids);
    }
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/19 14:54
     * @函数介绍: 获取印章编号
     * @参数说明: @param request String id
     * @return: json
     **/
    @RequestMapping("/getSealIdById")
    @ResponseBody
    public ToJson<Object> getSealIdById(HttpServletRequest request,String id){
        return sealService.getSealIdById(request,id);
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/19 14:54
     * @函数介绍: 获取印章编号是否重复
     * @参数说明: @param request String sealId
     * @return: json
     **/
    @RequestMapping("/getSealLogBySealId")
    @ResponseBody
    public ToJson<SealWithBLOBs> getSealBySealId(HttpServletRequest request,String sealId){
        return sealService.getSealBySealId(request,sealId);
    }

    /**
     * @创建作者: 侯王鑫
     * @创建日期: 2019/4/28 14:54
     * @函数介绍: 获取印章
     * @参数说明: @param request Integer sealId
     * @return: STRDATA:base64值，0为参数为空，1为查询不到此印章
     **/
    @RequestMapping(value = "/querySealById",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String querySealById(HttpServletRequest request, Integer sealId){
        return sealService.querySealById(request,sealId);
    }

    /**
     * @创建作者: 侯王鑫
     * @创建日期: 2019/5/6 14:54
     * @函数介绍: 印章数据转换为移动端可以显示的数据
     * @参数说明: @param request String sealData
     * @return: 一个xml，0为参数为空，1为查询不到此印章
     **/
    @RequestMapping(value = "/parseAllSeal",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String parseAllSeal(HttpServletRequest request, String sealData){
        return sealService.parseAllSeal(sealData);
    }


    /**
     * 侯王鑫
     * 接收移动端印章数据转换后返回
     * 2019/5/6 14:54
     * @param request
     * @param sealData   图片数据
     * @param sealW     w
     * @param sealY     y
     * @param sealName      盖章后的名称 同一个表单里不能有一样的名称
     * @param sealPosition  印章位置，一般是div的id
     * @param sealH     h
     * @param sealX     x
     * @param oriData   绑定的数据
     * @return
     */
    @RequestMapping(value = "/parseAppSeal",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String parseAppSeal(HttpServletRequest request, String sealData,Integer sealW,Integer sealY,String sealName,String sealPosition,String sealH,String sealX,String oriData){
        return sealService.parseAppSeal(request,sealData,sealW,sealY,sealName,sealPosition,sealH,sealX,oriData);
    }


    /**
     * 侯王鑫
     * 将制章后保存的数据转换为websign数据
     * 2019/5/6 14:54
     * @param request
     * @param sealData   制章数据
     * @param psw   密码
     * @param sealName   盖章后的名称
     * @param sealPosition     印章位置
     * @param sealX     x
     * @param sealY     y
     * @param oriData      绑定的数据
     * @return
     */
    @RequestMapping(value = "/parseSealToWebsign",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String parseSealToWebsign(HttpServletRequest request, String sealData, String psw, String sealName, String sealPosition, String sealX, String sealY, String oriData){
        return sealService.parseSealToWebsign(request,sealData,psw,sealName,sealPosition,sealX,sealY,oriData);
    }
}
