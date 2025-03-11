package com.xoa.controller.menu;

import com.xoa.service.menu.MenuService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by liu on 2017/6/20.
 * 作者：刘佩峰
 * 时间：2017/6/20
 */

@Controller
public class MenuFindIdController {

    @Resource
    private MenuService menuService;
   @ResponseBody
    @RequestMapping(value ="/getMenuId", produces = {"application/json;charset=UTF-8"})
    public ToJson<Integer> findMaxId(HttpServletRequest request)
    {
        return menuService.findMaxId();
    }
}
