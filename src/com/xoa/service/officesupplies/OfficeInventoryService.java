package com.xoa.service.officesupplies;

import com.alibaba.fastjson.JSONArray;
import com.xoa.dao.officesupplies.OfficeInventoryInfoMapper;
import com.xoa.dao.officesupplies.OfficeInventoryMapper;
import com.xoa.dao.officesupplies.OfficeProductsMapper;
import com.xoa.model.officesupplies.OfficeInventory;
import com.xoa.model.officesupplies.OfficeInventoryInfo;
import com.xoa.model.officesupplies.OfficeProductsWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.ExcelUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OfficeInventoryService {

    @Resource
    private OfficeInventoryMapper officeInventoryMapper;

    @Resource
    private OfficeInventoryInfoMapper officeInventoryInfoMapper;

    @Resource
    private OfficeProductsMapper officeProductsMapper;

    // 查询办公用品库存盘点
    public ToJson<OfficeInventory> selectOfficeInventory(HttpServletRequest request, HttpServletResponse response, Integer page, Integer pageSize, boolean useFlag, OfficeInventory officeInventory) {
        ToJson<OfficeInventory> toJson = new ToJson<>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        PageParams pageParams = new PageParams(useFlag, page, pageSize);
        Map<String, Object> map = new HashMap<>();
        map.put("pageParams", pageParams);
        map.put("inventoryName", officeInventory.getInventoryName());
        List<OfficeInventory> officeInventoryList = officeInventoryMapper.selectOfficeInventory(map);
        if (!CollectionUtils.isEmpty(officeInventoryList)) {
            toJson.setFlag(0);
            toJson.setMsg("ok");
            toJson.setObj(officeInventoryList);
            toJson.setTotleNum(pageParams.getTotal());

            // 导出
            if (!StringUtils.checkNull(officeInventory.getIsExport()) && "1".equals(officeInventory.getIsExport())) {
                for (OfficeInventory inventory : officeInventoryList) {
                    if (inventory.getInventoryDate() != null) {
                        inventory.setInventoryDateStr(DateFormat.getDatestr(inventory.getInventoryDate()));
                    }
                }
                HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("办公用品盘点", 3);
                String[] secondTitles = {"盘点名称", "盘点维度", "盘点时间", "盘点操作员"};
                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                String[] beanProperty = {"inventoryName", "inventoryDimension", "inventoryDateStr", "inventoryOperatorName"};
                HSSFWorkbook workbook;
                try {
                    workbook = ExcelUtil.exportExcelData(workbook2, officeInventoryList, beanProperty);
                    OutputStream out = response.getOutputStream();
                    String filename = "办公用品盘点.xls";
                    filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
                    response.setHeader("content-disposition", "attachment;filename=" + filename);
                    workbook.write(out);
                    out.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } else {
            toJson.setFlag(0);
            toJson.setMsg("暂无数据");
        }
        return toJson;
    }

    // 新增办公用品库存盘点
    public ToJson<OfficeInventory> addOfficeInventory(HttpServletRequest request, OfficeInventory officeInventory) {
        ToJson<OfficeInventory> toJson = new ToJson<>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        if (users != null && !StringUtils.checkNull(officeInventory.getInventoryName()) && !StringUtils.checkNull(officeInventory.getOfficeInventoryInfoJson())) {
            officeInventory.setInventoryDate(new Date()); // 盘点时间
            officeInventory.setInventoryOperator(users.getUserId()); // 盘点操作员
            // 新增物品库存盘点
            int count = officeInventoryMapper.addOfficeInventory(officeInventory);
            if (count > 0 && officeInventory.getInventoryId() != null) {
                List<OfficeInventoryInfo> officeInventoryInfoList = JSONArray.parseArray(officeInventory.getOfficeInventoryInfoJson(), OfficeInventoryInfo.class);
                if (!CollectionUtils.isEmpty(officeInventoryInfoList)) {
                    for (OfficeInventoryInfo officeInventoryInfo : officeInventoryInfoList) {
                        // 物品库存盘点记录
                        officeInventoryInfo.setInventoryId(officeInventory.getInventoryId());
                        officeInventoryInfoMapper.addOfficeInventoryInfo(officeInventoryInfo);

                        // 修改当前库存
                        OfficeProductsWithBLOBs officeProductsWithBLOBs = officeProductsMapper.selectByPrimaryKey(officeInventoryInfo.getProId());
                        if (officeProductsWithBLOBs != null && officeInventoryInfo.getActualDiskCount() != null) {
                            officeProductsWithBLOBs.setProStock(officeInventoryInfo.getActualDiskCount());
                            officeProductsMapper.updateByPrimaryKeySelective(officeProductsWithBLOBs);
                        }
                    }
                }

                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } else {
            toJson.setMsg("缺少参数");
        }
        return toJson;
    }
}
