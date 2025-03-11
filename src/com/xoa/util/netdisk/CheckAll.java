package com.xoa.util.netdisk;

import com.xoa.util.common.StringUtils;

import java.util.Map;

/**
 * Created by gsb on 2017/6/1.
 */
@SuppressWarnings("all")
public class CheckAll {
    /**
     *
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-26 上午9:21:36
     * 方法介绍:   检查部门权限Id
     * 参数说明:   @param DeptId
     * 参数说明:   @param deptIdOfuser_Id
     * 参数说明:   @return
     * @return     boolean
     */
    public static boolean checkDeptPriv(String DeptId,String deptIdOfuser_Id){
        //如果部门部分权限为“ALL_DEPT" 则部门范围有访问权限。将直返回return true；停止执行程序
        if("ALL_DEPT".equals(DeptId)||"ALL_DEPT"==DeptId){
            return true;
        }
        //如果部门部分权限为拼接字符串则将字符串拆开验证 ，如果登录人员匹配得所属部门则将直返回return true；停止执行程序
        if(DeptId!=null&&!"".equals(DeptId)){
            String[] deptIds=DeptId.split(",");
            for(int i=0;i<deptIds.length;i++){
                if(deptIdOfuser_Id.equals(deptIds[i])){
                    return true;
                }
            }
        }
        //如果部门字符串为其他类型 证明其无权限访问return false;
        return false;
    }
    /**
     *
     *
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-26 上午9:54:36
     * 方法介绍:   检查角色权限Id
     * 参数说明:   @param userPriv 角色id
     * 参数说明:   @param userPrivOfuser_Id 角色字符串
     * 参数说明:   @return
     * @return     boolean
     */
    public static boolean checkUserPriv(String userPriv,String userPrivOfuser_Id){
        //角色部分权限为拼接字符串，将字符串拆开验证 ，如果登录人员匹配得所属部门则将直接返回return true；停止执行程序
        if(userPriv!=null&&!"".equals(userPriv)){
            String[] deptIds=userPriv.split(",");
            for(int i=0;i<deptIds.length;i++){
                if(deptIds[i].equals(userPrivOfuser_Id)){
                    return true;
                }
            }
        }
        //如果角色部分字符串为其他类型  证明其无权限访问return false;
        return false;
    }
    /**
     *
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-26 上午9:57:41
     * 方法介绍:   人员权限验证
     * 参数说明:   @param userId 人员userId
     * 参数说明:   @param userIdOfuser_Id
     * 参数说明:   @return boolean
     * @return     boolean
     */
    public static boolean checkUserId(String userId,String userIdOfuser_Id){
        //如果部门部分权限为拼接字符串则将字符串拆开验证 ，如果登录人员匹配得所属部门则将直返回return true；停止执行程序
        if(userId!=null&&!"".equals(userId)){
            String[] deptIds=userId.split(",");
            for(int i=0;i<deptIds.length;i++){
                if(deptIds[i].equals(userIdOfuser_Id)){
                    return true;
                }
            }
        }
        //如果部门字符串为其他类型 证明其无权限访问return false;
        return false;
    }

    public static  boolean checkAll(String checkString,Map<String,Object> map){
        //"|"转义字符串  所以必须用\\进行转义 因为 而且取出数组长度不确定
        if (StringUtils.checkNull(checkString)){
            return false;
        }
        String[] checkStrings=checkString.split("\\|");
        if(checkStrings.length==0){
            return false;
        }
        //数组长度为1时 说明此时角色和用户Id权限为空
        if(checkStrings.length==1){
            if("ALL_DEPT".equals(checkStrings)){
                return  true;

            }
            String[]  checkDept=checkStrings[0].split(",");
            if (!StringUtils.checkNull(checkDept[0])) {
            for(int i=0;i<checkDept.length;i++){
                //调用校验部门方法  传值为部门id
                if(map.get("deptId")!=null){
                String depId=map.get("deptId").toString();
               if(checkDeptPriv(checkDept[i],depId)){
                        return true;
                    }
                }else{
                    return false;
                }
            }
        }
        }
        //数组长度为2时 说明此时角色和用户Id权限为空
        if(checkStrings.length==2) {
            String[] checkDept = checkStrings[0].split(",");
            if (!StringUtils.checkNull(checkDept[0])) {
                for (int i = 0; i < checkDept.length; i++) {
                    //调用校验部门范围方法  传值为部门id
                    if (map.get("deptId") != null) {
                        String depId = map.get("deptId").toString();
                        if (checkDeptPriv(checkDept[i], depId)) {
                            return true;
                        }
                    } else {
                        return false;
                    }
                }
            }
            String[] checkUserPriv = checkStrings[1].split(",");
            if (!StringUtils.checkNull(checkUserPriv[0])) {
                for (int i = 0; i < checkUserPriv.length; i++) {
                    //调用校验角色范围方法  传值为角色id
                    if (map.get("userPriv") != null) {
                        String userPrivId = map.get("userPriv").toString();
                        if (checkUserPriv(checkUserPriv[i], userPrivId)) {
                            return true;
                        }
                    } else {
                        return false;
                    }
                }
            }
        }
        //数组长度为3时 说明此时部门、角色和用户Id权限都不为空
        if(checkStrings.length==3){
            String[]  checkDept=checkStrings[0].split(",");
            if(!StringUtils.checkNull(checkDept[0])){
            for(int i=0;i<checkDept.length;i++){
              if (map.get("deptId")!=null){
                 String depId=map.get("deptId").toString();
               if(checkDeptPriv(checkDept[i],depId)){
                        return true;
                    }
                }else{
                    return false;
                }
            }
            }
            String[]  checkUserPriv=checkStrings[1].split(",");
            if(!StringUtils.checkNull(checkUserPriv[0])){
            for(int i=0;i<checkUserPriv.length;i++){
                //调用校验角色范围方法  传值为角色id
                if(map.get("userPriv")!=null){
              String userPrivId=map.get("userPriv").toString();
               if(checkUserPriv(checkUserPriv[i],userPrivId)){
                        return true;
                    }
                } else{
                    return false;
                }
            }
            }
            String[]  checkUserId=checkStrings[2].split(",");
            if(!StringUtils.checkNull(checkUserId[0])){
            for(int i=0;i<checkUserId.length;i++){
                //调用校验用户范围方法  传值为用户id
                if(map.get("userId")!=null){
                    String userId=map.get("userId").toString();
                    if(checkUserId(checkUserId[i],userId)){
                        return true;
                    }
                }
                else{
                    return false;
                }
            }
            }
        }
        return false;
    }
}
