package com.xoa.controller.widget;

import com.xoa.model.weather.OneDayWeatherInf;
import com.xoa.model.widget.WidgetModel;
import com.xoa.model.widget.WidgetSetModel;
import com.xoa.service.widget.WidgetService;
import com.xoa.util.ToJson;
import com.xoa.util.ipUtil.IpAddr;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 作者：张航宁
 * 日期：201-07-13
 */
@Controller
@RequestMapping("/widget")
public class WidgetController {


    @Resource
    private WidgetService widgetService;

    @ResponseBody
    @RequestMapping("/getMsg")
    public ToJson<WidgetSetModel> getMsg(HttpServletRequest request, String cityName,String district){
        return widgetService.getWidgetToDoMsg(request, cityName,district);
    }

    // 获取天气信息的旧接口，目前最新版本的app和前端页面已经使用了下面的getWeatherNew接口，保留该接口是为了兼容旧的app，迭代几个版本以后可以删除掉
    @ResponseBody
    @RequestMapping("/getWeather")
    public ToJson<WidgetSetModel> getWeather(HttpServletRequest request, String cityName, String district){
        return widgetService.getWeather(request, cityName,district);
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/7/10
     * @说明: 获取天气信息新接口，新版本的前端页面和APP已经更换为这个接口，保留上面的getWeather接口是为了兼容旧版本的app，迭代几个版本以后可以删除上面的getWeather接口
     *
     */
    @ResponseBody
    @RequestMapping("/getWeatherNew")
    public ToJson<OneDayWeatherInf> getWeatherNew(HttpServletRequest request, String cityName, String district){
        return widgetService.getWeatherNew(request, cityName,district);
    }

    @ResponseBody
    @RequestMapping("/getWeatherNews")
    public ToJson<OneDayWeatherInf> getWeatherNews(HttpServletRequest request){
        return widgetService.getWeatherNews(request);
    }

    @ResponseBody
    @RequestMapping("/getWidgetMsg")// /widget
    public ToJson<WidgetSetModel> getWidgetMsg(HttpServletRequest request){
        return widgetService.getWidgetMsg(request);
    }

    @ResponseBody
    @RequestMapping("/getByUid")
    public ToJson<WidgetSetModel> getByUid(HttpServletRequest request){
        return widgetService.getUserSetByUid(request);
    }

    @ResponseBody
    @RequestMapping("/edit")
    public ToJson<WidgetSetModel> edit(HttpServletRequest request,WidgetSetModel widgetModel){
        return  widgetService.editWidgetSetModel(request,widgetModel);
    }

    /**
     * @作者: 张航宁
     * @时间: 2020/9/16
     * @说明: 获取所有的widget类型 用来批量设置用 该接口在门户网页端的门户设置中调用了
     *
     */
    @ResponseBody
    @RequestMapping("/selAllWidgetModel")
    public ToJson<WidgetModel> selAllWidgetModel() {
        return widgetService.selAllWidgetModel();
    }

    /**
     * @作者: 张航宁
     * @时间: 2020/9/16
     * @说明: 批量设置 所有人的widget设置
     *
     */
    @ResponseBody
    @RequestMapping("/updateAllWidgetSet")
    public ToJson<WidgetSetModel> updateAllWidgetSet(WidgetSetModel widgetSetModel) {
        return widgetService.updateAllWidgetSet(widgetSetModel);
    }

}
