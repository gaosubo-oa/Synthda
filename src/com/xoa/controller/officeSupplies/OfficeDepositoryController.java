package com.xoa.controller.officeSupplies;

import com.xoa.model.officesupplies.OfficeDepositoryWithBLOBs;
import com.xoa.service.officesupplies.OfficeDepositoryService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 创建作者:   牛江丽
 * 创建日期:   ${date} ${time}
 * 类介绍  :
 * 构造参数:
 */
@Controller
    @RequestMapping("/officeDepository")
public class OfficeDepositoryController {

    @Resource
    private OfficeDepositoryService depositoryService;

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 上午11:00:00
     * 方法介绍:   添加办公用品库
     * 参数说明:   @param record
     * 返回值说明:
     */
    @ResponseBody
    @RequestMapping("/insertDepository")
    ToJson<OfficeDepositoryWithBLOBs> insertDepository(OfficeDepositoryWithBLOBs depositoryWithBLOBs){
        return  depositoryService.insertDepository(depositoryWithBLOBs);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 上午11:01:00
     * 方法介绍:   修改id办公用品库
     * 参数说明:   @param record
     * 返回值说明:
     */
    @ResponseBody
    @RequestMapping("/updateDepositoryById")
    ToJson<OfficeDepositoryWithBLOBs> updateDepositoryById(OfficeDepositoryWithBLOBs depositoryWithBLOBs){
        return  depositoryService.updateDepositoryById(depositoryWithBLOBs);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 上午11:02:00
     * 方法介绍:   根据id删除办公用品库
     * 参数说明:   @param id
     * 返回值说明:
     */
    @ResponseBody
    @RequestMapping("/delDepositoryById")
    ToJson<OfficeDepositoryWithBLOBs> delDepositoryById(Integer id){
        return  depositoryService.delDepositoryById(id);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 上午11:03:00
     * 方法介绍:   根据id查询办公用品库
     * 参数说明:   @param id
     * 返回值说明:
     */
    @ResponseBody
    @RequestMapping("/selDepositoryById")
    ToJson<OfficeDepositoryWithBLOBs> selDepositoryById(HttpServletRequest request,Integer id){
        return  depositoryService.selDepositoryById(request,id);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 上午11:04:00
     * 方法介绍:   查询所有办公用品库
     * 参数说明:   @param
     * 返回值说明:
     */
    @ResponseBody
    @RequestMapping("/selAllDepository")
    ToJson<OfficeDepositoryWithBLOBs> selAllDepository(HttpServletRequest request){
        return  depositoryService.selAllDepository(request);
    }

    //加分页
    @ResponseBody
    @RequestMapping("/selAllDepositoryPage")
    ToJson<OfficeDepositoryWithBLOBs> selAllDepositoryPage(HttpServletRequest request,int page,int pageSize,boolean useFlag){
        return  depositoryService.selAllDepositoryPage(request,page,pageSize,useFlag);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/09 10:44
     * 类介绍  :   列表映射地址
     * 构造参数:
     */
    @RequestMapping("/goDepositoryindex")
    public String goDepositoryList(){
        return "app/officeSupplies/depository/index";
    }


    /**
     * 采购清单
     * @return
     */
    @RequestMapping("/goDepositoryShopList")
    public String goDepositoryShopList(){
        return "app/officeSupplies/depository/shopList";
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/011 14:44
     * 类介绍  :   获取办公用品库的名称
     * 构造参数:
     */
    @ResponseBody
    @RequestMapping("/getDepositoryNameById")
    public ToJson<OfficeDepositoryWithBLOBs>getDepositoryNameById(HttpServletRequest request,Integer id){
        return depositoryService.selDepositoryById(request,id);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017/10/17 14:44
     * 类介绍  :   根据所属部门权限获取办公用品库
     * 构造参数:
     */
    @ResponseBody
    @RequestMapping("/getDeposttoryByDept")
    public ToJson<OfficeDepositoryWithBLOBs> selDepositoryByDept(HttpServletRequest request){
        return depositoryService.selDepositoryByDept(request);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/23 15:44
     * 类介绍  :   查询所有树形接口
     * 构造参数:
     */
    @ResponseBody
    @RequestMapping("/getAllDeposttoryTree")
    public ToJson<OfficeDepositoryWithBLOBs> getAllDeposttoryTree(HttpServletRequest request){
        return depositoryService.getAllDeposttoryTree(request);
    }

}
