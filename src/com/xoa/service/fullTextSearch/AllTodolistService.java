package com.xoa.service.fullTextSearch;

import com.xoa.model.email.EmailBodyModel;
import com.xoa.model.notify.Notify;
import com.xoa.model.users.Users;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;


/**
 * Created by gsb on 2018/3/15.
 */
@Service
public interface AllTodolistService {

        /**
         * 创建作者:   张龙飞
         * 创建日期:   2017年6月23日 下午5:02:21
         * 方法介绍:   根据userId 查询待办
         * 参数说明:   @param userId 用户Id
         * 参数说明    @param sqlType
         * 参数说明:   @return
         * @return     返回待办信息
         */
      /*  public AllDaiban list(String userId, String sqlType, HttpServletRequest request)throws Exception;*/
        /**
         * 创建作者:   王曰岐
         * 创建日期:   2017年6月23日 下午5:02:21
         * 方法介绍:   根据userId 查询待办
         * 参数说明:   @param userId 用户Id
         * 参数说明    @param sqlType
         * 参数说明:   @return
         * @return     返回已办信息
         */

     /*   public AllDaiban readList(String userId, String sqlType, HttpServletRequest request)throws Exception;


        public AllDaiban readTotal(String userId, String sqlType, HttpServletRequest request,String superfluity)throws Exception;
*/

       /* public BaseWrapper readHaveMsgList(String classification,String userId, String sqlType, HttpServletRequest request) throws Exception;


        public BaseWrapper readHaveList(String classification,String userId, String sqlType, HttpServletRequest request) throws Exception;


        public AllDaiban delete(Integer qid,String type);
*/

        /**
         * 创建作者:   牛江丽
         * 创建日期:   2017年6月27日 下午10:32:22
         * 方法介绍:   根据userId进行模糊查询
         * 参数说明:   @param userId
         * 参数说明:
         * @return List<SUsers>  返回用户信息
         */
        public ToJson<Users> queryUserByUserId(String userName,HttpServletRequest request);

        /**
         * 创建作者:   牛江丽
         * 创建日期:   2017年6月27日 下午10:35:22
         * 方法介绍:   根据userId进行模糊查询,查询出符合条件的数量
         * 参数说明:   @param  userId
         * 参数说明:
         * @return List<SUsers>  返回用户信息
         */
       /* public ToJson<Users> queryCountByUserId(String userName);*/

        /**
         * 创建作者:   牛江丽
         * 创建日期:   2017年6月27日 下午14:29:22
         * 方法介绍:   根据子菜单名称进行模糊查询
         * 参数说明:   @param funName
         * 参数说明:
         * @return List<SysFunction>  返回子菜单信息
         */
       /* public ToJson<SysFunction> getSysFunctionByName(String funName,HttpServletRequest request);*/
        /**
         * 创建作者:   牛江丽
         * 创建日期:   2017年6月27日 下午14:30:12
         * 方法介绍:   根据子菜单名称进行模糊查询获取符合的数量
         * 参数说明:   @param funName
         * 参数说明:
         * @return List<SysFunction>  查询数
         */
       /* public ToJson<SysFunction> getCountSysFunctionByName(String funName);
        public BaseWrapper smsListByType(String userId, HttpServletRequest request, String type);

        public BaseWrapper getUserFunctionByUserId(String userId, HttpServletRequest request);

        public BaseWrapper getWillDocSendOrReceive(String userId,String documentType, HttpServletRequest request);*/

        /**
         * 创建作者:   张丽军
         * 创建日期:   2018年3月15日 下午17:32:22
         * 方法介绍:   根据subject进行模糊查询内部邮件信息
         * 参数说明:   @param subject
         * 参数说明:
         *
         */
        ToJson<EmailBodyModel> queryEmailBySubject(String trim);

        /**
         * 创建作者:   张丽军
         * 创建日期:   2018年3月15日 下午17:32:22
         * 方法介绍:   根据subject进行模糊查询公告通知信息
         * 参数说明:   @param subject
         * 参数说明:
         *
         */
        ToJson<Notify> queryNotifyBySubject(String trim);
}
