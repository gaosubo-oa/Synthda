package com.xoa.service.menu.impl;

import com.xoa.dao.menu.SysFunctionMapper;
import com.xoa.dao.menu.SysMenuMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.SysParaExtend;
import com.xoa.model.menu.SysFunction;
import com.xoa.model.menu.SysMenu;
import com.xoa.model.users.Users;
import com.xoa.service.menu.MenuService;
import com.xoa.service.syspara.SysParaService;
import com.xoa.service.users.UserFunctionService;
import com.xoa.service.users.UserPrivTypeService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DBPropertiesUtils;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.charset.Charset;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * 创建作者: 王曰岐
 * <p/>
 * 创建日期: 2017-4-19 下午3:44:26
 * <p/>
 * 类介绍 : 菜单ServiceImpl 构造参数:
 */
@Transactional
@Service
public class MenuServiceImpl implements MenuService {
    private static final String SKEY = "abcdefgh";
    private static final Charset CHARSET = Charset.forName("utf-8");
    @Resource
    private SysMenuMapper sysMenuMapper;// 父类菜单DAO

    @Resource
    private SysFunctionMapper sysFunctionMapper;// 子类菜单DAO

    @Resource
    private UsersService usersService;


    @Resource
    private UsersPrivService usersPrivService;
    @Resource
    private SysParaService sysParaService;
    @Resource
    private UserFunctionService userFunctionService;

    @Resource
    private UserPrivTypeService userPrivTypeService;

