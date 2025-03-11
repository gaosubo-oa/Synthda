package com.xoa.util.encrypt.service;


import com.xoa.model.department.Department;
import net.sf.json.JSONArray;

import java.util.List;
import java.util.Map;

public interface BusinessCryptoService {


    /**
     * 根据key加密数据
     *
     * @param privateKey 对方公钥
     * @param department      部门
     * @return 加密数据
     */
    List<String> encrypt(String privateKey, List<Department> department);

    /**
     * 根据key解密数据
     *
     * @param privateKey 对方私钥
     * @param jsons      部门json
     * @return 解密数据
     */
    List<String> decrypt(String privateKey, JSONArray jsons);
}
