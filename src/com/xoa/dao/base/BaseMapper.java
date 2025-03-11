package com.xoa.dao.base;

import java.util.List;
import java.util.Map;

/**
 * 
 * @ClassName (类名):  BaseMapper
 * @Description(简述): 父类DAO
 * @author(作者):      zy
 * @date(日期):        2017-4-17 下午2:25:56
 *
 */
public interface BaseMapper<T> {
	
	/**
	 * 
	 * @Title: save
	 * @Description: 保存对象
	 * @author(作者):      zy
	 * @param: @param t   需要保存对象 
	 * @return: void   
	 * @throws
	 */
	public void save(T t);

	public void save2(T t);

	/**
	 * 
	 * @Title: update
	 * @Description: 修改对象
	 * @author(作者):      zy
	 * @param: @param t 需修改对象
	 * @param: @return   
	 * @return: Integer   修改条数
	 * @throws
	 */
	public void update(T t);
	
	/**
	 * 
	 * @Title: delete
	 * @Description: 删除对象
	 * @author(作者):      zy
	 * @param: @param t 需删除对象
	 * @param: @return   
	 * @return: Integer   删除数据条数
	 * @throws
	 */
	public void delete(T t);
	
	/**
	 *  查询结果返回
	 * @Title: selectObjcet
	 * @Description: TODO
	 * @author(作者):      zy
	 * @param: @param maps 需传入map条件
	 * @param: @return   
	 * @return: List<T>   查询结果以list集合显示
	 * @throws
	 */
	public List<T> selectObjcet(Map<String,Object> maps);
	
	/**
	 * 
	 * @Title: queryOne
	 * @Description: TODO
	 * @author(作者):      zy
	 * @param: @param maps
	 * @param: @return   
	 * @return: T   
	 * @throws
	 */
	public T queryOne(Map<String, Object> maps);
	
}
