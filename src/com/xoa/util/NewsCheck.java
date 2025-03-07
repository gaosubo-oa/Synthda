package com.xoa.util;

import java.util.Map;

/**
 * Created by gsb on 2017/6/13.
 */
@SuppressWarnings("all")
public class NewsCheck {

    public static boolean checkDeptPriv(String DeptId,String deptIdOfuser_Id){
        //如果部门部分权限为“ALL_DEPT" 则部门范围有访问权限。将直返回return true；停止执行程序
        if("ALL_DEPT".equals(DeptId)||"ALL_DEPT"==DeptId){
            return true;
        }
        //如果部门部分权限为拼接字符串则将字符串拆开验证 ，如果登录人员匹配得所属部门则将直返回return true；停止执行程序
        if(DeptId!=null&&!"".equals(DeptId)){
            String[] deptIds=DeptId.split(",");
            for(int i=0;i<deptIds.length;i++){
                if(deptIdOfuser_Id.equals(deptIds)){
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
                if(deptIds.equals(userPrivOfuser_Id)){
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

    public static  boolean checkAll(String depIds,String userIds,String roleIds, Map<String,Object> map) {
         if(depIds!=null){
             String[]  checkDept=depIds.split(",");
             for (int j = 0; j < checkDept.length; j++) {
                 if(map.get("deptId")!=null){
                     String depId=map.get("deptId").toString();
                     if(checkDeptPriv(checkDept[j],depId)){
                         return true;
                     }
                 }else{
                     return false;
                 }
                        }
         }
         if(userIds!=null){
             String[]  checkUser=userIds.split(",");
             for(int i=0;i<checkUser.length;i++){
                 if(map.get("userId")!=null){
                     String userId=map.get("userId").toString();
                     if(checkUserId(checkUser[i],userId)){
                         return true;
                     }
                 }
                 else{
                     return false;
                 }

             }
       }
       if(roleIds!=null){
           String[]  checkRole=roleIds.split(",");
           for(int i=0;i<checkRole.length;i++){
               if(map.get("userPriv")!=null){
                   String userPrivId=map.get("userPriv").toString();
                   if(checkUserPriv(checkRole[i],userPrivId)){
                       return true;
                   }
               } else{
                   return false;
               }

           }

       }


    return  false;
    }
}
