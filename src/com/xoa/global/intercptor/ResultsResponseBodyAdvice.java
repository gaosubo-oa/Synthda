package com.xoa.global.intercptor;

import com.alibaba.fastjson.JSON;
import com.xoa.util.common.constants.FlagConstants;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@ControllerAdvice
public class ResultsResponseBodyAdvice implements ResponseBodyAdvice {

    @Override
    public boolean supports(MethodParameter returnType, Class converterType) {
        return true;
    }

    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType, Class selectedConverterType, ServerHttpRequest request, ServerHttpResponse response) {
        //获取到返回内容
        String bodyStr = JSON.toJSONString(body);
        //判断返回code值是否为访问权限不足
        if (bodyStr.contains(FlagConstants.SERVICE_ERROR_403)) {
            HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            HttpServletResponse res = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getResponse();
            try {
                res.sendRedirect(req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + "/defaultIndexError");
            } catch (IOException e) {
                e.printStackTrace();
            }
            return null;
        }
        return body;
    }
}
