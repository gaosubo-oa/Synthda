package com.xoa.service.widget;

import com.xoa.model.weather.OneDayWeatherInf;
import com.xoa.model.widget.WidgetModel;
import com.xoa.model.widget.WidgetSetModel;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by gsb on 2017/7/13.
 */
public interface WidgetService {

    ToJson<WidgetSetModel> getWidgetToDoMsg(HttpServletRequest request, String cityName,String district);

    ToJson<WidgetSetModel> getWeather(HttpServletRequest request, String cityName, String district);

    ToJson<OneDayWeatherInf> getWeatherNew(HttpServletRequest request, String cityName, String district);

    ToJson<OneDayWeatherInf> getWeatherNews(HttpServletRequest request);
    ToJson<WidgetSetModel> getWidgetMsg(HttpServletRequest request);

    ToJson<WidgetSetModel> getUserSetByUid(HttpServletRequest request);

    ToJson<WidgetSetModel> editWidgetSetModel(HttpServletRequest request,WidgetSetModel widgetSetModel);

    ToJson<WidgetModel> selAllWidgetModel();

    ToJson<WidgetSetModel> updateAllWidgetSet(WidgetSetModel widgetSetModel);
}
