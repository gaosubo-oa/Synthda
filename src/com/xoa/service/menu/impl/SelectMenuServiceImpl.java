package com.xoa.service.menu.impl;

import com.xoa.dao.menu.SysFunctionMapper;
import com.xoa.dao.menu.SysMenuMapper;
import com.xoa.model.menu.SysFunction;
import com.xoa.model.menu.SysMenu;
import com.xoa.service.menu.SelectMenuService;
import com.xoa.util.common.wrapper.BaseWrappers;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by liu on 2017/6/21.
 * 作者：刘佩峰
 * 时间：2017/6/21
 */
@Transactional
@Service
public class SelectMenuServiceImpl implements SelectMenuService {
    @Resource
    private SysMenuMapper sysMenuMapper;// 父类菜单DAO
    @Resource
    private SysFunctionMapper sysFunctionMapper;// 子类菜单DAO

    @Override
    public BaseWrappers getAll(String locale) {
        BaseWrappers baseWrappers =new BaseWrappers();
        baseWrappers.setStatus(true);
        baseWrappers.setFlag(false);
         //获取menu
        List<SysMenu> menus = sysMenuMapper.getDatagrid();
        List<SysFunction> newFunctions =new ArrayList<SysFunction>();
          //获取二级菜单  function
        List<SysFunction> functions = sysFunctionMapper.getAll();
        if(menus==null){
            baseWrappers.setMsg("没有数据");
            return baseWrappers;
        }else{
         for(SysMenu menu:menus){
             SysFunction function =new SysFunction();
             function.setId(menu.getId());
             function.setExt(menu.getExt());
             function.setName(menu.getName());
             if (locale.equals("zh_CN")) {
                 function.setName(menu.getName());
             } else if (locale.equals("en_US")) {
                 function.setName(menu.getName1());
             } else if (locale.equals("zh_TW")) {
                 function.setName(menu.getName2());
             }
             function.setName1(menu.getName1());
             function.setName2(menu.getName2());
             function.setName3(menu.getName3());
             function.setName4(menu.getName4());
             function.setName5(menu.getName5());

             List<SysFunction> list1 = null;
             if (function.getId() != null) {
                 //获取二级菜单
                 list1 = sysFunctionMapper.getDatagrid(function
                         .getId().concat("__"));
                 if(!list1.isEmpty()){
                     for (SysFunction sysFunction : list1) {
                         if (locale.equals("zh_CN")) {
                             sysFunction.setName(sysFunction.getName());
                         } else if (locale.equals("en_US")) {
                             sysFunction.setName(sysFunction.getName1());
                         } else if (locale.equals("zh_TW")) {
                             sysFunction.setName(sysFunction.getName2());
                         }
                     }
                 }
             }
             function.setChild(list1);
             newFunctions.add(function);
         }
        }

        if(functions==null){
            baseWrappers.setFlag(true);
            baseWrappers.setMsg("没有合适的子菜单");
            baseWrappers.setDatas(newFunctions);
            return baseWrappers;
        }
    /*    for(SysFunction function:functions){
            newFunctions.add(function);
           *//*   String coreStr= function.getUrl();
              if(!StringUtils.checkNull(coreStr)){
                  if(coreStr.trim().startsWith("@")){
                      newFunctions.add(function);
                  }
              }*//*
        }*/
        //在把menu 和 function进行组装在一起
       // List<SysFunction> resultData = queryByMenuId(2,newFunctions,"");
        if(newFunctions!=null){
            baseWrappers.setFlag(true);
            baseWrappers.setMsg("");
            baseWrappers.setDatas(newFunctions);

        }else{
            baseWrappers.setFlag(false);
            baseWrappers.setMsg("");
            baseWrappers.setDatas(newFunctions);
        }
        return baseWrappers;
    }

    private List<SysFunction> queryByMenuId( Integer subLength,List<SysFunction> newFunctions,String idParent) {
        if(newFunctions==null) return null;
        List<SysFunction> datas = new ArrayList<SysFunction>();
        for(SysFunction sort:newFunctions ){
                String subStr=sort.getId();
                if(subStr.length()==subLength){
                    if (subLength==2||(subStr.startsWith(idParent) && subLength<=4)) {
                        sort.setChild(queryByMenuId(subLength+2,newFunctions,subStr));
                        datas.add(sort);
                    }
                }
        }
        return datas;
    }
}