package com.xoa.controller.menu;

import com.alibaba.fastjson.JSON;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.common.SyslogMapper;
import com.xoa.dao.menu.SysFunctionMapper;
import com.xoa.dao.menu.SysMenuMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.SysParaExtend;
import com.xoa.model.common.Syslog;
import com.xoa.model.menu.MobileApp;
import com.xoa.model.menu.SysFunction;
import com.xoa.model.menu.SysMenu;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.Users;
import com.xoa.service.menu.MenuService;
import com.xoa.service.menu.MobileAppService;
import com.xoa.service.sys.impl.SystemInfoServiceImpl;
import com.xoa.service.users.UserFunctionService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.ipUtil.IpAddr;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.*;

/**
 * 创建作者:   王曰岐
 * 创建日期:   2017-4-18 下午6:34:34
 * 类介绍   :    菜单控制器
 * 构造参数:    无
 */
@Controller
@Scope(value = "prototype")
public class MenuController {
    @Resource
    private MenuService menuService;
    @Resource
    private UsersPrivService usersPrivService;
    @Resource
    private UserFunctionService userFunctionService;

    @Resource
    private MobileAppService mobileAppService;
    @Resource
    private SysParaMapper sysParaMapper;
    @Resource
    private SysMenuMapper sysMenuMapper;

    private int flag;
    private String err = "err";
    private String ok = "ok";

