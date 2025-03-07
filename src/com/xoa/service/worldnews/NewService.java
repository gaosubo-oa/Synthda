package com.xoa.service.worldnews;

import com.xoa.model.users.Users;
import com.xoa.model.worldnews.News;
import com.xoa.util.ToJson;
import com.xoa.util.common.wrapper.BaseWrapper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
     * 
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-19 下午3:35:07
     * 类介绍  :    新闻Service(逻辑层)
     * 构造参数:    无 
     *
     */
public interface NewService {
	
	
	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-19 下午3:35:41
	 * 方法介绍:   查询新闻列表
	 * 参数说明:   @param maps map条件参数
	 * 参数说明:   @param page  当前页
	 * 参数说明:   @param pageSize 每页显示条数
	 * 参数说明:   @param useFlag 是否开启分页插件
	 * 参数说明:   @param name 名字
	 * 参数说明:   @return
	 * 参数说明:   @throws Exception
	 * @return     List<News> 返回新闻列表List
	 */
	public ToJson<News> selectNews(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, Users users) throws Exception;
	
	
	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-19 下午3:35:41
	 * 方法介绍:   查询未读新闻列表
	 * 参数说明:   @param maps map条件参数
	 * 参数说明:   @param page  当前页
	 * 参数说明:   @param pageSize 每页显示条数
	 * 参数说明:   @param useFlag 是否开启分页插件
	 * 参数说明:   @param name 名字
	 * 参数说明:   @return
	 * 参数说明:   @throws Exception
	 * @return     List<News> 返回新闻列表List
	 */
	public ToJson<News> unreadNews(Map<String, Object> maps,Integer page,Integer pageSize,boolean useFlag,String name,String sqlType) throws Exception;
	
	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-19 下午3:35:41
	 * 方法介绍:   查询未读新闻列表
	 * 参数说明:   @param maps map条件参数
	 * 参数说明:   @param page  当前页
	 * 参数说明:   @param pageSize 每页显示条数
	 * 参数说明:   @param useFlag 是否开启分页插件
	 * 参数说明:   @param name 名字
	 * 参数说明:   @return
	 * 参数说明:   @throws Exception
	 * @return     List<News> 返回新闻列表List
	 */
	public ToJson<News> readNews(Map<String, Object> maps,Integer page,Integer pageSize,boolean useFlag,String name,String sqlType) throws Exception;
	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-19 下午3:39:06
	 * 方法介绍:   查询新闻管理
	 * 参数说明:   @param maps map条件参数
	 * 参数说明:   @param page  当前页
	 * 参数说明:   @param pageSize 每页显示条数
	 * 参数说明:   @param useFlag 是否开启分页插件
	 * 参数说明:   @return
	 * 参数说明:   @throws Exception
	 * @return     List<News>
	 */
	public ToJson<News> selectNewsManage(Map<String, Object> maps,Integer page,Integer pageSize,boolean useFlag,String name,String sqlType) throws Exception;
	
	/**
	 * 
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-19 下午3:39:24
	 * 方法介绍:   添加新闻
	 * 参数说明:   @param news
	 * @return     void
	 */
	 public News sendNews(News news,String remind,String tuisong,HttpServletRequest request);
    
	 /**
	  * 
	  * 创建作者:   王曰岐
	  * 创建日期:   2017-4-19 下午3:39:48
	  * 方法介绍:   修改新闻
	  * 参数说明:   @param news
	  * @return     void
	  */
    public void updateNews(News news,String remind,String tuisong, HttpServletRequest request);
    
    /**
	  * 
	  * 创建作者:   王曰岐
	  * 创建日期:   2017-4-19 下午3:39:48
	  * 方法介绍:   修改新闻
	  * 参数说明:   @param news
	  * @return     void
	  */
   public void updatePublish(News news, String remind, String tuisong, HttpServletRequest request);

   public void updateNewsReades(News news, String remind, String tuisong, HttpServletRequest request);

    /**
     * 
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-19 下午3:39:57
     * 方法介绍:   
     * 参数说明:   @param maps map条件参数
	 * 参数说明:   @param page  当前页
	 * 参数说明:   @param pageSize 每页显示条数
	 * 参数说明:   @param useFlag 是否开启分页插件
     * 参数说明:   @param name
     * 参数说明:   @return
     * 参数说明:   @throws Exception
     * @return     News
     */
    public News queryById(Map<String, Object> maps,Integer page,Integer pageSize,boolean useFlag,String name,String sqlType,String changId) throws Exception;
    
    /**
     * 
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-19 下午3:40:16
     * 方法介绍:   根据ID删除一条
     * 参数说明:   @param newsId
     * @return     void
     */
    public void deleteByPrimaryKey(Integer newsId);

    public ToJson<News> deleteByids(String[] newsId);

	public ToJson<News> updayeByids(String[] newsId,String top,String publish);

	public ToJson<News> ConsultTheSituationNew(String  newsId);

	/**
	 * 作者: 杨超
	 * 函数说明: 根据类型统计新闻数量
	 * 时间: 2018-08-18
	 * @param type
	 * @return
	 */
	public BaseWrapper getNewCountByType(HttpServletRequest request, String type);

	public ToJson getXzNews(HttpServletRequest request);

    ToJson<News> updateDate(HttpServletRequest request);

	ToJson<News> getNewStatus(HttpServletRequest request,String auditerStatus,Integer page, Integer pageSize,Boolean useFlag);

	ToJson<News> upNewStatus(HttpServletRequest request, String auditerStatus, String newsId, String publish);

	//一键已读新闻
	public ToJson readNews(HttpServletRequest request);

	//办公门户待审核新闻
	public ToJson approveNew(HttpServletRequest request);

	ToJson<News> unreadNewsPlus(Map<String, Object> maps, Integer page, Integer pageSize, Boolean useFlag, String name, String sqlType);

	ToJson<News> readNewsPlus(Map<String, Object> maps, Integer page, Integer pageSize, Boolean useFlag, String name, String sqlType);

    void updateTop();

    //根据新闻主键更新新闻内容
	public ToJson<News> updateContent(News news, HttpServletRequest request);

	//根据主键获取新闻数据
	public News getDataByNewsId(HttpServletRequest request, Integer newsId,String sqlType) throws Exception;
    //统计所有新闻题目，作者，摄影作者，日期，字数，图片数量等数量并导出excel
    ToJson<News> showAllCountByHtml(HttpServletRequest request, HttpServletResponse response);
}
