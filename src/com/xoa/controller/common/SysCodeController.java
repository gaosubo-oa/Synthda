package com.xoa.controller.common;

import com.xoa.model.common.SysCode;
import com.xoa.service.common.SysCodeService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.List;
import java.util.Map;

/**
 * 创建作者:   王曰岐
 * 创建日期:   2017-5-2 下午4:59:25
 * 类介绍  :    系统代码表控制器
 * 构造参数:
 */
@Controller
@Scope(value = "prototype")
@RequestMapping("/code")

public class SysCodeController {


    @Resource
    private SysCodeService sysCodeService;//系统代码Service

    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-5-2 下午4:59:42
     * 方法介绍:   得到系统类型信息
     * 参数说明:   @param parentNo
     * 参数说明:   @return
     *
     * @return ToJson<SysCode>
     */
    @RequestMapping("/getCode")
    public
    @ResponseBody
    ToJson<SysCode> getCode(String parentNo, HttpServletRequest request, HttpServletResponse response,String codeName) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        if("CONTENT_SECRECY".equals(parentNo)){
            return sysCodeService.getContentSecrecy(request,parentNo,codeName);
        }
        return sysCodeService.getSysCode(request,parentNo,codeName);
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 上午9:28:13
     * 方法介绍:   获取所有代码主分类
     * 参数说明:   @param request	请求
     * 参数说明:   @return
     *
     * @return ToJson<SysCode> 返回代码主分类
     */
    @ResponseBody
    @RequestMapping(value = "/syscode/getAllSysCode", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public ToJson<SysCode> getAllSysCode(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        ToJson<SysCode> json = new ToJson<SysCode>(0, null);
        try {
            List<SysCode> list = sysCodeService.getAllSysCode();
            if (!CollectionUtils.isEmpty(list)) {
                for (SysCode sysCode : list) {
                    if (locale.equals("zh_CN")) {
                        sysCode.setCodeName(sysCode.getCodeName());
                    } else if (locale.equals("en_US")) {
                        sysCode.setCodeName(sysCode.getCodeName1());
                    } else if (locale.equals("zh_TW")) {
                        sysCode.setCodeName(sysCode.getCodeName2());
                    }
                }
            }
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 上午10:12:05
     * 方法介绍:   修改系统代码设置表主分类
     * 参数说明:   @param request 请求
     * 参数说明:   @param sysCode 系统代码设置表主分类
     * 参数说明:   @return
     *
     * @return ToJson<SysCode> 系统代码设置表主分类
     */
    @ResponseBody
    @RequestMapping(value = "/syscode/update", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public ToJson<SysCode> update(HttpServletRequest request, SysCode sysCode) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        ToJson<SysCode> json = new ToJson<SysCode>(0, null);
        try {
            if (locale.equals("zh_CN")) {
                sysCode.setCodeName(sysCode.getCodeName());
            } else if (locale.equals("en_US")) {
                sysCode.setCodeName1(sysCode.getCodeName());
                sysCode.setCodeName(null);
            } else if (locale.equals("zh_TW")) {
                sysCode.setCodeName2(sysCode.getCodeName());
                sysCode.setCodeName(null);
            }
            sysCodeService.update(sysCode);
            json.setObject(sysCode);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * 创建作者:  韩成冰
     * 创建日期:  2017/6/3 13:22
     * 函数介绍:   删除日志
     * 参数说明:   @param request 请求
     * 参数说明:   @param Syscode 请求
     *
     * @return: json
     **/
    @ResponseBody
    @RequestMapping("/deleteSysCode")
    public ToJson<SysCode> deleteSysCode(HttpServletRequest request, SysCode sysCode) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<SysCode> json = new ToJson<SysCode>(0, null);
        try {
            sysCodeService.deleteSysCode(sysCode);
            //json = sysCodeService.getSysCode(sysCode.getParentNo());
            json.setObject(sysCode);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;

    }

    /**
     * @创建作者: 马东辉
     * @创建日期: 2021/12/24
     * @函数介绍: 增加模糊查询
     * @参数说明: codeName
     * @return: json
     **/
    @ResponseBody
    @RequestMapping("/searchLike")
    public ToJson<SysCode> searchLike(String codeName) {
        return sysCodeService.searchLike(codeName);
    }
    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/3 13:38
     * @函数介绍: 增加代码主分类
     * @参数说明: @param paramname paramintroduce
     * @return: XXType(value introduce)
     **/
    @ResponseBody
    @RequestMapping(value = "/addSysMainCode", produces = {"application/json;charset=UTF-8"})
    public ToJson<SysCode> addSysMainCode(HttpServletRequest request, SysCode sysCode) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<SysCode> json = new ToJson<SysCode>(0, null);
        try {
            sysCodeService.addSysMainCode(sysCode);
            json.setObject(sysCode);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/3 14:11
     * @函数介绍: 判断系统代码排序是否存在
     * @参数说明: @param paramname paramintroduce
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/isCodeOrderExits", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> isCodeOrderExits(HttpServletRequest request, SysCode sysCode) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Object> json = new ToJson<Object>(0, null);
        try {
            Boolean isExits = sysCodeService.isCodeOrderExits(sysCode);
            json.setMsg("OK");
            if (isExits) {
                json.setFlag(0);
            } else {
                json.setFlag(1);
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/3 14:11
     * @函数介绍: 判断系统代码CODE_NO是否存在
     * @参数说明: @param paramname paramintroduce
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/isCodeNoExits", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> isCodeNoExits(HttpServletRequest request, SysCode sysCode) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Object> json = new ToJson<Object>(0, null);
        try {
            Boolean isExits = sysCodeService.isCodeNoExits(sysCode);
            if (isExits) {
                json.setFlag(0);
                json.setMsg("OK");
            } else {
                json.setFlag(1);
                json.setMsg("NO");
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/27 20：55
     * @函数介绍: 判断系统代码主代码更新时CODE_NO是否存在
     * @参数说明: @param paramname paramintroduce
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/iseditCodeNoExits", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> iseditCodeNoExits(HttpServletRequest request, SysCode sysCode) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Object> json = new ToJson<Object>(0, null);
        try {
            Boolean isExits = sysCodeService.iseditCodeNoExits(sysCode);
            if (isExits) {
                json.setFlag(0);
                json.setMsg("OK");
            } else {
                json.setFlag(1);
                json.setMsg("NO");
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/22 18.04
     * @函数介绍: 判断系统代码更新时CODE_NO是否存在
     * @参数说明: @param oldCodeNo 修改前的sysCode
     * @参数说明: @param sysCode 修改后的sysCode
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/editisCodeNoExits", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> editisCodeNoExits(HttpServletRequest request, SysCode sysCode, String oldCodeNo) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return sysCodeService.editisCodeNoExits(sysCode, oldCodeNo);
    }
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/20 11：02
     * @函数介绍: 判断系统子代码CODE_NO是否存在
     * @参数说明: @param sysCode
     * @return: json
     **/

    @ResponseBody
    @RequestMapping(value = "/ChildisCodeNoExits", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> ChildisCodeNoExits(HttpServletRequest request,SysCode sysCode){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<Object> json = new ToJson<Object>(0, null);
        try {
            Boolean isExits = sysCodeService.ChildisCodeNoExits(sysCode);
            json.setMsg("OK");
            if (isExits) {
                json.setFlag(0);
            } else {
                json.setFlag(1);
                json.setMsg("NO");
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/15 19:17
     * @函数介绍: 添加子代码
     * @参数说明: @param SysCode 需要添加的信息
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "addChildSysCode", produces = {"application/json;charset=UTF-8"})
    public ToJson<SysCode> addChildSysCode(HttpServletRequest request, SysCode sysCode) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        ToJson<SysCode> json = new ToJson<SysCode>(0, null);
        try {
            if (locale.equals("zh_CN")) {
                sysCode.setCodeName(sysCode.getCodeName());
            } else if (locale.equals("en_US")) {
                sysCode.setCodeName1(sysCode.getCodeName());
                sysCode.setCodeName(null);
            } else if (locale.equals("zh_TW")) {
                sysCode.setCodeName2(sysCode.getCodeName());
                sysCode.setCodeName(null);
            }
            sysCodeService.addChildSysCode(sysCode);
            json.setObject(sysCode);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/30 19：50
     * @函数介绍: 查询错误代码列表
     * @参数说明:
     * @return: List<SysCode>
     **/

    @ResponseBody
    @RequestMapping("/getErrCode")
    public ToJson<List<SysCode>> getErrSyscode(){
        return sysCodeService.getErrSysCode();
    }

/**
 * @创建作者: 高亚峰
 * @创建日期: 2017/7/04 11:03
 * @函数介绍: 系统代码恢复
 * @参数说明: path 用于导入sql的路径
 * @return:
 * */
     @RequestMapping("/ImportCode")
     @ResponseBody
     public ToJson<Object> recoverMenu(HttpServletRequest request,MultipartFile sqlFile)  {
         //上传文件到服务器


         Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);


         String realPath = request.getSession().getServletContext().getRealPath("/");
         ToJson<Object> toJson = new ToJson<Object>(0, "");
         try {
             //实现上传图片
             if (sqlFile != null && sqlFile.getOriginalFilename() != null
                     && !sqlFile.getOriginalFilename().equals("")) {
                 //获取图片原始名称，目标要从原始名称中获取文件的扩展名
                 String originalFilename = sqlFile.getOriginalFilename();
                 String path = realPath.concat("sys_code.sql");
                 //新文件
                 File newFile = new File(path);
                 //将内存中的文件内容写入磁盘上
                 sqlFile.transferTo(newFile);

                 toJson = sysCodeService.recoverCode(request, path);
                 toJson.setFlag(0);
                 toJson.setMsg("ok");

             }
         } catch (Exception e) {
             toJson.setFlag(1);
             toJson.setMsg("err");

         }

         return toJson;
  }

/**
 * @创建作者: 高亚峰
 * @创建日期: 2017/7/04 11:20
 * @函数介绍: 系统代码备份
 * @参数说明: request response
 * @return: Tojson
 * */
@RequestMapping("/ExportCode")
@ResponseBody
public void exportMenu(HttpServletRequest request,HttpServletResponse response){
    try {
        sysCodeService.exportCode( request, response);
    } catch (Exception e) {
        e.printStackTrace();
    }
}

/**
 * @创建作者: 高亚峰
 * @创建日期: 2017/7/11 20:26
 * @函数介绍: 根据codeId查询错误代码信息
 * @参数说明: CodeId
 * @return: Tojson
 * */
@RequestMapping("/getErrInfo")
@ResponseBody
public ToJson<SysCode> getErrInfo(String CodeId){

        return  sysCodeService.getErrInfo(CodeId);
}
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/12 10:41
     * @函数介绍: 根据codeId删除错误代码
     * @参数说明: CodeId
     * @return: Tojson
     * */
    @RequestMapping("/deleteErrCode")
    @ResponseBody
    public ToJson<SysCode> deleteErrCode(String CodeId){
        return  sysCodeService.deleteErrCode(CodeId);
    }
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/12 13:08
     * @函数介绍: 获取所有正确代码
     * @参数说明:
     * @return: Tojson
     * */
    @ResponseBody
    @RequestMapping("/getAllCode")
     public ToJson<List<SysCode>> getAllCode(){
      return sysCodeService.getAllCode();
     };
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/19 19:16
     * @函数介绍: 获取下拉框
     * @参数说明: CodeIds  CodeIds用，分割的数组
     * @return: Tojson
     */
    @ResponseBody
    @RequestMapping("/GetDropDownBox")
    public Map DropDownBox(HttpServletRequest request, String CodeNos){
            String[] split = CodeNos.split(",");
            return  sysCodeService.DropDownBoxs(request, split);
        }

   /* *//**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/19 19:16
     * @函数介绍: 迁移数据库升级接口
     * @参数说明:
      * @return:
     */
    @ResponseBody
    @RequestMapping("/updateDabase")
    public ToJson<Object> updateDabase(){
        return  sysCodeService.updateDabase();
    }
     /* *//**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/19 19:16
     * @函数介绍: 读取Excel文件
     * @参数说明:
     * @return:
     */
    @ResponseBody
    @RequestMapping("/editDabase")
    public ToJson<Object> editDabase(HttpServletRequest request,HttpServletResponse response){
        return  sysCodeService.editDabase(request,response);
    }

      /*  *//* *//**//**
     * @创建作者: 高亚峰
     * @创建日期: 2018/1/23 19:16
     * @函数介绍: 查询数据库脚本执行情况
     * @参数说明:
     * @return:
     */
    @ResponseBody
    @RequestMapping("/getObjectcount")
    public ToJson<Object> getObjects(){
        return  sysCodeService.getObjects();
    }
      /*  *//* *//**//**
     * @创建作者: 高亚峰
     * @创建日期: 2018/1/23 19:16
     * @函数介绍: 查询数据库脚本返回数据
     * @参数说明:
     * @return:
     */
    @ResponseBody
    @RequestMapping("/getObjectdetail")
    public ToJson<Object> getObjectdetail(){
        return  sysCodeService.getObjectdetail();
    }

  /*  *//* *//**//**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/19 19:16
     * @函数介绍: 数据库升级接口
     * @参数说明:
     * @return:
     */
  @ResponseBody
  @RequestMapping("/updateResource")
    public ToJson<Object> updateResource(){
        return  sysCodeService.updateResource();
    }

     /*  *//* *//**//**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/19 19:16
     * @函数介绍: 下载log日志
     * @参数说明:
     * @return:
     */
    @ResponseBody
    @RequestMapping("/downLog")
    public void downLog(HttpServletResponse response,HttpServletRequest request){
        sysCodeService.downLog(response,request);
    }




    /**
     * 创建作者:   张丽军
     * 创建日期:   2019年1月22日 上午15:12:05
     * 方法介绍:   修改系统代码设置默认事务提醒 1默认提醒0不提醒
     * 参数说明:   @param request 请求
     * 参数说明:   @param sysCode
     * 参数说明:   @return
     *
     * @return ToJson<SysCode>
     */
    @ResponseBody
    @RequestMapping(value = "/syscode/addRemind", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public ToJson<SysCode> addRemind(HttpServletRequest request, String codeIds) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        SysCode sysCode = new SysCode();
        ToJson<SysCode> json = new ToJson<SysCode>(0, null);
        try {
            if(codeIds!=null&&!codeIds.equals("")){
                String [] str = codeIds.split("\\|");
                for(int i=0;i<str.length;i++){
                    String str1 = str[i];
                    if(str1!=null&&!str1.equals("")){
                        String [] str2 = str1.split(",");
                        sysCode.setCodeId(Integer.valueOf(str2[0]));
                        sysCode.setIsCan(str2[1]);
                        sysCode.setIsRemind(str2[2]);
                        sysCode.setIsIphone(str2[3]);
                        sysCodeService.update(sysCode);
                    }
                }
            }
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }


    /**
     * 创建作者:   张丽军
     * 创建日期:   2019-1-22 下午4:59:42
     * 方法介绍:   得到系统事务提醒设置权限的所有菜单
     * 参数说明:   @param parentNo
     * 参数说明:   @return
     *
     * @return ToJson<SysCode>
     */
    @RequestMapping("/getCodeRemind")
    public
    @ResponseBody
    ToJson<SysCode> getCodeRemind(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return sysCodeService.getCodeRemind(request);
    }

    /**
     * houwangxin
     * @param request
     * @param versionCode  修改端版本号code，1为PC端，2为安卓端，3为IOS
     * @param version      修改的版本号
     * @return
     */
    @RequestMapping("/editServerVersion")
    @ResponseBody
    public ToJson<SysCode> editServerVersion(HttpServletRequest request,String pcVersion,String AndroidVersion,String iosVersion){
        return sysCodeService.editServerVersion(request,pcVersion,AndroidVersion,iosVersion);
    }

    /**
     * @创建作者: 廉小雨
     * @创建日期: 2020/7/06
     * @函数介绍: 获取领导指示精神模块
     * @return: Tojson
     */
    @ResponseBody
    @RequestMapping("/GetLeaderBox")
    public ToJson GetLeaderBox(SysCode sysCode){
        return  sysCodeService.GetLeaderBox(sysCode);
    }


    @RequestMapping("/getCodeValue")
    @ResponseBody
    public  ToJson getCodeValue(String parentNo ){
        return  sysCodeService.getCodeValue(parentNo);
    }
}