    /**
     * 创建作者: 王曰岐
     * <p/>
     * 创建日期: 2017-4-19 下午3:43:57
     * <p/>
     * 方法介绍: 获取全部菜单 参数说明: @return
     *
     * @return List<SysMenu>
     */
    @Override
    public List<SysMenu> getAll(HttpServletRequest request, String locale) {
        //1、获取当前登录用户权限
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        Integer uid = users.getUid();
/*
        //users里没有这个属性，要查询出来
        String userPriv = usersService.getUserPrivByuId(uid);*/

        //用户菜单权限=该用户所具有权限，不考虑角色表
        //该用户所具有权限
        String userFunctionStr = userFunctionService.getUserFunctionStrById(uid);
        String[] funcIds = userFunctionStr.split(",");
        //该用户对应角色所具有权限
        // users = usersService.getByUid(uid);

/*        UserPriv userPriv1 = usersPrivService.getUserPriv(Integer.parseInt(userPriv));
        String privStr = "";
        if (userPriv1 != null) {
            privStr = userPriv1.getFuncIdStr();
        }

        String[] privArr = privStr.split(",");*/
        Set<String> userMenuSet = new HashSet<String>();

        for (String funcId : funcIds) {
            userMenuSet.add(funcId);
        }
/*        for (String s : privArr) {
            userMenuSet.add(s);
        }*/
        //用一个StringBuffer记录有三级菜单的二级菜单，因为用户如果排除所有三级菜单，
        // 有三级菜单和没有三级菜单的二级菜单难以区分，而没有三级菜单的二级菜单要不显示
        StringBuffer sb = new StringBuffer();

        //2、获取所有菜单
        List<SysMenu> list = sysMenuMapper.getDatagrid();
        List<SysFunction> allSysFunction = sysFunctionMapper.getAll();

        for (SysMenu sysMenu : list) {
            if (locale.equals("zh_CN")) {
                sysMenu.setName(sysMenu.getName());
            } else if (locale.equals("en_US")) {
                sysMenu.setName(sysMenu.getName1());
            } else if (locale.equals("zh_tw")) {
                sysMenu.setName(sysMenu.getName2());
            }
            List<SysFunction> list1 = new ArrayList<>();
            if (sysMenu.getId() != null) {
                //获取二级菜单
                //list1 = sysFunctionMapper.getDatagrid(sysMenu.getId().concat("__"));
                for (SysFunction sysFunction : allSysFunction) {
                    String menuId = sysFunction.getId();
                    if(menuId.length()==(sysMenu.getId().length()+2)&&menuId.startsWith(sysMenu.getId())){
                        list1.add(sysFunction);
                    }
                }
                allSysFunction.removeAll(list1);
            }

            for (SysFunction sysFunction : list1) {
                if (locale.equals("zh_CN")) {
                    sysFunction.setName(sysFunction.getName());
                } else if (locale.equals("en_US")) {
                    sysFunction.setName(sysFunction.getName1());
                } else if (locale.equals("zh_TW")) {
                    sysFunction.setName(sysFunction.getName2());
                }
                if ("1".equals(sysFunction.getSendUser())) {
                    StringBuilder stringBuilder = new StringBuilder();
                    String url = sysFunction.getUrl();
                    stringBuilder.append(url);
                    stringBuilder.append("?uId=");
                    stringBuilder.append(encrypt(uid.toString(), CHARSET, SKEY));
                    stringBuilder.append("&userId=");
                    stringBuilder.append(encrypt(users.getUserId(), CHARSET, SKEY));
                    stringBuilder.append("&userName=");
                    stringBuilder.append(encrypt(users.getUserName(), CHARSET, SKEY));
                    stringBuilder.append("&passWord=");
                    if (!StringUtils.checkNull(users.getPassword())) {
                        stringBuilder.append(encrypt(users.getPassword(), CHARSET, SKEY));
                    } else {
                        stringBuilder.append(encrypt("", CHARSET, SKEY));
                    }
                    if (sysFunction.getSendKey() != null && !"".equals(sysFunction.getSendKey())) {
                        stringBuilder.append("&sendKey=");
                        stringBuilder.append(encrypt(sysFunction.getSendKey(), CHARSET, SKEY));
                    }
                    sysFunction.setUrl(stringBuilder.toString());
                }
                List<SysFunction> list2 = new ArrayList<>();
                if (sysFunction.getId() != null) {
                    //获取三级菜单
                    //list2 = sysFunctionMapper.childMenu(sysFunction.getId().concat("__"));
                    for (SysFunction sysFunction2 : allSysFunction) {
                        String menuId = sysFunction2.getId();
                        if(menuId.length()==(sysFunction.getId().length()+2)&&menuId.startsWith(sysFunction.getId())){
                            list2.add(sysFunction2);
                        }
                    }
                    allSysFunction.removeAll(list2);
                }

                //某二级菜单有三级菜单,把有三级菜单的二级菜单fid拼接为字符串，用，前后分隔。
                if (list2.size() > 0) {
                    sb.append(",").append(sysFunction.getfId()).append(",");
                }
                sysFunction.setChild(list2);

                for (SysFunction sysFunction2 : list2) {
                    if (locale.equals("zh_CN")) {
                        sysFunction2.setName(sysFunction2.getName());
                    } else if (locale.equals("en_US")) {
                        sysFunction2.setName(sysFunction2.getName1());
                    } else if (locale.equals("zh_TW")) {
                        sysFunction2.setName(sysFunction2.getName2());
                    }
                    if ("1".equals(sysFunction2.getSendUser())) {
                        StringBuilder stringBuilder = new StringBuilder();
                        String url = sysFunction2.getUrl();
                        stringBuilder.append(url);
                        stringBuilder.append("?uId=");
                        stringBuilder.append(encrypt(uid.toString(), CHARSET, SKEY));
                        stringBuilder.append("&userId=");
                        stringBuilder.append(encrypt(users.getUserId(), CHARSET, SKEY));
                        stringBuilder.append("&userName=");
                        stringBuilder.append(encrypt(users.getUserName(), CHARSET, SKEY));
                        stringBuilder.append("&passWord=");
                        if (!StringUtils.checkNull(users.getPassword())) {
                            stringBuilder.append(encrypt(users.getPassword(), CHARSET, SKEY));
                        } else {
                            stringBuilder.append(encrypt("", CHARSET, SKEY));
                        }
                        if (sysFunction2.getSendKey() != null && !"".equals(sysFunction2.getSendKey())) {
                            stringBuilder.append("&sendKey=");
                            stringBuilder.append(encrypt(sysFunction2.getSendKey(), CHARSET, SKEY));
                        }
                        sysFunction2.setUrl(stringBuilder.toString());
                    }

                    List<SysFunction> list3 = new ArrayList<>();
                    if (sysFunction2.getId() != null) {
                        //获取四级级菜单
                        //list3 = sysFunctionMapper.childMenu(sysFunction2.getId().concat("__"));
                        for (SysFunction sysFunction3 : allSysFunction) {
                            String menuId = sysFunction3.getId();
                            if(menuId.length()==(sysFunction2.getId().length()+2)&&menuId.startsWith(sysFunction2.getId())){
                                list3.add(sysFunction3);
                            }
                        }
                        allSysFunction.removeAll(list3);
                    }
                    for (SysFunction sysFunction3 : list3) {
                        if (locale.equals("zh_CN")) {
                            sysFunction3.setName(sysFunction3.getName());
                        } else if (locale.equals("en_US")) {
                            sysFunction3.setName(sysFunction3.getName1());
                        } else if (locale.equals("zh_TW")) {
                            sysFunction3.setName(sysFunction3.getName2());
                        }
                    }
                    StringBuffer sbt = new StringBuffer();
                    //某三级菜单有四级菜单,把有四级菜单的三级菜单fid拼接为字符串，用，前后分隔。
                    if (list3.size() > 0) {
                        sbt.append(",").append(sysFunction2.getfId()).append(",");
                    }
                    sysFunction2.setChild(list3);
                }

            }
            sysMenu.setChild(list1);
        }

        //3、将list中的，用户没有的权限给排除了
        List<SysMenu> userMenulistResult = new ArrayList<SysMenu>();
        for (SysMenu sysMenu : list) {
            List<SysFunction> secondList = new ArrayList<SysFunction>();
            List<SysFunction> tempSecondList = sysMenu.getChild();
            for (SysFunction sysFunction : tempSecondList) {
                for (String funcId : userMenuSet) {
                    Integer fId = sysFunction.getfId();
                    if (funcId != null && funcId.equals(String.valueOf(fId))) {
                        secondList.add(sysFunction);
                    }
                }
            }
            for (SysFunction sysFunction : secondList) {

                if (sysFunction != null) {
                    List<SysFunction> thirdList = new ArrayList<SysFunction>();
                    List<SysFunction> tempThirdList = sysFunction.getChild();


                    for (SysFunction function : tempThirdList) {
                        for (String funcId : userMenuSet) {
                            Integer fId = function.getfId();

                            if (funcId != null && funcId.equals(String.valueOf(fId))) {
                                thirdList.add(function);
                            }

                        }
                    }
                    sysFunction.setChild(thirdList);
                }
            }
            sysMenu.setChild(secondList);
            userMenulistResult.add(sysMenu);
        }


        //4、如果sysMenu下面一个二级菜单都没有，此一级菜单也不显示，二级菜单同理
        //注意二级菜单处理方式上和一级菜单的区别
        List<SysMenu> sysMenuListWithoutEmpty = new ArrayList<SysMenu>();
        for (SysMenu sysMenu : userMenulistResult) {
            List<SysFunction> twoSysFunctionList = sysMenu.getChild();
            List<SysFunction> twoMenuList = new ArrayList<SysFunction>();
            //排除一级菜单下为空
            if (twoSysFunctionList != null && twoSysFunctionList.size() > 0) {
                for (SysFunction sysFunction : twoSysFunctionList) {
                    List<SysFunction> threeSysFunctionList = sysFunction.getChild();
                    //有三级菜单的二级菜单
                    if (threeSysFunctionList != null) {
                        if (threeSysFunctionList.size() > 0) {
                            twoMenuList.add(sysFunction);
                        } else if (threeSysFunctionList.size() == 0) {
                            //没有三级菜单的二级菜单，且此二级菜单在根据用户权限排除前就没有三级菜单
                            if (!sb.toString().contains(",".concat(String.valueOf(sysFunction.getfId())).concat(","))) {
                                twoMenuList.add(sysFunction);
                            }
                        }
                    }
                }
            }
            //有二级菜单的一级菜单
            if (twoMenuList.size() > 0) {
                sysMenu.setChild(twoMenuList);
                sysMenuListWithoutEmpty.add(sysMenu);
            }
        }
        return sysMenuListWithoutEmpty;

    }

