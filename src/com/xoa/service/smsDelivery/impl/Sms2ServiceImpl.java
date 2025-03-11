package com.xoa.service.smsDelivery.impl;


import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.sms2.Sms2Mapper;
import com.xoa.dao.smsSettings.SmsSettingsMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.department.Department;
import com.xoa.model.sms2.Sms2;
import com.xoa.model.sms2.Sms2dto;
import com.xoa.model.smsSettings.SmsSettings;
import com.xoa.model.users.Users;
import com.xoa.service.smsDelivery.Sms2PrivService;
import com.xoa.service.smsDelivery.Sms2Service;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.page.PageParams;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class Sms2ServiceImpl implements Sms2Service {

    @Resource
    private Sms2Mapper sms2Mapper;
    @Resource
    private SmsSettingsMapper smsSettingsMapper;
    @Resource
    private Sms2PrivService sms2PrivService;
    @Resource
    private UsersMapper usersMapper;
    @Resource
    private DepartmentMapper departmentMapper;

    @Override
    public ToJson<Sms2> selectSms2(HttpServletRequest request, HttpServletResponse response, Integer page, Integer pageSize, boolean useFlag, Sms2 sms2,String beginDate, String endDate, String fromIds) {

        ToJson<Sms2> json = new ToJson<Sms2>();
        PageParams pageParams = new PageParams();

        try {
            Map<String, Object> map = new HashMap<String, Object>();
            SimpleDateFormat dtf = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:SS");
            //   格式化时间  开始00.00.00    结束23.59.59
            if (!StringUtils.checkNull(beginDate)){
                Date beginDate1 = dtf.parse(beginDate);
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(beginDate1);
                //获取年
                int year = calendar.get(Calendar.YEAR);
                //获取月份，0表示1月份
                int month = calendar.get(Calendar.MONTH) + 1;
                //获取日
                int lastDay = calendar.get(Calendar.DAY_OF_MONTH);
                Date beginDate2 = format.parse(year + "-" + month + "-" + lastDay + " 00:00:00");
                map.put("beginDate",beginDate2);
            }
            if (!StringUtils.checkNull(endDate)){
                Date endDate1 = dtf.parse(endDate);
                Calendar calendar2 = Calendar.getInstance();
                calendar2.setTime(endDate1);
                int year2 = calendar2.get(Calendar.YEAR);
                int month2 = calendar2.get(Calendar.MONTH) + 1;
                int lastDay2 = calendar2.get(Calendar.DAY_OF_MONTH);
                Date endDate2 = format.parse(year2 + "-" + month2 + "-" + lastDay2 + " 23:59:59");
                map.put("endDate",endDate2);
            }
            List<String> mobils = sms2Mapper.selectDisPhones(map);//查询到表中的所有不同的收件人手机号，存入数组查询对应全部收件人信息
            String[] mobilString = new String[mobils.size()];
            if (mobils.size()!=0){
                for (int i=0;i<mobilString.length;i++){
                    mobilString[i] = mobils.get(i);
                }
            }
            List<Users> usersList = usersMapper.selectUsersByMobilNos(mobilString);
            // List<Sms2> list = sms2Mapper.selectSms2(map);//改前代码
            if (!fromIds.equals("")){
                String [] str = fromIds.split(",");
                map.put("fromIds",str);
            }
            map.put("sms2",sms2);
            List<Sms2> sms2s = sms2Mapper.selectMSms(map);
            String[] formIds = new String[sms2s.size()];
            for (int i = 0; i < formIds.length; i++) {
                formIds[i] = sms2s.get(i).getFromId();
            }
            List<Users> users = usersMapper.getUsersByUserIdsOrderByDeptId(formIds);
            if (sms2.getPhone()!=null && !sms2.getPhone().equals("")){
                //外部收件人手机号就能输入一个
                Users user = usersMapper.selectUserByMobilNo(sms2.getPhone());
                if (user != null){
                    users.add(user);
                }
            }
            for (Sms2 sms : sms2s) {
                for (Users user : users) {
                    if (sms.getFromId().equals(user.getUserId())){
                        sms.setFromName(user.getUserName());
                    }
                }
            }
          /*  SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(pzFullRelease.getpOutPrisonTime());
            pzFullRelease.setOutTime(format);

            String format1 = sdf.format(pzFullRelease.getpJoinDate());
            pzFullRelease.setJoinDate(format1);*/

           /* Integer smsCountByMap = sms2Mapper.getSmsCountByMap(map);*/

            for (Sms2 sms : sms2s) {
                for (Users use : usersList) {
                    if (sms.getPhone().equals(use.getMobilNo())){
                        sms.setRecipientName(use.getUserName());
                        break;
                    }else {
                        sms.setRecipientName("外部人员");
                    }
                }
            }
            if (sms2s.size() > 0) {
                json.setTotleNum(sms2s.size());
                //分页
                List<Sms2> sms2List = new ArrayList<>();
                if (sms2s.size()>pageSize*page){
                    for (int i=0+pageSize*(page-1);i<pageSize*page;i++){
                        sms2List.add(sms2s.get(i));
                    }
                    json.setObj(sms2List);
                }else {
                    for (int i=0+pageSize*(page-1);i<sms2s.size();i++){
                        sms2List.add(sms2s.get(i));
                    }
                    json.setObj(sms2List);
                }
                json.setMsg("查询成功");
                json.setFlag(0);
            }else {
                json.setMsg("查询无数据");
                json.setFlag(0);
            }
        } catch (Exception e) {

            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;

    }

    @Transactional
    public ToJson selectSms2ById(HttpServletRequest request, Integer smsId) {
        ToJson<Sms2> json = new ToJson<Sms2>();
        try {
            Sms2 sms2 = sms2Mapper.selectByPrimaryKey(smsId);
          /*  SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(pzFullRelease.getpOutPrisonTime());
            pzFullRelease.setOutTime(format);

            String format1 = sdf.format(pzFullRelease.getpJoinDate());
            pzFullRelease.setJoinDate(format1);*/

            json.setObject(sms2);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {

            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }

    @Transactional
    public ToJson insertSms2(Sms2 sms2) {
        ToJson<Sms2> toJson = new ToJson<Sms2>(1, "error");
        try {
            int temp = sms2Mapper.insertSelective(sms2);
            if (temp > 0) {
                toJson.setFlag(0);
                toJson.setMsg("success");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return toJson;

    }

    @Transactional
    public ToJson delSms2(Sms2 sms2,String beginDate, String endDate, String smsIds, String fromIds) {
        ToJson toJson = new ToJson(1, "error");
        Map map = new HashMap();
        try {
            if (sms2 != null && StringUtils.checkNull(smsIds)){
                SimpleDateFormat dtf = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:SS");
                //   格式化时间  开始00.00.00    结束23.59.59
                if (!StringUtils.checkNull(beginDate)){
                    Date beginDate1 = dtf.parse(beginDate);
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(beginDate1);
                    //获取年
                    int year = calendar.get(Calendar.YEAR);
                    //获取月份，0表示1月份
                    int month = calendar.get(Calendar.MONTH) + 1;
                    //获取日
                    int lastDay = calendar.get(Calendar.DAY_OF_MONTH);
                    Date beginDate2 = format.parse(year + "-" + month + "-" + lastDay + " 00:00:00");
                    map.put("beginDate",beginDate2);
                }
                if (!StringUtils.checkNull(endDate)){
                    Date endDate1 = dtf.parse(endDate);
                    Calendar calendar2 = Calendar.getInstance();
                    calendar2.setTime(endDate1);
                    int year2 = calendar2.get(Calendar.YEAR);
                    int month2 = calendar2.get(Calendar.MONTH) + 1;
                    int lastDay2 = calendar2.get(Calendar.DAY_OF_MONTH);
                    Date endDate2 = format.parse(year2 + "-" + month2 + "-" + lastDay2 + " 23:59:59");
                    map.put("endDate",endDate2);
                }
                // int temp = sms2Mapper.delSms2(sms2);
                if (!fromIds.equals("")){
                    String [] str = fromIds.split(",");
                    map.put("fromIds",str);
                }
                map.put("sms2",sms2);
                int temp = sms2Mapper.delMSms(map);
                if (temp == 0){
                    List<Sms2> sms2s = sms2Mapper.selectMSms(map);
                    if (sms2s.size()==0){
                        toJson.setFlag(0);
                        toJson.setMsg("无删除数据");
                    }
                }
                if (temp > 0) {
                    toJson.setFlag(0);
                    toJson.setMsg("删除成功");
                }
            }else {
                String[] smsidArry = smsIds.split(",");
                int[] smsids = new int[smsidArry.length];//转换为int数组删除
                for (int i = 0; i < smsids.length; i++) {
                    smsids[i] = Integer.parseInt(smsidArry[i]);
                }
                map.put("smsIds",smsids);
                int temp = sms2Mapper.delMSms(map);
                if (temp > 0){
                    toJson.setFlag(0);
                    toJson.setMsg("删除成功");
                }
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }
    @Transactional
    public ToJson upSms2(Sms2 sms2) {
        ToJson toJson = new ToJson<>(1, "error");
        try {
            int temp = sms2Mapper.updateByPrimaryKeySelective(sms2);
            if (temp > 0) {
                toJson.setFlag(0);
                toJson.setMsg("success");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;

    }

    @Override
    public ToJson SendSms() {
        return null;
    }

    @Override
    public BaseWrapper sendMessageByExcel(MultipartFile file){
        BaseWrapper baseWrapper=new BaseWrapper();
        //读取当前配置
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
        // 判断是否为空文件
        if (file.isEmpty()) {
            baseWrapper.setMsg("请上传文件！");
            baseWrapper.setFlag(true);
            return baseWrapper;
        } else {
            File file1 = new File(path.toString());
            if (!file1.exists()) {
                file1.mkdirs();
            }
            String fileName = file.getOriginalFilename();
            if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")) {
                String uuid = UUID.randomUUID().toString().replaceAll("-", "");
                int pos = fileName.indexOf(".");
                String extName = fileName.substring(pos);
                String newFileName = uuid + extName;
                File dest = new File(path.toString(), newFileName);
                // 将文件上传成功后进行读取文件
                // 进行读取的路径
                String readPath = path.append(System.getProperty("file.separator")).append(newFileName).toString();

                try{
                    file.transferTo(dest);
                    InputStream is = new FileInputStream(readPath);
                    HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
                    // 循环工作表Sheet
                    StringBuffer contextString=new StringBuffer();
                    StringBuffer mobileString=new StringBuffer();
                    Map<String,Object> map=new HashMap<>();
                    List<SmsSettings> list = smsSettingsMapper.selectSmsSettings(map);
                    for(SmsSettings smsSettings:list){
                        smsSettings.setSign("sign="+smsSettings.getSign());
                    }
                    for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
                        HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
                        if (hssfSheet == null) {
                            continue;
                        }
                        // 循环行Row
                        for (int rowNum = 3; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
                            HSSFRow hssfRow = hssfSheet.getRow(rowNum);
                            if (hssfRow != null) {
                                HSSFCell mobiemodel = hssfRow.getCell(0);
                                HSSFCell contentmodel = hssfRow.getCell(1);
                                if (mobiemodel != null && contentmodel != null) {
                                    String mobie=mobiemodel.getStringCellValue();
                                    String content=contentmodel.getStringCellValue();
                                    mobileString.setLength(0);
                                    contextString.setLength(0);
                                    mobileString.append(mobie);
                                    contextString.append(content);
                                    if (!StringUtils.checkNull(mobileString.toString())&&!StringUtils.checkNull(contextString.toString())) {
                                        //发送短信
                                        ToJson toJson = sms2PrivService.smsSenderMobiles(contextString, mobileString.toString());
                                        if("ok".equals(toJson.getMsg())){
                                            baseWrapper.setMsg("发送成功");
                                            baseWrapper.setFlag(true);
                                            baseWrapper.setStatus(true);
                                        }
                                    }
                                }
                            }
                        }

                    }
                    //导入结束 删除文件
                    dest.delete();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
        return  baseWrapper;
    }

    @Override
    public ToJson sendSmsByUserOrDept(String beginDate, String endDate, String way, Integer page, Integer pageSize, boolean useFlag) {
        ToJson toJson = new ToJson(1,"查询失败");
        Map map = new HashMap();
        Map dateMape = new HashMap();
        dateMape.put("beginDate",beginDate);
        dateMape.put("endDate",endDate);
        PageParams pageParams = new PageParams();
        try {
            SimpleDateFormat dtf = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:SS");
            //   格式化时间  开始00.00.00    结束23.59.59
            if (!StringUtils.checkNull(beginDate)){
                Date beginDate1 = dtf.parse(beginDate);
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(beginDate1);
                //获取年
                int year = calendar.get(Calendar.YEAR);
                //获取月份，0表示1月份
                int month = calendar.get(Calendar.MONTH) + 1;
                //获取日
                int lastDay = calendar.get(Calendar.DAY_OF_MONTH);
                Date beginDate2 = format.parse(year + "-" + month + "-" + lastDay + " 00:00:00");
                map.put("beginDate",beginDate2);
            }
            if (!StringUtils.checkNull(endDate)){
                Date endDate1 = dtf.parse(endDate);
                Calendar calendar2 = Calendar.getInstance();
                calendar2.setTime(endDate1);
                int year2 = calendar2.get(Calendar.YEAR);
                int month2 = calendar2.get(Calendar.MONTH) + 1;
                int lastDay2 = calendar2.get(Calendar.DAY_OF_MONTH);
                Date endDate2 = format.parse(year2 + "-" + month2 + "-" + lastDay2 + " 23:59:59");
                map.put("endDate",endDate2);
            }
            //"1"按人员    "2"按部门
            if (way.equals("1")){
                pageParams.setPage(page);
                pageParams.setPageSize(pageSize);
                pageParams.setUseFlag(useFlag);
                map.put("page",pageParams);
                List<Sms2dto> sms2dtoList = new ArrayList<>();
                List<String> fromIds = sms2Mapper.selectDisFromIds(map);
                String[] userIds = new String[fromIds.size()];//转换为数组调用user中sql
                for (int i = 0; i < userIds.length; i++) {
                    userIds[i] = fromIds.get(i);
                }
                if (userIds.length==0){
                    toJson.setFlag(0);
                    toJson.setMsg("查询无数据");
                    return toJson;
                }
                List<Users> users = usersMapper.getUsersByUserIdsOrderByDeptId(userIds);
                String[] deptIds = new String[users.size()];
                for (int i = 0; i < deptIds.length; i++) {
                    deptIds[i] = String.valueOf(users.get(i).getDeptId());
                }
                List<Department> departments = departmentMapper.userDeptOrder(deptIds);
                for (Users user : users) {
                    for (Department department : departments) {
                        if (user.getDeptId().equals(department.getDeptId())){
                            map.put("fromId",user.getUserId());
                            map.remove("page");
                            int count = sms2Mapper.countByFromId(map);
                            Sms2dto sms2dto = new Sms2dto();
                            sms2dto.setFromId(user.getUserId());
                            sms2dto.setDeptId(user.getDeptId());
                            sms2dto.setFromName(user.getUserName());
                            sms2dto.setDeptName(department.getDeptName());
                            sms2dto.setCount(count);
                            sms2dtoList.add(sms2dto);
                        }
                    }
                }
                if (sms2dtoList.size()>0){
                    toJson.setTotleNum(pageParams.getTotal());
                    toJson.setObject(dateMape);
                    toJson.setObj(sms2dtoList);
                    toJson.setFlag(0);
                    toJson.setMsg("查询成功");
                }else {
                    toJson.setFlag(0);
                    toJson.setMsg("查询无数据");
                }
            }else if (way.equals("2")){
                List<Sms2dto> sms2dtoList = new ArrayList<>();
                List<String> fromIds = sms2Mapper.selectDisFromIds(map);
                String[] userIds = new String[fromIds.size()];//转换为数组调用user中sql
                if (userIds.length==0){
                    toJson.setFlag(0);
                    toJson.setMsg("查询无数据");
                    return toJson;
                }
                for (int i = 0; i < userIds.length; i++) {
                    userIds[i] = fromIds.get(i);
                }
                List<Users> users = usersMapper.getUsersByUserIdsOrderByDeptId(userIds);
                String[] deptIds = new String[users.size()];
                for (int i = 0; i < deptIds.length; i++) {
                    deptIds[i] = String.valueOf(users.get(i).getDeptId());
                }
                List<Department> departments = departmentMapper.userDeptOrder(deptIds);
                for (Users user : users) {
                    for (Department department : departments) {
                        if (user.getDeptId().equals(department.getDeptId())){
                            map.put("fromId",user.getUserId());
                            map.remove("page");
                            int count = sms2Mapper.countByFromId(map);
                            Sms2dto sms2dto = new Sms2dto();
                            sms2dto.setDeptId(user.getDeptId());
                            sms2dto.setDeptName(department.getDeptName());
                            sms2dto.setCount(count);
                            sms2dtoList.add(sms2dto);
                        }
                    }
                }
                List<Sms2dto> sms2dtos = new ArrayList<>();
                if (sms2dtoList.size() != 1){
                    for (int i=0;i<sms2dtoList.size();i++){
                        Integer count = sms2dtoList.get(i).getCount();          //赋值当前对象的count
                        for (int j=i+1;j<sms2dtoList.size();j++){               //循环此对象判断下一个是否与这个是同一部门   是，cont相加、否，下一个
                            if (sms2dtoList.get(i).getDeptName().equals(sms2dtoList.get(j).getDeptName())){
                                count = sms2dtoList.get(j).getCount() + count;
                                sms2dtoList.remove(j);
                            }
                        }
                        Sms2dto sms2dto = new Sms2dto();
                        sms2dto.setDeptId(sms2dtoList.get(i).getDeptId());
                        sms2dto.setDeptName(sms2dtoList.get(i).getDeptName());
                        sms2dto.setCount(count);
                        sms2dtos.add(sms2dto);
                    }
                    if (sms2dtos.size()>0){
                        toJson.setTotleNum(sms2dtos.size());
                        //将时间数据传回用于删除
                        toJson.setObject(dateMape);
                        //分页
                        List<Sms2dto> sms2dtoArry = new ArrayList<>();
                        if (sms2dtos.size()>pageSize*page){
                            for (int i=0+pageSize*(page-1);i<pageSize*page;i++){
                                sms2dtoArry.add(sms2dtos.get(i));
                            }
                            toJson.setObj(sms2dtoArry);
                        }else {
                            for (int i=0+pageSize*(page-1);i<sms2dtos.size();i++){
                                sms2dtoArry.add(sms2dtos.get(i));
                            }
                            toJson.setObj(sms2dtoArry);
                        }
                        toJson.setFlag(0);
                        toJson.setMsg("查询成功");
                    }else {
                        toJson.setFlag(0);
                        toJson.setMsg("查询无数据");
                    }
                }else {
                    toJson.setObject(dateMape);
                    toJson.setTotleNum(1);
                    toJson.setObj(sms2dtoList);
                    toJson.setFlag(0);
                    toJson.setMsg("查询成功");
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson delSmsByUserOrDept(String beginDate, String endDate, String fromId, Integer deptId) {
        ToJson toJson = new ToJson(1,"删除失败");
        Map map = new HashMap();
        try {
            SimpleDateFormat dtf = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:SS");
            //   格式化时间  开始00.00.00    结束23.59.59
            if (!StringUtils.checkNull(beginDate)){
                Date beginDate1 = dtf.parse(beginDate);
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(beginDate1);
                //获取年
                int year = calendar.get(Calendar.YEAR);
                //获取月份，0表示1月份
                int month = calendar.get(Calendar.MONTH) + 1;
                //获取日
                int lastDay = calendar.get(Calendar.DAY_OF_MONTH);
                Date beginDate2 = format.parse(year + "-" + month + "-" + lastDay + " 00:00:00");
                map.put("beginDate",beginDate2);
            }
            if (!StringUtils.checkNull(endDate)){
                Date endDate1 = dtf.parse(endDate);
                Calendar calendar2 = Calendar.getInstance();
                calendar2.setTime(endDate1);
                int year2 = calendar2.get(Calendar.YEAR);
                int month2 = calendar2.get(Calendar.MONTH) + 1;
                int lastDay2 = calendar2.get(Calendar.DAY_OF_MONTH);
                Date endDate2 = format.parse(year2 + "-" + month2 + "-" + lastDay2 + " 23:59:59");
                map.put("endDate",endDate2);
            }
            if (!StringUtils.checkNull(fromId)){
                map.put("fromId",fromId);
                int i = sms2Mapper.delSms2ByMap(map);
                if (i==0){
                    int count = sms2Mapper.countByFromId(map);
                    if (count==0){
                        toJson.setMsg("无删除数据");
                    }
                }
                if (i>0){
                    toJson.setFlag(0);
                    toJson.setMsg("删除成功");
                }
            }
            if (deptId != null){
                List<Users> usersList = usersMapper.getUsersByPId(deptId);//这里查询到的是该部门下所有人员
                String[] userIds = new String[usersList.size()];
                for (int i = 0; i < userIds.length; i++) {
                    userIds[i] = usersList.get(i).getUserId();//数组中是当前部门下所有人员
                }
                map.put("fromIds",userIds);
                int i = sms2Mapper.delSms2ByMap(map);
                if (i==0){
                    toJson.setMsg("无删除数据");
                }
                if (i>0){
                    toJson.setFlag(0);
                    toJson.setMsg("删除成功");
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }
}
