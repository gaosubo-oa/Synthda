package com.xoa.kg.service;

import com.xoa.dao.kg.KgRelationKeySignMapper;
import com.xoa.dao.kg.KgRelationKeyUserMapper;
import com.xoa.dao.kg.KgSignKeyMapper;
import com.xoa.dao.kg.KgSignatureMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.kg.model.*;
import com.xoa.model.users.Users;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.common.wrapper.BaseWrappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by pfl on 2018-1-17.
 */
@Service
public class KgService {

    @Autowired
    KgSignatureMapper kgSignatureMapper;

    @Autowired
    KgRelationKeyUserMapper kgRelationKeyUserMapper;

    @Autowired
    KgSignKeyMapper kgSignKeyMapper;

    @Autowired
    KgRelationKeySignMapper kgRelationKeySignMapper;

    @Autowired
    UsersMapper usersMapper;

    public BaseWrappers getAllSignatures() {
        BaseWrappers wrappers = new BaseWrappers();
        List<KgSignature> datas = kgSignatureMapper.selectByExample(null);
        wrappers.setStatus(true);
        wrappers.setDatas(datas);
        wrappers.setFlag(true);
        return wrappers;
    }

    public BaseWrappers getUserSignature(Integer uid) {
        BaseWrappers baseWrappers =new BaseWrappers();
        if(uid==null) return baseWrappers;
        //获取所有用户keysn
        List<KgSignKey> kgSignKeys=   kgSignKeyMapper.selectUserKey(uid);
        //获取所有用户签章
        List<KgSignature> kgSignatures = kgSignatureMapper.selectUserSign(uid);
        for(KgSignKey key:kgSignKeys){
            List<KgSignature> keySign =new ArrayList<KgSignature>();
            for(KgSignature signature:kgSignatures){
                if(signature.getKeyId()==key.getSignkeyId()){
                    keySign.add(signature);
                }
            }
            key.setKgSignatures(keySign);
        }
        baseWrappers.setDatas(kgSignKeys);
        baseWrappers.setFlag(true);
        return baseWrappers;
    }


    //获取印章管理列表
    public BaseWrapper getKgSignatureList() {
        BaseWrapper wrapper = new BaseWrapper();
        List<KgSignature> kgSignatureList = kgSignatureMapper.getKgSignatureList();

        if(kgSignatureList != null) {
            wrapper.setFlag(true);
            wrapper.setMsg("查询成功！");
            wrapper.setData(kgSignatureList);
        } else {
            wrapper.setMsg("查询出错！");
        }
        return wrapper;
    }

    //获取授权管理列表
    public BaseWrapper getKgSignKeyList(Integer signId) {
        BaseWrapper wrapper = new BaseWrapper();
        List<KgSignKey> kgSignKeyList = kgSignKeyMapper.getKgSignKeyList(signId);

        if(kgSignKeyList != null) {
            wrapper.setFlag(true);
            wrapper.setMsg("查询成功！");
            wrapper.setData(kgSignKeyList);
        } else {
            wrapper.setMsg("查询出错！");
        }
        return wrapper;
    }

