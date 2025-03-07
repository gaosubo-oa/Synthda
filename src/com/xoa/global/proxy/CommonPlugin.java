package com.xoa.global.proxy;


import java.util.Map;

public interface CommonPlugin {

    Map<String,Object> doRun(String company, Object... ags);
}
