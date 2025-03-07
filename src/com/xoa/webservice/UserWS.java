package com.xoa.webservice;
import com.xoa.model.users.UserExt;
import com.xoa.model.users.Users;
import com.xoa.util.common.wrapper.BaseWrapper;

import javax.jws.WebService;

@WebService
public interface UserWS {
    BaseWrapper insert(String orgId, Users user, UserExt userExt);
    BaseWrapper delete(String orgId, String userid);
    BaseWrapper update(String orgId, Users user, UserExt userExt);
}