    //添加印章
    @Transactional(rollbackFor = RuntimeException.class)
    public BaseWrapper addKgSignature(KgSignature kgSignature) {
        BaseWrapper wrapper = new BaseWrapper();
        try {
            int result = kgSignatureMapper.insertSelective(kgSignature);

            if(result > 0) {
                wrapper.setMsg("添加成功！");
                wrapper.setFlag(true);
            } else {
                wrapper.setMsg("添加失败！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("添加出错！");
        }
        return wrapper;
    }

    //添加授权
    @Transactional(rollbackFor = RuntimeException.class)
    public BaseWrapper addKgSignKey(KgSignKey kgSignKey, Integer signId) {
        BaseWrapper wrapper = new BaseWrapper();
        int result = 0;
        try {
            kgSignKeyMapper.insertSelective(kgSignKey);

            //插入key_sign表
            KgRelationKeySign kgRelationKeySign = new KgRelationKeySign();
            kgRelationKeySign.setSignId(signId);
            kgRelationKeySign.setKeyId(kgSignKey.getSignkeyId());
            kgRelationKeySignMapper.insertSelective(kgRelationKeySign);

            //插入key_user表
            KgRelationKeyUser kgRelationKeyUser = new KgRelationKeyUser();
            kgRelationKeyUser.setKeyId(kgSignKey.getSignkeyId());
            for(String userId: kgSignKey.getUserIdStr().split(",")) {
                kgRelationKeyUser.setUserId(Integer.parseInt(userId));
                result = kgRelationKeyUserMapper.insertSelective(kgRelationKeyUser);
            }

            if(result > 0) {
                wrapper.setMsg("添加成功！");
                wrapper.setFlag(true);
            } else {
                wrapper.setMsg("添加失败！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("添加出错！");
        }
        return wrapper;
    }

    //修改印章
    public BaseWrapper updateKgSignature(KgSignature kgSignature) {
        BaseWrapper wrapper = new BaseWrapper();
        try {
            int result = kgSignatureMapper.updateByPrimaryKeySelective(kgSignature);

            if(result > 0) {
                wrapper.setMsg("修改成功！");
                wrapper.setFlag(true);
            } else {
                wrapper.setMsg("修改失败！");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return wrapper;
    }

    //修改授权
    @Transactional(rollbackFor = RuntimeException.class)
    public BaseWrapper updateKgSignKey(KgSignKey kgSignKey) {
        BaseWrapper wrapper = new BaseWrapper();
        int result = 0;
        try {
            kgSignKeyMapper.updateByPrimaryKeySelective(kgSignKey);

            //删除ket_user表中对应的记录
            KgRelationKeyUserExample example = new KgRelationKeyUserExample();
            example.or().andKeyIdEqualTo(kgSignKey.getSignkeyId());
            kgRelationKeyUserMapper.deleteByExample(example);
            //增加记录
            KgRelationKeyUser kgRelationKeyUser = new KgRelationKeyUser();
            kgRelationKeyUser.setKeyId(kgSignKey.getSignkeyId());
            for(String userId: kgSignKey.getUserIdStr().split(",")) {
                kgRelationKeyUser.setUserId(Integer.parseInt(userId));
                result = kgRelationKeyUserMapper.insertSelective(kgRelationKeyUser);
            }

            if(result > 0) {
                wrapper.setMsg("修改成功！");
                wrapper.setFlag(true);
            } else {
                wrapper.setMsg("修改失败！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("修改出错！");
        }
        return wrapper;
    }

    //删除印章
    public BaseWrapper deleteKgSignature(Integer signatureId) {
        BaseWrapper wrapper = new BaseWrapper();

        KgSignatureExample example = new KgSignatureExample();
        example.or().andSignatureIdEqualTo(signatureId);
        KgSignature kgSignature = new KgSignature();
        kgSignature.setSignatureStatus(-1);
        try {
            int result = kgSignatureMapper.updateByExampleSelective(kgSignature, example);

            if(result > 0) {
                wrapper.setMsg("修改成功！");
                wrapper.setFlag(true);
            } else {
                wrapper.setMsg("修改失败！");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return wrapper;
    }

    //删除授权
    public BaseWrapper deleteKgSignKey(Integer signkeyId) {
        BaseWrapper wrapper = new BaseWrapper();

        KgSignKeyExample example = new KgSignKeyExample();
        example.or().andSignkeyIdEqualTo(signkeyId);
        KgSignKey kgSignKey = new KgSignKey();
        kgSignKey.setSignkeyStatus(-1);
        try {
            int result = kgSignKeyMapper.updateByExampleSelective(kgSignKey, example);

            if(result > 0) {
                wrapper.setMsg("修改成功！");
                wrapper.setFlag(true);
            } else {
                wrapper.setMsg("修改失败！");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return wrapper;
    }

    //根据主键查询印章
    public BaseWrapper getKgSignatureByKey(Integer signatureId) {
        BaseWrapper wrapper = new BaseWrapper();
        KgSignature kgSignature = kgSignatureMapper.selectByPrimaryKey(signatureId);
        if(kgSignature != null) {
            wrapper.setFlag(true);
            wrapper.setMsg("查询成功！");
            wrapper.setData(kgSignature);
        } else {
            wrapper.setMsg("查询失败！");
        }
        return wrapper;
    }

    //根据主键查询授权
    public BaseWrapper getKgSignKetByKey(Integer signkeyId) {
        BaseWrapper wrapper = new BaseWrapper();
        String resultId = "";
        String resultName = "";
        Users users;
        KgSignKey kgSignKey = kgSignKeyMapper.selectByPrimaryKey(signkeyId);

        KgRelationKeyUserExample example = new KgRelationKeyUserExample();
        example.or().andKeyIdEqualTo(signkeyId);
        List<KgRelationKeyUser> userIds = kgRelationKeyUserMapper.selectByExample(example);

        for(KgRelationKeyUser userId: userIds) {
            resultId += userId.getUserId() + ",";
            users = usersMapper.selectUserByUId(userId.getUserId());
            resultName += "," + users.getUserName();
        }
        resultName = resultName.replaceFirst(",", "");
        kgSignKey.setUserIdStr(resultId);
        kgSignKey.setUserNameStr(resultName);

        if(kgSignKey != null) {
            wrapper.setMsg("查询成功！");
            wrapper.setFlag(true);
            wrapper.setData(kgSignKey);
        } else {
            wrapper.setMsg("查询失败！");
        }
        return wrapper;
    }
}
