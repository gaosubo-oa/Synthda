package com.xoa.global.exception;

import com.alibaba.fastjson.support.spring.FastJsonJsonView;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;
/**
 * 
 * @作者 韩东堂
 * @创建日期 2017-4-26 下午6:30:26 
 * @类介绍  全局异常处理类
 * @构造参数 无
 */
public class GlobalException implements HandlerExceptionResolver {


	@Override
	public ModelAndView resolveException(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3) {
		// TODO Auto-generated method stub
		FastJsonJsonView view = new FastJsonJsonView();
		ModelAndView modelAndView =new ModelAndView();


		Map<String, Object> all =new HashMap<String, Object>();
		all.put("status", false);
		all.put("flag", false);
		all.put("message", arg3.getMessage());
		view.setAttributesMap(all);

		arg3.printStackTrace();
		modelAndView.setView(view);
		return modelAndView;
	}

}
