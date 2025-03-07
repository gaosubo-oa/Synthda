package com.xoa.controller.users;

import com.xoa.model.users.UserModulePage;
import com.xoa.service.users.UserModulePageService;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("userModulePage")
public class UserModulePageController {

    @Autowired
    UserModulePageService userModulePageService;

    @ResponseBody
    @RequestMapping("save")
    BaseWrapper save(UserModulePage userModulePage){
        return userModulePageService.save(userModulePage);
    }

    @ResponseBody
    @RequestMapping("selectPage")
    BaseWrapper selectPage(UserModulePage userModulePage) {
        return userModulePageService.selectPage(userModulePage);
    }


}
