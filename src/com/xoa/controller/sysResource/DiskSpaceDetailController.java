package com.xoa.controller.sysResource;


import com.xoa.dao.email.EmailBodyMapper;
import com.xoa.dao.email.EmailMapper;
import com.xoa.dao.users.UserExtMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.email.EmailBodyModel;
import com.xoa.service.email.EmailService;
import com.xoa.service.sysResource.DiskSpaceDetailService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/disk")
public class DiskSpaceDetailController {
        @Resource
        DiskSpaceDetailService diskSpaceDetailService;

        @ResponseBody
        @RequestMapping("/diskSpace")  //  /disk/diskSpace
        public ToJson diskSpace(){
                return diskSpaceDetailService.GetDiskSpaceDetail();
        }

        //附件空间统计
        @ResponseBody
        @RequestMapping("showAttchmentSize")
        public ToJson showAttchmentSize(){return diskSpaceDetailService.showAttchmentSize();}

        //网络硬盘空间统计
        @ResponseBody
        @RequestMapping("showIntDiskSpace")
        public ToJson showIntDiskSpace(HttpServletRequest request){return diskSpaceDetailService.showIntDiskSpace(request);}


        @ResponseBody
        @RequestMapping("/email")// /disk/email
        public ToJson detail(HttpServletRequest request){return diskSpaceDetailService.detail(request);}

        @ResponseBody
        @RequestMapping("/selectEmailAll")//     /disk/selectEmailAll
        public  ToJson selectEmailAll(EmailBodyModel emailBodyModel,Integer page,Integer pageSize,boolean useFlag){
                return diskSpaceDetailService.selectEmail(emailBodyModel,page,pageSize,useFlag);
        }

        /**
         * 删除接口
         */
        @ResponseBody
        @RequestMapping("/alldelete") // /disk/alldelete
        public ToJson Alldelete (String[] bodyId){
                return diskSpaceDetailService.Allemaildelete(bodyId);
        }

        /**
         * 创建作者:   张勇
         * 创建日期:   2017/7/5 15:02
         * 方法介绍:   倒序查询排序及条件
         * 参数说明:
         *
         * @return
         */
        @SuppressWarnings("all")
        public static Map<String, String> returnMapValue() {
                Map<String, String> maps = new HashMap<String, String>();
                maps.put("0", "ASC"); //升序
                maps.put("1", "DESC");//降序
                maps.put("2", "eb.SEND_TIME");//日期
                maps.put("3", "eb.FROM_ID");//发件人
                maps.put("4", "e.READ_FLAG");//是否已读
                maps.put("6", "eb.ATTACHMENT_ID");//附件
                return maps;
        }

        @RequestMapping("/system")  //  /disk/system
        public String show(HttpServletRequest request) {
                Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
                return "app/sys/sysManage";
        }
        @RequestMapping("/details")// /disk/details
        public String details(HttpServletRequest request) {
                Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
                return "app/sys/sysManageDetails";
        }
}