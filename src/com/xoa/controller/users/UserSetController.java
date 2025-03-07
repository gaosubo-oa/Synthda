package com.xoa.controller.users;

import com.xoa.service.users.UserSetService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 用户设置
 */
@Controller
@RequestMapping(value="/userSet")
public class UserSetController {


    @Resource
    private UserSetService userSetService;

    /**
     * 保存用户设置
     * @param userId 用户ID（必填）
     * @param setItem 设置项（必填）
     * @param setValue 设置值
     * @return
     */
    @ResponseBody
    @RequestMapping("/saveUserSet")
    public ToJson saveUserSet(HttpServletRequest request,
                              @RequestParam(name = "userId", required = true) String userId,
                              @RequestParam(name = "setItem", required = true) String setItem,
                              String setValue){
        return userSetService.saveUserSet(request, userId, setItem, setValue);
    }


    /**
     * 读取用户设置
     * @param userId  用户ID（必填）
     * @param setItem 设置项
     * @return
     */
    @ResponseBody
    @RequestMapping("/readUserSet")
    public ToJson readUserSet(HttpServletRequest request,
                              @RequestParam(name = "userId", required = true) String userId,
                              String setItem){
        return userSetService.readUserSet(request, userId, setItem);
    }
}
