package com.xoa.service.h5AppLogin;

import com.xoa.dao.WeixinGzh.UserWeixinGzhMapMapper;
import com.xoa.dao.users.UsersMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WeixinPublicService {

    @Autowired
    protected UsersMapper usersMapper;

    @Autowired
    protected UserWeixinGzhMapMapper userWeixinGzhMapMapper;


}
