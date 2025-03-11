package com.xoa.util;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.xoa.model.weather.OneDayWeatherInf;
import com.xoa.model.weather.WeatherInf;
import com.xoa.util.common.StringUtils;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;

@Component
public class WeatherUtil {


    // 存储聚合接口支持的城市名字和城市id
    static Map<String,String> cityMap;
    public static Map<String,String> xianHaoCityMap;


    //根据城市获取天气信息的java代码
    //cityName 是你要取得天气信息的城市的中文名字，如“北京”，“深圳”
    static String getWeatherInform(String cityId) {

        //百度天气API
        //String baiduUrl = "http://api.map.baidu.com/telematics/v3/weather?location=北京&output=json&ak=W69oaDTCfuGwzNwmtVvgWfGH";
        // 聚合
        String juheUrl = "http://apis.juhe.cn/simpleWeather/query?city=1&key=dedf6138fb5a0420be15fcab7a2af35e";

        StringBuffer strBuf;

        //通过浏览器直接访问http://api.map.baidu.com/telematics/v3/weather?location=北京&output=json&ak=5slgyqGDENN7Sy7pw29IUvrZ
        //要访问的地址URL，通过URLEncoder.encode()函数对于中文进行转码
        //baiduUrl = "http://api.map.baidu.com/telematics/v3/weather?location=" + URLEncoder.encode(cityName, "utf-8") + "&output=json&ak=eQX5bMc9sGz8SPWquI3XV7x5eTAIgCQj";
        juheUrl = "http://apis.juhe.cn/simpleWeather/query?city="+cityId+"&key=dedf6138fb5a0420be15fcab7a2af35e";


        strBuf = new StringBuffer();
        BufferedReader reader=null;
        try {
            URL url = new URL(juheUrl);
            URLConnection conn = url.openConnection();
            conn.setConnectTimeout(2000);
            conn.setReadTimeout(3000);
            reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));//转码。
            String line = null;
            while ((line = reader.readLine()) != null)
                strBuf.append(line + " ");
            reader.close();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                if(reader!=null){
                    reader.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return strBuf.toString();
    }

    // 2021.06.28 聚合停用尾号查询接口 进行注释
    /*public static TodayCarNo getWeiHaoInform(String cityName) {

        String city = xianHaoCityMap.get(cityName.replace("市", ""));

        // 聚合
        StringBuffer strBuf;

        TodayCarNo todayCarNo = new TodayCarNo();

        String juheUrl = "http://v.juhe.cn/xianxing/index?key=d7e872e4a0d9164f2eda491b00a4d543&type=1&city="+city;

        strBuf = new StringBuffer();
        BufferedReader reader=null;
        try {
            URL url = new URL(juheUrl);
            URLConnection conn = url.openConnection();
            conn.setConnectTimeout(2000);
            reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));//转码。
            String line = null;
            while ((line = reader.readLine()) != null)
                strBuf.append(line + " ");
            reader.close();

            // 生成 todayCarNo 实体
            JsonObject jsonObject = (JsonObject) new JsonParser().parse(strBuf.toString());

            if("0".equals(jsonObject.get("error_code").getAsString())){
                JsonObject result = jsonObject.get("result").getAsJsonObject();
                todayCarNo = new TodayCarNo();
                todayCarNo.setCity(cityName);
                todayCarNo.setDate(new Date());
                todayCarNo.setRestrictionFlag("1");
                String isxianxing = result.get("isxianxing").getAsString();
                // 1限行
                if("1".equals(isxianxing)){
                    JsonArray xxweihao = result.get("xxweihao").getAsJsonArray();
                    StringBuilder xxweihaoStr = new StringBuilder();
                    for (int i = 0, size = xxweihao.size(); i < size; i++) {
                        String string = xxweihao.get(i).getAsString();
                        if(i!=size-1){
                            xxweihaoStr.append(string).append(",");
                        }else{
                            xxweihaoStr.append(string);
                        }
                    }
                    todayCarNo.setRestrictionNum(xxweihaoStr.toString());
                } else {
                    todayCarNo.setRestrictionFlag("0");
                    todayCarNo.setRestrictionNum("不限行");
                }
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                if(reader!=null){
                    reader.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return todayCarNo;
    }*/

