package com.xoa.controller.common;

/**
 * Created by 张丽军 on 2018/7/23.
 */

import com.xoa.model.common.HrCode;
import com.xoa.service.common.HrCodeService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import net.sf.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.List;

/**
 * 创建作者:   张丽军
 * 创建日期:   2017-5-2 下午4:59:25
 * 类介绍  :    系统代码表控制器
 * 构造参数:
 */
@Controller
@Scope(value = "prototype")
@RequestMapping("/hrCode")
public class HrCodeController {


    @Resource
    private HrCodeService hrCodeService;//系统代码Service

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
    ToJson<HrCode> getCode(String parentNo, HttpServletRequest request, HttpServletResponse response) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return hrCodeService.getSysCode(parentNo);
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年5月4日 上午9:28:13
     * 方法介绍:   获取所有代码主分类
     * 参数说明:   @param request	请求
     * 参数说明:   @return
     *
     * @return ToJson<SysCode> 返回代码主分类
     */
    @ResponseBody
    @RequestMapping(value = "/syscode/getAllSysCode", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public ToJson<HrCode> getAllSysCode(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<HrCode> json = new ToJson<HrCode>(0, null);
        try {
            List<HrCode> list = hrCodeService.getAllSysCode();
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
     * 创建作者:   张丽军
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
    public ToJson<HrCode> update(HttpServletRequest request, HrCode hrCode) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<HrCode> json = new ToJson<HrCode>(0, null);
        try {
            hrCodeService.update(hrCode);
            json.setObject(hrCode);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * 创建作者:  张丽军
     * 创建日期:  2017/6/3 13:22
     * 函数介绍:   删除日志
     * 参数说明:   @param request 请求
     * 参数说明:   @param Syscode 请求
     *
     * @return: json
     **/
    @ResponseBody
    @RequestMapping("/deleteSysCode")
    public ToJson<HrCode> deleteSysCode(HttpServletRequest request, HrCode hrCode) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<HrCode> json = new ToJson<HrCode>(0, null);
        try {
            hrCodeService.deleteSysCode(hrCode);
            //json = hrCodeService.getSysCode(sysCode.getParentNo());
            json.setObject(hrCode);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;

    }

    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/3 13:38
     * @函数介绍: 增加代码主分类
     * @参数说明: @param paramname paramintroduce
     * @return: XXType(value introduce)
     **/
    @ResponseBody
    @RequestMapping(value = "/addSysMainCode", produces = {"application/json;charset=UTF-8"})
    public ToJson<HrCode> addSysMainCode(HttpServletRequest request, HrCode hrCode) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<HrCode> json = new ToJson<HrCode>(0, null);
        try {
            hrCodeService.addSysMainCode(hrCode);
            json.setObject(hrCode);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/3 14:11
     * @函数介绍: 判断系统代码排序是否存在
     * @参数说明: @param paramname paramintroduce
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/isCodeOrderExits", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> isCodeOrderExits(HttpServletRequest request, HrCode hrCode) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Object> json = new ToJson<Object>(0, null);
        try {
            Boolean isExits = hrCodeService.isCodeOrderExits(hrCode);
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
     * @创建作者: 张丽军
     * @创建日期: 2017/6/3 14:11
     * @函数介绍: 判断系统代码CODE_NO是否存在
     * @参数说明: @param paramname paramintroduce
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/isCodeNoExits", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> isCodeNoExits(HttpServletRequest request, HrCode hrCode) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Object> json = new ToJson<Object>(0, null);
        try {
            Boolean isExits = hrCodeService.isCodeNoExits(hrCode);
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
     * @创建作者: 张丽军
     * @创建日期: 2017/6/27 20：55
     * @函数介绍: 判断系统代码主代码更新时CODE_NO是否存在
     * @参数说明: @param paramname paramintroduce
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/iseditCodeNoExits", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> iseditCodeNoExits(HttpServletRequest request, HrCode hrCode) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Object> json = new ToJson<Object>(0, null);
        try {
            Boolean isExits = hrCodeService.iseditCodeNoExits(hrCode);
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
     * @创建作者: 张丽军
     * @创建日期: 2017/6/22 18.04
     * @函数介绍: 判断系统代码更新时CODE_NO是否存在
     * @参数说明: @param oldCodeNo 修改前的sysCode
     * @参数说明: @param sysCode 修改后的sysCode
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/editisCodeNoExits", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> editisCodeNoExits(HttpServletRequest request, HrCode hrCode, String oldCodeNo) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return hrCodeService.editisCodeNoExits(hrCode, oldCodeNo);
    }
    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/20 11：02
     * @函数介绍: 判断系统子代码CODE_NO是否存在
     * @参数说明: @param sysCode
     * @return: json
     **/

    @ResponseBody
    @RequestMapping(value = "/ChildisCodeNoExits", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> ChildisCodeNoExits(HttpServletRequest request,HrCode hrCode){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<Object> json = new ToJson<Object>(0, null);
        try {
            Boolean isExits = hrCodeService.ChildisCodeNoExits(hrCode);
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
     * @创建作者: 张丽军
     * @创建日期: 2017/6/15 19:17
     * @函数介绍: 添加子代码
     * @参数说明: @param SysCode 需要添加的信息
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "addChildSysCode", produces = {"application/json;charset=UTF-8"})
    public ToJson<HrCode> addChildSysCode(HttpServletRequest request, HrCode hrCode) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<HrCode> json = new ToJson<HrCode>(0, null);
        try {
            hrCodeService.addChildSysCode(hrCode);
            json.setObject(hrCode);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/30 19：50
     * @函数介绍: 查询错误代码列表
     * @参数说明:
     * @return: List<SysCode>
     **/

    @ResponseBody
    @RequestMapping("/getErrCode")
    public ToJson<List<HrCode>> getErrSyscode(){
        return hrCodeService.getErrSysCode();
    }

    /**
     * @创建作者: 张丽军
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

                toJson = hrCodeService.recoverCode(request, path);
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
     * @创建作者: 张丽军
     * @创建日期: 2017/7/04 11:20
     * @函数介绍: 系统代码备份
     * @参数说明: request response
     * @return: Tojson
     * */
    @RequestMapping("/ExportCode")
    @ResponseBody
    public void exportMenu(HttpServletRequest request,HttpServletResponse response){
        try {
            hrCodeService.exportCode( request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/11 20:26
     * @函数介绍: 根据codeId查询错误代码信息
     * @参数说明: CodeId
     * @return: Tojson
     * */
    @RequestMapping("/getErrInfo")
    @ResponseBody
    public ToJson<HrCode> getErrInfo(String CodeId){

        return  hrCodeService.getErrInfo(CodeId);
    }
    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/12 10:41
     * @函数介绍: 根据codeId删除错误代码
     * @参数说明: CodeId
     * @return: Tojson
     * */
    @RequestMapping("/deleteErrCode")
    @ResponseBody
    public ToJson<HrCode> deleteErrCode(String CodeId){
        return  hrCodeService.deleteErrCode(CodeId);
    }
    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/12 13:08
     * @函数介绍: 获取所有正确代码
     * @参数说明:
     * @return: Tojson
     * */
    @ResponseBody
    @RequestMapping("/getAllCode")
    public ToJson<List<HrCode>> getAllCode(){
        return hrCodeService.getAllCode();
    };
    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/19 19:16
     * @函数介绍: 获取下拉框
     * @参数说明: CodeIds  CodeIds用，分割的数组
     * @return: Tojson
     */
    @ResponseBody
    @RequestMapping("/GetDropDownBox")
    public JSONObject DropDownBox(String CodeNos){
        String[] split = CodeNos.split(",");
        return  hrCodeService.DropDownBoxs(split);
    }

   /* *//**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/19 19:16
     * @函数介绍: 迁移数据库升级接口
     * @参数说明:
     * @return:
     */
    @ResponseBody
    @RequestMapping("/updateDabase")
    public ToJson<Object> updateDabase(){
        return  hrCodeService.updateDabase();
    }
     /* *//**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/19 19:16
     * @函数介绍: 读取Excel文件
     * @参数说明:
     * @return:
     */
    @ResponseBody
    @RequestMapping("/editDabase")
    public ToJson<Object> editDabase(HttpServletRequest request,HttpServletResponse response){
        return  hrCodeService.editDabase(request,response);
    }

      /*  *//* *//**//**
     * @创建作者: 张丽军
     * @创建日期: 2018/1/23 19:16
     * @函数介绍: 查询数据库脚本执行情况
     * @参数说明:
     * @return:
     */
    @ResponseBody
    @RequestMapping("/getObjectcount")
    public ToJson<Object> getObjects(){
        return  hrCodeService.getObjects();
    }
      /*  *//* *//**//**
     * @创建作者: 张丽军
     * @创建日期: 2018/1/23 19:16
     * @函数介绍: 查询数据库脚本返回数据
     * @参数说明:
     * @return:
     */
    @ResponseBody
    @RequestMapping("/getObjectdetail")
    public ToJson<Object> getObjectdetail(){
        return  hrCodeService.getObjectdetail();
    }

  /*  *//* *//**//**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/19 19:16
     * @函数介绍: 数据库升级接口
     * @参数说明:
     * @return:
     */
    @ResponseBody
    @RequestMapping("/updateResource")
    public ToJson<Object> updateResource(){
        return  hrCodeService.updateResource();
    }

     /*  *//* *//**//**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/19 19:16
     * @函数介绍: 下载log日志
     * @参数说明:
     * @return:
     */
    @ResponseBody
    @RequestMapping("/downLog")
    public void downLog(HttpServletResponse response,HttpServletRequest request){
        hrCodeService.downLog(response,request);
    }


}
