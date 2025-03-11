package com.xoa.dao.email;

import com.xoa.dao.base.BaseMapper;
import com.xoa.model.email.EmailBoxModel;
import org.apache.ibatis.annotations.Param;


/**
 *  (勿删)
 * 创建作者:   张勇
 * 创建日期:   2017/5/15 16:25
 * 类介绍  :   邮件数据源层
 * 构造参数:
 *
 */
public interface EmailBoxMapper extends BaseMapper<EmailBoxModel>{

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/19 10:58
     * 方法介绍:   其他邮件删除文件夹
     * 参数说明:
     * @return
     */
    public void deleteBox(Integer boxId);

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/9 17:26
     * 方法介绍:   其他邮件邮箱名字和排序号重复
     * 参数说明:
     * @return
     */
    public Integer selectNameCount(@Param("boxName")String name,@Param("userId") String userId);

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/9 17:26
     * 方法介绍:   其他邮件排序号重复
     * 参数说明:
     * @return
     */
    public Integer selectBoxIdCount(@Param("boxNo")Integer boxNo,@Param("userId")String userId);

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/7/3 17:47
     * 方法介绍:   修改时，序号或姓名不重名，那么就可执行
     * 参数说明:
     * @return
     */
    public  Integer selectBoxUpdate(@Param("boxNo")Integer boxNo,@Param("boxName")String name,@Param("userId")String userId);




}