    public static WeatherInf resolveWeatherInf(String cityName,String district){
        //cityName = "湛江";
        initCityMap();
        initXianHaoCityMap();
        //保存全部的天气信息。
        WeatherInf weatherInf = new WeatherInf();
        //保留原始县级/区级
        String districts=district;
        try{
            String cityId = "";

            if(!StringUtils.checkNull(district)){
                // 判断区县和县级市聚合是否支持
                if(district.trim().length()>2){
                    if(district.indexOf("县")>0||district.indexOf("区")>0||district.indexOf("市")>0)
                        district = district.trim().substring(0,district.trim().length()-1);
                }
                String city = cityName;
//                if(cityName.trim().length()>2){
//                    if(!StringUtils.checkNull(cityName)&&cityName.indexOf("市")>0)
//                        city = cityName.trim().substring(0,cityName.trim().length()-1);
//                }
                cityId = cityMap.get(city+district);
            }


            if(StringUtils.checkNull(cityId)){
                // 上面的区县不支持的话 获取市级的id
//                if(cityName.trim().length()>2){
//                    if(!StringUtils.checkNull(cityName)&&cityName.indexOf("市")>0)
//                        cityName = cityName.trim().substring(0,cityName.trim().length()-1);
//                }
                cityId = cityMap.get(cityName+cityName);
            }

            // 聚合接口查询天气json
            String weatherInform = getWeatherInform(cityId);

            if(StringUtils.checkNull(weatherInform)){
                return null;
            }
            // json化
            JsonObject dataOfJson = (JsonObject) new JsonParser().parse(weatherInform);

            // 判断接口是否查询成功
            if(dataOfJson.get("error_code").getAsInt()!=0){
                return null;
            }

            OneDayWeatherInf[] oneDayWeatherInfS = new OneDayWeatherInf[1];

            // 获取结果
            JsonObject WeatherJson = dataOfJson.get("result").getAsJsonObject();
            // 获取实时天气信息
            JsonObject nowDayWeather = WeatherJson.get("realtime").getAsJsonObject();
            // 获取未来天气数组，第一条为当前天天气 部分参数需要从这里取值
            JsonArray future = WeatherJson.get("future").getAsJsonArray();

            for(int i=0;i<1;i++){


                JsonObject OneDayWeatherinfo=future.get(i).getAsJsonObject();
                OneDayWeatherInf oneDayWeatherInf = new OneDayWeatherInf();

//                oneDayWeatherInf.setLocation(WeatherJson.get("city").getAsString());
                oneDayWeatherInf.setLocation(districts);

                //第一个，也就是当天的天气
                if(i==0){
                    // 设置当前温度
                    oneDayWeatherInf.setTempertureNow(nowDayWeather.get("temperature").getAsString());
                    // 设置当前星期
                    oneDayWeatherInf.setWeek(DateFormat.getNowWeek());
                    // 设置当前天气
                    oneDayWeatherInf.setWeather(nowDayWeather.get("info").getAsString());
                    // 根据接口返回天气id 设置天气图片
                    oneDayWeatherInf.setPicture("/img/weather/" + nowDayWeather.get("wid").getAsString() + ".png");
                    // 设置天气质量指数
                    oneDayWeatherInf.setAqi(nowDayWeather.get("aqi").getAsString());
                } else {
                    // 设置天气
                    oneDayWeatherInf.setWeather(OneDayWeatherinfo.get("weather").getAsString());
                }
                // 当天的温度 格式为：最低/最高℃
                String temperature = OneDayWeatherinfo.get("temperature").getAsString();
                // 拆分最低和最高温度
                String[] split = temperature.replace("℃", "").split("/");
                // 设置最低温度
                oneDayWeatherInf.setTempertureMin(split[0]);
                // 设置最高温度
                oneDayWeatherInf.setTempertureMax(split[1]);
                // 设置当天稳定 格式为：最低 ~ 最高℃
                oneDayWeatherInf.setTempertureOfDay(temperature.replace("/"," ~ "));
                // 设置日期
                oneDayWeatherInf.setDate(OneDayWeatherinfo.get("date").getAsString());
                // 设置风
                oneDayWeatherInf.setWind(OneDayWeatherinfo.get("direct").getAsString());
                oneDayWeatherInf.setCityName(cityName+"市");
                oneDayWeatherInfS[i] = oneDayWeatherInf;
            }
            weatherInf.setWeatherInfs(oneDayWeatherInfS);

        }catch (Exception e){
            e.printStackTrace();
            return null;
        }

        return weatherInf;
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/7/8
     * @说明: 初始化聚合接口支持的城市列表
     */
    public static void initCityMap(){
        if(cityMap!=null&&!cityMap.isEmpty())
            return;
        // 聚合
        String juheUrl = "http://apis.juhe.cn/simpleWeather/cityList?key=dedf6138fb5a0420be15fcab7a2af35e";

        StringBuffer strBuf;

        strBuf = new StringBuffer();

        try {
            URL url = new URL(juheUrl);
            URLConnection conn = url.openConnection();
            conn.setConnectTimeout(2000);
            conn.setReadTimeout(3000);
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));//转码。
            String line = null;
            while ((line = reader.readLine()) != null)
                strBuf.append(line + " ");
            reader.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String str = strBuf.toString();
        if(StringUtils.checkNull(str)){
            return;
        }
        JsonObject jsonObject = (JsonObject) new JsonParser().parse(str);
        JsonArray cityArr;
        // 判断是否请求成功，如果没有成功的话 使用默认值
        if(jsonObject.get("error_code").getAsInt()==0){
            // 初始化map
            cityMap = new HashMap<String,String>();
            // 获取arr
            cityArr = jsonObject.get("result").getAsJsonArray();
            for(int i=0,size=cityArr.size();i<size;i++){
                JsonObject jsonObject1 = cityArr.get(i).getAsJsonObject();
                cityMap.put(jsonObject1.get("city").getAsString()+jsonObject1.get("district").getAsString(),jsonObject1.get("id").getAsString());
            }
        }


    }

