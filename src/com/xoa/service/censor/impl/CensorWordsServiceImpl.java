package com.xoa.service.censor.impl;

import com.xoa.dao.censor.CensorWordsMapper;
import com.xoa.model.censor.CensorWords;
import com.xoa.model.users.Users;
import com.xoa.service.censor.CensorWordsService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ExcelUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.*;

@Service
public class CensorWordsServiceImpl implements CensorWordsService {
    @Resource
    private CensorWordsMapper censorWordsMapper;

    /**
     * 创建作者:   朱新元
     * 创建日期:   2018年4月18日
     * 方法介绍:   新建词语定义
     * @param censorWords
     * @return
     */
    @Override
    public ToJson<CensorWords> addCensorWords(HttpServletRequest request, CensorWords censorWords) {
        ToJson<CensorWords> toJson = new ToJson<>(1,"err");
        try {
            HashMap<String,Object> map = new HashMap<>();
            map.put("find",censorWords.getFind());
            List<CensorWords> list = censorWordsMapper.getcensorWordsById(map);
            if(list != null&&list.size()>0){
                toJson.setMsg("isExist");
                toJson.setFlag(0);
                return toJson;
            }
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            censorWords.setUid(users.getUid());
            int a = censorWordsMapper.addCensorWords(censorWords);
            if (a>0){
                toJson.setMsg("ok");
                toJson.setFlag(0);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }


    /**
     * 创建作者:   朱新元
     * 创建日期:   2018年4月18日
     * 方法介绍:   根据id删除记录
     * @param wordId
     * @return
     */
    @Override
    public ToJson<CensorWords> delCensorWords(HttpServletRequest request, Integer wordId) {
        ToJson<CensorWords> toJson = new ToJson<>(1,"err");
        try {
            if (wordId!=0){
                censorWordsMapper.delCensorWordsById(wordId);
            }
            toJson.setMsg("ok");
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    /**
     * 创建作者:   朱新元
     * 创建日期:   2018年4月18日
     * 方法介绍:   编辑
     * @param censorWords
     * @return
     */
    @Override
    public ToJson<CensorWords> updateCensorWords(HttpServletRequest request, CensorWords censorWords) {
        ToJson<CensorWords> toJson = new ToJson<>(1,"err");
        try {
            HashMap<String,Object> map = new HashMap<>();
            map.put("find",censorWords.getFind());
            List<CensorWords> list = censorWordsMapper.getcensorWordsById(map);
            for(CensorWords censorWords1:list){
                if(!censorWords1.getWordId().equals(censorWords.getWordId())){
                    toJson.setMsg("isExist");
                    toJson.setFlag(0);
                    return toJson;
                }
            }
            int a = censorWordsMapper.updateCensorWords(censorWords);
            if (a>0){
                toJson.setMsg("ok");
                toJson.setFlag(0);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }


    /**
     * 创建作者:   朱新元
     * 创建日期:   2018年4月18日
     * 方法介绍:   根据id获取数据
     * @param wordId
     * @return
     */
    @Override
    public ToJson<CensorWords> getCensorWordsInforById(HttpServletRequest request, Integer wordId) {
        ToJson<CensorWords> toJson = new ToJson<>(1,"err");
        try {
            CensorWords censorWords = censorWordsMapper.getCensorWordsInforById(wordId);
            toJson.setObject(censorWords);
            toJson.setMsg("ok");
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }


    /**
     * 创建作者:   朱新元
     * 创建日期:   2018年4月18日
     * 方法介绍:   获取列表
     * @param censorWords
     * @param page
     * @param pageSize
     * flag 1-导出，2-删除,查询-默认空字符串
     * @return
     */
    @Override
    public ToJson<CensorWords> getCensorWords(HttpServletResponse response,Integer page, Integer pageSize, boolean useFlag, HttpServletRequest request, CensorWords censorWords, String flag) {
        ToJson<CensorWords> toJson = new ToJson<>(1,"err");
        try {
            Map<String,Object> map = new HashMap<>();
            PageParams pageParams = new PageParams();
            if(StringUtils.checkNull(flag)){
                pageParams.setPage(page);
                pageParams.setPageSize(pageSize);
                pageParams.setUseFlag(useFlag);
                map.put("page",pageParams);
            }
            map.put("censorWords",censorWords);
            List<CensorWords> list = censorWordsMapper.getCensorWords(map);
            if("1".equals(flag)){//导出
                HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("词语过滤信息", 9);
                String[] secondTitles = {"不良词语", "替换词语"};
                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                String[] beanProperty = {"find","replacement"};
                HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, list, beanProperty);
                ServletOutputStream out = response.getOutputStream();

                String filename = "词语过滤信息.xls"; //考虑多语言
                filename = FileUtils.encodeDownloadFilename(filename,
                        request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("content-disposition",
                        "attachment;filename=" + filename);
                workbook.write(out);
                out.close();
            }
            if("2".equals(flag)){//删除
                StringBuffer sb=new StringBuffer();
                for(CensorWords censorWords1:list){
                   sb.append(censorWords1.getWordId());
                }
                if(!StringUtils.checkNull(sb.toString())){
                    String[] wordIdArr=sb.toString().split(",");
                    int count=censorWordsMapper.batchDel(wordIdArr);
                }
            }
            toJson.setObj(list);
            toJson.setTotleNum(pageParams.getTotal());
            toJson.setMsg("ok");
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    public  ToJson<CensorWords> inputCensorWord(HttpServletRequest request,MultipartFile file) throws Exception {
        ToJson<CensorWords> json = new ToJson<CensorWords>(1, "error");
        try {
            //判读当前系统
            //读取配置文件
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            ResourceBundle rb = ResourceBundle.getBundle("upload");
            String osName = System.getProperty("os.name");
            StringBuffer path = new StringBuffer();
            StringBuffer buffer=new StringBuffer();
      /*  if (os.toLowerCase().startsWith("win")) {
            sb = sb.append(rb.getString("upload.win"));
        } else {
            sb = sb.append(rb.getString("upload.linux"));
        }*/
            if(osName.toLowerCase().startsWith("win")){
                //sb=sb.append(rb.getString("upload.win"));
                //判断路径是否是相对路径，如果是的话，加上运行的路径
                String uploadPath = rb.getString("upload.win");
                if(uploadPath.indexOf(":")==-1){
                    //获取运行时的路径
                    String basePath = this.getClass().getClassLoader().getResource(".").getPath()+File.pathSeparator;
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
            int success=0;
            int fail=0;
            String reason="";
            // 判断是否为空文件
            if (file.isEmpty()) {
                json.setMsg("请上传文件！");
                json.setFlag(1);
                return json;
            } else {
                CensorWords temp=new CensorWords();
                String fileName = file.getOriginalFilename();
                if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")) {
                    String uuid = UUID.randomUUID().toString().replaceAll("-", "");
                    int pos = fileName.indexOf(".");
                    String extName = fileName.substring(pos);
                    String newFileName = uuid + extName;
                    File dest = new File(path.toString());
                    if(!dest.exists()){
                        dest.mkdirs();
                    }
                    File destFile =new File(dest,newFileName);
                    if(!destFile.exists()){
                        destFile.createNewFile();
                    }
                    file.transferTo(destFile);
                    // 将文件上传成功后进行读取文件
                    // 进行读取的路径
                    String readPath = path.append(System.getProperty("file.separator")).append(newFileName).toString();
                    InputStream in = new FileInputStream(readPath);
                    HSSFWorkbook excelObj = new HSSFWorkbook(in);
                    HSSFSheet sheetObj = excelObj.getSheetAt(0);
                    Row row = sheetObj.getRow(0);
                    int lastRowNum = sheetObj.getLastRowNum();
                    Map<String,Integer> map=new HashMap<>();
                    map.put("find",0);
                    map.put("replacement",1);
                    for (int i = 2; i <= lastRowNum; i++) {
                        row = sheetObj.getRow(i);
                        Cell cell = row.getCell(1);
                        CensorWords censorWords = ExcelUtil.setCellInfoToModel(row, CensorWords.class, new CensorWords(), map);
                        censorWords.setUid(user.getUid());
                        HashMap<String,Object> paramMap = new HashMap<>();
                        paramMap.put("find",censorWords.getFind());
                        List<CensorWords> list = censorWordsMapper.getcensorWordsById(paramMap);
                        if(list != null&&list.size()>0){
                            reason="isExist";
                            fail++;
                            continue;
                        }
                        if(list == null||list.size()==0){
                            success += censorWordsMapper.addCensorWords(censorWords);
                        }
                    }
                    temp.setSuccess(success);
                    temp.setFail(fail);
                    temp.setReason(reason);
                    json.setFlag(0);
                    json.setMsg("ok");
                    json.setObject(temp);
                    destFile.delete();
                } else {
                    json.setMsg("文件类型不正确！");
                    return json;
                }
            }
        } catch (Exception e) {
            json.setMsg("数据保存异常");
            e.printStackTrace();
            L.e("CensorWordsServiceImpl inputCensorWord:"+e);
        }
        return json;
    }
}
