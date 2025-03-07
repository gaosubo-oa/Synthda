package com.xoa.util.base64;

import java.io.File;

public interface Base64FileListener {

    void ResponseString(String ResponseString);//返回的错误原因字符串

    void ResponseFile(File ResponseFile);//返回的文件

}