    @Override
    public List<SysMenu> getAll2(HttpServletRequest request, String locale) {

        //1、获取当前登录用户权限
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        Integer uid = users.getUid();
        //用户菜单权限=该用户所具有权限，不考虑角色表
        //该用户所具有权限
        String userFunctionStr = userFunctionService.getUserFunctionStrById(uid);
        String[] funcIds = userFunctionStr.split(",");
        Set<String> userMenuSet = new HashSet<String>();

        for (String funcId : funcIds) {
            userMenuSet.add(funcId);
        }

        //用一个StringBuffer记录有三级菜单的二级菜单，因为用户如果排除所有三级菜单，
        // 有三级菜单和没有三级菜单的二级菜单难以区分，而没有三级菜单的二级菜单要不显示
        StringBuffer sb = new StringBuffer();

        //2、获取所有菜单
        List<SysMenu> list = sysMenuMapper.getDatagrid();
        for (SysMenu sysMenu : list) {
            if (locale.equals("zh_CN")) {
                sysMenu.setName(sysMenu.getName());
            } else if (locale.equals("en_US")) {
                sysMenu.setName(sysMenu.getName1());
            } else if (locale.equals("zh_tw")) {
                sysMenu.setName(sysMenu.getName2());
            }
            List<SysFunction> list1 = null;
            if (sysMenu.getId() != null) {

                list1 = sysFunctionMapper.getDatagrid(sysMenu
                        .getId().concat("__"));
            }
            for (SysFunction sysFunction : list1) {

                for (String funcId : userMenuSet) {
                    Integer fId = sysFunction.getfId();
                    if (funcId != null && funcId.equals(String.valueOf(fId))) {
                        if (locale.equals("zh_CN")) {
                            sysFunction.setName(sysFunction.getName());
                        } else if (locale.equals("en_US")) {
                            sysFunction.setName(sysFunction.getName1());
                        } else if (locale.equals("zh_TW")) {
                            sysFunction.setName(sysFunction.getName2());
                        }
                        List<SysFunction> list2 = null;
                        if (sysFunction.getId() != null) {

                            list2 = sysFunctionMapper
                                    .childMenu(sysFunction.getId().concat("__"));
                        }
                        for (SysFunction sysFunction2 : list2) {
                            if (locale.equals("zh_CN")) {
                                sysFunction2.setName(sysFunction2.getName());
                            } else if (locale.equals("en_US")) {
                                sysFunction2.setName(sysFunction2.getName1());
                            } else if (locale.equals("zh_TW")) {
                                sysFunction2.setName(sysFunction2.getName2());
                            }
                        }
                        //某二级菜单有三级菜单,把有三级菜单的二级菜单fid拼接为字符串，用，前后分隔。
                        if (list2.size() > 0) {
                            sb.append(",").append(sysFunction.getfId()).append(",");
                        }
                        sysFunction.setChild(list2);
                    }
                }
            }
            sysMenu.setChild(list1);
        }

        //3、将list中的，用户没有的权限给排除了
        List<SysMenu> userMenulistResult = new ArrayList<SysMenu>();
        for (SysMenu sysMenu : list) {
            List<SysFunction> tempSecondList = sysMenu.getChild();
            for (SysFunction sysFunction : tempSecondList) {

                if (sysFunction != null) {
                    List<SysFunction> thirdList = new ArrayList<SysFunction>();
                    List<SysFunction> tempThirdList = sysFunction.getChild();

                    if (tempThirdList != null) {
                        for (SysFunction function : tempThirdList) {
                            for (String funcId : userMenuSet) {
                                Integer fId = function.getfId();

                                if (funcId != null && funcId.equals(String.valueOf(fId))) {
                                    thirdList.add(function);
                                }

                            }
                        }
                    }
                    sysFunction.setChild(thirdList);
                }
            }
            sysMenu.setChild(tempSecondList);
            userMenulistResult.add(sysMenu);
        }


        //4、如果sysMenu下面一个二级菜单都没有，此一级菜单也不显示，二级菜单同理
        //注意二级菜单处理方式上和一级菜单的区别
        List<SysMenu> sysMenuListWithoutEmpty = new ArrayList<SysMenu>();
        for (SysMenu sysMenu : list) {
            List<SysFunction> twoSysFunctionList = sysMenu.getChild();
            List<SysFunction> twoMenuList = new ArrayList<SysFunction>();
            //排除一级菜单下为空
            if (twoSysFunctionList != null && twoSysFunctionList.size() > 0) {
                for (SysFunction sysFunction : twoSysFunctionList) {
                    List<SysFunction> threeSysFunctionList = sysFunction.getChild();
                    //有三级菜单的二级菜单
                    if (threeSysFunctionList != null) {
                        if (threeSysFunctionList.size() > 0) {
                            twoMenuList.add(sysFunction);
                        } else if (threeSysFunctionList.size() == 0) {
                            //没有三级菜单的二级菜单，且此二级菜单在根据用户权限排除前就没有三级菜单
                            if (!sb.toString().contains(",".concat(String.valueOf(sysFunction.getfId())).concat(","))) {
                                twoMenuList.add(sysFunction);
                            }
                        }
                    }
                }
            }
            //有二级菜单的一级菜单
            if (twoMenuList.size() > 0) {
                sysMenu.setChild(twoMenuList);
                sysMenuListWithoutEmpty.add(sysMenu);
            }
        }
        return sysMenuListWithoutEmpty;
    }


    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-19 下午3:43:57
     * 方法介绍:   获取全部菜单
     * 参数说明:   @param request 登录用户
     * 参数说明:   @return
     *
     * @param request
     * @param locale
     * @return List<SysMenu>
     */
    @Override
    public List<SysMenu> getAllWithEmpty(HttpServletRequest request, String locale) {

        //2、获取所有菜单
        List<SysMenu> list = sysMenuMapper.getDatagrid();
        for (SysMenu sysMenu : list) {
            if (locale.equals("zh_CN")) {
                sysMenu.setName(sysMenu.getName());
            } else if (locale.equals("en_US")) {
                sysMenu.setName(sysMenu.getName1());
            } else if (locale.equals("zh_TW")) {
                sysMenu.setName(sysMenu.getName2());
            }
            List<SysFunction> list1 = null;
            if (sysMenu.getId() != null) {

                list1 = sysFunctionMapper.getDatagrid(sysMenu
                        .getId().concat("__"));
            }
            for (SysFunction sysFunction : list1) {
                if (locale.equals("zh_CN")) {
                    sysFunction.setName(sysFunction.getName());
                } else if (locale.equals("en_US")) {
                    sysFunction.setName(sysFunction.getName1());
                } else if (locale.equals("zh_TW")) {
                    sysFunction.setName(sysFunction.getName2());
                }
                List<SysFunction> list2 = null;
                if (sysFunction.getId() != null) {

                    list2 = sysFunctionMapper
                            .childMenu(sysFunction.getId().concat("__"));
                }
                for (SysFunction sysFunction2 : list2) {
                    if (locale.equals("zh_CN")) {
                        sysFunction2.setName(sysFunction2.getName());
                    } else if (locale.equals("en_US")) {
                        sysFunction2.setName(sysFunction2.getName1());
                    } else if (locale.equals("zh_TW")) {
                        sysFunction2.setName(sysFunction2.getName2());
                    }

                }


                sysFunction.setChild(list2);

            }
            sysMenu.setChild(list1);
        }


        return list;
    }

