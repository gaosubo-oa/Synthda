package com.xoa.service.officesupplies;

import com.xoa.dao.officesupplies.OfficeInventoryInfoMapper;
import com.xoa.model.officesupplies.OfficeInventoryInfo;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OfficeInventoryInfoService {

    @Resource
    private OfficeInventoryInfoMapper officeInventoryInfoMapper;

    // 查询办公用品库存盘点详情
    public ToJson<OfficeInventoryInfo> selectOfficeInventoryInfo(HttpServletRequest request, HttpServletResponse response, Integer page, Integer pageSize, boolean useFlag, OfficeInventoryInfo officeInventoryInfo) {
        ToJson<OfficeInventoryInfo> toJson = new ToJson<>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        PageParams pageParams = new PageParams(useFlag, page, pageSize);
        Map<String, Object> map = new HashMap<>();
        map.put("pageParams", pageParams);
        map.put("inventoryId", officeInventoryInfo.getInventoryId());
        map.put("proName", officeInventoryInfo.getProName());
        List<OfficeInventoryInfo> officeInventoryInfoList = officeInventoryInfoMapper.selectOfficeInventoryInfo(map);
        if (!CollectionUtils.isEmpty(officeInventoryInfoList)) {
            toJson.setFlag(0);
            toJson.setMsg("ok");
            toJson.setObj(officeInventoryInfoList);
            toJson.setTotleNum(pageParams.getTotal());

            // 导出
            if (!StringUtils.checkNull(officeInventoryInfo.getIsExport()) && "1".equals(officeInventoryInfo.getIsExport())) {
                for (OfficeInventoryInfo inventoryInfo : officeInventoryInfoList) {
                    if (inventoryInfo.getLastInventoryDate() != null) {
                        inventoryInfo.setLastInventoryDateStr(DateFormat.getDatestr(inventoryInfo.getLastInventoryDate()));
                    }
                }
                HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("办公用品盘点详情", 8);
                String[] secondTitles = {"办公用品名称", "所属分类", "规格/型号", "上期盘点时间", "上期结余", "账面数量", "实际盘点数", "备注"};
                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                String[] beanProperty = {"proName", "officeProtypeName", "proDesc", "lastInventoryDateStr", "oldBalance", "bookQuantity", "actualDiskCount", "inventoryInfoDesc"};
                HSSFWorkbook workbook;
                try {
                    workbook = ExcelUtil.exportExcelData(workbook2, officeInventoryInfoList, beanProperty);
                    OutputStream out = response.getOutputStream();
                    String filename = "办公用品盘点详情.xls";
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
}
