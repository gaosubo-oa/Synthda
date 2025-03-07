package com.xoa.service.sysMenuH5;

import com.xoa.dao.sysMenuH5.SysMenuH5Mapper;
import com.xoa.dao.users.UserFunctionMapper;
import com.xoa.model.sysMenuH5.SysMenuH5;
import com.xoa.model.users.UserFunction;
import com.xoa.model.users.Users;
import com.xoa.util.CookiesUtil;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SysMenuH5Service {


    @Resource
    SysMenuH5Mapper sysMenuH5Mapper;

    @Resource
    UserFunctionMapper userFunctionMapper;

    // 添加接口
    public BaseWrapper addMenu(SysMenuH5 sysMenuH5) {
        BaseWrapper baseWrapper = new BaseWrapper();

        sysMenuH5.setIsSystem("2");
        sysMenuH5.setOpenStatus("0");
        sysMenuH5Mapper.insertSelective(sysMenuH5);
        baseWrapper.setFlag(true);
        baseWrapper.setCode("0");
        baseWrapper.setMsg("ok");
        return baseWrapper;

    }

    // 更新接口
    public BaseWrapper updateMenu(SysMenuH5 sysMenuH5) {
        BaseWrapper baseWrapper = new BaseWrapper();
        sysMenuH5Mapper.updateByPrimaryKeySelective(sysMenuH5);
        baseWrapper.setFlag(true);
        baseWrapper.setCode("0");
        baseWrapper.setMsg("ok");

        return baseWrapper;

    }

    // 根据id查询接口
    public BaseWrapper selectMenuById(Integer menuId) {
        BaseWrapper baseWrapper = new BaseWrapper();
        SysMenuH5 sysMenuH5 = sysMenuH5Mapper.selectByPrimaryKey(menuId);

        baseWrapper.setData(sysMenuH5);
        baseWrapper.setFlag(true);
        baseWrapper.setCode("0");
        baseWrapper.setMsg("ok");

        return baseWrapper;

    }

    // 批量删除接口
    public BaseWrapper deleteMenu(String menuIds) {
        BaseWrapper baseWrapper = new BaseWrapper();

        if (!StringUtils.checkNull(menuIds)) {
            sysMenuH5Mapper.deleteMenusByIds(menuIds.split(","));
        }

        baseWrapper.setFlag(true);
        baseWrapper.setCode("0");
        baseWrapper.setMsg("ok");
        return baseWrapper;

    }

    // 多条件查询接口
    public BaseWrapper selectMenus(SysMenuH5 sysMenuH5, PageParams pageParams) {
        BaseWrapper baseWrapper = new BaseWrapper();

        Map<String, Object> map = new HashMap<>();
        map.put("menuName", sysMenuH5.getMenuName());
        map.put("page", pageParams);

        List<SysMenuH5> sysMenuH5s = sysMenuH5Mapper.selectMenus(map);

        baseWrapper.setData(sysMenuH5s);
        baseWrapper.setFlag(true);
        baseWrapper.setCode("0");
        baseWrapper.setMsg("ok");
        baseWrapper.setTotleNum(pageParams.getTotal());
        return baseWrapper;

    }

    // 获取H5主页面menu根据权限
    public BaseWrapper showH5Menus(HttpServletRequest request,String portalGroupType) {
        BaseWrapper baseWrapper = new BaseWrapper();

        Cookie redisSessionCookie1 = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie1);

        UserFunction menuByUserId = userFunctionMapper.getMenuByUserId(users.getUid());

        List<SysMenuH5> menus = new ArrayList<>();



        if (menuByUserId != null && !StringUtils.checkNull(menuByUserId.getUserFunCidStr())) {

            String[] ids = menuByUserId.getUserFunCidStr().split(",");

            Map<String,SysMenuH5> h5Map = new HashMap<>();

            List<SysMenuH5> sysMenuH5s = sysMenuH5Mapper.selectOpenMenus(portalGroupType);

            // 判断是否是管理员
            if(users.getUserPriv()!=null&&users.getUserPriv()==1){
                menus = sysMenuH5s;
            } else {
                // 生成map
                // 和无关联菜单权限直接允许
                for (SysMenuH5 sysMenuH5:sysMenuH5s) {
                    if(sysMenuH5.getMenuPcId()!=null&&sysMenuH5.getMenuPcId()!=0){
                        h5Map.put(sysMenuH5.getMenuPcId().toString(),sysMenuH5);
                    } else {
                        menus.add(sysMenuH5);
                    }

                }

                // 判断是否有权限
                for (int i = 0, length = ids.length; i < length; i++) {
                    if(!StringUtils.checkNull(ids[i]))
                        if(h5Map.get(ids[i])!=null)
                            menus.add(h5Map.get(ids[i]));
                }


                // 排序
                if(menus.size()>0)
                menus.sort((o1, o2) -> {
                    if(o1!=null&&o2!=null)
                    if (!StringUtils.checkNull(o1.getSortNo()) && !StringUtils.checkNull(o2.getSortNo())) {
                        return Integer.parseInt(o1.getSortNo()) - Integer.parseInt(o2.getSortNo());
                    }
                    return 0;
                });
            }


        }

        baseWrapper.setData(menus);
        baseWrapper.setFlag(true);

        return baseWrapper;
    }



}
