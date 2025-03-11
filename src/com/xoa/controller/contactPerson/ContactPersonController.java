package com.xoa.controller.contactPerson;

import com.xoa.model.users.Users;
import com.xoa.service.contactPerson.ContactPersonService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by 李显 on 2017/12/11.
 * 常用联系人查询
 */
@Controller
@RequestMapping("/contactPerson")
public class ContactPersonController {

    @Resource
    public ContactPersonService contactPersonService;

    /**
     *
     * 查询常用联系人
     */
    @ResponseBody
    @RequestMapping("/serchContactPerson")
    public ToJson<Users> serchContactPerson(HttpServletRequest request){
        return  contactPersonService.serchContactPerson(request);
    }
}
