package com.xoa.service.officesupplies;

import com.xoa.dao.officesupplies.OfficeDepositoryMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.officesupplies.OfficeDepositoryWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/10/7 18:03
 * 类介绍  :   办公用品库
 * 构造参数:
 */
@Service
public class OfficeDepositoryService {
    @Resource
    private OfficeDepositoryMapper officeDepositoryMapper;

    @Resource
    private DepartmentService departmentService;

    @Resource
    private UsersService usersService;

    @Resource
    private UsersPrivService usersPrivService;

    @Resource
    private UsersMapper usersMapper;
    @Resource
    private OfficeTypeService officeTypeService;

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 上午11:00:00
     * 方法介绍:   添加办公用品库
     * 参数说明:   @param record
     * 返回值说明:
     */
    @Transactional
    public ToJson<OfficeDepositoryWithBLOBs> insertDepository(OfficeDepositoryWithBLOBs depositoryWithBLOBs) {
        ToJson<OfficeDepositoryWithBLOBs> json = new ToJson<OfficeDepositoryWithBLOBs>(1, "error");
        try {
            int count = officeDepositoryMapper.insertDepository(depositoryWithBLOBs);
            if (count > 0) {
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("OfficeDepositoryService insertDepository:" + e);
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 上午11:01:00
     * 方法介绍:   修改id办公用品库
     * 参数说明:   @param record
     * 返回值说明:
     */
    @Transactional
    public ToJson<OfficeDepositoryWithBLOBs> updateDepositoryById(OfficeDepositoryWithBLOBs depositoryWithBLOBs) {
        ToJson<OfficeDepositoryWithBLOBs> json = new ToJson<OfficeDepositoryWithBLOBs>(1, "error");
        try {
            int count = officeDepositoryMapper.updateDepositoryById(depositoryWithBLOBs);
            if (count > 0) {
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("OfficeDepositoryService updateDepositoryById:" + e);
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 上午11:02:00
     * 方法介绍:   根据id删除办公用品库
     * 参数说明:   @param id
     * 返回值说明:
     */
    @Transactional
    public ToJson<OfficeDepositoryWithBLOBs> delDepositoryById(Integer id) {
        ToJson<OfficeDepositoryWithBLOBs> json = new ToJson<OfficeDepositoryWithBLOBs>(1, "error");
        try {
            int count = officeDepositoryMapper.delDepositoryById(id);
            if (count > 0) {
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("OfficeDepositoryService delDepositoryById:" + e);
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 上午11:03:00
     * 方法介绍:   根据id查询办公用品库
     * 参数说明:   @param id
     * 返回值说明:
     */
    public ToJson<OfficeDepositoryWithBLOBs> selDepositoryById(HttpServletRequest request,Integer id) {
        ToJson<OfficeDepositoryWithBLOBs> json = new ToJson<OfficeDepositoryWithBLOBs>(1, "error");
        try {
            String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            OfficeDepositoryWithBLOBs officeDepositoryWithBLOBs = officeDepositoryMapper.selDepositoryById(id);
            if (officeDepositoryWithBLOBs != null) {
                if (!StringUtils.checkNull(officeDepositoryWithBLOBs.getDeptId())) {
                    if (officeDepositoryWithBLOBs.getDeptId().equals("ALL_DEPT")) {
                        officeDepositoryWithBLOBs.setDeptName("全体部门");
                        if (locale.equals("zh_CN")) {
                            officeDepositoryWithBLOBs.setDeptName("全部部门");
                        } else if (locale.equals("en_US")) {
                            officeDepositoryWithBLOBs.setDeptName("All Department");
                        } else if (locale.equals("zh_TW")) {
                            officeDepositoryWithBLOBs.setDeptName("全部部门");
                        }
                    } else {
                        officeDepositoryWithBLOBs.setDeptName(departmentService.getDeptNameByDeptId(officeDepositoryWithBLOBs.getDeptId(), ","));
                    }
                }
            }
            if (!StringUtils.checkNull(officeDepositoryWithBLOBs.getManager())) {
                officeDepositoryWithBLOBs.setManagerName(usersService.getUserNamesByUserIds(officeDepositoryWithBLOBs.getManager()));
            }
            if (!StringUtils.checkNull(officeDepositoryWithBLOBs.getProKeeper())) {
                officeDepositoryWithBLOBs.setProKeeperName(usersService.getUserNamesByUserIds(officeDepositoryWithBLOBs.getProKeeper()));
            }
            if (!StringUtils.checkNull(officeDepositoryWithBLOBs.getPrivId())) {
                officeDepositoryWithBLOBs.setPrivName(usersPrivService.getPrivNameByPrivId(officeDepositoryWithBLOBs.getPrivId(), ","));
            }
            if (!StringUtils.checkNull(officeDepositoryWithBLOBs.getOfficeTypeId())) {
                officeDepositoryWithBLOBs.setOfficeTypeName(officeTypeService.getTypeNameByTypeIds(officeDepositoryWithBLOBs.getOfficeTypeId()));
            }
            if (!StringUtils.checkNull(officeDepositoryWithBLOBs.getReturnReason())) {
                officeDepositoryWithBLOBs.setReturnReasonName(usersService.getUserNamesByUserIds(officeDepositoryWithBLOBs.getReturnReason()));
            }
            json.setObject(officeDepositoryWithBLOBs);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("OfficeDepositoryService selDepositoryById:" + e);
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 上午11:04:00
     * 方法介绍:   查询所有办公用品库
     * 参数说明:   @param
     * 返回值说明:
     */
    public ToJson<OfficeDepositoryWithBLOBs> selAllDepository(HttpServletRequest request) {
        ToJson<OfficeDepositoryWithBLOBs> json = new ToJson<OfficeDepositoryWithBLOBs>(1, "error");
        try {
            String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            List<OfficeDepositoryWithBLOBs> officeDepositoryWithBLOBs = officeDepositoryMapper.selAllDepository();
            for (OfficeDepositoryWithBLOBs depository : officeDepositoryWithBLOBs) {
                if (!StringUtils.checkNull(depository.getDeptId())) {
                    if (depository.getDeptId().equals("ALL_DEPT")) {
                        depository.setDeptName("全体部门");
                        if (locale.equals("zh_CN")) {
                            depository.setDeptName("全部部门");
                        } else if (locale.equals("en_US")) {
                            depository.setDeptName("All Department");
                        } else if (locale.equals("zh_TW")) {
                            depository.setDeptName("全部部门");
                        }
                    } else {
                        depository.setDeptName(departmentService.getDeptNameByDeptId(depository.getDeptId(), ","));
                    }
                }
                if (!StringUtils.checkNull(depository.getManager())) {
                    depository.setManagerName(usersService.getUserNamesByUserIds(depository.getManager()));
                }
                if (!StringUtils.checkNull(depository.getProKeeper())) {
                    depository.setProKeeperName(usersService.getUserNamesByUserIds(depository.getProKeeper()));
                }
                if (!StringUtils.checkNull(depository.getPrivId())) {
                    depository.setPrivName(usersPrivService.getPrivNameByPrivId(depository.getPrivId(), ","));
                }
                if (!StringUtils.checkNull(depository.getOfficeTypeId())) {
                    depository.setOfficeTypeName(officeTypeService.getTypeNameByTypeIds(depository.getOfficeTypeId()));
                }
            }
            json.setObj(officeDepositoryWithBLOBs);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("OfficeDepositoryService selAllDepository:" + e);
            e.printStackTrace();
        }
        return json;
    }

    public ToJson<OfficeDepositoryWithBLOBs> selAllDepositoryPage(HttpServletRequest request,int page, int pageSize, boolean useFlag) {
        ToJson<OfficeDepositoryWithBLOBs> json = new ToJson<OfficeDepositoryWithBLOBs>(1, "error");
        try {
            Map map = new HashMap();
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            map.put("page", pageParams);
            String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            List<OfficeDepositoryWithBLOBs> officeDepositoryWithBLOBs = officeDepositoryMapper.selAllDepositoryPage(map);
            for (OfficeDepositoryWithBLOBs depository : officeDepositoryWithBLOBs) {
                if (!StringUtils.checkNull(depository.getDeptId())) {
                    if (depository.getDeptId().equals("ALL_DEPT")) {
                        depository.setDeptName("全体部门");
                        if (locale.equals("zh_CN")) {
                            depository.setDeptName("全部部门");
                        } else if (locale.equals("en_US")) {
                            depository.setDeptName("All Department");
                        } else if (locale.equals("zh_TW")) {
                            depository.setDeptName("全部部门");
                        }
                    } else {
                        depository.setDeptName(departmentService.getDeptNameByDeptId(depository.getDeptId(), ","));
                    }
                }
                if (!StringUtils.checkNull(depository.getManager())) {
                    depository.setManagerName(usersService.getUserNamesByUserIds(depository.getManager()));
                }
                if (!StringUtils.checkNull(depository.getProKeeper())) {
                    depository.setProKeeperName(usersService.getUserNamesByUserIds(depository.getProKeeper()));
                }
                if (!StringUtils.checkNull(depository.getPrivId())) {
                    depository.setPrivName(usersPrivService.getPrivNameByPrivId(depository.getPrivId(), ","));
                }
                if (!StringUtils.checkNull(depository.getOfficeTypeId())) {
                    depository.setOfficeTypeName(officeTypeService.getTypeNameByTypeIds(depository.getOfficeTypeId()));
                }
            }
            json.setTotleNum(pageParams.getTotal());
            json.setObj(officeDepositoryWithBLOBs);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("OfficeDepositoryService selAllDepository:" + e);
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017/10/17 14:44
     * 类介绍  :   根据所属部门权限获取办公用品库
     * 构造参数:
     */
    public ToJson<OfficeDepositoryWithBLOBs> selDepositoryByDept(HttpServletRequest request) {
        ToJson<OfficeDepositoryWithBLOBs> json = new ToJson<OfficeDepositoryWithBLOBs>(1, "error");
        Map<String, String> map = new HashMap<>();
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            List<OfficeDepositoryWithBLOBs> list = officeDepositoryMapper.selDepositoryByDept(users.getUserId());
            String string = list.stream().map(OfficeDepositoryWithBLOBs::getReturnReason).collect(Collectors.joining(","));
            String[] split = string.split(",");
            Set<String> returnReasons = new HashSet<>();
            for (String s : split) {
                returnReasons.add(s);
            }
            if (returnReasons != null && returnReasons.size() > 0) {
                List<Map<String, String>> mapList = usersMapper.getNamesById(returnReasons);
                for (Map<String, String> stringStringMap : mapList) {
                    map.put(stringStringMap.get("key"), stringStringMap.get("value"));
                }
            }
            for (OfficeDepositoryWithBLOBs officeDepositoryWithBLOBs : list) {
                if (!StringUtils.checkNull(officeDepositoryWithBLOBs.getReturnReason())) {
                    String[] returnReason = officeDepositoryWithBLOBs.getReturnReason().split(",");
                    StringBuffer sb = new StringBuffer();
                    for (String userId : returnReason) {
                        String name = map.get(userId);
                        if (!StringUtils.checkNull(name)) {
                            sb.append(name + ",");
                        }
                    }
                    if (sb.length() > 0) {
                        officeDepositoryWithBLOBs.setReturnReasonName(sb.toString().substring(0, sb.toString().length() - 1));
                    }
                }
            }
            json.setObj(list);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("OfficeDepositoryService getDeposttoryByDept:" + e);
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/23 15:44
     * 类介绍  :   查询所有树形接口
     * 构造参数:
     */
    public ToJson<OfficeDepositoryWithBLOBs> getAllDeposttoryTree(HttpServletRequest request) {
        ToJson<OfficeDepositoryWithBLOBs> json = new ToJson<OfficeDepositoryWithBLOBs>(1, "error");
        try {
            List<OfficeDepositoryWithBLOBs> list = officeDepositoryMapper.getAllDeposttoryTree();
            json.setObj(list);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("OfficeDepositoryService getDeposttoryByDept:" + e);
            e.printStackTrace();
        }
        return json;
    }
}
