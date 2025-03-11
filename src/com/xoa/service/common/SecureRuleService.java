package com.xoa.service.common;/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/8/12 9:58
 * 类介绍  :
 * 构造参数:
 */

import com.xoa.model.common.SecureRule;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;

/**
 *    创建作者:      高亚峰
 *    创建日期：     2017-08-12 9:58
 *    类介绍：       三员安全管理
 *    构造参数：     无
 *
 */
public interface SecureRuleService {

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-8-12 上午：10：01
     * 方法介绍:   三员安全管理列表展示
     * 参数说明:
     * @return:   ToJson
     */
    public ToJson<SecureRule> getAllSecureRule();
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-8-12 上午：10：01
     * 方法介绍:   三员安全管理修改信息
     * 参数说明:
     * @return:   ToJson
     */
    public ToJson<Object> editSecureRule(HttpServletRequest request,SecureRule secureRule);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-8-14 下午 15:56
     * 方法介绍:   三员安全管理通过Id查询接口
     * 参数说明:   ruleId
     * @return:  ToJson
     */
    public ToJson<SecureRule> getSecureById(String ruleId);


    /**
     *
     */
    public ToJson<SecureRule> getAllInfoSecureRule();
}