    /**
     * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:44:08 方法介绍: 获取子类菜单 参数说明: @param menuId
     * 参数说明: @return
     *
     * @return List<SysFunction>
     */
    @Override
    public List<SysFunction> getDadMenu(String menuId, String locale) {
        List<SysFunction> list = null;
        if (menuId != null) {

            list = sysFunctionMapper.getDatagrid(menuId.concat("__"));
        }
        for (SysFunction sysFunction : list) {

            if (locale.equals("zh_CN")) {
                sysFunction.setName(sysFunction.getName());
            } else if (locale.equals("en_US")) {
                sysFunction.setName(sysFunction.getName1());
            } else if (locale.equals("zh_TW")) {
                sysFunction.setName(sysFunction.getName2());
            }
            List<SysFunction> list1 = null;
            if (sysFunction.getId() != null) {

                list1 = sysFunctionMapper.childMenu(sysFunction
                        .getId().concat("__"));
            }

            for (SysFunction function : list1) {
                if (locale.equals("zh_CN")) {
                    sysFunction.setName(sysFunction.getName());
                } else if (locale.equals("en_US")) {
                    sysFunction.setName(sysFunction.getName1());
                } else if (locale.equals("zh_TW")) {
                    sysFunction.setName(sysFunction.getName2());
                }
            }

            sysFunction.setChild(list1);
        }
        return list;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 12:50
     * @函数介绍: 修改一级菜单
     * @参数说明: @param SysMenu
     * @return: void
     */
    @Override
    public int updateSysMenu(SysMenu sysMenu) {
        return sysMenuMapper.updateSysMenu(sysMenu);
    }

    /**
     * @param sysMenu
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 13:03
     * @函数介绍: 添加一级菜单
     * @参数说明: @param paramname paramintroduce
     * @return: void
     */
    @Override
    public void addSysMenu(SysMenu sysMenu) {
        sysMenuMapper.addSysMenu(sysMenu);
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 13:16
     * @函数介绍: 删除菜单
     * @参数说明: @param paramname paramintroduce
     * @return: void
     */
    @Override
    public void deleteSysMenu(String id) {
        //根据id长度,判断删除是一级菜单，还是其他菜单
        //一级
        if (id != null && id.trim().length() == 2) {
            sysMenuMapper.deleteSysMenu(id);
            sysFunctionMapper.deleteFunction(id.concat("%"));
        } else {
            sysFunctionMapper.deleteFunction(id.concat("%"));
        }


    }

    /*   作者： 刘佩峰
     *    时间：2017/6/19
     *    函数介绍: 增加菜单
     * */
    @Override
    public ToJson<SysFunction> addFunctionMenu(SysFunction sysFunction, String pfId) {
        ToJson<SysFunction> json = new ToJson<SysFunction>();

        try {
            json.setFlag(1);
            if (StringUtils.checkNull(pfId)) {
                json.setMsg("父ID为空");
                return json;
            }
    /* //查询父类
        SysFunction parfunction = sysFunctionMapper.getParentFunction(pfId);
        //把数据放到Function中去。
        if (parfunction == null) {
            json.setMsg("父菜单不存在");
            return json;
        }*/

            if (sysFunction != null) {
                // TODO: 2017/6/19
                // 根据menuid 拼接 function中的Id
                //（需要查数据库sys_menu 和sys_function）
                String menuId = sysFunction.getId();
                Integer fid = sysFunction.getfId();
                if (fid == null) {
                    json.setMsg("id不存在");
                    return json;
                }
                SysFunction check = sysFunctionMapper.checkFunctionExits(fid);
                if (check != null) {
                    json.setMsg("菜单已经存在");
                    return json;
                }
                String newId = pfId + menuId;
                int exis = sysFunctionMapper.checkIdExists(newId);
                if (exis > 0) {
                    json.setMsg("Id不合法");
                    return json;
                } else {
                    //将function存到数据表 sys_function 中
                    sysFunction.setId(newId);
                    int res = sysFunctionMapper.addFunctionMenu(sysFunction);
                    //判断操作是否成功
                    if (res > 0) {
//                   将信息包装到json中
                        json.setFlag(0);
                        json.setMsg("操作成功");
                        return json;
                    } else {
//                   将错误信息包装到json中
                        json.setMsg("操作失败");
                    }
                }
            } else {
                json.setMsg("参数不足");
                return json;
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 13:59
     * @函数介绍: 添加二级菜单
     * @参数说明: @param SysFunctioni
     * @return: void
     */

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 14:14
     * @函数介绍: 修改二级菜单
     * @参数说明: @param sysFunction
     * @return: void
     **/
    @Override
    public void editSysFunction(SysFunction sysFunction) {
        sysFunctionMapper.editSysFunction(sysFunction);
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 19:37
     * @函数介绍: 查询子菜单
     * @参数说明: @param id
     * @return: List<SysFunction></SysFunction>
     **/
    @Override
    public List<SysFunction> findChildMenu(String id, String locale) {
        List<SysFunction> list = null;

        //查出所有的2级3级菜单
        if (id != null) {
            Map<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("secondId", id.concat("__"));
            hashMap.put("thirdId", id.concat("____"));
            hashMap.put("id", id);
            list = sysFunctionMapper.findChildMenu(hashMap);
        }

        //是否查询的是2级菜单，如果是，把三级菜单放到对应的二级菜单。
        // 如果不是就直接返回多个三级
        boolean isFindSecond = false;

        //把三级菜单放到对应的二级菜单。
        List<SysFunction> secondMenuList = new ArrayList<SysFunction>();
        List<SysFunction> thirdList = new ArrayList<SysFunction>();


        if (list != null && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                //国际化,处理方法是，判断如果是美国，就用英文名字覆盖name,即name1覆盖name
                if ("zh_CN".equals(locale)) {
                    list.get(i).setName(list.get(i).getName());
                } else if ("en_US".equals(locale)) {
                    list.get(i).setName(list.get(i).getName1());
                } else if ("zh_TW".equals(locale)) {
                    list.get(i).setName(list.get(i).getName2());
                }

                SysFunction sysFunction = list.get(i);
                if (sysFunction.getId().length() == 4) {
                    //查询的是2级
                    isFindSecond = true;
                    secondMenuList.add(sysFunction);
                } else if (sysFunction.getId().length() == 6) {
                    thirdList.add(sysFunction);
                }
            }
        }


        if (secondMenuList.size() > 0) {
            for (int i = 0; i < secondMenuList.size(); i++) {
                secondMenuList.get(i).setChild(new ArrayList<SysFunction>());
                for (int j = 0; j < thirdList.size(); j++) {
                    String thirdMenuId = thirdList.get(j).getId().substring(0, 4);
                    String theSecondMenuId = secondMenuList.get(i).getId();
                    if (theSecondMenuId != null && theSecondMenuId.equals(thirdMenuId)) {
                        secondMenuList.get(i).getChild().add(thirdList.get(j));
                    }
                }
            }
        }


        if (isFindSecond) {
            return secondMenuList;
        } else {
            return list;
        }

    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 19:37
     * @函数介绍: 根据id查一级菜单
     * @参数说明: @param Stirng
     * @return: List<SysMenu></SysMenu>
     **/
    @Override
    public List<SysMenu> getTheFirstMenu(String id, String locale) {

        if (id != null) {
            List<SysMenu> list = sysMenuMapper.getTheFirstMenu(id);
            if (list != null) {
                for (int i = 0; i < list.size(); i++) {
                    //国际化,处理方法是，判断如果是美国，就用英文名字覆盖name,即name1覆盖name
                    if ("zh_CN".equals(locale)) {
                        list.get(i).setName(list.get(i).getName());
                    } else if ("en_US".equals(locale)) {
                        list.get(i).setName(list.get(i).getName1());
                    } else if ("zh_TW".equals(locale)) {
                        list.get(i).setName(list.get(i).getName2());
                    }
                }
            }

            return list;
        }
        return null;
    }

    /* 作者： 刘佩峰
     *  时间： 6/20
     * */
    @Override
    public ToJson<Integer> findMaxId() {
        ToJson<Integer> json = new ToJson<Integer>();
        try {
            json.setFlag(1);
            //查询数据库中最大的一个FUNC_ID
            int maxId = sysFunctionMapper.getMaxId();
            //当用户输入id时 如果小于1000则给出提示
            if (maxId < 1000) {
                json.setObject(1001);
                json.setMsg("子菜单项ID必须大于1000");
            } else {
                json.setObject(maxId + 1);
            }
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;

    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/5/26 19:37
     * @函数介绍: 查询子菜单, 根据用户权限
     * @参数说明: @param id
     * @return: List<SysFunction></SysFunction>
     **/
    @Override
    public List<SysFunction> getMenus(HttpServletRequest request, String id, String locale) {
        List<SysFunction> list1 = null;

        //查出所以的2级3级菜单
        if (id != null) {
            Map<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("secondId", id.concat("__"));
            hashMap.put("thirdId", id.concat("____"));
            hashMap.put("id", id);
            list1 = sysFunctionMapper.findChildMenu(hashMap);
        }

        //用户有权限的
        List<SysFunction> list = new ArrayList<SysFunction>();

        //用户权限排除没有权限的菜单
        //从session中获得user信息

        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        //获得用户的id
        String user_id = users.getUserId();

        /* String user_id = "admin";*/
        String userFunctionStr = userFunctionService.getUserFunctionStr(user_id);

        String[] funcId = userFunctionStr.split(",");


        //如果该用户有这个菜单权限就放到list.

        for (String fid : funcId) {

            for (SysFunction sysFunction : list1) {

                Integer dbFid = sysFunction.getfId();

                //用户有权限的id和数据库查询的所有
                if (String.valueOf(dbFid).equals(fid)) {
                    list.add(sysFunction);
                }
            }
        }


        //是否查询的是2级菜单，如果是，把三级菜单放到对应的二级菜单。
        // 如果不是就直接返回多个三级
        boolean isFindSecond = false;

        //把三级菜单放到对应的二级菜单。
        List<SysFunction> secondMenuList = new ArrayList<SysFunction>();
        List<SysFunction> thirdList = new ArrayList<SysFunction>();


        if (list != null && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                //国际化,处理方法是，判断如果是美国，就用英文名字覆盖name,即name1覆盖name
                if ("zh_CN".equals(locale)) {
                    list.get(i).setName(list.get(i).getName());
                } else if ("en_US".equals(locale)) {
                    list.get(i).setName(list.get(i).getName1());
                } else if ("zh_TW".equals(locale)) {
                    list.get(i).setName(list.get(i).getName2());
                }

                SysFunction sysFunction = list.get(i);
                if (sysFunction.getId().length() == 4) {
                    //查询的是2级
                    isFindSecond = true;
                    secondMenuList.add(sysFunction);
                } else if (sysFunction.getId().length() == 6) {
                    thirdList.add(sysFunction);
                }
            }
        }


        if (secondMenuList.size() > 0) {
            for (int i = 0; i < secondMenuList.size(); i++) {
                secondMenuList.get(i).setChild(new ArrayList<SysFunction>());
                for (int j = 0; j < thirdList.size(); j++) {
                    String thirdMenuId = thirdList.get(j).getId().substring(0, 4);
                    String theSecondMenuId = secondMenuList.get(i).getId();
                    if (theSecondMenuId != null && theSecondMenuId.equals(thirdMenuId)) {
                        secondMenuList.get(i).getChild().add(thirdList.get(j));
                    }
                }
            }
        }


        if (isFindSecond) {
            return secondMenuList;
        } else {
            return list;
        }

    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/26 14:06
     * @函数介绍: 查询所有菜单，不考虑权限
     * @参数说明: @param request
     * @参数说明: @param zh_cn 国际化
     * @return: XXType(value introduce)
     */
    @Override
    public List<SysMenu> getAllMenu(HttpServletRequest request, String locale) {


        List<SysMenu> list = sysMenuMapper.getDatagrid();

        //优化查询所有菜单时不要在循环中查询
        List<SysFunction> sysFunctionList = sysFunctionMapper.getAll();
        for (SysMenu sysMenu : list) {
            if (locale.equals("zh_CN")) {
                sysMenu.setName(sysMenu.getName());
            } else if (locale.equals("en_US")) {
                sysMenu.setName(sysMenu.getName1());
            } else if (locale.equals("zh_TW")) {
                sysMenu.setName(sysMenu.getName2());
            }
            List<SysFunction> list1 = null;
            if (sysMenu.getId() != null) {

                list1 = sysFunctionList.stream().filter(s -> s.getId().length() == 4).filter(s -> s.getId().startsWith(sysMenu.getId())).collect(Collectors.toList());
                /*list1 = sysFunctionMapper.getDatagrid(sysMenu
                        .getId().concat("__"));*/
            }
            for (SysFunction sysFunction : list1) {
                if (locale.equals("zh_CN")) {
                    sysFunction.setName(sysFunction.getName());
                } else if (locale.equals("en_US")) {
                    sysFunction.setName(sysFunction.getName1());
                } else if (locale.equals("zh_TW")) {
                    sysFunction.setName(sysFunction.getName2());
                }
                List<SysFunction> list2 = null;
                if (sysFunction.getId() != null) {

                    list2 = sysFunctionList.stream().filter(s -> s.getId().length() == 6).filter(s -> s.getId().startsWith(sysFunction.getId())).collect(Collectors.toList());
                    /*list2 = sysFunctionMapper
                            .childMenu(sysFunction.getId().concat("__"));*/
                }
                for (SysFunction sysFunction2 : list2) {
                    if (locale.equals("zh_CN")) {
                        sysFunction2.setName(sysFunction2.getName());
                    } else if (locale.equals("en_US")) {
                        sysFunction2.setName(sysFunction2.getName1());
                    } else if (locale.equals("zh_TW")) {
                        sysFunction2.setName(sysFunction2.getName2());
                    }

                }
                sysFunction.setChild(list2);

            }
            sysMenu.setChild(list1);
        }


        return list;

    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月27日 下午14:29:22
     * 方法介绍:   根据子菜单名称进行模糊查询
     * 参数说明:   @param funName
     * 参数说明:
     *
     * @return List<SysFunction>  返回子菜单信息
     */
    public List<SysFunction> getSysFunctionByName(String funName) {
        return sysFunctionMapper.getSysFunctionByName(funName);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月27日 下午14:30:12
     * 方法介绍:   根据子菜单名称进行模糊查询获取符合的数量
     * 参数说明:   @param funName
     * 参数说明:
     *
     * @return List<SysFunction>  查询数
     */
    public int getCountSysFunctionByName(String funName) {
        return sysFunctionMapper.getCountSysFunctionByName(funName);
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-6-27 下午14:13:57
     * 方法介绍:   获取当前用户权限15个二级菜单
     * 参数说明:
     * 参数说明:   @return
     *
     * @return List<SysFunction>
     */

    @Override
    public List<SysFunction> getPriMenu(HttpServletRequest request, String locale) {
        List<SysFunction> sysFunctionList = new ArrayList<SysFunction>();
        List<SysFunction> child = new ArrayList<SysFunction>();
        //获得当前用户的所有菜单
        List<SysMenu> sysMenus = this.getAll(request, locale);
        //遍历一级菜单
        for (SysMenu sysMenu : sysMenus) {
            //得到二级应用（其中含有二级菜单）
            child = sysMenu.getChild();
            //遍历二级应用（二级菜单）
            for (SysFunction sysFunction : child) {
                //判断国际化 name至返回一个字段
                if (locale.equals("zh_CN")) {
                    sysFunction.setName(sysFunction.getName());
                    sysFunction.setName1(null);
                    sysFunction.setName2(null);
                    sysFunction.setName3(null);
                    sysFunction.setName4(null);
                    sysFunction.setName5(null);
                } else if (locale.equals("en_US")) {
                    sysFunction.setName(sysFunction.getName1());
                    sysFunction.setName1(null);
                    sysFunction.setName2(null);
                    sysFunction.setName3(null);
                    sysFunction.setName4(null);
                    sysFunction.setName5(null);
                } else if (locale.equals("zh_TW")) {
                    sysFunction.setName(sysFunction.getName2());
                    sysFunction.setName1(null);
                    sysFunction.setName2(null);
                    sysFunction.setName3(null);
                    sysFunction.setName4(null);
                    sysFunction.setName5(null);
                }
                //判断是不是二级菜单,如果是则添加二级菜单下面的应用
                if (sysFunction.getChild().size() == 0) {
                    //限制二级菜单数量小于等于15个
                    if (sysFunctionList.size() < 15) {

                        sysFunctionList.add(sysFunction);
                    }
                } else {

                    //如果不是则直接添加即可
                    List<SysFunction> threeChildList = sysFunction.getChild();
                    for (SysFunction function : threeChildList) {
                        //判断国际化 name至返回一个字段
                        if (locale.equals("zh_CN")) {
                            function.setName(function.getName());
                            function.setName1(null);
                            function.setName2(null);
                            function.setName3(null);
                            function.setName4(null);
                            function.setName5(null);
                        } else if (locale.equals("en_US")) {
                            function.setName(function.getName1());
                            function.setName1(null);
                            function.setName2(null);
                            function.setName3(null);
                            function.setName4(null);
                            function.setName5(null);
                        } else if (locale.equals("zh_TW")) {
                            function.setName(function.getName2());
                            function.setName1(null);
                            function.setName2(null);
                            function.setName3(null);
                            function.setName4(null);
                            function.setName5(null);
                        }
                        //限制二级菜单数量小于等于15个
                        if (sysFunctionList.size() < 15) {
                            sysFunctionList.add(function);
                        }
                    }
                }
            }

        }
        return sysFunctionList;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-6-30 下午16:50:57
     * 方法介绍:   获得错误子菜单
     *
     * @return json
     */

    @Override
    public ToJson<List<SysFunction>> getErrMenu() {
        //获取所有的sysFunction菜单，比较 不过和上面获取的二三级菜单不同的说明是错误菜单。
        //声明一个空的集合用来存放主菜单下面的子菜单。
        List<SysFunction> list = new ArrayList<SysFunction>();
        //声明一个空的集合用来存放错误菜单。
        List<SysFunction> errlist = new ArrayList<SysFunction>();
        ToJson<List<SysFunction>> json = new ToJson<List<SysFunction>>();

        try {


            //先获取到所有的主菜单
            List<SysMenu> sysMenus = sysMenuMapper.getDatagrid();
            //遍历所有的主菜单获得主菜单ID 通过id去查所有的二级三级菜单
            for (SysMenu sysMenu : sysMenus) {
                List<SysFunction> someChildMenu = sysFunctionMapper.getSomeChildMenu(sysMenu.getId());
                //遍历子菜单
                for (SysFunction sysFunction : someChildMenu) {
                    list.add(sysFunction);
                }
            }

            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < list.size(); i++) {
                String id = list.get(i).getId();
                sb.append(",").append(id).append(",");
            }


            //获得数据库中所有的子菜单
            List<SysFunction> allMenu = sysFunctionMapper.getAll();
            for (int i = 0; i < allMenu.size(); i++) {
                String id = allMenu.get(i).getId();
                if (!sb.toString().contains("," + id + ",")) {
                    errlist.add(allMenu.get(i));
                }
            }
            if (errlist != null) {
                json.setMsg("Ok");
                json.setObject(errlist);
                json.setFlag(0);
            } else {
                errlist = new ArrayList<SysFunction>();
                json.setObject(errlist);
            }

        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * 创建作者:   韩成冰
     * 创建日期:   2017-7-3 上午10：34
     * 方法介绍:   菜单恢复
     *
     * @return json
     */

    @Override
    public ToJson<Object> recoverMenu(HttpServletRequest request, String path) {
        //通过session获取到数据库名字
        String sqlType = "xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ToJson<Object> json = new ToJson<Object>();
        OutputStream os = null;
        OutputStreamWriter writer = null;
        try {
            String username = DBPropertiesUtils.getDbMsg(request).get("username");//用户名
            String password = DBPropertiesUtils.getDbMsg(request).get("password");//密码
            String host = DBPropertiesUtils.getDbMsg(request).get("ip");//导入的目标数据库所在的主机
            //获取项目项目路径
            String realPath = request.getSession().getServletContext().getRealPath("/");
            String Topath = realPath + "\\ui\\lib";
            String loginCommand = new StringBuffer().append("/usr/local/mysql/bin/mysql -u").append(username).append(" -p").append(password).append(" -h").append(host).toString();
            //第二步，获取切换数据库到目标数据库的命令语句
            String switchCommand = new StringBuffer("use ").append(sqlType).toString();
            //第三步，设置编码格式。
            String charsetCommand = new StringBuffer("set names utf8;").toString();
            //第四步，获取导入的命令语句
            String importCommand = new StringBuffer("source ").append(path).toString();
            //需要返回的命令语句数组
            String[] commands = new String[]{loginCommand, switchCommand, charsetCommand, importCommand};

            Runtime runtime = Runtime.getRuntime();

            Process process = runtime.exec(commands[0]);

            //执行了第一条命令以后已经登录到mysql了，所以之后就是利用mysql的命令窗口
            //进程执行后面的代码
            os = process.getOutputStream();
            writer = new OutputStreamWriter(os);
            //执行命令行
            writer.write(commands[1] + "\r\n");
            writer.flush();
            Thread.sleep(300);
            writer.write(commands[2] + "\r\n");
            Thread.sleep(300);
            writer.flush();
            writer.write(commands[3]);
            Thread.sleep(300);

            json.setFlag(0);
            json.setMsg("ok");
            writer.flush();


        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        } finally {
            IOUtils.closeQuietly(writer);
            IOUtils.closeQuietly(os);
            try {
                //删除上传的暂存sql
                File file = new File(path);
                file.delete();
            } catch (Exception e) {

            }

        }


        return json;
    }

    /**
     * 创建作者:   韩成冰
     * 创建日期:   2017-7-3 上午18：34
     * 方法介绍:   菜单导出
     *
     * @return
     */
    @Override
    public void exportMenu(HttpServletRequest request, HttpServletResponse response) {
        //通过session获取到数据库名字
        String sqlType = "xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ToJson<Object> json = new ToJson<Object>(0, "ok");
        String exportPath = null;
        String fileName = null;

        //获取项目项目路径
        String realPath = request.getSession().getServletContext().getRealPath("/");
        String username = DBPropertiesUtils.getDbMsg(request).get("username");//用户名
        String password = DBPropertiesUtils.getDbMsg(request).get("password");//密码
        String host = DBPropertiesUtils.getDbMsg(request).get("ip");//导入的目标数据库所在的主机
        //String exportDatabaseName = "xoa1001";//导入的目标数据库的名称
        String tablename = "sys_menu sys_function";//表名
        //String importPath = "C:\\sys_menu.sql";//导入的目标文件所在的位置
        exportPath = realPath;//导出路径
        fileName = "menu.sql";
        //注意哪些地方要空格，哪些不要空格
        String path = exportPath + "\\ui\\lib";
        String[] command = new String[]{"/bin/sh ", "-c ", "/usr/bin/mysqldump" + " -h" + host + " -u" + username + " -p" + password, sqlType + " " + tablename + " -r" + exportPath};

        File file = new File(exportPath + fileName);
        try (FileInputStream fis = new FileInputStream(file); BufferedInputStream bis = new BufferedInputStream(fis); OutputStream os = response.getOutputStream();) {
            Process runtimeProcess = Runtime.getRuntime().exec(command);
            int processComplete = runtimeProcess.waitFor();
            Thread.sleep(300);
            if (file.exists()) {
                response.setContentType("application/force-download");// 设置强制下载不打开
                response.addHeader("Content-Disposition",
                        "attachment;fileName=" + fileName);// 设置文件名
                byte[] buffer = new byte[1024];
                int i = bis.read(buffer);
                while (i != -1) {
                    os.write(buffer, 0, i);
                    i = bis.read(buffer);
                }
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        } finally {
            try {
                Thread.sleep(300);
                File file1 = new File(exportPath + fileName);
                Thread.sleep(300);
                if (file1.exists()) {
                    file1.delete();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }


    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/4 15:25
     * @函数介绍: 菜单设置
     * @参数说明: TOP_MENU_NUM 快捷菜单栏每行显示的个数
     * MENU_GROUP 菜单快捷组 0代表打勾 1代表未选中
     * MENU_WINEXE 显示windows 快捷组
     * MENU_URL    显示常用地址
     * MENU_EXPAND_SINGLE  同时只能展开一个菜单
     * @return: json
     */
    @Override
    public ToJson<Object> editMenuPara(SysParaExtend sysParaExtend) {


        ToJson<Object> json = new ToJson<Object>();
        //把接收到的三个参数拼到一个接口中去保存。


        try {
            if (sysParaExtend != null) {


                String menuQuickGroup = sysParaExtend.getMenuQuickGroup();
                String menuWinexe = sysParaExtend.getMenuWinexe();
                String menuUrl = sysParaExtend.getMenuUrl();
                String menuExpandSingle = sysParaExtend.getMenuExpandSingle();
                String topMenuNum = sysParaExtend.getTopMenuNum();

                String menu_Display = "";
                if (menuQuickGroup != null && menuQuickGroup != "") {
                    menu_Display = menu_Display + "," + menuQuickGroup;
                }
                if (menuWinexe != null && menuWinexe != "") {
                    menu_Display = menu_Display + "," + menuWinexe;
                }
                if (menuUrl != null && menuUrl != "") {
                    menu_Display = menu_Display + "," + menuUrl;
                }
                SysPara sysPara1 = new SysPara();
                SysPara sysPara2 = new SysPara();
                SysPara sysPara3 = new SysPara();
                sysPara1.setParaName("TOP_MENU_NUM");
                sysPara1.setParaValue(topMenuNum);
                sysPara2.setParaName("MENU_DISPLAY");
                sysPara2.setParaValue(menu_Display);
                sysPara3.setParaName("MENU_EXPAND_SINGLE");
                sysPara3.setParaValue(menuExpandSingle);

                sysParaService.updateSysPara(sysPara1);
                sysParaService.updateSysPara(sysPara2);
                sysParaService.updateSysPara(sysPara3);
                json.setMsg("修改成功");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("修改失败");
            e.printStackTrace();
        }
        return json;
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/4 17:22
     * @函数介绍: 查询菜单设置内容
     * @参数说明:
     * @return: json
     */

    @Override
    public ToJson<SysParaExtend> getParaInfo() {
        SysParaExtend sysParaExtend = new SysParaExtend();
        ToJson<SysParaExtend> json = new ToJson<SysParaExtend>();
        try {
            SysPara sysPara1 = new SysPara();
            SysPara sysPara2 = new SysPara();
            SysPara sysPara3 = new SysPara();
            sysPara1.setParaName("TOP_MENU_NUM");
            sysPara2.setParaName("MENU_DISPLAY");
            sysPara3.setParaName("MENU_EXPAND_SINGLE");

            List<SysPara> top_menu_num = sysParaService.getTheSysParam("TOP_MENU_NUM");
            List<SysPara> menu_display = sysParaService.getTheSysParam("MENU_DISPLAY");
            List<SysPara> menu_expand_single = sysParaService.getTheSysParam("MENU_EXPAND_SINGLE");
            sysParaExtend.setTopMenuNum(top_menu_num.get(0).getParaValue());
            String paraValue = menu_display.get(0).getParaValue();
            String[] split = paraValue.split(",");
            String MENU_QUICKGROUP = null;
            String MENU_WINEXE = null;
            String MENU_URL = null;
            for (String s : split) {
                if (s.equals("menuQuickGroup")) {
                    MENU_QUICKGROUP = s;
                }
                if (s.equals("menuWinexe")) {
                    MENU_WINEXE = s;
                }
                if (s.equals("menuUrl")) {
                    MENU_URL = s;
                }
            }
            sysParaExtend.setMenuQuickGroup(MENU_QUICKGROUP);
            sysParaExtend.setMenuWinexe(MENU_WINEXE);
            sysParaExtend.setMenuUrl(MENU_URL);
            sysParaExtend.setMenuExpandSingle(menu_expand_single.get(0).getParaValue());
            json.setObject(sysParaExtend);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setObject(sysParaExtend);
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/7/11 13:22
     * @函数介绍: 根据fid查Sysfuntion
     * @参数说明: fid
     * @return: SysFunction
     */
    @Override
    public SysFunction getSysFunctionByFid(Integer fid) {

        return sysFunctionMapper.getSysFunctionByFid(fid);
    }


    /**
     * 加密
     *
     * @param srcStr
     * @param charset
     * @param sKey
     * @return
     */
    public static String encrypt(String srcStr, Charset charset, String sKey) {
        byte[] src = srcStr.getBytes(charset);
        byte[] buf = encrypt(src, sKey);
        return parseByte2HexStr(buf);
    }

    /**
     * 加密
     *
     * @param data
     * @param sKey
     * @return
     */
    public static byte[] encrypt(byte[] data, String sKey) {
        try {
            byte[] key = sKey.getBytes();
            // 初始化向量
            IvParameterSpec iv = new IvParameterSpec(key);
            DESKeySpec desKey = new DESKeySpec(key);
            // 创建一个密匙工厂，然后用它把DESKeySpec转换成securekey
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            SecretKey securekey = keyFactory.generateSecret(desKey);
            // Cipher对象实际完成加密操作
            Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
            // 用密匙初始化Cipher对象
            cipher.init(Cipher.ENCRYPT_MODE, securekey, iv);
            // 现在，获取数据并加密
            // 正式执行加密操作
            return cipher.doFinal(data);
        } catch (Throwable e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 将二进制转换成16进制
     *
     * @param buf
     * @return
     */
    public static String parseByte2HexStr(byte buf[]) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < buf.length; i++) {
            String hex = Integer.toHexString(buf[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }
            sb.append(hex.toUpperCase());
        }
        return sb.toString();
    }

    /**
     * 将16进制转换为二进制
     *
     * @param hexStr
     * @return
     */
    public static byte[] parseHexStr2Byte(String hexStr) {
        if (hexStr.length() < 1)
            return null;
        byte[] result = new byte[hexStr.length() / 2];
        for (int i = 0; i < hexStr.length() / 2; i++) {
            int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
            int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2), 16);
            result[i] = (byte) (high * 16 + low);
        }
        return result;
    }

    @Override
    public ToJson<SysFunction> getUsuallyMenu(HttpServletRequest request) {
        ToJson<SysFunction> json = new ToJson<SysFunction>();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        Users usersByuserId = usersService.findUsersByuserId(users.getUserId());
        List<SysFunction> sysFunctions = new ArrayList<>();
        if(usersByuserId.getShortcut()!=null&&usersByuserId.getShortcut()!=""){
            String[] split = usersByuserId.getShortcut().split(",");
            for (String sp:split) {
                SysFunction sysFunction = sysFunctionMapper.checkFunctionExits(Integer.parseInt(sp));
                if(sysFunction!=null){
                    sysFunctions.add(sysFunction);
                }
            }}
        if(sysFunctions.size()>0){
            for (SysFunction sysFunction : sysFunctions) {
                if (locale.equals("zh_CN")) {
                    sysFunction.setName(sysFunction.getName());
                } else if (locale.equals("en_US")) {
                    sysFunction.setName(sysFunction.getName1());
                } else if (locale.equals("zh_TW")) {
                    sysFunction.setName(sysFunction.getName2());
                }
            }
            json.setObj(sysFunctions);
        }
        json.setMsg("ok");
        json.setFlag(0);
        return json;
    }

    @Override
    public ToJson<SysMenu> queryAllMenu(HttpServletRequest request, String locale) {

        ToJson<SysMenu> menuJson = new ToJson<SysMenu>(1, "err");

        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);

            List<Integer> funcIds = userPrivTypeService.getPrivTypeFuncIds(users);
            if(funcIds.size() == 1 && funcIds.get(0) == 0){
                menuJson.setFlag(0);
                menuJson.setMsg("无角色分类");
                return menuJson;
            }

            List<SysMenu> list = sysMenuMapper.getDatagrid();
            for (SysMenu sysMenu : list) {
                String menuId = sysMenu.getId();
                if(funcIds.size() > 0 && !funcIds.contains(sysMenu.getId())){
                    sysMenu.setId("");
                }
                if (locale.equals("zh_CN")) {
                    sysMenu.setName(sysMenu.getName());
                } else if (locale.equals("en_US")) {
                    sysMenu.setName(sysMenu.getName1());
                } else if (locale.equals("zh_TW")) {
                    sysMenu.setName(sysMenu.getName2());
                }
                List<SysFunction> list1 = null;
                if (sysMenu.getId() != null) {

                    list1 = sysFunctionMapper.getDatagrid(menuId.concat("__"));
                }
                for (SysFunction sysFunction : list1) {
                    String functionId = sysFunction.getId();
                    if(funcIds.size() > 0 && !funcIds.contains(sysFunction.getfId())){
                        sysFunction.setId("");
                        sysFunction.setfId(0);
                    }
                    if (locale.equals("zh_CN")) {
                        sysFunction.setName(sysFunction.getName());
                    } else if (locale.equals("en_US")) {
                        sysFunction.setName(sysFunction.getName1());
                    } else if (locale.equals("zh_TW")) {
                        sysFunction.setName(sysFunction.getName2());
                    }
                    List<SysFunction> list2 = null;
                    if (sysFunction.getId() != null) {

                        list2 = sysFunctionMapper
                                .childMenu(functionId.concat("__"));
                    }
                    for (SysFunction sysFunction2 : list2) {
                        if(funcIds.size() > 0 && !funcIds.contains(sysFunction2.getfId())){
                            sysFunction2.setId("");
                            sysFunction2.setfId(0);
                        }
                        if (locale.equals("zh_CN")) {
                            sysFunction2.setName(sysFunction2.getName());
                        } else if (locale.equals("en_US")) {
                            sysFunction2.setName(sysFunction2.getName1());
                        } else if (locale.equals("zh_TW")) {
                            sysFunction2.setName(sysFunction2.getName2());
                        }

                    }
                    sysFunction.setChild(list2);

                }
                sysMenu.setChild(list1);
            }
            menuJson.setFlag(0);
            menuJson.setMsg("ok");
            menuJson.setObj(list);
        }catch (Exception e){
            menuJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return menuJson;
    }

}
