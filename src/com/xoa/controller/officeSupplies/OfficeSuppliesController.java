package com.xoa.controller.officeSupplies;

import com.xoa.dao.officesupplies.OfficeDepositoryMapper;
import com.xoa.model.officesupplies.OfficeDepositoryWithBLOBs;
import com.xoa.model.officesupplies.OfficeProductsWithBLOBs;
import com.xoa.model.officesupplies.OfficeType;
import com.xoa.service.officesupplies.OfficeProductService;
import com.xoa.service.officesupplies.OfficeTypeService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/officeSupplies")
public class OfficeSuppliesController {

    @Resource
    private OfficeProductService officeProductService;
    @Resource
    private OfficeTypeService officeTypeService;
    @Resource
    private OfficeDepositoryMapper officeDepositoryMapper;



    @RequestMapping("/info")
    public String info(HttpServletRequest request) {
        return "app/officeSupplies/infoQuery";
    }
    @RequestMapping("/infoManage")
    public String manage(HttpServletRequest request) {
        return "app/officeSupplies/infoManage";
    }
    @RequestMapping("/librarySet")
    public String librarySet(HttpServletRequest request) {
        return "app/officeSupplies/librarySet";
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/10 12:44
     * 类介绍  :   办公用品列表映射界面
     * 构造参数:
     */
    @RequestMapping("/goOfficeList")
    public String goOfficeList(String typeId,Map<String,Object> map){
        map.put("typeId",typeId);
        return  "app/officeSupplies/Information/index";
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/13 12:44
     * 类介绍  :   办公用品信息管理主界面映射
     * 构造参数:
     */
    @RequestMapping("/goInfomationHome")
    public String goInfomationHome(){
        return "app/officeSupplies/Information/fileHome";
    }


    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/17 18:58
     * 类介绍  :   办公用品查询映射界面
     * 构造参数:
     */
    @RequestMapping("/goOfficeQuery")
    public String goOfficeList(){
        return  "app/officeSupplies/Information/query";
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 12:44
     * 类介绍  :   办公用品导入页面
     * 构造参数:
     */
    @RequestMapping("/goimport")
    public String goimport(){
        return "app/officeSupplies/Information/import";
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/13 12:44
     * 类介绍  :   办公用品新建页面
     * 构造参数:
     */
    @RequestMapping("/newProduct")
    public String goNewProduct(String editFlag,int proId,Map<String,Object>map){
        map.put("editFlag",editFlag);
        map.put("proId",proId);
        return "app/officeSupplies/Information/newProduct";
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/13 12:44
     * 类介绍  :   办公用品申请界面
     * 构造参数:
     */
    @RequestMapping("/goProductApply")
    public String goProductApply(){
        return "app/officeSupplies/product/fileHome";
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/11 9:44
     * 类介绍  :   办公用品分类列表展示
     * 构造参数:
     */
    @RequestMapping("/goOfficeTypeList")
    public String goOfficeTypeList(String typeDepository,Map<String,Object> map){
        map.put("typeDepository",typeDepository);
        return  "app/officeSupplies/offType/index";
    }

    /**
     * 办公用品统计
     * @return
     */
    @RequestMapping("/statistics")
    public String statistics(){
        return "app/officeSupplies/statistics/index";
    }

    @RequestMapping("/summary")
    public String summary(){
        return "app/officeSupplies/statistics/summary";
    }

    /**
     * 入库统计
     */
    @RequestMapping("/acceptance")
    public String acceptance(){
        return "app/officeSupplies/statistics/acceptance";
    }

    /**
     * 出库统计
     */
    @RequestMapping("/outbound")
    public String outbound(){
        return "app/officeSupplies/statistics/outbound";
    }

    /**
     * 费用统计
     */
    @RequestMapping("/expenses")
    public String expenses(){
        return "app/officeSupplies/statistics/expenses";
    }

    /**
     * 维护统计
     */
    @RequestMapping("/maintenance")
    public String maintenance(){
        return "app/officeSupplies/statistics/maintenance";
    }

    /**
     * 报废统计
     */
    @RequestMapping("/maintenanceStatistics")
    public String maintenanceStatistics(){
        return "app/officeSupplies/statistics/maintenanceStatistics";
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 10:44
     * 类介绍  :   新建办公用品接口
     * 构造参数:
     */
    @RequestMapping("/addOfficeProducts")
    @ResponseBody
    public ToJson<Object> addOfficeProducts(OfficeProductsWithBLOBs officeProductsWithBLOBs){
        return officeProductService.addOfficeProducts(officeProductsWithBLOBs);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 12:44
     * 类介绍  :   编辑办公用品接口
     * 构造参数:
     */
    @RequestMapping("/editOfficeProducts")
    @ResponseBody
    public ToJson<Object> editOfficeProducts(OfficeProductsWithBLOBs officeProductsWithBLOBs){
        return officeProductService.editOfficeProducts(officeProductsWithBLOBs);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/17 14:25
     * 类介绍  :   查询办公用品详情接口
     * 构造参数:
     */
    @RequestMapping("/getOfficeProductById")
    @ResponseBody
    public ToJson<OfficeProductsWithBLOBs> getOfficeProductById(Integer proId, String officeInventory){
        return officeProductService.getOfficeProductById(proId, officeInventory);
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 12:44
     * 类介绍  :   删除办公用品接口
     * 构造参数:
     */
    @RequestMapping("/deleteOfficeProductById")
    @ResponseBody
    public ToJson<Object> deleteOfficeProductById(Integer proId){
        return officeProductService.deleteOfficeProductById(proId);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 12:44
     * 类介绍  :   批量删除办公用品接口
     * 构造参数:
     */
    @RequestMapping("/deleteOfficeProducts")
    @ResponseBody
    public ToJson<Object> deleteOfficeProducts(String[] proIds){
        return officeProductService.deleteOfficeProducts(proIds);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 12:44
     * 类介绍  :   查询与导出办公用品设备
     * 构造参数:
     */
    @RequestMapping("/selectOfficeProducts")
    @ResponseBody
    public ToJson<OfficeProductsWithBLOBs> selectOfficeProducts(HttpServletRequest request, HttpServletResponse response,String id, String typeId, String proId, String export,int page,int pageSize,boolean useFlag){
            return officeProductService.selectOfficeProducts(request,response,id,typeId,proId,export,page,pageSize,useFlag);
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 16:44
     * 类介绍  :   办公用品导入
     * 构造参数:
     */
    @ResponseBody
    @RequestMapping("/importOfficeProducts")
    public ToJson<Object> importOfficeProducts(MultipartFile file, HttpServletRequest request, HttpServletResponse response, HttpSession session){
        return officeProductService.importOfficeProducts(file,request,response,session);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 10:44
     * 类介绍  :   编辑办公用品类别接口
     * 构造参数:
     */
    @RequestMapping("/editOfficeType")
    @ResponseBody
    public ToJson<Object> editOfficeType(OfficeType OfficeType){
        return officeTypeService.editOfficeType(OfficeType);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 12:44
     * 类介绍  :   删除办公用品类别接口
     * 构造参数:
     */
    @RequestMapping("/deleteOfficeTypeById")
    @ResponseBody
    public ToJson<Object> deleteOfficeTypeById(Integer id){
        return officeTypeService.deleteOfficeTypeById(id);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月9日 下午15:47:00
     * 方法介绍:   根据权限查询左侧树形
     * 参数说明:   @param
     * 返回值说明:
     */
    @ResponseBody
    @RequestMapping("/selDepositoryByDept")
    public ToJson<OfficeDepositoryWithBLOBs> selDepositoryByDept(HttpServletRequest request){
        return  officeProductService.selDepositoryByDept(request);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月10日 下午15:47:00
     * 方法介绍:  根据办公用品类型查询办公用品
     * 参数说明:   @param typeId办公用品类型id
     * 返回值说明:
     */
    @ResponseBody
    @RequestMapping("/selProductByType")
    public ToJson<OfficeProductsWithBLOBs> selProductByType(String typeId){
        return  officeProductService.selProductByType(typeId);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/11 10:44
     * 类介绍  :   新建办公用品分类接口
     * 构造参数:
     */
    @ResponseBody
    @RequestMapping("/addOffType")
    public ToJson<Object> addOffType(OfficeType officeType){
        return officeTypeService.addOfficeType(officeType);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/11 10:44
     * 类介绍  :   办公用品分类列表展示接口
     * 构造参数:
     */
    @ResponseBody
    @RequestMapping("/selectAllOffType")
    public ToJson<OfficeType> selectAllOffType(HttpServletRequest request,String typeDepository) {
        return officeTypeService.selectAllOffType(request,typeDepository);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/11 10:44
     * 类介绍  :   办公用品分类详情接口
     * 构造参数:
     */
    @ResponseBody
    @RequestMapping("/getOfficeTypeById")
    public ToJson<OfficeType> getOfficeTypeById(Integer id){
      return officeTypeService.getOfficeTypeById(id);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/13 10:44
     * 类介绍  :   办公用品分类详情接口
     * 构造参数:
     */
    @ResponseBody
    @RequestMapping("/getInfo")
    public ToJson<OfficeProductsWithBLOBs> getInfo(HttpServletRequest request){
        return officeProductService.getInfo(request);
    }

    /**
     *
     * @param request 贾志敏
     * @return 得到办公用品
     */
    @ResponseBody
    @RequestMapping("/getOfficeTypeByNameList")
    public ToJson getOfficeTypeByNameList(HttpServletRequest request,String proId,String typeId,String depositoryName){
        return officeProductService.getOfficeTypeByNameList(request,proId,typeId,depositoryName);
    }

    //



}
