package com.xoa.service.infoCenter;

import com.xoa.dao.infoCenter.InfoCenterMapper;
import com.xoa.dao.portals.PortalsMapper;
import com.xoa.dao.users.UserFunctionMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.infoCenter.InfoCenter;
import com.xoa.model.users.Users;
import com.xoa.util.CookiesUtil;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by 张雨 on 2018/1/15.
 * 首页标签卡设置
 */
@Service
public class InfoCenterService {

    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private InfoCenterMapper infoCenterMapper;

    @Autowired
    private UserFunctionMapper userFunctionMapper;

    @Autowired
    private PortalsMapper portalsMapper;

    //获取标签卡位置顺序
    public BaseWrapper getInfoCenterOrder(HttpServletRequest request) {
        BaseWrapper wrapper = new BaseWrapper();
        try {
            Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),CookiesUtil.getCookieByName(request,"redisSessionId"));
            Users user = usersMapper.selectUserByUId(users.getUid());

            String[] infoCenters;  //旧
            String strs=""; //返回的字符串

            //如果为ALL则说明未自定义位置，使用默认位置。
            if(user!=null&&user.getMytableLeft().equals("ALL")) {
                //默认排序
                infoCenters=portalsMapper.selectByPrimaryKey(1).getPortalsShow().split(",");
            }else{
                //指定排序
                infoCenters = user.getMytableLeft().split(",");
            }

            //查询门户信息
            if(infoCenters.length>0){
                List<InfoCenter> centers=infoCenterMapper.getInfoCenter(infoCenters);

                //判断门户是否在菜单里
                String[] userIdFunctions = userFunctionMapper.getUserFuncIdStr(user.getUserId()).split(",");
                for (InfoCenter s:centers){
                    String infoNo = s.getInfoNo();//编号
                    String infoFuncId = s.getInfoFuncId(); //funcId

                    //过滤出今日看板和常用功能，自定义告示栏，速卓待办
                    if (infoNo.equals("00") || infoNo.equals("0b")|| infoNo.equals("07") || infoNo.equals("17") || infoNo.equals("18") || infoNo.equals("19") || infoNo.equals("23")){
                        strs+=infoNo+",";
                        continue;
                    }

                    //判断菜单是否包含
                    boolean res = Arrays.asList(userIdFunctions).contains(infoFuncId);
                    if (res){
                        strs+=infoNo+",";
                    }
                }
            }

            wrapper.setFlag(true);
            wrapper.setMsg("查询成功！");
            wrapper.setData(strs);
        }catch (Exception e){
            e.printStackTrace();
            wrapper.setMsg(e.getMessage());
        }
        return wrapper;
    }

    //设置标签卡位置顺序
    @Transactional(rollbackFor = RuntimeException.class)
    public BaseWrapper setInfoCenterOrder(String infoCenterOrder,String infoLeftOrder,String infoRightOrder,HttpServletRequest request) {
        BaseWrapper wrapper = new BaseWrapper();
        try {
            Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),CookiesUtil.getCookieByName(request,"redisSessionId"));

            Map sets=new HashMap();
            sets.put("MYTABLE_LEFT",infoLeftOrder);
            sets.put("SHORTCUT",infoCenterOrder);
            sets.put("MYTABLE_RIGHT",infoRightOrder);

            Map map=new HashMap();
            map.put("uId",user.getUid());
            map.put("sets",sets);
            try {
                int result = usersMapper.updateUserMap(map);
                if(result > 0) {
                    wrapper.setFlag(true);
                    wrapper.setMsg("更新成功！");
                } else {
                    wrapper.setMsg("更新失败！");
                }
            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException("更新出错！");
            }
        }catch (Exception e){
            wrapper.setMsg(e.getMessage());
        }
        return wrapper;
    }

    /**
     * 获取菜单设置已添加的标签卡
     */
    public BaseWrapper getHadInfoCenterList(HttpServletRequest request) {
        BaseWrapper wrapper = new BaseWrapper();
        List<InfoCenter> infoCenterList = new ArrayList<>();
        String userFunctions;

        Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),CookiesUtil.getCookieByName(request,"redisSessionId"));
        String definedOrder = infoCenterMapper.getInfoCenterDefinedOrder(); //获取全部菜单
        Users users=usersMapper.selectUserByUId(user.getUid());
        //展示已添加菜单
        if(!users.getMytableLeft().equals("ALL")) {
            userFunctions = users.getMytableLeft();
        } else {
            userFunctions = definedOrder;
        }

        //获取用户菜单
        //String userIdFunctions = userFunctionMapper.getUserFuncIdStr(user.getUserId());
        // String userIdFunctions=users.getMytableLeft();
        //userIdFunctions = getNewUserIdFunction(definedOrder, userIdFunctions);
        String[] userFunctio = userFunctions.split(",");
        //权限过滤
        //infoCenters = power(infoCenters, userIdFunctions);

        for(String userFunction: userFunctio) {
            if(!userFunction.equals("")) {
                InfoCenter infoCenter = infoCenterMapper.getInfoCenterByInfoFuncId(Integer.parseInt(userFunction));
                if(infoCenter != null) {
                    infoCenterList.add(infoCenter);
                }
            }
        }

        if(infoCenterList != null) {
            wrapper.setFlag(true);
            wrapper.setMsg("查询成功！");
            wrapper.setData(infoCenterList);
        } else {
            wrapper.setMsg("查询失败！");
        }
        return wrapper;
    }

    /**
     * 获取菜单设置未添加的标签卡
     * @return
     */
    public BaseWrapper getChooseInfoCenterList(HttpServletRequest request) {
        BaseWrapper wrapper = new BaseWrapper();
        List<InfoCenter> infoCenterList = new ArrayList<>();
        Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),CookiesUtil.getCookieByName(request,"redisSessionId"));
        String definedOrder = infoCenterMapper.getInfoCenterDefinedOrder(); //获取全部菜单
        Users users=usersMapper.selectUserByUId(user.getUid());
        //获取用户已添加的菜单
        String userFunctions = users.getMytableLeft();
        //获取用户菜单