    /**
     * @作者: 张航宁
     * @时间: 2020/06/19
     * @说明: 初始化聚合限行尾号接口支持的城市列表
     */
    public static void initXianHaoCityMap(){
        if(xianHaoCityMap!=null&&!xianHaoCityMap.isEmpty())
            return;
        // 聚合
        String juheUrl = "http://v.juhe.cn/xianxing/citys?key=d7e872e4a0d9164f2eda491b00a4d543";

        StringBuffer strBuf;

        strBuf = new StringBuffer();

        try {
            URL url = new URL(juheUrl);
            URLConnection conn = url.openConnection();
            conn.setConnectTimeout(2000);
            conn.setReadTimeout(3000);
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));//转码。
            String line = null;
            while ((line = reader.readLine()) != null)
                strBuf.append(line + " ");
            reader.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String str = strBuf.toString();
        if(StringUtils.checkNull(str)){
            return;
        }
        JsonObject jsonObject = (JsonObject) new JsonParser().parse(str);

        JsonArray cityArr;
        // 判断是否请求成功，如果没有成功的话 使用默认值
        if(jsonObject.get("error_code").getAsInt()==0){
            // 初始化map
            xianHaoCityMap = new HashMap<String,String>();
            // 获取arr
            cityArr = jsonObject.get("result").getAsJsonArray();
            for(int i=0,size=cityArr.size();i<size;i++){
                JsonObject jsonObject1 = cityArr.get(i).getAsJsonObject();
                xianHaoCityMap.put(jsonObject1.get("cityname").getAsString(),jsonObject1.get("city").getAsString());
            }
        }


    }

    // 设置天气信息图片
    public static OneDayWeatherInf setWeatherPicture(OneDayWeatherInf oneDayWeatherInf){

        switch (oneDayWeatherInf.getWeather()){
            case SUN:
                oneDayWeatherInf.setPicture("");
                break;
            case CLOUDY:
                oneDayWeatherInf.setPicture("");
                break;
            case OVERCAST:
                oneDayWeatherInf.setPicture("");
                break;
            case THUNDER_SHOWER:
                oneDayWeatherInf.setPicture("");
                break;
            case LIGHT_RAIN:
                oneDayWeatherInf.setPicture("");
                break;
            case MODERATE_RAIN:
                oneDayWeatherInf.setPicture("");
                break;
            case HEAVY_RAIN:
                oneDayWeatherInf.setPicture("");
                break;
            case RAINSTORM:
                oneDayWeatherInf.setPicture("");
                break;
        }
        return  oneDayWeatherInf;
    }

    /**
     *  定义天气类型常量
     * */

    private static final String SUN = "晴";
    private static final String CLOUDY = "多云";
    private static final String OVERCAST = "阴";
    private static final String THUNDER_SHOWER = "雷阵雨";
    private static final String LIGHT_RAIN = "小雨";
    private static final String MODERATE_RAIN = "中雨";
    private static final String HEAVY_RAIN = "大雨";
    private static final String RAINSTORM = "暴雨";

}