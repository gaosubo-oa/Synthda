package com.xoa.controller.common;

import com.alibaba.fastjson.JSONObject;
import com.xoa.util.CookiesUtil;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrappers;
import com.xoa.util.dataSource.ContextHolder;
import org.apache.http.entity.ContentType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

/**
 * 
 * 创建作者:   朱振宇
 * 创建日期:   2017-4-27 上午11:42:15
 * 类介绍:     公共选人页面 
 * 构造参数: 
 *
 */
@Controller
@Scope(value = "prototype")
@RequestMapping("/common")
public class CommonController {

	//附件选择个人及公共文件柜
	@RequestMapping("/selectNewFile")
	public String selectFile(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/selectNewFile";
	}
	//设备需要的选人
	@RequestMapping("lmisSelectUserExp")
	public String lmisSelectUserExp(HttpServletRequest request){
		ContextHolder.setConsumerType("xoa" + (String) request.getSession().getAttribute(
				"loginDateSouse"));
		return "app/common/selectUserExp";
	}

	@RequestMapping("/printFile")
	public String printFile(HttpServletRequest request) {
		return "app/common/printFile";
	}


	@RequestMapping("/selectUser")
	public String addboxPage(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/selectUser";
	}
	@RequestMapping("/selectUsershiyuan")
	public String selectUsershiyuan(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/selectUsershiyuan";
	}
	
	@RequestMapping("/selectUser_iframe")
	public String addboxPageIframe(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/selectUser_iframe";
	}

