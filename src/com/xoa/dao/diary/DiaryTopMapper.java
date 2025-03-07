package com.xoa.dao.diary;

import com.xoa.model.diary.DiaryModel;
import com.xoa.model.diary.DiaryTop;

import java.util.List;

/**
 * 创建作者:   牛江丽
 创建日期:   2017年7月6日 下午13:20:35
 * 类介绍  :    工作日志操作信息dao接口
 * 构造参数:   无
 */
public interface DiaryTopMapper {
	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月6日 下午13:24:05
	 * 方法介绍:   添加工作日志操作信息
	 * @return int 添加条数
	 */
	public int insertDiaryTop(DiaryTop diaryTop);
	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月6日 下午13:25:13
	 * 方法介绍:   修改工作日志操作信息
	 * @return int 修改条数
	 */
	public int updUserIdByDiaId(DiaryTop diaryTop);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月6日 下午13:26:10
	 * 方法介绍:   根据日志id查询操作信息
	 * @return DiaryTop
	 */
	public DiaryTop  getDiaryTopByDiaId(String diaId);
	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月6日 下午13:27:25
	 * 方法介绍:   根据日志i删除操作信息
	 * @return int 删除条数
	 */
	public int  delDiaryTopByDiaId(String diaId);


	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月6日 下午13:35:15
	 * 方法介绍:   获取置顶操作后工作日志的List集合
	 * @return List<DiaryModel>
	 */
	public List<DiaryModel>  getOrderDiary(String userId);

}