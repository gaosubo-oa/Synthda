package com.xoa.service.enclosure;

import com.xoa.model.enclosure.Attachment;
import com.xoa.util.ToJson;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

public interface EnclosureService {
	public void saveAttachment(Attachment attachment);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月26日 下午7:05:20
	 * 方法介绍:   
	 * 参数说明:   @param attachId
	 * 参数说明:   @return
	 * @return     Attachment
	 */
	public Attachment findByAttachId(Integer aId);

	public Attachment findByAttachId1(Integer attachId);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月26日 下午6:57:35
	 * 方法介绍:   查找最后的附件信息
	 * 参数说明:   @return
	 * @return     Attachment 附件信息
	 */
	public Attachment findByLast();

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月26日 下午6:56:58
	 * 方法介绍:   上传接口
	 * 参数说明:   @param files 上传文件
	 * 参数说明:   @param company 公司名
	 * 参数说明:   @param module 模块名
	 * 参数说明:   @param basePath 上传路径
	 * 参数说明:   @return
	 * @return     List<Attachment>  附件信息集合
	 */
	public List<Attachment>  upload(MultipartFile[] files,String company,String module) throws UnsupportedEncodingException;
	
	public List<Attachment>  upload2(MultipartFile[] files,String company,String module) throws UnsupportedEncodingException;

	public Attachment  upload1(MultipartFile files,String company,String module) throws UnsupportedEncodingException;

	public List<Attachment>  uploadenterprise(MultipartFile[] files,String company,String module,String sql) throws UnsupportedEncodingException;


	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月27日 上午9:24:05
	 * 方法介绍:   获取附件url
	 * 参数说明:   @param att 附件信息
	 * 参数说明:   @param company 公司
	 * 参数说明:   @param module 模块名
	 * 参数说明:   @return
	 * @return     String 返回附件
	 */
	public String attachmenturl(Attachment att,String company,String module);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月26日 下午6:56:58
	 * 方法介绍:   用户抛出用户上传附件的信息
	 * 参数说明:   @param files 上传文件
	 * 参数说明:   @param company 公司名
	 * 参数说明:   @param module 模块名
	 * 参数说明:   @param basePath 上传路径
	 * 参数说明:   @return
	 * @return     List<Attachment>  附件信息集合
	 */
	public List<Attachment> uploadReturn(MultipartFile[] files, String company, String module,String fNmae);
	public List<Attachment> uploadReturn2(MultipartFile[] files, String company, String module);

	//多文件上传
	Attachment uploadReturn1(MultipartFile files, String company, String module);

	public List<Attachment> uploadReturnenterprise(MultipartFile[] files, String company, String module, String sql);

	public ToJson delete(@RequestParam("AID") String aid ,
						 @RequestParam("MODULE") String module ,
						 @RequestParam("YM") String ym ,
						 @RequestParam("ATTACHMENT_ID") String attachmentId ,
						 @RequestParam("ATTACHMENT_NAME") String attachmentName ,
						 @RequestParam("COMPANY") String company ,
						 HttpServletResponse response,
						 HttpServletRequest request);

	/**
	 * 作者: 张航宁
	 * 日期: 2018/1/23
	 * 说明: 根据aid查询附件信息
	 */
	ToJson<Attachment> selectByPrimaryKey(Integer aid,String module,HttpServletRequest request);

	ToJson<Attachment> findByAIds(String aids,HttpServletRequest request);

	 Attachment selectByAid(Integer aid) ;

	 //跟上面的upload一样，多了一个自定义的文件名参数，但是上面的upload被调用的地方太多了，所以拷贝下来
	public List<Attachment>  uploadScan(MultipartFile[] files,String company,String module,String fileNmae) throws UnsupportedEncodingException;
	public List<Attachment> uploadReturnVideo(MultipartFile[] files, String company, String module);

	Attachment selectOneBySearch(Map<String,Object> paraMap);

	String getCompany(String company);
}