	@RequestMapping("/selectUserPlus")
	public String addboxPagePlus(HttpServletRequest request,String OID) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		if(OID!=null||"".equals(OID)){
			request.setAttribute("OID",OID);
		}
		return "app/common/selectUserPlus";
	}


	@RequestMapping("/hierarchicalselectDept")
	public String hierarchicalselectDept(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/hierarchicalselectDept";
	}
	@RequestMapping("/ntko")
	public String ntko(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/ntko";
	}

	@RequestMapping("/ntkos")
	public String ntkos(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/webOffice/ntko";
	}

	@RequestMapping("/ntkoview")
	public String ntkoview(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/ntkoView";
	}

	@RequestMapping("/ntkoPreview")
	public String ntkoPreview(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/ntkoPreview";
	}

	@RequestMapping("/webOffice")
	public String webOffice(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/webOffice";
	}

	@RequestMapping("/webOffices")
	public String webOffices(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/webOffice/webOffices";
	}

	@RequestMapping("/webOfficeView")
	public String webOfficeView(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/webOfficeView";
	}

	@RequestMapping("/webOfficePreview")
	public String webOfficePreview(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/webOfficePreview";
	}
	@RequestMapping("/selectUserWorkFlow")
	public String selectUserWorkFlow(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/selectUserWorkFlow";
	}


	@RequestMapping("/selectUserWorkFlowNew")
	public String selectUserWorkFlowNew(HttpServletRequest request) {
		return "app/common/selectUserWorkFlowNew";
	}

	@RequestMapping("/selectPriv")
	public String addPrivPage(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/selectPriv";
	}

	@RequestMapping("/selectPrivNew")
	public String addPrivPageNew(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/selectPrivNew";
	}
	@RequestMapping("/selectOtherOrg")
	public String selectOtherOrg(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/selectOtherOrg";
	}
	@RequestMapping("/selectDept")
	public String addDeptPage(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/selectDept";
	}
	@RequestMapping("/selectDeptshiyuan")
	public String addOrgDeptPage(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/selectDeptshiyuan";
	}
	@RequestMapping("/addPageDemo")
	public String addPageDemo(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/addPageDemo";
	}
	@RequestMapping("/deptManagement")
	public String divisionalManagement(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/deptManagement";
	}
	@RequestMapping("/roleManagement")
	public String roleManagement(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/roleManagement";
	}
	@RequestMapping("/userManagement")
	public String userManagement(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/userManagement";
	}

	@RequestMapping("/userManagementPlus")
	public String userManagementPlus(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/userManagementPlus";
	}
	@RequestMapping("/systemCode")
	public String systemCode(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/sysCode";
	}
	@RequestMapping("/hrSystemCode")// common/hrSystemCode
	public String hrSystemCode(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/hrSysCode";
	}
	@RequestMapping("/selectEduDept")
	public String selectEduDep(HttpServletRequest request) {
		return "app/common/selectEduDept";
	}

	@RequestMapping("/selectEduPriv")
	public String addEduPrivPage(HttpServletRequest request) {
		return "app/common/selectEduPriv";
	}

	@RequestMapping("/selectEduUser")
	public String addEduUserPage(HttpServletRequest request) {
		return "app/common/selectEduUser";
	}
	//选择年级
	@RequestMapping("/selectGrade")
	public String selectGrade(HttpServletRequest request) {
		return "app/common/selectGrade";
	}

	//选择班级
	@RequestMapping("/selectClazz")
	public String selectClazz(HttpServletRequest request) {
		return "app/common/selectClazz";
	}

	@RequestMapping("/selectAddDept")
	public String addEduDept(HttpServletRequest request) {
		return "app/common/selectDeptAdd";
	}

	//管理门户
	@RequestMapping("/managementPortal")
	public String managementPortal(HttpServletRequest request) {
		return "app/main/managementPortal";
	}
	//管理门户
	@RequestMapping("/selectSchool")
	public String selectSchool(HttpServletRequest request) {
		return "app/common/selectSchool";
	}
	//管理门户
	@RequestMapping("/out")
	public String out(HttpServletRequest request) {
		return "app/main/out";
	}

	//应用门户
	@RequestMapping("/applyOA")
	public String applyOA(HttpServletRequest request) {
		return "app/main/applyOA";
	}
	//我的门户
	@RequestMapping("/myOA")
	public String myOA(HttpServletRequest request) {
		return "app/main/myOA";
	}
	//我的新门户
	@RequestMapping("/myOA2")
	public String myOA2(HttpServletRequest request) {
		return "app/main/myOA2";
	}
	//受理门户
	@RequestMapping("/acceptOA")
	public String acceptOA(HttpServletRequest request) {
		return "app/main/workflowOA";
	}

	//视频播放页面
	@RequestMapping("/video")
	public String video(HttpServletRequest request) {
		return "app/common/video";
	}
	//附件下载错误提示页面
	@RequestMapping("/errorMessage")
	public String errorMessage(HttpServletRequest request) {
		return "app/common/errorMessage";
	}
	//复制选人控件
	@RequestMapping("/selectUser_s")
	public String selectUser_s(HttpServletRequest request) {
		return "app/common/selectUser_s";
	}

	//选择岗位页面映射
	@RequestMapping("/selectUserJob")
	public String selectUserJob(HttpServletRequest request) {
		return "app/common/selectUserJob";
	}
	@RequestMapping("/selectSeal")
	public String selectSeal(HttpServletRequest request) {
		return "app/workflow/work/selectSeal";
	}

	@RequestMapping("/OAIEindex")
	public String oAIEindex(HttpServletRequest request) {
		return "/app/common/OAIEindex";
	}

	// jacob预览office页面
	@RequestMapping("/officereader")
	public String officereader() {
		return "app/common/jacobPreview/index";
	}

	// office excel预览页面
	@RequestMapping("/excelPreview")
	public String excelPreview() {
		return "app/common/officePreview/excelPreview";
	}

	// office pdf预览页面
	@RequestMapping("/pdfPreview")
	public String pdfPreview() {
		return "app/common/officePreview/pdfPreview";
	}

	// office ppt预览页面
	@RequestMapping("/pptPreview")
	public String pptPreview() {
		return "app/common/officePreview/pptPreview";
	}

	// pdf编辑页面
	@RequestMapping("/PDFEditor")
	public String PDFEditor() {
		return "app/common/PDFEditor/index";
	}

	// pdf选择印章页面
	@RequestMapping("/PDFselectSeal")
	public String PDFselectSeal() {
		return "app/common/PDFEditor/selectPdfSeal";
	}

	// pdf预览页面
	@RequestMapping("/PDFBrowser")
	public String PDFBrowser() {
		return "app/common/PDFBrowser/index";
	}
	//社区入口页面
	@RequestMapping("/communityEntry")
	public String communityEntry() {
		return "app/communityEntry/community";
	}


	//onlyoffice
	@RequestMapping("/onlyoffice")
	public String onlyoffice() {
		return "app/common/onlyoffice/onlyoffice";
	}

	// html预览
	@RequestMapping("/htmlPreview")
	public String htmlPreview() {
		return "/app/common/HTMLBrowser/htmlPreview";
	}

	/**
	 * 上传图片
	 * @param
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/images")
	public Map<String, Object> images (MultipartFile upfile, HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> params = new HashMap<String, Object>();
		try{
			String basePath = "d:/lyz/static";
			String visitUrl = "d:/lyz/static";
			if(basePath == null || "".equals(basePath)){
				basePath = "d:/lyz/static";  //与properties文件中lyz.uploading.url相同，未读取到文件数据时为basePath赋默认值
			}
			if(visitUrl == null || "".equals(visitUrl)){
				visitUrl = "/upload/"; //与properties文件中lyz.visit.url相同，未读取到文件数据时为visitUrl赋默认值
			}
			String ext = upfile.getOriginalFilename();
			String fileName = upfile.getOriginalFilename();
			StringBuilder sb = new StringBuilder();
			//拼接保存路径
			sb.append(basePath).append("/").append(fileName);
			visitUrl = visitUrl.concat(fileName);
			File f = new File(sb.toString());
			if(!f.exists()){
				f.getParentFile().mkdirs();
			}
			OutputStream out = new FileOutputStream(f);
			FileCopyUtils.copy(upfile.getInputStream(), out);
			params.put("state", "SUCCESS");
			params.put("url", visitUrl);
			params.put("size", upfile.getSize());
			params.put("original", fileName);
			params.put("type", upfile.getContentType());
		} catch (Exception e){
			params.put("state", "ERROR");
		}
		return params;
	}

	@RequestMapping("/selectUserIMAddGroup")
	public String selectUserIMAddGroup(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/selectUserIMAddGroup";
	}
	
	@RequestMapping("/selectUserIMAddGroup_iframe")
	public String selectUserIMAddGroupIframe(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/selectUserIMAddGroup_iframe";
	}

	/**
	 *
	 */
	@RequestMapping("/selectPartyMember")
	public String selectPartyMember(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/common/selectPartyMember";
	}

}
