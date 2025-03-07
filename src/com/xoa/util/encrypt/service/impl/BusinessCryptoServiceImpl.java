package com.xoa.util.encrypt.service.impl;


import com.xoa.model.department.Department;
import com.xoa.util.encrypt.service.BusinessCryptoService;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Service;
import java.util.ArrayList;

import java.util.List;
import com.xoa.util.encrypt.RsaTool;

/**
 * 业务数据加密/解密
 */
@Service
public class BusinessCryptoServiceImpl implements BusinessCryptoService {

    @Override
    public List<String> encrypt(String publicKeyStr, List<Department> department) {
        try {
            List<String> departments = new ArrayList<>();
            for (Department str : department) {
                    String deptstr= "Department:{" +
                            " deptName:'" + str.getDeptName() + '\'' +
                            ", telNo:'" + str.getTelNo() + '\'' +
                            ", faxNo:'" + str.getFaxNo() + '\'' +
                            ", deptAddress:'" + str.getDeptAbbrName() + '\'' +
                            ", deptParentName:'" + str.getDeptParentName() + '\'' +
                            ", deptNo:'" + str.getDeptNo() + '\'' +
                            ", deptCode:'" + str.getDeptCode() + '\'' +
                            '}';
                String encryptSignData =  RsaTool.encryptByPublicKey(deptstr,publicKeyStr);
                departments.add(encryptSignData);
            }
            return departments;
        }  catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public List<String> decrypt(String privateKey, JSONArray jsons) {
        try {
            List<String> departments = new ArrayList<>();
            for (Object json : jsons) {
                String encryptSignData =  RsaTool.decryptByPrivateKey(json.toString(),privateKey);
                departments.add(encryptSignData);
            }
            return departments;
        }  catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
