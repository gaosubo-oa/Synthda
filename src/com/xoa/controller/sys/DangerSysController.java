package com.xoa.controller.sys;

import com.xoa.service.sys.DangerSysService;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by 韩东堂  on 2017/7/4.
 */
@RestController
@RequestMapping("/danger")
public class DangerSysController {
    @Autowired
    DangerSysService dangerSysService;
    @RequestMapping("/truncate")
    public BaseWrapper truncateTable(HttpServletRequest request
    ,@RequestParam(required = false,name = "menuId[]") String[] menuId
    ){
        return dangerSysService.truncateTable(request,menuId);
    }

    @RequestMapping("/truncatePlagiarize")
    public BaseWrapper truncateTablePlagiarize(HttpServletRequest request
            ,@RequestParam(required = false,name = "menuId[]") String[] menuId
    ){
        return dangerSysService.truncateTablePlagiarize(request,menuId);
    }
//    @RequestMapping("/canTruMenu")
//    public BaseWrappers getShouldDelMenu(HttpServletRequest request){
//      return   dangerSysService.getShouldDelMenu(request);
//    }

}
