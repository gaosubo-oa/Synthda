package com.xoa.service.users.impl;

import com.xoa.dao.users.UserSetMapper;
import com.xoa.model.users.UserSet;
import com.xoa.model.users.UserSetExample;
import com.xoa.service.users.UserSetService;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Objects;

@Service
public class UserSetServiceImpl implements UserSetService {

    @Resource
    private UserSetMapper userSetMapper;

    /**
     * 保存用户设置
     * @param userId 用户ID（必填）
     * @param setItem 设置项（必填）
     * @param setValue 设置值
     * @return
     */
    @Override
    public ToJson saveUserSet(HttpServletRequest request, String userId, String setItem, String setValue) {
        ToJson toJson = new ToJson(1, "error");
        try {
            //根据用户Id和设置项查询是否存在此设置
            UserSetExample example = new UserSetExample();
            example.createCriteria().andUserIdEqualTo(userId).andSetItemEqualTo(setItem);
            List<UserSet> userSets = userSetMapper.selectByExample(example);

            //不存在新增，存在更新
            UserSet userSet = new UserSet();
            if(Objects.isNull(userSets) || userSets.size() == 0){
                userSet.setUserId(userId);
                userSet.setSetItem(setItem);
                userSet.setSetValue(setValue);
                userSetMapper.insertSelective(userSet);
            }else {
                userSet.setSetValue(setValue);
                userSetMapper.updateByExampleSelective(userSet,example);
            }

            toJson.setFlag(0);
            toJson.setMsg("SUCCESS");
        }catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }


    /**
     * 读取用户设置
     * @param request
     * @param userId  用户ID（必填）
     * @param setItem 设置项
     * @return
     */
    @Override
    public ToJson readUserSet(HttpServletRequest request, String userId, String setItem) {
        ToJson toJson = new ToJson(1, "error");
        try {
            UserSetExample example = new UserSetExample();
            UserSetExample.Criteria criteria = example.createCriteria();
            criteria.andUserIdEqualTo(userId);

            if(!StringUtils.checkNull(setItem)){
                criteria.andSetItemEqualTo(setItem);
            }
            List<UserSet> userSets = userSetMapper.selectByExample(example);

            toJson.setObj(userSets);
            toJson.setFlag(0);
            toJson.setMsg("SUCCESS");
        }catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }
}
