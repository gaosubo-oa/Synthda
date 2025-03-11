package com.xoa.controller.officeSupplies;

import com.xoa.model.officesupplies.OfficeAllocate;
import com.xoa.model.users.Users;
import com.xoa.service.officesupplies.OfficeAllocateService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/officeAllocate")
public class OfficeAllocateController {

    @Resource
    private OfficeAllocateService officeAllocateService;

    @ResponseBody
    @RequestMapping("/selectByMap")
    public ToJson selectByMap(HttpServletRequest request, Integer page, Integer pageSize, String approvalStatus, String beginDate, String endDate, String subName){
           return officeAllocateService.selectByMap(request,page,pageSize,approvalStatus,beginDate,endDate,subName);
    }
    @ResponseBody
    @RequestMapping("/insertSelective")
    public ToJson insertSelective(HttpServletRequest request,OfficeAllocate officeAllocate){
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        officeAllocate.setCreator(users.getUserId());
        return officeAllocateService.insertSelective(officeAllocate);
    }

    @ResponseBody
    @RequestMapping("/updateSelective")
    public ToJson updateSelective(OfficeAllocate officeAllocate){
        return officeAllocateService.updateSelective(officeAllocate);
    }
}
