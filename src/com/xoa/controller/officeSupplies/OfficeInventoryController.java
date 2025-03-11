package com.xoa.controller.officeSupplies;

import com.xoa.model.officesupplies.OfficeInventory;
import com.xoa.service.officesupplies.OfficeInventoryService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/officeInventory")
public class OfficeInventoryController {

    @Resource
    private OfficeInventoryService officeInventoryService;

    // 查询办公用品库存盘点
    @ResponseBody
    @RequestMapping("/selectOfficeInventory")
    ToJson<OfficeInventory> selectOfficeInventory(HttpServletRequest request, HttpServletResponse response, Integer page, Integer pageSize, boolean useFlag, OfficeInventory officeInventory) {
        return officeInventoryService.selectOfficeInventory(request, response, page, pageSize, useFlag, officeInventory);
    }

    // 新增办公用品库存盘点
    @ResponseBody
    @RequestMapping("/addOfficeInventory")
    ToJson<OfficeInventory> addOfficeInventory(HttpServletRequest request, OfficeInventory officeInventory) {
        return officeInventoryService.addOfficeInventory(request, officeInventory);
    }

}
