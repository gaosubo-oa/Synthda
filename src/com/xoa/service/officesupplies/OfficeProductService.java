package com.xoa.service.officesupplies;

import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.officesupplies.*;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.officesupplies.OfficeDepositoryWithBLOBs;
import com.xoa.model.officesupplies.OfficeInventoryInfo;
import com.xoa.model.officesupplies.OfficeProductsWithBLOBs;
import com.xoa.model.officesupplies.OfficeType;
import com.xoa.model.users.Users;
import com.xoa.util.*;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.apache.commons.io.IOUtils;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.*;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/10/7 10:58
 * 类介绍  :   办公用品管理
 * 构造参数:
 */
@Service
public class OfficeProductService {

    @Resource
    private OfficeProductsMapper officeProductsMapper;
    @Resource
    private UsersMapper usersMapper;
    @Resource
    private OfficeDepositoryMapper officeDepositoryMapper;
    @Resource
    private OfficeTypeMapper officeTypeMapper;
    @Resource
    private DepartmentMapper departmentMapper;

    @Resource
    private OfficeInventoryInfoMapper officeInventoryInfoMapper;

    @Resource
    private OfficeTranshistoryMapper officeTranshistoryMapper;


    public ToJson<Object> addOfficeProducts(OfficeProductsWithBLOBs officeProductsWithBLOBs){
        ToJson<Object> json =new ToJson<Object>(1,"err");
        try {
            int i = officeProductsMapper.insertSelective(officeProductsWithBLOBs);
           if(i>0){
               json.setMsg("ok");
               json.setFlag(0);
           }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 10:45
     * 类介绍  :   编辑办公用品接口
     * 构造参数:
     */
    public ToJson<Object> editOfficeProducts(OfficeProductsWithBLOBs officeProductsWithBLOBs){
        ToJson<Object> json =new ToJson<Object>(1,"err");
        try {
            int i = officeProductsMapper.updateByPrimaryKeySelective(officeProductsWithBLOBs);
            if(i>0){
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 12:44
     * 类介绍  :   删除办公用品接口
     * 构造参数:
     */
    public ToJson<Object> deleteOfficeProductById(Integer proId){
        ToJson<Object> json =new ToJson<Object>(1,"err");
        try {
            int i = officeProductsMapper.deleteByPrimaryKey(proId);
            if(i>0){
                json.setFlag(0);
                json.setMsg("ok");
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 12:44
     * 类介绍  :   删除办公用品接口
     * 构造参数:
     */
    public ToJson<Object> deleteOfficeProducts(String[] proIds){
        ToJson<Object> json =new ToJson<Object>(1,"err");
        try {
            officeProductsMapper.deleteOfficeProducts(proIds);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/17 14:25
     * 类介绍  :   查询办公用品详情接口
     * 构造参数:
     */
    public ToJson<OfficeProductsWithBLOBs> getOfficeProductById(Integer proId, String officeInventory){
        ToJson<OfficeProductsWithBLOBs> json =new ToJson<OfficeProductsWithBLOBs>(1,"err");
        try {
            OfficeProductsWithBLOBs officeProductsWithBLOBs = officeProductsMapper.selectByPrimaryKey(proId);
            StringBuffer sb= new StringBuffer();
            StringBuffer sbdept= new StringBuffer();
            if(officeProductsWithBLOBs!=null){
                if(!StringUtils.checkNull(officeProductsWithBLOBs.getProManager())){
                    String[] split = officeProductsWithBLOBs.getProManager().split(",");
                    for(String s:split){
                        Users byuserId = usersMapper.getUserId(s);
                        if(byuserId!=null) {
                            sb.append(byuserId.getUserName()+",");
                        }
                    }
                    officeProductsWithBLOBs.setProManagerName(sb.toString());
                }

                if(!StringUtils.checkNull(officeProductsWithBLOBs.getProDept())){
                    if(officeProductsWithBLOBs.getProDept().equals("ALL_DEPT")){
                        officeProductsWithBLOBs.setProDeptName("全体部门");
                    }else{
                        String[] split = officeProductsWithBLOBs.getProDept().split(",");
                        for(String s:split){
                            String deptNameByDeptId = departmentMapper.getDeptNameByDeptId(Integer.valueOf(s));
                            if(deptNameByDeptId!=null) {
                                sbdept.append(deptNameByDeptId+",");
                            }
                        }
                        officeProductsWithBLOBs.setProDeptName(sbdept.toString());
                    }
                }
                if(!StringUtils.checkNull(officeProductsWithBLOBs.getProCreator())){
                    Users byuserId = usersMapper.getUserId(officeProductsWithBLOBs.getProCreator());
                    if (byuserId!=null) {
                        officeProductsWithBLOBs.setProCreatorName(byuserId.getUserName());
                    }
                }
                if(!StringUtils.checkNull(officeProductsWithBLOBs.getOfficeProtype())){
                    OfficeType depositoryByProType = officeTypeMapper.selectOffTypeByProType(officeProductsWithBLOBs.getOfficeProtype());
                    if (depositoryByProType!=null){
                        officeProductsWithBLOBs.setOfficeDepositoryId(String.valueOf(depositoryByProType.getTypeDepository()));
                    }
                }

                // 库存盘点处理
                if (!StringUtils.checkNull(officeInventory) && "1".equals(officeInventory)) {
                    String lastInventoryDate = null;
                    // 上期盘点时间 上期结余
                    OfficeInventoryInfo officeInventoryInfo = officeInventoryInfoMapper.selectLastOfficeInventoryInfo(proId);
                    if (officeInventoryInfo != null) {
                        if (officeInventoryInfo.getInventoryDate() != null) {
                            officeProductsWithBLOBs.setLastInventoryDate(officeInventoryInfo.getInventoryDate());
                            lastInventoryDate = DateFormat.getDatestr(officeInventoryInfo.getInventoryDate());
                        }

                        if (officeInventoryInfo.getActualDiskCount() != null) {
                            officeProductsWithBLOBs.setOldBalance(officeInventoryInfo.getActualDiskCount());
                        }
                    }
                    // 入库量 入库量为当前时间范围内实际入库量与借用归还数量之和
                    String currentTime = DateFormat.getDatestr(new Date());
                    Integer scheduledReceipt = officeTranshistoryMapper.selectScheduledReceipt(proId, lastInventoryDate, currentTime);
                    if (scheduledReceipt != null) {
                        officeProductsWithBLOBs.setScheduledReceipt(scheduledReceipt);
                    } else {
                        officeProductsWithBLOBs.setScheduledReceipt(0);
                    }
                    // 出库量 领用，借用未还数量之和
                    Integer outboundQuantity = officeTranshistoryMapper.selectOutboundQuantity(proId, lastInventoryDate, currentTime);
                    if (outboundQuantity != null) {
                        officeProductsWithBLOBs.setOutboundQuantity(outboundQuantity);
                    } else {
                        officeProductsWithBLOBs.setOutboundQuantity(0);
                    }
                }
            }

            json.setFlag(0);
            json.setMsg("ok");
            json.setObject(officeProductsWithBLOBs);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 15:44
     * 类介绍  :   查询与导出办公用品设备
     * 构造参数:
     */
    public ToJson<OfficeProductsWithBLOBs> selectOfficeProducts(HttpServletRequest request, HttpServletResponse response,String id, String typeId, String proId, String export,int page,int pageSize,boolean useFlag){
       ToJson<OfficeProductsWithBLOBs> json =new ToJson<OfficeProductsWithBLOBs>(1,"err");
        if(export==null){
           export="0";
       }
        Map<String,Object> map =new HashMap<String,Object>();
       map.put("id",id);
       map.put("typeId",typeId);
       map.put("proId",proId);
        PageParams pageParams=new PageParams();
        pageParams.setPageSize(pageSize);
        pageParams.setPage(page);
        pageParams.setUseFlag(useFlag);
        map.put("page",pageParams);
        String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        List<OfficeProductsWithBLOBs> officeProductsWithBLOBs = null;
        try {
            officeProductsWithBLOBs = officeProductsMapper.selectOfficeProducts(map);
        for (OfficeProductsWithBLOBs officeProductsWithBLOBs1:officeProductsWithBLOBs){
           if(officeProductsWithBLOBs1!=null){
             if(officeProductsWithBLOBs1.getProCreator()!=null && officeProductsWithBLOBs1.getProCreator()!=""){
                 Users byuserId = usersMapper.getUserId(officeProductsWithBLOBs1.getProCreator());
                 if(byuserId!=null){
                     officeProductsWithBLOBs1.setProCreatorName(byuserId.getUserName());
                 }
             }
             if(officeProductsWithBLOBs1.getProAuditer()!=null &&officeProductsWithBLOBs1.getProAuditer()!=""){
                 Users byuserId = usersMapper.getUserId(officeProductsWithBLOBs1.getProAuditer().substring(0,officeProductsWithBLOBs1.getProAuditer().length()-1));
                if(byuserId!=null){
                    officeProductsWithBLOBs1.setProAuditerName(byuserId.getUserName());
                }
             }
           }
       }
            json.setTotleNum(pageParams.getTotal());
            json.setObj(officeProductsWithBLOBs);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }
        //导出
       if(export.equals("1")){
           HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead(I18nUtils.getMessage("office.Product.xls"), 9);
           String[] secondTitles = {I18nUtils.getMessage("vote.th.OfficeName"), I18nUtils.getMessage("vote.th.OfficeCategory"),
                   I18nUtils.getMessage("vote.th.Measurement") , I18nUtils.getMessage("vote.th.Supplier"),I18nUtils.getMessage("vote.th.MinimumInventory"),
                   I18nUtils.getMessage("vote.th.CurrentStock"),   I18nUtils.getMessage("customer.creator"), I18nUtils.getMessage("hr.th.Approver")};
           HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
           String[] beanProperty = {"proName","typeName", "proUnit","proSupplier","proLowstock", "proStock", "proCreatorName", "proAuditerName"};
           HSSFWorkbook workbook = null;
           try {
               workbook = ExcelUtil.exportExcelData(workbook2, officeProductsWithBLOBs, beanProperty);
               OutputStream out = response.getOutputStream();
               String filename = I18nUtils.getMessage("office.Product.xls")+".xls";
               filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
               response.setContentType("application/vnd.ms-excel;charset=UTF-8");
               response.setHeader("content-disposition", "attachment;filename=" + filename);
               workbook.write(out);
               out.close();
           } catch (Exception e) {
               e.printStackTrace();
           }
       }

      return json;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 16:44
     * 类介绍  :   办公用品导入
     * 构造参数:
     */
    public ToJson<Object> importOfficeProducts(MultipartFile file, HttpServletRequest request, HttpServletResponse response, HttpSession session){
        ToJson<Object> json = new ToJson<Object>(1,"err");
        // 成功次数
        Integer successCount = 0;
        InputStream in=null;
        try {
            //判读当前系统
            //读取配置文件
            ResourceBundle rb = ResourceBundle.getBundle("upload");
            String osName = System.getProperty("os.name");
            StringBuffer path = new StringBuffer();
             StringBuffer buffer=new StringBuffer();
        if(osName.toLowerCase().startsWith("win")){
            //sb=sb.append(rb.getString("upload.win"));
            //判断路径是否是相对路径，如果是的话，加上运行的路径
            String uploadPath = rb.getString("upload.win");
            if(uploadPath.indexOf(":")==-1){
                //获取运行时的路径
                String basePath = this.getClass().getClassLoader().getResource(".").getPath()+ File.pathSeparator;
                //获取截取后的路径
                String str2 = "";
                if(basePath.indexOf("/xoa")!=-1){
                    //获取字符串的长度
                    int length = basePath.length();
                    //返回指定字符在此字符串中第一次出现处的索引
                    int index = basePath.indexOf("/xoa");
                    //从指定位置开始到指定位置结束截取字符串
                    str2=basePath.substring(0,index);
                }
                path = path.append(str2 + "/xoa");
            }
            path.append(uploadPath);
            buffer=buffer.append(rb.getString("upload.win"));
        }else{
            path=path.append(rb.getString("upload.linux"));
            buffer=buffer.append(rb.getString("upload.linux"));
        }
            StringBuffer result = new StringBuffer();
            // 判断是否为空文件
            if (file.isEmpty()) {
                json.setMsg("请上传文件！");
                json.setFlag(1);
                return json;
            } else {
                String fileName = file.getOriginalFilename();
                if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")) {
                    String uuid = UUID.randomUUID().toString().replaceAll("-", "");
                    int pos = fileName.indexOf(".");
                    String extName = fileName.substring(pos);
                    String newFileName = uuid + extName;
                    String readPath = path.append("/"+newFileName).toString();
                    File dest = new File(readPath);
                    file.transferTo(dest);
                    // 将文件上传成功后进行读取文件
                    // 进行读取的路径

                    in = new FileInputStream(readPath);
                    HSSFWorkbook excelObj = new HSSFWorkbook(in);
                    HSSFSheet sheetObj = excelObj.getSheetAt(0);
                    Row row = sheetObj.getRow(0);
                    int colNum = row.getPhysicalNumberOfCells();
                    int lastRowNum = sheetObj.getLastRowNum();
                    List<OfficeProductsWithBLOBs> saveList = new ArrayList<OfficeProductsWithBLOBs>();
                    OfficeProductsWithBLOBs officeProductsWithBLOBs=null;
                    result.append("共" + (lastRowNum) + "条。\n");
                K:  for (int i = 1; i <= lastRowNum; i++) {
                        OfficeDepositoryWithBLOBs officeDepositoryWithBLOBs=new OfficeDepositoryWithBLOBs();
                        OfficeType  officeType =new OfficeType();
                        officeProductsWithBLOBs =new OfficeProductsWithBLOBs();
                        row = sheetObj.getRow(i);
                        if (row != null) {
                            for (int j = 0; j < colNum; j++) {
                                Cell cell = row.getCell(j);
                                if (cell != null) {
                                    switch (j) {
                                        case 0:
                                            if (StringUtils.checkNull(cell.getStringCellValue())) {
                                                continue K;
                                            }
                                            //办公用品名称
                                            officeProductsWithBLOBs.setProName(cell.getStringCellValue());
                                            break;
                                        case 1:
                                            //办公用品库
                                            row.getCell(1).setCellType(CellType.STRING);
                                            officeDepositoryWithBLOBs = officeDepositoryMapper.selDepositoryByName(cell.getStringCellValue());
                                            if(Objects.isNull(officeDepositoryWithBLOBs)){
                                                result.append("Line" + i + "does not exist in the office supply warehouse \n");
                                                continue K;
                                            }
                                            break;
                                        case 2:
                                            //办公用品类别
                                            officeType =officeTypeMapper.selectByDepositoryIdAndName(officeDepositoryWithBLOBs.getId().toString(), cell.getStringCellValue());
                                            if(Objects.isNull(officeType)){
                                                result.append("Line" + i + "office supplies category does not exist \n");
                                                continue K;
                                            }
                                            officeProductsWithBLOBs.setOfficeProtype(String.valueOf(officeType.getId()));
                                            break;
                                        case 3:
                                            //登记类型
                                            officeProductsWithBLOBs.setOfficeProductType( Integer.parseInt( getValue(row,cell,3)));
                                            break;
                                        case 4:
                                            //编码
                                           officeProductsWithBLOBs.setProCode(getValue(row,cell,4));
                                            break;
                                        case 5:
                                            // 单价
                                            officeProductsWithBLOBs.setProPrice(new BigDecimal(getValue(row,cell,5)));
                                            break;
                                        case 6:
                                            //计量单位
                                            row.getCell(6).setCellType(CellType.STRING);
                                          officeProductsWithBLOBs.setProUnit(cell.getStringCellValue());
                                            break;
                                        case 7:
                                            //供应商
                                            row.getCell(7).setCellType(CellType.STRING);
                                           officeProductsWithBLOBs.setProSupplier(cell.getStringCellValue());
                                            break;
                                        case 8:
                                            // 最底警戒
                                           officeProductsWithBLOBs.setProLowstock(Integer.parseInt(getValue(row,cell,8)));
                                            break;
                                        case 9:
                                            // 最高警戒
                                            officeProductsWithBLOBs.setProMaxstock(Integer.parseInt(getValue(row,cell,9)));
                                            break;
                                        case 10:
                                           //当前库存
                                            officeProductsWithBLOBs.setProStock(Integer.parseInt(getValue(row,cell,10)));
                                            break;
                                        case 11:
                                            // 创建人
                                            Users byuserName = usersMapper.getUserByUserName(cell.getStringCellValue());
                                            if(byuserName!=null){
                                                officeProductsWithBLOBs.setProCreator(byuserName.getUserId());
                                            }
                                            break;
                                        case 12:
                                            // 登记权限用户
                                            String Name=cell.getStringCellValue();
                                            if(Name!=null){
                                                String[] split = Name.split(",");
                                                for(String s:split){
                                                    Users byuserName2 = usersMapper.getUserByUserName(s);
                                                    if(byuserName2!=null){
                                                        row.getCell(12).setCellType(CellType.STRING);
                                                        officeProductsWithBLOBs.setProManager(byuserName2.getUserId());
                                                    }
                                                }
                                            }

                                            break;
                                        case 13:
                                            // 审批权限用户
                                            String proName=cell.getStringCellValue();
                                            if(proName!=null) {
                                                String[] split = proName.split(",");
                                                for (String s : split) {
                                                    Users byuserName3 = usersMapper.getUserByUserName(s);
                                                    if (byuserName3 != null) {
                                                        row.getCell(13).setCellType(CellType.STRING);
                                                        officeProductsWithBLOBs.setProManager(byuserName3.getUserId() + ",");
                                                    }
                                                }
                                            }
                                            break;
                                        case 14:
                                            // 规格/类型
                                            row.getCell(14).setCellType(CellType.STRING);
                                            officeProductsWithBLOBs.setProDesc(cell.getStringCellValue());
                                            break;
                                    }
                                }
                            }
                            //防止读取"" 数据导致查询报错
                            if (officeProductsWithBLOBs!=null && !StringUtils.checkNull(officeProductsWithBLOBs.getProName())) {
                              //把officeProductsWithBLOBs当做条件查询是否在数据库中存在
                            OfficeProductsWithBLOBs officeProductsWithBLOBs1 = officeProductsMapper.selectSingleOfficeProducts(officeProductsWithBLOBs);
                            if (officeProductsWithBLOBs1 != null) {
                                officeProductsWithBLOBs1.setProId(officeProductsWithBLOBs1.getProId());
                                officeProductsMapper.updateByPrimaryKeySelective(officeProductsWithBLOBs1);
                                successCount++;
                            } else {
                                this.addOfficeProducts(officeProductsWithBLOBs);
                                successCount++;
                            }
                            }

                        }
                    }
                } else {
                    json.setMsg("file type error!");
                    json.setFlag(1);
                    return json;
                }
            }
            result.append("Import" + successCount );
            json.setTotleNum(successCount);
            json.setMsg(result.toString());
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            json.setFlag(1);
        } finally {
            IOUtils.closeQuietly(in);
        }
        return json;
    }

    public String getValue(Row row,Cell cell,int i){
        String value="";
        try{

            cell.setCellType(CellType.STRING);
            value= cell.getStringCellValue();
        }catch (Exception e){

        }finally {
            return value;
        }
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月9日 下午15:47:00
     * 方法介绍:   根据权限查询左侧树形
     * 参数说明:   @param
     * 返回值说明:
     */
    public ToJson<OfficeDepositoryWithBLOBs> selDepositoryByDept(HttpServletRequest request){
        ToJson<OfficeDepositoryWithBLOBs> json = new ToJson<OfficeDepositoryWithBLOBs>(1, "error");
        try{
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            List<OfficeDepositoryWithBLOBs> list=officeDepositoryMapper.selDepositoryByDept(users.getUserId());
            for (OfficeDepositoryWithBLOBs officeDepository:list){
                List<OfficeType> typeList=officeTypeMapper.selectDownObject(String.valueOf(officeDepository.getId()));
                officeDepository.setOfficeTypeList(typeList);
                for (OfficeType officeType:typeList){
                    List<OfficeProductsWithBLOBs> officeProductsList=officeProductsMapper.selectDownObject(String.valueOf(officeType.getId()));
                    officeType.setOfficeProductsList(officeProductsList);
                }
            }
            json.setObj(list);
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("OfficeProductService selDepositoryByDept:"+e);
            e.printStackTrace();
        }
        return  json;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月10日 下午15:47:00
     * 方法介绍:   根据办公用品类型查询办公用品
     * 参数说明:   @param typeId办公用品类型id
     * 返回值说明:
     */
    public ToJson<OfficeProductsWithBLOBs> selProductByType(String typeId){
        ToJson<OfficeProductsWithBLOBs> json = new ToJson<OfficeProductsWithBLOBs>(1, "error");
        try{
            List<OfficeProductsWithBLOBs> officeProductsList=officeProductsMapper.selectDownObject(typeId);
            for(OfficeProductsWithBLOBs temp:officeProductsList){
                if(temp!=null){
                    if(temp.getProCreator()!=null && temp.getProCreator()!=""){
                        Users byuserId = usersMapper.getUserId(temp.getProCreator());
                        if(byuserId!=null){
                            temp.setProCreatorName(byuserId.getUserName());
                        }
                    }
                    if(temp.getProAuditer()!=null &&temp.getProAuditer()!=""){
                        Users byuserId = usersMapper.getUserId(temp.getProAuditer().substring(0,temp.getProAuditer().length()-1));
                        if(byuserId!=null){
                            temp.setProAuditerName(byuserId.getUserName());
                        }
                    }
                    if(!StringUtils.checkNull(temp.getOfficeProtype())){
                        OfficeType type=officeTypeMapper.selectByPrimaryKey(Integer.valueOf(temp.getOfficeProtype()));
                        if(type!=null){
                            temp.setOfficeProtypeName(type.getTypeName());
                        }
                    }

                }
            }
            json.setObj(officeProductsList);
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("OfficeProductService selProductByType:"+e);
            e.printStackTrace();
        }
        return  json;
    }
    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月10日 下午15:47:00
     * 方法介绍:   调拨
     * 参数说明:   @param
     * 返回值说明:
     */
    public ToJson<OfficeProductsWithBLOBs> transferProduct(HttpServletRequest request,int orgDepository,int orgType,int orgProduct,int count,int destDepository,int destType,int destProduct){
        ToJson<OfficeProductsWithBLOBs> json = new ToJson<OfficeProductsWithBLOBs>(1, "error");
        try{
            //不能调拨到同一个位置
            if(orgDepository==destDepository && orgType==destType){
                return json;//调拨信息有误，请重新填写
            }
            //调拨的数量不能超过库存数量或调拨后库存数量不能小于最低警戒数量
            OfficeProductsWithBLOBs officeProductsWithBLOBs=officeProductsMapper.selectByPrimaryKey(orgProduct);
            if (officeProductsWithBLOBs!=null){
                if(officeProductsWithBLOBs.getProLowstock()!=null){
                    if((officeProductsWithBLOBs.getProStock()-count)<officeProductsWithBLOBs.getProLowstock()){
                        json.setMsg("stockNotEnough");//提交数量超过库存，请重新填写！
                        return json;
                    }
                }else{
                    if(officeProductsWithBLOBs.getProStock()<count){
                        json.setMsg("stockNotEnough");//提交数量超过库存，请重新填写！
                        return json;
                    }
                }
            }
            //只有调拨员才能进行调拨
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            if(!officeProductsWithBLOBs.getProKeeper().contains(users.getUserId())){
                return json;//调拨信息有误，请重新填写
            }
            int num=0;
            //进行调拨操作
            officeProductsWithBLOBs.setAllocation(0);//调拨属性设为true
            if((officeProductsWithBLOBs.getProStock()-count)==0){//如果将所有用品都调拨过去，则直接将该用品的类别改为调拨后的类别
                officeProductsWithBLOBs.setOfficeProtype(String.valueOf(destType));
                num+=officeProductsMapper.updateByPrimaryKey(officeProductsWithBLOBs);
            }else{
                officeProductsWithBLOBs.setProStock(officeProductsWithBLOBs.getProStock()-count);
                num+=officeProductsMapper.updateByPrimaryKey(officeProductsWithBLOBs);
                officeProductsWithBLOBs.setProId(null);
                officeProductsWithBLOBs.setProStock(count);
                num+=officeProductsMapper.insertSelective(officeProductsWithBLOBs);
            }
            if(destProduct!=0){//如果目标办公用品不为空，则需要将目标办公用品类别修改原类别
                OfficeProductsWithBLOBs destOfficeProduct=officeProductsMapper.selectByPrimaryKey(destProduct);
                destOfficeProduct.setOfficeProtype(String.valueOf(orgType));
                num+=officeProductsMapper.updateByPrimaryKey(destOfficeProduct);
            }
            if(num>0){
                json.setMsg("ok");
                json.setFlag(0);
            }
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("OfficeProductService transferProduct:"+e);
            e.printStackTrace();
        }
        return  json;
    }
    public ToJson<OfficeProductsWithBLOBs> getInfo(HttpServletRequest request){
        ToJson<OfficeProductsWithBLOBs> json =new ToJson<OfficeProductsWithBLOBs>();
        Date date = null;
        try {
            //从session中获取当前登录人的信息
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            date = new Date();
            OfficeProductsWithBLOBs officeProductsWithBLOBs =new OfficeProductsWithBLOBs();
            officeProductsWithBLOBs.setProCode(String.valueOf(date.getTime()));
            officeProductsWithBLOBs.setProCreator(users.getUserId());
            officeProductsWithBLOBs.setProCreatorName(users.getUserName());
            json.setObject(officeProductsWithBLOBs);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }

        return json;
    }

    public ToJson getOfficeTypeByNameList(HttpServletRequest request,String proId,String typeId,String depositoryName){
        ToJson toJson=new ToJson();
        try{
            Map map=new HashMap();
            map.put("proId",proId);
            map.put("typeId",typeId);
            map.put("depositoryName",depositoryName);
            List<OfficeProductsWithBLOBs> list=officeProductsMapper.selProByNameList(map);
            toJson.setFlag(0);
            toJson.setMsg("true");
            toJson.setObj(list);
        }catch (Exception e){
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }



}
