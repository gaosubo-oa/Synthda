package com.xoa.service.users;

import com.xoa.model.users.UserModulePage;
import com.xoa.util.common.wrapper.BaseWrapper;

public interface UserModulePageService {

    BaseWrapper save(UserModulePage userModulePage);

    BaseWrapper selectPage(UserModulePage userModulePage);

}
