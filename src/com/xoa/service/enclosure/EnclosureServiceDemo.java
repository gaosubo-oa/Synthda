package com.xoa.service.enclosure;

import com.xoa.model.enclosure.Attachment;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.UnsupportedEncodingException;

/**
 * 创建作者:   刘佩峰
 * 创建日期:  2017-6-15 20：55
 * 方法介绍:   上传接口
 * 参数说明:   @param files 上传文件
 * 参数说明:   @param company 公司名
 * 参数说明:   @param module 模块名
 * 参数说明:   @param basePath 上传路径
 * 参数说明:   @return
 */
@Service
public interface EnclosureServiceDemo {
    // 单文件上传
    public Attachment upload(File file, String company, String module) throws UnsupportedEncodingException;
}
