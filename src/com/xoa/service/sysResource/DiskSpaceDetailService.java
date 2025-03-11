package com.xoa.service.sysResource;

import com.xoa.dao.email.EmailBodyMapper;
import com.xoa.dao.email.EmailMapper;
import com.xoa.dao.enclosure.AttachmentMapper;
import com.xoa.dao.sms.SmsBodyMapper;
import com.xoa.dao.sms.SmsMapper;
import com.xoa.dao.sys.TableStatisticsMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.email.EmailBodyModel;
import com.xoa.model.email.EmailModel;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.sys.TableStatistics;
import com.xoa.model.users.Users;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

;

/**
 * @author 左春晖
 * @date 2018/5/15 16:40
 * @desc
 */
@Service
public class DiskSpaceDetailService {

    @Resource
     EmailMapper emailMapper;

    @Resource
    EmailBodyMapper emailBodyMapper;

    @Resource
    SmsMapper smsMapper;

    @Resource
    SmsBodyMapper smsBodyMapper;

    @Resource
    UsersMapper usersMapper;

    @Resource
    TableStatisticsMapper tableStatisticsMapper;

    @Resource
    AttachmentMapper attachmentMapper;
    /**
     * 左春晖  18.5.16  18:00
     * 获取当前软件所在磁盘的 磁盘大小 可用 已用 。
     * @return
     */
    public static ToJson GetDiskSpaceDetail(){
        ToJson toJson = new ToJson();
        List<Object> list = new ArrayList<>();
        File diskPartition = new File(System.getProperty("user.dir"));//获取当前路径
        long totalCapacity = diskPartition.getTotalSpace();//总大小
        long freePartitionSpace = diskPartition.getFreeSpace();//可用大小
        long usedSpace  = totalCapacity - freePartitionSpace;//已用大小
        list.add(0,usedSpace);
        list.add(1,freePartitionSpace);
        list.add(2,totalCapacity);
        list.add(3,new BigDecimal(usedSpace).divide(new BigDecimal(1024*1024*1024),2,BigDecimal.ROUND_HALF_UP));
        list.add(4,new BigDecimal(freePartitionSpace).divide(new BigDecimal(1024*1024*1024),2,BigDecimal.ROUND_HALF_UP));
        list.add(5,new BigDecimal(totalCapacity).divide(new BigDecimal(1024*1024*1024),2,BigDecimal.ROUND_HALF_UP));
        toJson.setFlag(0);
        toJson.setMsg("OK");
        toJson.setObj(list);
        toJson.setTurn(true);
        return toJson;
    }
//    public static void main(String[] args) {
//
//        ToJson toJson = GetDiskSpaceDetail();
//        System.out.println((toJson.getObj().get(0)));
//        System.out.println(((toJson.getObj().get(1))));
//        System.out.println(((toJson.getObj().get(2))));
//        System.out.println((toJson.getObj().get(3))+"GB");
//        System.out.println(((toJson.getObj().get(4))+"GB"));
//        System.out.println(((toJson.getObj().get(5))+"GB"));
//    }