    @Resource
    SysFunctionMapper sysFunctionMapper;
    @Resource
    private SyslogMapper syslogMapper;
    @Resource
    private UsersService usersService;
    @RequestMapping("deleteDatePage")
    public String deleteDatePage(HttpServletRequest request) {
        return "app/delete/delete";
    }

    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-18 下午6:35:04
     * 方法介绍:   获取菜单和下面的子菜单
     * 参数说明:   @return
     *
     * @return String 返回JSON类型的菜单
     */
    @RequestMapping(value = "/showMenu", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public ToJson<SysMenu> showNew(HttpServletRequest request, HttpServletResponse response,String Pcflag) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        //  String LOCALE_SESSION_ATTRIBUTE_NAME = SessionLocaleResolver.class.getName() + ".LOCALE";
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        List<SysMenu>  munuLists = new ArrayList<>();
        List<SysMenu> munuList;
        try {
            SysPara sysPara = sysParaMapper.querySysPara("PC_FAVORITE_MENU");
            if (sysPara!=null&&"1".equals(sysPara.getParaValue())&&!StringUtils.checkNull(Pcflag)&&"pc".equals(Pcflag)) {
                List<SysFunction> sysFunctions = new ArrayList<>();
                Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
                Users usersByuserId = usersService.findUsersByuserId(users.getUserId());
                if(usersByuserId.getShortcut()!=null&&usersByuserId.getShortcut()!=""){
                    String[] split = usersByuserId.getShortcut().split(",");
                    for (String sp:split) {
                        SysFunction sysFunction = sysFunctionMapper.checkFunctionExits(Integer.parseInt(sp));
                        if(sysFunction!=null){
                            sysFunction.setChild(new ArrayList<>());
                            sysFunctions.add(sysFunction);
                        }
                    }
                }
                    SysFunction sysFunction =  new SysFunction();
                    sysFunction.setChild(new ArrayList<>());
                    sysFunction.setExt("");
                    sysFunction.setName("常用应用设置");
                    sysFunction.setId("cyyysz");
                    sysFunction.setUrl("/controlpanel/commonSettings");
                    sysFunction.setName1("");
                    sysFunction.setName2("");
                    sysFunctions.add(sysFunction);
                if(sysFunctions.size()>0){
                    SysMenu sysMenu = new SysMenu();
                    sysMenu.setId("cy");
                    if ( "zh_CN".equals(locale)) {
                        sysMenu.setName("常用应用");
                    } else if ("en_US".equals(locale)) {
                        sysMenu.setName("Common applications");
                    } else if ("zh_tw".equals(locale)) {
                        sysMenu.setName("常用应用");
                    }else {
                        sysMenu.setName("常用应用");
                    }
                    sysMenu.setImg("common_setting");
                    sysMenu.setName1("Common applications");
                    sysMenu.setExt("");
                    sysMenu.setName2("常用应用");
                    sysMenu.setChild(sysFunctions);
                    munuLists.add(sysMenu);
                }
            }

            //选中文时，locale可能是null,
            if (locale == null) {
                munuList = menuService.getAll(request, "zh_CN");
            } else {
                munuList = menuService.getAll(request, locale.toString());
            }
            String msg;
            if (munuList.size() > 0) {
                flag = 0;
                msg = ok;
            } else {
                flag = 1;
                msg = err;
            }

            ToJson<SysMenu> menuJson = new ToJson<SysMenu>(flag, msg);
            munuLists.addAll(munuList);
            menuJson.setObj(munuLists);

            Map<String, String> map = new HashMap<String, String>();
            map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                    "yyyy-MM-dd HH:mm:ss"));
            return menuJson;
        } catch (Exception e) {

            munuList = menuService.getAll(request, "zh_CN");
            String msg;
            if (munuList.size() > 0) {
                flag = 0;
                msg = ok;
            } else {
                flag = 1;
                msg = err;
            }

            ToJson<SysMenu> menuJson = new ToJson<SysMenu>(flag, msg);
            menuJson.setObj(munuList);

            Map<String, String> map = new HashMap<String, String>();
            map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                    "yyyy-MM-dd HH:mm:ss"));
            return menuJson;
        }


    }


    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-18 下午6:35:04
     * 方法介绍:   获取菜单和下面的子菜单
     * 参数说明:   @return
     *
     * @return String 返回JSON类型的菜单
     */
    @RequestMapping(value = "/showMenu2", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public ToJson<SysMenu> showMenu2(HttpServletRequest request, HttpServletResponse response) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        //  String LOCALE_SESSION_ATTRIBUTE_NAME = SessionLocaleResolver.class.getName() + ".LOCALE";
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        List<SysMenu> munuList;
        try {

            //选中文时，locale可能是null,
            if (locale == null) {
                munuList = menuService.getAll2(request, "zh_CN");
            } else {
                munuList = menuService.getAll2(request, locale.toString());
            }
            String msg;
            if (munuList.size() > 0) {
                flag = 0;
                msg = ok;
            } else {
                flag = 1;
                msg = err;
            }

            ToJson<SysMenu> menuJson = new ToJson<SysMenu>(flag, msg);
            menuJson.setObj(munuList);

            Map<String, String> map = new HashMap<String, String>();
            map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                    "yyyy-MM-dd HH:mm:ss"));
            return menuJson;
        } catch (Exception e) {

            munuList = menuService.getAll2(request, "zh_CN");
            String msg;
            if (munuList.size() > 0) {
                flag = 0;
                msg = ok;
            } else {
                flag = 1;
                msg = err;
            }

            ToJson<SysMenu> menuJson = new ToJson<SysMenu>(flag, msg);
            menuJson.setObj(munuList);

            Map<String, String> map = new HashMap<String, String>();
            map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                    "yyyy-MM-dd HH:mm:ss"));
            return menuJson;
        }


    }


    /**
     * 创建作者:   韩成冰
     * 创建日期:   2017-4-18 下午6:35:04
     * 方法介绍:   获取菜单和下面的子菜单，无子菜单的也要查出来
     * 参数说明:   @return
     *
     * @return String 返回JSON类型的菜单
     */
    @RequestMapping(value = "/showNewWithEmpty", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public ToJson<SysMenu> showNewWithEmpty(HttpServletRequest request, HttpServletResponse response) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        //  String LOCALE_SESSION_ATTRIBUTE_NAME = SessionLocaleResolver.class.getName() + ".LOCALE";
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        List<SysMenu> munuList;
        try {

            //选中文时，locale可能是null,
            if (locale == null) {
                munuList = menuService.getAllWithEmpty(request, "zh_CN");
            } else {
                munuList = menuService.getAllWithEmpty(request, locale.toString());
            }
            String msg;
            if (munuList.size() > 0) {
                flag = 0;
                msg = ok;
            } else {
                flag = 1;
                msg = err;
            }

            ToJson<SysMenu> menuJson = new ToJson<SysMenu>(flag, msg);
            menuJson.setObj(munuList);

            Map<String, String> map = new HashMap<String, String>();
            map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                    "yyyy-MM-dd HH:mm:ss"));
            return menuJson;
        } catch (Exception e) {

            munuList = menuService.getAllWithEmpty(request, "zh_CN");
            String msg;
            if (munuList.size() > 0) {
                flag = 0;
                msg = ok;
            } else {
                flag = 1;
                msg = err;
            }

            ToJson<SysMenu> menuJson = new ToJson<SysMenu>(flag, msg);
            menuJson.setObj(munuList);

            Map<String, String> map = new HashMap<String, String>();
            map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                    "yyyy-MM-dd HH:mm:ss"));
            return menuJson;
        }


    }


    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-19 下午3:57:41
     * 方法介绍:   获取一级菜单下面的子类菜单
     * 参数说明:   @param request
     * 参数说明:   @param response
     * 参数说明:   @return
     *
     * @return String
     */
    @RequestMapping(value = "/showSubclassesMenu", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String showDadMenu(HttpServletRequest request, HttpServletResponse response) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        String LOCALE_SESSION_ATTRIBUTE_NAME = SessionLocaleResolver.class.getName() + ".LOCALE";
        Object locale = request.getSession().getAttribute(LOCALE_SESSION_ATTRIBUTE_NAME);
        String menuId = request.getParameter("menuId");
        List<SysFunction> list = null;
        if (locale == null) {
            list = menuService.getDadMenu(menuId, "zh_CN");

        } else {
            list = menuService.getDadMenu(menuId, locale.toString());

        }
        String msg;
        if (list.size() > 0) {
            flag = 0;
            msg = ok;
        } else {
            flag = 1;
            msg = err;
        }
        ToJson<SysFunction> menuJson = new ToJson<SysFunction>(flag, msg);
        menuJson.setObj(list);
        Map<String, String> map = new HashMap<String, String>();
        map.put("showSubclassesMenu", JSON.toJSONStringWithDateFormat(menuJson,
                "yyyy-MM-dd HH:mm:ss"));

        return JSON.toJSONStringWithDateFormat(menuJson, "yyyy-MM-dd HH:mm:ss");
    }

    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-19 下午3:59:56
     * 方法介绍:   移动对应菜单
     * 参数说明:   @return
     *
     * @return String
     */
    @RequestMapping(value = "/getMenu", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public
    @ResponseBody
    ToJson<MobileApp> getMenu(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        List<MobileApp> munuList = mobileAppService.getMobileAppList(request);
        String msg;
        if (munuList.size() > 0) {
            flag = 0;
            msg = ok;
        } else {
            flag = 1;
            msg = err;

        }

        ToJson<MobileApp> menuJson = new ToJson<MobileApp>(flag, msg);
        menuJson.setObj(munuList);
        return menuJson;


    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/23 19:28
     * @函数介绍: 对一级菜单(SysMenu)修改,
     * @参数说明: @param sysMenu
     * @参数说明: @param request
     * @return: String (转发到查询所有菜单)
     **/
    @ResponseBody
    @RequestMapping(value = "/updateFirstMenu", produces = {"application/json;charset=UTF-8"})
    public ToJson<SysMenu> updateSysMenu(SysMenu sysMenu, HttpServletRequest request, HttpServletResponse response) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        String LOCALE_SESSION_ATTRIBUTE_NAME = SessionLocaleResolver.class.getName() + ".LOCALE";
        Object locale = request.getSession().getAttribute(LOCALE_SESSION_ATTRIBUTE_NAME);
        ToJson<SysMenu> menuJson = new ToJson<SysMenu>();
        //部分属性不为null.
        if (sysMenu != null && sysMenu.getId() != null && sysMenu.getName() != null &&
                sysMenu.getName1() != null && sysMenu.getName2() != null && sysMenu.getImg() != null) {
            try {
                //修改菜单
                //判断主菜单分类代码是否已存在
                Map<String, Object> updateMap = new HashMap<>();
                updateMap.put("id", sysMenu.getId());
                updateMap.put("newId", sysMenu.getNewId());
                int i = sysMenuMapper.selectIdRepeat(updateMap);
                // 大于0说明改主菜单分类代码已存在，直接返回提示信息
                if (i > 0){
                    menuJson.setFlag(1);
                    menuJson.setMsg("The main menu classification code already exists！");
                    return menuJson;
                }
                int y = menuService.updateSysMenu(sysMenu);
                // 如果y 大于 0 说明修改成功，进行子菜单的修改
                if (y > 0){
                    //判断旧id与新id不一样时才进行主菜单分类代码修改
                    if (!StringUtils.checkNull(sysMenu.getNewId()) && !sysMenu.getId().equals(sysMenu.getNewId())){
                        int z = sysFunctionMapper.updateFuncIdByMenuId(updateMap);
                        if (z > 0){
                            menuJson.setFlag(0);
                            menuJson.setMsg("ok");
                        }
                    }
                }

                //相当于调用showmenu
                List<SysMenu> munuList;
                try {
                    //选中文时，locale可能是null,
                    if (locale == null) {
                        munuList = menuService.getAll(request, "zh_CN");
                    } else {
                        munuList = menuService.getAll(request, locale.toString());
                    }
                    if (munuList.size() > 0) {
                        menuJson.setFlag(0);
                        menuJson.setMsg("ok");
                    } else {
                        menuJson.setFlag(1);
                        menuJson.setMsg("err");
                    }


                    menuJson.setObj(munuList);

                    Map<String, String> map = new HashMap<String, String>();
                    map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                            "yyyy-MM-dd HH:mm:ss"));
                    return menuJson;
                } catch (Exception e) {

                    munuList = menuService.getAll(request, "zh_CN");
                    String msg;
                    if (munuList.size() > 0) {
                        flag = 0;
                        msg = ok;
                    } else {
                        flag = 1;
                        msg = err;
                    }

                    menuJson = new ToJson<SysMenu>(flag, msg);
                    menuJson.setObj(munuList);

                    Map<String, String> map = new HashMap<String, String>();
                    map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                            "yyyy-MM-dd HH:mm:ss"));
                    return menuJson;
                }
            } catch (Exception e) {
                menuJson.setMsg(e.getMessage());
            }
        } else {
            menuJson.setMsg("参数传递问题。");
        }

        return menuJson;
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 13:01
     * @函数介绍: 添加主菜单(由于主菜单和其它子菜单对应不同的表 ， 所以添加时分开)
     * @参数说明: @param sysMenu
     * @return: String
     **/
    @ResponseBody
    @RequestMapping(value = "/addSysMenu", produces = {"application/json;charset=UTF-8"})
    public ToJson<SysMenu> addSysMenu(SysMenu sysMenu, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<SysMenu> menuJson = new ToJson<SysMenu>();
        //菜单代码，菜单的中、英、繁体名不能为null才可以修改。
        if (sysMenu != null && sysMenu.getId() != null && sysMenu.getName() != null
                && sysMenu.getName1() != null && sysMenu.getName2() != null && sysMenu.getImg() != null) {

            //数据库要求字段不为空，但是前端没传入，这里设置为“”
            /*
             *   作者： 刘佩峰
             *   时间：2017-6-16 18
             * */
            if (sysMenu.getName3() != null) {
                sysMenu.setName3(sysMenu.getName3());
            }
            if (sysMenu.getName4() != null) {
                sysMenu.setName4(sysMenu.getName4());
            }
            if (sysMenu.getName5() != null) {
                sysMenu.setName5(sysMenu.getName5());
            }
            // sysMenu.setName4("");
            //sysMenu.setName5("");
            sysMenu.setExt("");

            //菜单id长度为2
            if (sysMenu.getId().length() == 2) {
                try {
                    //判断主菜单分类代码是否已存在
                    Map<String, Object> addeMap = new HashMap<>();
                    addeMap.put("id", sysMenu.getId());
                    int i = sysMenuMapper.selectIdRepeat(addeMap);
                    // 大于0说明改主菜单分类代码已存在，直接返回提示信息
                    if (i > 0){
                        menuJson.setFlag(1);
                        menuJson.setMsg("该主菜单分类代码已存在！");
                        return menuJson;
                    }
                    menuService.addSysMenu(sysMenu);

                    //相当于调用showmenu
                    Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
                    List<SysMenu> munuList;
                    try {

                        //选中文时，locale可能是null,
                        if (locale == null) {
                            munuList = menuService.getAllWithEmpty(request, "zh_CN");
                        } else {
                            munuList = menuService.getAllWithEmpty(request, locale.toString());
                        }
                        String msg;
                        if (munuList.size() > 0) {
                            flag = 0;
                            msg = ok;
                        } else {
                            flag = 1;
                            msg = err;
                        }

                        menuJson = new ToJson<SysMenu>(flag, msg);
                        menuJson.setObj(munuList);

                        Map<String, String> map = new HashMap<String, String>();
                        map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                                "yyyy-MM-dd HH:mm:ss"));
                        return menuJson;
                    } catch (Exception e) {

                        munuList = menuService.getAllWithEmpty(request, "zh_CN");
                        String msg;
                        if (munuList.size() > 0) {
                            flag = 0;
                            msg = ok;
                        } else {
                            flag = 1;
                            msg = err;
                        }

                        menuJson = new ToJson<SysMenu>(flag, msg);
                        menuJson.setObj(munuList);

                        Map<String, String> map = new HashMap<String, String>();
                        map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                                "yyyy-MM-dd HH:mm:ss"));
                        return menuJson;
                    }

                } catch (Exception e) {
                    menuJson.setFlag(1);
                    menuJson.setMsg("err");
                    menuJson.setMsg(e.getMessage());
                }
            }
        }
        return menuJson;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 13:15
     * @函数介绍: 删除菜单
     * @参数说明: @param id（对应数据库MENU_ID）
     * @return: String
     **/
    @ResponseBody
    @RequestMapping(value = "/deleteSysMenu", produces = {"application/json;charset=UTF-8"})
    public ToJson<SysMenu> deleteSysMenu(String id, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        List<SysMenu> munuList;
        ToJson<SysMenu> menuJson = new ToJson<SysMenu>();
        //id不为空，去除空格，id长度大于等于2
        if (id != null && id.trim().length() >= 2) {
            try {
                menuService.deleteSysMenu(id);


                //  查询菜单，相当于调用showmenu
                Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");

                try {

                    //选中文时，locale可能是null,
                    if (locale == null) {
                        munuList = menuService.getAllWithEmpty(request, "zh_CN");
                    } else {
                        munuList = menuService.getAllWithEmpty(request, locale.toString());
                    }
                    String msg;
                    if (munuList.size() > 0) {
                        flag = 0;
                        msg = ok;
                    } else {
                        flag = 1;
                        msg = err;
                    }

                    menuJson = new ToJson<SysMenu>(flag, msg);
                    menuJson.setObj(munuList);

                    Map<String, String> map = new HashMap<String, String>();
                    map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                            "yyyy-MM-dd HH:mm:ss"));
                    return menuJson;
                } catch (Exception e) {

                    munuList = menuService.getAll(request, "zh_CN");
                    String msg;
                    if (munuList.size() > 0) {
                        flag = 0;
                        msg = ok;
                    } else {
                        flag = 1;
                        msg = err;
                    }

                    menuJson = new ToJson<SysMenu>(flag, msg);
                    menuJson.setObj(munuList);

                    Map<String, String> map = new HashMap<String, String>();
                    map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                            "yyyy-MM-dd HH:mm:ss"));
                    return menuJson;
                }
            } catch (Exception e) {
                menuJson.setFlag(1);
                menuJson.setMsg("err");
                menuJson.setMsg(e.getMessage());
            }
        }
        return menuJson;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/24 17:10
     * @函数介绍: 非一级菜单的添加。（参考本类中方法addMenu）
     * @参数说明: @param sysFunction 子类菜单实体类
     * @参数说明: @param parentId 子类菜单的父菜单id
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/addFunction", produces = {"application/json;charset=UTF-8"}, name = "添加子类")
    public ToJson<SysFunction> addFunctionMenu(SysFunction sysFunction, HttpServletRequest request, String parentId) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        //localhost:8081/addFunction?fid=343&id=76&name=myname&parentId=1090&url=myurl
        //ext是 国际版多语言菜单名称，先用“”，留好接口
        sysFunction.setExt("");
        //json.isFlag();
        //数据库某些字段不允许为空，所以判断
        if (sysFunction != null && sysFunction.getId() != null && sysFunction.getName() != null &&
                sysFunction.getfId() != null && sysFunction.getExt() != null &&
                sysFunction.getUrl() != null && !StringUtils.checkNull(parentId)) {
        }
        return menuService.addFunctionMenu(sysFunction, parentId);
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 14:12
     * @函数介绍: 修改二级菜单
     * @参数说明: @param sysFunction
     * @参数说明: @param parentId
     * @return: String
     **/
    @ResponseBody
    @RequestMapping(value = "/editSysFunction", produces = {"application/json;charset=UTF-8"})
    public ToJson<SysFunction> editSysFunction(SysFunction sysFunction, String parentId, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<SysFunction> json = new ToJson<SysFunction>(0, null);

        if (sysFunction != null && sysFunction.getfId() != null && parentId != null &&
                sysFunction.getId() != null && sysFunction.getName() != null && sysFunction.getUrl() != null) {

            //前端传来的parentId,和id拼接后即要存入数据库的菜单id（MENU_ID）
            sysFunction.setId(parentId.concat(sysFunction.getId()));
            try {

                menuService.editSysFunction(sysFunction);
                json.setMsg("OK");
                json.setFlag(0);
            } catch (Exception e) {
                json.setFlag(1);
                json.setMsg("err");
                json.setMsg(e.getMessage());
            }


        }
        return json;

    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 16:53
     * @函数介绍: 查询2/3级菜单
     * @参数说明: @param id 菜单id
     * @return: Json
     **/
    @ResponseBody
    @RequestMapping(value = "/findChildMenu", produces = {"application/json;charset=UTF-8"})
    public ToJson<SysFunction> findChildMenu(String id, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<SysFunction> json = new ToJson<SysFunction>(0, null);
        try {


            String LOCALE_SESSION_ATTRIBUTE_NAME = SessionLocaleResolver.class.getName() + ".LOCALE";
            Object locale = request.getSession().getAttribute(LOCALE_SESSION_ATTRIBUTE_NAME);


            List<SysFunction> menuList = null;
            //选中文时，locale可能是null,
            if (locale == null) {
                menuList = menuService.findChildMenu(id, "zh_CN");
            } else {
                menuList = menuService.findChildMenu(id, locale.toString());
            }
            String msg;

            json.setObj(menuList);
            flag = 0;
            msg = ok;
            json.setFlag(flag);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;

    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 19:36
     * @函数介绍: 根据id查一级菜单
     * @参数说明: @param String
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/getTheFirstMenu", produces = {"application/json;charset=UTF-8"})
    public ToJson<SysMenu> getTheFirstMenu(String id, HttpServletRequest request, @RequestHeader(value = "Accept-Language",defaultValue = "zh-CN,zh;q=0.9")
            String acceptLang) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        String LOCALE_SESSION_ATTRIBUTE_NAME = SessionLocaleResolver.class.getName() + ".LOCALE";
        Object locale = request.getSession().getAttribute(LOCALE_SESSION_ATTRIBUTE_NAME);
        ToJson<SysMenu> json = new ToJson<SysMenu>(0, null);

        try {
            //选中文时，locale可能是null,
            List<SysMenu> list = null;
            if (locale == null) {
                list = menuService.getTheFirstMenu(id, "zh_CN");
            } else {
                list = menuService.getTheFirstMenu(id, locale.toString());
            }


            if (list != null & list.size() == 1) {
                json.setObject(list.get(0));
            }
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;

    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/1 13:39
     * @函数介绍: 获取某个功能授权的角色;
     * @参数说明: @param String fid(子类菜单ID)
     * @参数说明: @param HttpServletRequest
     * @return: json
     **/
    @ResponseBody
    @RequestMapping("/getAuthRoleName")
    public ToJson<StringBuffer> getAuthRoleName(String fid, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<StringBuffer> json = new ToJson<StringBuffer>(0, null);
        try {
            List<UserPriv> userPrivList = usersPrivService.getUserPrivNameByFuncId(fid);

            StringBuffer sb = new StringBuffer();

            for (int i = 0; i < userPrivList.size(); i++) {
                if (i == (userPrivList.size() - 1)) {
                    sb.append(userPrivList.get(i).getPrivName());
                } else {
                    sb.append(userPrivList.get(i).getPrivName()).append(",");
                }

            }

            json.setObject(sb);
            json.setMsg("OK");
            json.setFlag(0);

        } catch (Exception e) {
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/1 13:39
     * @函数介绍: 获取某个功能授权的用户名;
     * @参数说明: @param String fid(子类菜单ID)
     * @参数说明: @param HttpServletRequest
     * @return: json
     **/
    @ResponseBody
    @RequestMapping("/getAuthUserName")
    public ToJson<StringBuffer> getAuthUserName(String fid, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<StringBuffer> json = new ToJson<StringBuffer>(0, null);

        try {
            List<String> list = userFunctionService.getUserNameByFuncId(fid);

            StringBuffer sb = new StringBuffer();

            for (int i = 0; i < list.size(); i++) {
                if (i == (list.size() - 1)) {
                    sb.append(list.get(i));
                } else {
                    sb.append(list.get(i)).append(",");
                }

            }

            json.setObject(sb);
            json.setMsg("OK");
            json.setFlag(0);

        } catch (NullPointerException e) {
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/1 19:41
     * @函数介绍: 修改UserPriv(user_priv), 某个菜单增加角色权限
     * @参数说明: @param String privids
     * @参数说明: @param String funcId
     * @return: json
     **/
    @ResponseBody
    @RequestMapping("/updateUserPrivfuncIdStr")
    public ToJson<Object> updateUserPrivfuncIdStr(HttpServletRequest request, String privids, String funcId) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

        ToJson<Object> json = new ToJson<Object>(0, null);

        try {
            usersPrivService.updateUserPrivfuncIdStr(privids, funcId);

            //加入操作日志处理
            Syslog sysLog = new Syslog();
            sysLog.setUserId(users.getUserId() + "");
            sysLog.setType(20);
            sysLog.setTypeName("菜单设置-编辑角色菜单权限");
            sysLog.setIp(IpAddr.getIpAddress(request));
            sysLog.setRemark("");
            String userAgent = request.getParameter("userAgent");
            if ("iOS".equals(userAgent)) {
                //添加客户端类型
                sysLog.setClientType(3);
                SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else if ("android".equals(userAgent)) {
                sysLog.setClientType(4);
                SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else if ("pc".equals(userAgent)) {
                sysLog.setClientType(2);
                SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else {
                sysLog.setClientType(1);
                String clientVersion = request.getParameter("clientVersion");
                if (clientVersion != null && clientVersion.length() > 0) {
                    sysLog.setClientVersion(clientVersion);
                } else {
                    sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
                }
            }
            sysLog.setRemark(sysLog.getTypeName()+":funcId="+funcId+",privids="+privids);
            sysLog.setTime(new Date(System.currentTimeMillis()));
            syslogMapper.save(sysLog);

            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/2 13:28
     * @函数介绍: 修改该用户对某个菜单的权限，对应user_ext表，user_function表
     * @参数说明: fid 某个某个功能的id, 对应sys_function的id
     * @参数说明: uids 用户的userId多个用逗号分隔。
     * @return: json
     **/
    @ResponseBody
    @RequestMapping("/updateAuthUser")
    public ToJson<Object> updateAuthUser(HttpServletRequest request, String fid, String uids) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        ToJson<Object> json = new ToJson<Object>(0, null);

        try {
            userFunctionService.updateAuthUser(fid, uids);

            //加入操作日志处理
            Syslog sysLog = new Syslog();
            sysLog.setUserId(users.getUserId() + "");
            sysLog.setType(20);
            sysLog.setTypeName("菜单设置-编辑用户菜单权限");
            sysLog.setIp(IpAddr.getIpAddress(request));
            sysLog.setRemark("");
            String userAgent = request.getParameter("userAgent");
            if ("iOS".equals(userAgent)) {
                //添加客户端类型
                sysLog.setClientType(3);
                SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else if ("android".equals(userAgent)) {
                sysLog.setClientType(4);
                SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else if ("pc".equals(userAgent)) {
                sysLog.setClientType(2);
                SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else {
                sysLog.setClientType(1);
                String clientVersion = request.getParameter("clientVersion");
                if (clientVersion != null && clientVersion.length() > 0) {
                    sysLog.setClientVersion(clientVersion);
                } else {
                    sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
                }
            }
            sysLog.setRemark(sysLog.getTypeName()+":funcId="+fid+",uids="+uids);
            sysLog.setTime(new Date(System.currentTimeMillis()));
            syslogMapper.save(sysLog);

            json.setMsg("OK");
            json.setFlag(0);

        } catch (Exception e) {
            json.setMsg("err");
            json.setFlag(1);
        }

        return json;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/2 14:54
     * @函数介绍: 删除角色权限
     * @参数说明: @param String privids
     * @参数说明: @param String funcId
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "deleteUserPriv", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> deleteUserPriv(HttpServletRequest request, String privids, String funcIds) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        ToJson<Object> json = new ToJson<Object>(0, null);

        try {
            usersPrivService.deleteUserPriv(privids, funcIds);

            //加入操作日志处理
            Syslog sysLog = new Syslog();
            sysLog.setUserId(users.getUserId() + "");
            sysLog.setType(21);
            sysLog.setTypeName("菜单设置-角色删除菜单权限");
            sysLog.setIp(IpAddr.getIpAddress(request));
            sysLog.setRemark("");
            String userAgent = request.getParameter("userAgent");
            if ("iOS".equals(userAgent)) {
                //添加客户端类型
                sysLog.setClientType(3);
                SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else if ("android".equals(userAgent)) {
                sysLog.setClientType(4);
                SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else if ("pc".equals(userAgent)) {
                sysLog.setClientType(2);
                SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else {
                sysLog.setClientType(1);
                String clientVersion = request.getParameter("clientVersion");
                if (clientVersion != null && clientVersion.length() > 0) {
                    sysLog.setClientVersion(clientVersion);
                } else {
                    sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
                }
            }
            sysLog.setRemark(sysLog.getTypeName()+":funcIds="+funcIds+",privids="+privids);
            sysLog.setTime(new Date(System.currentTimeMillis()));
            syslogMapper.save(sysLog);

            json.setMsg("OK");
            json.setFlag(0);

        } catch (Exception e) {
            json.setMsg("err");
            json.setFlag(1);

        }

        return json;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/2 15:24
     * @函数介绍: 删除用户的某项菜单权限（对应user_ext和user_function表）
     * @参数说明: fid 某个某个功能的id, 对应sys_function的id
     * @参数说明: uids 用户的userId多个用逗号分隔。
     * @return: json
     **/
    @ResponseBody
    @RequestMapping("/deleteAuthUser")
    public ToJson<Object> deleteAuthUser(HttpServletRequest request, String fid, String uIds) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        ToJson<Object> json = new ToJson<Object>(0, null);

        try {
            userFunctionService.deleteAuthUser(fid, uIds);

            //加入操作日志处理
            Syslog sysLog = new Syslog();
            sysLog.setUserId(users.getUserId() + "");
            sysLog.setType(21);
            sysLog.setTypeName("菜单设置-删除用户菜单权限");
            sysLog.setIp(IpAddr.getIpAddress(request));
            sysLog.setRemark("");
            String userAgent = request.getParameter("userAgent");
            if ("iOS".equals(userAgent)) {
                //添加客户端类型
                sysLog.setClientType(3);
                SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else if ("android".equals(userAgent)) {
                sysLog.setClientType(4);
                SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else if ("pc".equals(userAgent)) {
                sysLog.setClientType(2);
                SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else {
                sysLog.setClientType(1);
                String clientVersion = request.getParameter("clientVersion");
                if (clientVersion != null && clientVersion.length() > 0) {
                    sysLog.setClientVersion(clientVersion);
                } else {
                    sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
                }
            }
            sysLog.setRemark(sysLog.getTypeName()+":funcIds="+fid+",uIds="+uIds);
            sysLog.setTime(new Date(System.currentTimeMillis()));
            syslogMapper.save(sysLog);

            json.setMsg("OK");
            json.setFlag(0);

        } catch (Exception e) {
            json.setMsg("err");
            json.setFlag(1);
        }

        return json;
    }
    /*
     *//**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/20 12：30
     * @函数介绍: 登陆人权限获得的菜单
     * @参数说明:
     * @return: json
     **//*
    @ResponseBody
    @RequestMapping("/getMenus")
    public ToJson<SysFunction> getMenus(HttpServletRequest request, String parentId) {
        ToJson<SysFunction> json = new ToJson<SysFunction>(0, null);


        String LOCALE_SESSION_ATTRIBUTE_NAME = SessionLocaleResolver.class.getName() + ".LOCALE";
        Object locale = request.getSession().getAttribute(LOCALE_SESSION_ATTRIBUTE_NAME);
        //选中文时，locale可能是null,
        List<SysFunction> list = null;
        if (locale == null) {
            list = menuService.getMenus(request, parentId,"zh_CN");
        } else {
            list = menuService.getMenus(request,parentId,locale.toString());

        }
        json.setObj(list);
        json.setFlag(0);
        json.setMsg("OK");


        return json;


    }*/

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/26 14:03
     * @函数介绍: 获取所有菜单，不考虑权限
     * @参数说明: @param request
     * @return: json
     **/

    @RequestMapping("/getAllFunctionMenu")
    @ResponseBody
    public ToJson<SysMenu> getAllFunctionMenu(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        String LOCALE_SESSION_ATTRIBUTE_NAME = SessionLocaleResolver.class.getName() + ".LOCALE";
        Object locale = request.getSession().getAttribute(LOCALE_SESSION_ATTRIBUTE_NAME);
        List<SysMenu> munuList;
        try {

            //选中文时，locale可能是null,
            if (locale == null) {
                munuList = menuService.getAllMenu(request, "zh_CN");
            } else {
                munuList = menuService.getAllMenu(request, locale.toString());
            }
            String msg;
            if (munuList.size() > 0) {
                flag = 0;
                msg = ok;
            } else {
                flag = 1;
                msg = err;
            }

            ToJson<SysMenu> menuJson = new ToJson<SysMenu>(flag, msg);
            menuJson.setObj(munuList);

            Map<String, String> map = new HashMap<String, String>();
            map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                    "yyyy-MM-dd HH:mm:ss"));
            return menuJson;
        } catch (Exception e) {
            e.printStackTrace();
            munuList = menuService.getAll(request, "zh_CN");
            String msg;
            if (munuList.size() > 0) {
                flag = 0;
                msg = ok;
            } else {
                flag = 1;
                msg = err;
            }

            ToJson<SysMenu> menuJson = new ToJson<SysMenu>(flag, msg);
            menuJson.setObj(munuList);
            menuJson.setMsg("err");
            menuJson.setFlag(1);
            Map<String, String> map = new HashMap<String, String>();
            map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                    "yyyy-MM-dd HH:mm:ss"));
            return menuJson;
        }
    }

    /*  *//**
     * 创建作者:   高亚峰
     * 创建日期:   2017-6-27 下午13:25:56
     * 方法介绍:   根据当前登录用户查询15个菜单应用
     * 参数说明:   @return
     *
     * @return String
     *//*
    @RequestMapping(value = "/getMenus", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public ToJson<SysFunction> getMenus(HttpServletRequest request, HttpServletResponse response) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        String LOCALE_SESSION_ATTRIBUTE_NAME = SessionLocaleResolver.class.getName() + ".LOCALE";
        Object locale = request.getSession().getAttribute(LOCALE_SESSION_ATTRIBUTE_NAME);
        List<SysFunction> munuList;
        try {

            //选中文时，locale可能是null,
            if (locale == null) {
                munuList = menuService.getPriMenu(request, "zh_CN");
            } else {
                munuList = menuService.getPriMenu(request, locale.toString());
            }
            String msg;
            if (munuList.size() > 0) {
                flag = 0;
                msg = ok;
            } else {
                flag = 1;
                msg = err;
            }

            ToJson<SysFunction> menuJson = new ToJson<SysFunction>(flag, msg);
            menuJson.setObj(munuList);

            Map<String, String> map = new HashMap<String, String>();
            map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                    "yyyy-MM-dd HH:mm:ss"));
            return menuJson;
        } catch (Exception e) {

            munuList = menuService.getPriMenu(request, "zh_CN");
            String msg;
            if (munuList.size() > 0) {
                flag = 0;
                msg = ok;
            } else {
                flag = 1;
                msg = err;
            }

            ToJson<SysFunction> menuJson = new ToJson<SysFunction>(flag, msg);
            menuJson.setObj(munuList);

            Map<String, String> map = new HashMap<String, String>();
            map.put("showMenu", JSON.toJSONStringWithDateFormat(menuJson,
                    "yyyy-MM-dd HH:mm:ss"));
            return menuJson;

        }
    }*/

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/30 16:03
     * @函数介绍: 获取错误子菜单
     * @参数说明:
     * @return: json
     **/
    @RequestMapping("/getErrMenu")
    @ResponseBody
    public ToJson<List<SysFunction>> getErrMenu() {
        return menuService.getErrMenu();
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/7/3 10:22
     * @函数介绍: 菜单恢复
     * @参数说明: path sql文件的路径
     * @return: json
     **/
    @RequestMapping("/ImportMenu")
    @ResponseBody
    public ToJson<Object> recoverMenu(HttpServletRequest request, MultipartFile sqlFile) {


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
                //新文件名称
                String fileName_new = "lec";
                String path = realPath.concat("sys_function.sql");
                //新文件
                File newFile = new File(path);
                //将内存中的文件内容写入磁盘上
                sqlFile.transferTo(newFile);

                toJson = menuService.recoverMenu(request, path);
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
     * @创建作者: 韩成冰
     * @创建日期: 2017/7/3 15:22
     * @函数介绍: 菜单导出
     * @参数说明:
     * @return: json
     */
    @RequestMapping("/ExportMenu")
    @ResponseBody
    public void exportMenu(HttpServletRequest request, HttpServletResponse response) {
        try {
            menuService.exportMenu(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/4 15:22
     * @函数介绍: 菜单设置
     * @参数说明: TOP_MENU_NUM 快捷菜单栏每行显示的个数
     * MENU_GROUP 菜单快捷组
     * MENU_WINEXE 显示windows 快捷组
     * MENU_URL    显示常用地址
     * MENU_EXPAND_SINGLE  同时只能展开一个菜单
     * @return: json
     */
    @RequestMapping("/EditMenuPara")
    @ResponseBody
    public ToJson<Object> editMenuPara(SysParaExtend sysParaExtend) {
        return menuService.editMenuPara(sysParaExtend);
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/4 17:22
     * @函数介绍: 查询菜单设置内容
     * @参数说明:
     * @return: json
     */
    @RequestMapping("/getMenuPara")
    @ResponseBody
    public ToJson<SysParaExtend> getParaInfo() {
        return menuService.getParaInfo();
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/7/11 13:13
     * @函数介绍: 根据id查sysFunciton
     * @参数说明: String fid;
     * @return: json
     **/

    @RequestMapping(value = "/getSysFunctionByFid")
    @ResponseBody
    public ToJson<SysFunction> getSysFunctionByFid(HttpServletRequest request, Integer fid) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<SysFunction> tojson = new ToJson<SysFunction>(0, "");
        try {

            SysFunction sysFunction = menuService.getSysFunctionByFid(fid);
            tojson.setObject(sysFunction);
            tojson.setMsg("ok");
            tojson.setFlag(0);
        } catch (Exception e) {
            tojson.setFlag(1);
            tojson.setMsg("err");
        }
        return tojson;
    }

    //获得常用应用设置
    @RequestMapping(value = "/getUsuallyMenu", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public ToJson<SysFunction> getUsuallyMenu(HttpServletRequest request) {
        return menuService.getUsuallyMenu(request);
    }


    @RequestMapping("/documentDispatchReceive")
    @ResponseBody
    public ToJson<SysFunction> documentDispatchReceive(HttpServletRequest request) {
        ToJson json = new ToJson();
        List<SysFunction> function = null;
        try {
            function = sysFunctionMapper.getSysFunctionByName("公文收发");
        }catch (Exception e){

        }
        if (function.size()!=0){
            json.setData(function.get(0));
        }
        json.setFlag(0);
        return json;
    }
    /**
     * create by:李善澳
     * description:根绝url获取menuId
     No such property: code for class: Script1
     * @return
     */
    @RequestMapping("/getMenuIdByUrl")
    @ResponseBody
    public ToJson getMenuIdByUrl(HttpServletRequest request,@RequestParam(value = "url") String url) {
        ToJson json = new ToJson();
        if (url==null || url==""){
            json.setMsg("url数据为空");
            json.setFlag(1);
            return json;
        }
        String[] split = url.split(",");
        List<String> list = new ArrayList<>();
        for (int i = 0; i <split.length ; i++) {
            list.add(split[i]);
        }
        try {
            List<SysFunction> menuIdByUrl = sysFunctionMapper.getMenuIdByUrl(list);
            json.setObject(menuIdByUrl);
        }catch (Exception e){

        }
        json.setFlag(0);
        return json;
    }


    /**
     * @函数介绍: 获取所有菜单，过滤无权限菜单id
     * @参数说明: @param request
     * @return: json
     **/
    @RequestMapping("/queryAllFunctionMenu")
    @ResponseBody
    public ToJson<SysMenu> queryAllFunctionMenu(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        String LOCALE_SESSION_ATTRIBUTE_NAME = SessionLocaleResolver.class.getName() + ".LOCALE";
        Object locale = request.getSession().getAttribute(LOCALE_SESSION_ATTRIBUTE_NAME);
        //选中文时，locale可能是null,
        if (locale == null) {
            return menuService.queryAllMenu(request, "zh_CN");
        } else {
            return menuService.queryAllMenu(request, locale.toString());
        }
    }
}



