package com.xoa.dao.wages_manage;

import com.xoa.model.wages_manage.WagesLock;

public interface WagesLockMapper {
    WagesLock  selectByName (WagesLock wagesLock);
    int insert (WagesLock wagesLock);
    int update(WagesLock wagesLock);
}
