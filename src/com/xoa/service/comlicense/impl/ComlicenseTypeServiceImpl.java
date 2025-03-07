package com.xoa.service.comlicense.impl;

import com.xoa.dao.comlicense.ComlicenseTypeMapper;
import com.xoa.model.comlicense.ComlicenseType;
import com.xoa.service.comlicense.ComlicenseTypeService;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Service
public class ComlicenseTypeServiceImpl  implements ComlicenseTypeService {
    @Autowired
    private ComlicenseTypeMapper comlicenseTypeMapper;
    @Override
    public ToJson addComlicenseType(HttpServletRequest request, ComlicenseType comlicenseType) {
        ToJson toJson = new ToJson();
        try {
            int i = comlicenseTypeMapper.insertSelective(comlicenseType);
            if (i>0) {
                toJson.setFlag(0);
                toJson.setMsg("插入成功");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson deleteComlicenseType(HttpServletRequest request, Integer typeId) {
        ToJson toJson = new ToJson();
        try {
            int i = comlicenseTypeMapper.deleteByPrimaryKey(typeId);
            if (i>0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson updateComlicenseType(HttpServletRequest request, ComlicenseType comlicenseType) {
        ToJson toJson = new ToJson();
        try {
            int i = comlicenseTypeMapper.updateByPrimaryKeySelective(comlicenseType);
            if (i>0) {
                toJson.setFlag(0);
                toJson.setMsg("修改成功");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson queryAll(HttpServletRequest request, PageParams pageParams) {
        ToJson toJson = new ToJson();
        try {
            HashMap<String, Object> map = new HashMap<>();
            map.put("pageParams",pageParams);
            List<ComlicenseType> comlicenseTypes = comlicenseTypeMapper.selectAll(map);
            toJson.setTotleNum(pageParams.getTotal());
            toJson.setData(comlicenseTypes);
            toJson.setFlag(0);
            toJson.setMsg("查询成功");
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson queryByTypeId(HttpServletRequest request, Integer typeId) {
        ToJson toJson = new ToJson();
        try {
            ComlicenseType comlicenseType = comlicenseTypeMapper.selectByPrimaryKey(typeId);
            toJson.setData(comlicenseType);
            toJson.setFlag(0);
            toJson.setMsg("ok");
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }
}