//        String userIdFunctions = userFunctionMapper.getUserFuncIdStr(user.getUserId());
        //为ALL则获取默认顺序
        if(userFunctions.equals("ALL")) {
            userFunctions = definedOrder;
        }
        //转换为数组
        String[] userFunctionList = userFunctions.split(",");
        String[] definedOrderList=definedOrder.split(",") ;
        // userIdFunctions = getNewUserIdFunction(definedOrder, userIdFunctions);

        // String[] userIdFunctionList = userIdFunctions.split(",");
        //去除已添加的标签卡
        for(String userFunction: userFunctionList) {
            for(int i = 0; i < definedOrderList.length; i ++) {
                if(userFunction.equals(definedOrderList[i])) {
                    definedOrderList[i] = "";
                }
            }
        }

        for(String userIdFunction: definedOrderList) {
            InfoCenter infoCenter = null;
            if(!userIdFunction.equals("")) {
                infoCenter = infoCenterMapper.getInfoCenterByInfoFuncId(Integer.parseInt(userIdFunction));
                if(infoCenter != null) {
                    infoCenterList.add(infoCenter);
                }
            }
        }

        if(infoCenterList != null) {
            wrapper.setFlag(true);
            wrapper.setMsg("查询成功！");
            wrapper.setData(infoCenterList);
        } else {
            wrapper.setMsg("查询失败！");
        }
        return wrapper;
    }

    //权限过滤方法
    public String[] power(String[] theTables, String userIdFunctions) {
        int i = 0;
        for(String theTable: theTables) {
            if(!(","+userIdFunctions+",").contains(","+theTable+",")) {
                theTables[i] = "";
            }
            i ++;
        }
        return theTables;
    }

    //数组转化成字符串
    public String transToStr(String[] strs) {
        String result = "";
        for(String str: strs) {
            if(str!=""){
                result += str+",";
            }
        }
        return result;
    }

    //将info_center表中有但是user_function表中没有的标签卡插入userIdFunctions
    public String getNewUserIdFunction(String definedOrders, String userIdFunctions) {
        String[] definedOrderList = definedOrders.split(",");
        for(String order: definedOrderList) {
            if(Integer.parseInt(order) <= 0) {
                if(!StringUtils.checkNull(userIdFunctions)){
                    if(!userIdFunctions.substring(userIdFunctions.length()-1,userIdFunctions.length()).equals(",")){
                        userIdFunctions +=","+ order + ",";
                    }else{
                        userIdFunctions +=order + ",";
                    }
                }
            }
        }
        return userIdFunctions;
    }


    //获取全部标签卡
    public BaseWrapper getInfoCenters(HttpServletRequest request) {
        BaseWrapper wrapper = new BaseWrapper(false,false,"err",null);
        try {
            List<InfoCenter> centers = infoCenterMapper.selectByExample(null);
            for (InfoCenter center:centers) {
                center.setIconPath("/img/main_img/app/"+center.getIconPath());
            }
            wrapper.setFlag(true);
            wrapper.setMsg("OK");
            wrapper.setData(centers);
        }catch (Exception e){
            e.getMessage();
        }
        return wrapper;
    }
}