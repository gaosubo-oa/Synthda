package com.xoa.controller.common;

import com.xoa.model.common.SecureRule;
import com.xoa.service.common.SecureRuleService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/8/12 9:53
 * 类介绍  :   三员安全管理
 * 构造参数:
 */

@Controller
@RequestMapping("/SecureRule")
public class SecureRuleController {

  @Resource
  private SecureRuleService secureRuleService;

  /**
 * 创建作者:   高亚峰
 * 创建日期:   2017-8-12 上午：10：01
 * 方法介绍:   三员安全管理列表展示
 * 参数说明:
 * @return:   ToJson
 */
    @RequestMapping("/getAllSecureRule")
    @ResponseBody
    public ToJson<SecureRule> getAllSecureRule(){
     return secureRuleService.getAllSecureRule();
    }
  /**
   * 创建作者:   高亚峰
   * 创建日期:   2017-8-12 上午：10：01
   * 方法介绍:   三员安全管理修改信息接口
   * 参数说明:
   * @return:   ToJson
   */
  @RequestMapping("/editSecureRule")
  @ResponseBody
  public ToJson<Object> editSecureRule(HttpServletRequest request,SecureRule secureRule){
    return secureRuleService.editSecureRule(request,secureRule);
  }

  @RequestMapping("/getSecureRule")
  @ResponseBody
  public String getSecureRule(){
    return "app/sys/seIndex2";
  }
  /**
   * 创建作者:   高亚峰
   * 创建日期:   2017-8-14 下午 15:56
   * 方法介绍:   三员安全管理通过Id查询接口
   * 参数说明:
   * @return:   ToJson
   */
  @RequestMapping("/getSecureById")
  @ResponseBody
  public ToJson<SecureRule> getSecureById(String ruleId){
    return secureRuleService.getSecureById(ruleId);
  }
}
