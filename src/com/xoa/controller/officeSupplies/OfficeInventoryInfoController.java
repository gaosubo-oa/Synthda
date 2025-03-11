package com.xoa.controller.officeSupplies;

import com.xoa.model.officesupplies.OfficeInventoryInfo;
import com.xoa.service.officesupplies.OfficeInventoryInfoService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/officeInventoryInfo")
public class OfficeInventoryInfoController {

    @Resource
    private OfficeInventoryInfoService officeInventoryInfoService;

    // 查询办公用品库存盘点详情
    @ResponseBody
    @RequestMapping("/selectOfficeInventoryInfo")
    ToJson<OfficeInventoryInfo> selectOfficeInventoryInfo(HttpServletRequest request, HttpServletResponse response, Integer page, Integer pageSize, boolean useFlag, OfficeInventoryInfo officeInventoryInfo) {
        return officeInventoryInfoService.selectOfficeInventoryInfo(request, response, page, pageSize, useFlag, officeInventoryInfo);
    }

}
