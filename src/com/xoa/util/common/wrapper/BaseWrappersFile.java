package com.xoa.util.common.wrapper;

import java.util.Map;

public  class BaseWrappersFile<T> extends BaseWrappers{
	Map<String,Object> map;

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
}