    /**
     * 左春晖  18.5.16   18:00
     * 查询信息 系统资源信息查询 注入进来直接查找就好。
     * @return
     */
    public  ToJson detail(HttpServletRequest request){
        ToJson toJson = new ToJson();
        List<TableStatistics> list = new ArrayList<>();
        list.add(tableStatisticsMapper.select("EMAIL"));//邮件
        list.add(tableStatisticsMapper.select("EMAIL_BODY"));//邮件总数
        list.add(tableStatisticsMapper.select("sms"));//提醒
        list.add(tableStatisticsMapper.select("SMS_BODY"));//提醒内容
       // list.add(tableStatisticsMapper.select(" MESSAGE"));//微讯
        list.add(tableStatisticsMapper.select("FLOW_RUN"));//工作流
        list.add(tableStatisticsMapper.select("FLOW_RUN_DATA")); //工作流数据
        list.add(tableStatisticsMapper.select("FILE_SORT"));//文件柜文件夹
        list.add(tableStatisticsMapper.select("FILE_CONTENT"));//文件柜文件
        list.add(tableStatisticsMapper.select("NOTIFY"));//公告通知
        list.add(tableStatisticsMapper.select("DIARY")); //工作日志
       // list.add(tableStatisticsMapper.select("BBS_COMMENT")); //内部讨论区
        String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        for (TableStatistics ta : list){
            if (ta.getName().equals("email")){
                ta.setName("邮件");
                if (locale.equals("zh_CN")) {
                    ta.setName("邮件");
                } else if (locale.equals("en_US")) {
                    ta.setName("mail");
                } else if (locale.equals("zh_TW")) {
                    ta.setName("郵件");
                }
            }
            if (ta.getName().equals("email_body")){
                ta.setName("邮件内容");
                if (locale.equals("zh_CN")) {
                    ta.setName("邮件内容");
                } else if (locale.equals("en_US")) {
                    ta.setName("Email Content");
                } else if (locale.equals("zh_TW")) {
                    ta.setName("郵件內容");
                }
            }
            if (ta.getName().equals("sms")){
                ta.setName("提醒");
                if (locale.equals("zh_CN")) {
                    ta.setName("提醒");
                } else if (locale.equals("en_US")) {
                    ta.setName("remind");
                } else if (locale.equals("zh_TW")) {
                    ta.setName("提醒");
                }
            }
            if (ta.getName().equals("sms_body")){
                ta.setName("提醒内容");
                if (locale.equals("zh_CN")) {
                    ta.setName("提醒内容");
                } else if (locale.equals("en_US")) {
                    ta.setName("Reminder content");
                } else if (locale.equals("zh_TW")) {
                    ta.setName("提醒内容");
                }
            }
            if (ta.getName().equals("flow_run")){
                ta.setName("工作流");
                if (locale.equals("zh_CN")) {
                    ta.setName("工作流");
                } else if (locale.equals("en_US")) {
                    ta.setName("Workflow");
                } else if (locale.equals("zh_TW")) {
                    ta.setName("工作流");
                }
            }
            if (ta.getName().equals("flow_run_data")){
                ta.setName("工作流数据");
                if (locale.equals("zh_CN")) {
                    ta.setName("工作流数据");
                } else if (locale.equals("en_US")) {
                    ta.setName("workflow data");
                } else if (locale.equals("zh_TW")) {
                    ta.setName("工作流數據");
                }
            }
            if (ta.getName().equals("file_sort")){
                ta.setName("文件柜文件夹");
                if (locale.equals("zh_CN")) {
                    ta.setName("文件柜文件夹");
                } else if (locale.equals("en_US")) {
                    ta.setName("File cabinet folder");
                } else if (locale.equals("zh_TW")) {
                    ta.setName("文件櫃資料夾");
                }
            }
            if (ta.getName().equals("file_content")){
                ta.setName("文件柜文件");
                if (locale.equals("zh_CN")) {
                    ta.setName("文件柜文件");
                } else if (locale.equals("en_US")) {
                    ta.setName("File cabinet files");
                } else if (locale.equals("zh_TW")) {
                    ta.setName("文件櫃檔案");
                }
            }
            if (ta.getName().equals("notify")){
                ta.setName("公告通知");
                if (locale.equals("zh_CN")) {
                    ta.setName("公告通知");
                } else if (locale.equals("en_US")) {
                    ta.setName("Announcement Notice");
                } else if (locale.equals("zh_TW")) {
                    ta.setName("公告通知");
                }
            }
            if (ta.getName().equals("diary")){
                ta.setName("工作日志");
                if (locale.equals("zh_CN")) {
                    ta.setName("工作日志");
                } else if (locale.equals("en_US")) {
                    ta.setName("Work Log");
                } else if (locale.equals("zh_TW")) {
                    ta.setName("工作日志");
                }
            }
            ta.setDatalength(ta.getDatalength() / 1024);
        }
            toJson.setFlag(0);
            toJson.setMsg("数据存在");
            toJson.setObject(list);
            toJson.setTurn(true);
        return toJson;
    }
    /**
     * 左春晖  18.5.17
     * 邮件监控
     */
    @SuppressWarnings("all")
    public ToJson<EmailBodyModel> selectEmail(EmailBodyModel emailBodyModel, Integer page, Integer pageSize, boolean useFlag) {
        ToJson tojson = new ToJson();
        Map<String,Object> maps = new HashMap<>();

        if (!StringUtils.checkNull(emailBodyModel.getFromId())){
            String[] str =(emailBodyModel.getFromId()).split(",");
            if(str!=null&&str.length>0){
                maps.put("fromId",str);//发信人ID串
            }
        }
        if (!StringUtils.checkNull(emailBodyModel.getToId2())){
            maps.put("toId2",emailBodyModel.getToId2());//接收人ID串
//            String[] str1 =(emailBodyModel.getToId2()).split(",");
//            if(str1!=null&&str1.length>0){ }

        }
        if (!StringUtils.checkNull(emailBodyModel.getSubject())){
            maps.put("Subject",emailBodyModel.getSubject());//主题
        }
        if (!StringUtils.checkNull(emailBodyModel.getAttachmentName())){
            maps.put("attachmentName",emailBodyModel.getAttachmentName());//附件
        }
        if (!StringUtils.checkNull(emailBodyModel.getContent())) {
            maps.put("content", emailBodyModel.getContent());//正文
        }
         if (!StringUtils.checkNull(emailBodyModel.getStartTimes())){
            maps.put("startTimes",DateFormat.getTime(emailBodyModel.getStartTimes()));//开始时间
        }
        if (!StringUtils.checkNull(emailBodyModel.getEndTimes())){
            maps.put("endTimes",DateFormat.getTime(emailBodyModel.getEndTimes()));//结束时间
        }
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        int total=emailBodyMapper.AllselectObjcetsCount(maps);
        maps.put("page", pageParams);
        //PageParams pageParams = new PageParams();
        //总条数
        //int total=emailBodyMapper.AllselectInt();
        //总页数
        //int totalPage = total/pageSize;
//        pageParams.setTotal(total);
//        pageParams.setTotalPage(totalPage);
//        pageParams.setUseFlag(useFlag);
//        pageParams.setPage(page);
//        pageParams.setPageSize(pageSize);
//        Integer start = (page - 1) * pageSize;
       // maps.put("start", start);
        //maps.put("pageSize", pageSize);
        List<EmailBodyModel> list = new ArrayList<EmailBodyModel>();
        List<EmailBodyModel> listEmai = emailBodyMapper.AllselectObjcets(maps);

        for (EmailBodyModel emailBody : listEmai) {

            //收件人
            Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());

            if (!ToMap.isEmpty()) {

                //循环遍历所有的收件人key值
                for(String key:ToMap.keySet()){
                    //获取对应的value值
                    String value = ToMap.get(key);
                    //如果value包含逗号则截取字符串
                    if(value.contains(",")){
                        String[] split = value.split(",");

                        //发件人
                        Map<String, String> ToMap1 = this.getEmailUserName(emailBody.getFromId());
//                        if (!ToMap.isEmpty()) {
//                            newEmailBody.setFromId(ToMap1.keySet().iterator().next());
//                            newEmailBody.setFromName(ToMap1.get(emailBody.getFromId()));
//                        }

                        for (int i = 0; i < split.length; i++) {
                            //   emailBody.setToId2(ToMap.keySet().iterator().next());
                            //  emailBody.setToName(ToMap.get(emailBody.getToId2()));
                            //lr
                            //收件人
                            EmailBodyModel ebm=new EmailBodyModel();
                            BeanUtils.copyProperties(emailBody, ebm);
                            ebm.setToName(split[i]);
                            //发件人
                            if (!ToMap.isEmpty()) {
                                ebm.setFromId(ToMap1.keySet().iterator().next());
                                ebm.setFromName(ToMap1.get(emailBody.getFromId()));
                            }
                            //时间
                            ebm.setSendTimeStr(DateFormat.getStrTime(emailBody.getSendTime()));
                            list.add(ebm);

                            }

                    }else {
                        emailBody.setToName(value);
                        //发件人
                        Map<String, String> ToMap1 = this.getEmailUserName(emailBody.getFromId());
                        if (!ToMap.isEmpty()) {
                            emailBody.setFromId(ToMap1.keySet().iterator().next());
                            emailBody.setFromName(ToMap1.get(emailBody.getFromId()));
                        }
                        emailBody.setSendTimeStr(DateFormat.getStrTime(emailBody.getSendTime()));
                        list.add(emailBody);
                    }

                }

            }


        }
        tojson.setMsg("OK");
        tojson.setFlag(0);
        tojson.setTurn(true);
        tojson.setObj(list);
        tojson.setTotleNum(total);
        return tojson;
    }
    /**
     * 批量邮件删除
     */

    public ToJson Allemaildelete(String[] bodyId){
        ToJson toJson = new ToJson();
        if (bodyId.length>0){
            int temp = emailBodyMapper.AlldeleteId(bodyId);
            if (temp > 0) {
                toJson.setFlag(0);
                toJson.setMsg("success");
            } else {
                toJson.setFlag(1);
                toJson.setMsg("false");
            }
        }
        return toJson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/7/1 10:29
     * 方法介绍:   姓名处理
     * 参数说明:
     *
     * @return k:返回姓名拼音字符串 v:姓名汉字字符串
     */
    @SuppressWarnings("all")
    public Map<String, String> getEmailUserName(String userIds) {
        if (StringUtils.checkNull(userIds)) {
            return new HashMap<String, String>();
        }
        Map<String, String> maps = new HashMap<String, String>();
        //定义用于拼接角色名称的字符串
        StringBuffer sb = new StringBuffer();
        //返回拼音字符串
        StringBuffer sName = new StringBuffer();
        String[] temp = userIds.split(",");
        int length = temp.length;
        if(length>3){
            length = 3;
        }
        for (int i = 0; i < length; i++) {
            if (!StringUtils.checkNull(temp[i])) {
                String userName = usersMapper.getUsernameByUserId(temp[i]);
                if (!StringUtils.checkNull(userName)) {
                    if (i < length - 1) {
                        sb.append(userName).append(",");
                        sName.append(temp[i]).append(",");
                    } else {
                        sb.append(userName);
                        sName.append(temp[i]);
                    }
                }
            }
        }
        maps.put(userIds, sb.toString());
        return maps;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-27 下午1:54:02
     * 方法介绍:   收件人user_id转换为姓名
     * 参数说明:   @param listEmail
     * 参数说明:   @return
     *
     * @return List<EmailModel>
     */
    @SuppressWarnings("all")
    public List<EmailModel> returnEmail(List<EmailModel> listEmail) {
        List<EmailModel> list = new ArrayList<EmailModel>();
        for (EmailModel emailModel : listEmail) {
            Map<String, String> returnEmailMap = this.getEmailUserName(emailModel.getToId());
            if (!returnEmailMap.isEmpty()) {
                emailModel.setToId(returnEmailMap.keySet().iterator().next());
//                emailModel.setToName(usersService.getUserNameById(emailModel.getToId()));
                emailModel.setToName(returnEmailMap.get(emailModel.getToId()));
            }
            list.add(emailModel);
        }
        return list;
    }
    public  ToJson showAttchmentSize(){
        ToJson toJson = new ToJson();
        List<Attachment> attachments = attachmentMapper.selectAttachment();
        long usedSpace  = 0;
        for (Attachment attachment:attachments){
            if (attachment.getSize().contains(" KB")){
                String str="KB";
             //   long l = new Double(Double.parseDouble(attachment.getSize().replace(str, "").trim())).longValue();
                float a=Float.parseFloat(attachment.getSize().replace(str, "").trim());
                usedSpace+=a*1024;
            }
            if (attachment.getSize().contains(" MB")){
                String str="MB";
                float a=Float.parseFloat(attachment.getSize().replace(str, "").trim());
                usedSpace+=(a*1024*1024);
            }
        }
        List<Object> list = new ArrayList<>();
        File diskPartition = new File(System.getProperty("user.dir"));//获取当前路径
        long totalCapacity = diskPartition.getTotalSpace();//总大小
        long freePartitionSpace = totalCapacity - usedSpace;//可用大小
        //long usedSpace  = totalCapacity - freePartitionSpace;//已用大小
        list.add(0,usedSpace);
        list.add(1,freePartitionSpace);
        list.add(2,totalCapacity);
        list.add(3,new BigDecimal(usedSpace).divide(new BigDecimal(1024*1024*1024),2,BigDecimal.ROUND_HALF_UP));
        list.add(4,new BigDecimal(freePartitionSpace).divide(new BigDecimal(1024*1024*1024),2,BigDecimal.ROUND_HALF_UP));
        list.add(5,new BigDecimal(totalCapacity).divide(new BigDecimal(1024*1024*1024),2,BigDecimal.ROUND_HALF_UP));
        toJson.setFlag(0);
        toJson.setMsg("OK");
        toJson.setObj(list);
        toJson.setTurn(true);
        return toJson;
    }

    public  ToJson showIntDiskSpace(HttpServletRequest request){
        ToJson toJson=new ToJson();

        toJson.setTurn(true);
        return toJson;
    }


}
