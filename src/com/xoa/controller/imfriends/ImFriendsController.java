package com.xoa.controller.imfriends;

import com.xoa.service.imfriends.ImfriendsService;
import com.xoa.util.ToJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 *
 * 20180817为pc即时通讯添加好友功能
 * 贾志敏
 */
@Controller
@RequestMapping("/imfriends")
public class ImFriendsController {
    @Autowired
    private ImfriendsService imfriendsService;

    //是否同意的页面
    @RequestMapping("/geImfriendsByIdPage")
    public String geImfriendsByIdPage(){
        return "app/spirit/imfriendsByIdPage";
    }

    //添加好友
    @ResponseBody
    @RequestMapping("/addFriend")
    public ToJson addFriend(HttpServletRequest request, String fuids, String message){
        return  imfriendsService.addFriend(request,fuids,message);
    }

    //通过id得到中间表数据
    @ResponseBody
    @RequestMapping("/geImfriendsById")
    public ToJson geImfriendsById(HttpServletRequest request, String frdId){
        return imfriendsService.geImfriendsById(request,frdId);
    }

    //同意加好友更改状态
    @ResponseBody
    @RequestMapping("/updatePass")
    public ToJson updateImfriendsPassByFrdId(HttpServletRequest request, String frdId, String pass){
        return imfriendsService.updateImfriendsPassByFrdId(request,frdId,pass);
    }

    //获取好友列表并搜索
    @ResponseBody
    @RequestMapping("/getfriendsList")
    public ToJson getList(HttpServletRequest request, String userName){
        return imfriendsService.getList(request,userName);
    }
    //获取当前登录人名字
    @ResponseBody
    @RequestMapping("/getUserName")
    public ToJson getUserName(HttpServletRequest request){
        return imfriendsService.getUserName(request);
    }
    //获取未验证通过的好友
    @ResponseBody
    @RequestMapping("/getWyzFriends")
    public ToJson getWyzFriends(HttpServletRequest request){
      return imfriendsService.getWyzFriends(request);
    }

    //获取是好友还是组织
    @ResponseBody
    @RequestMapping("/getIsFriends")
    public ToJson getIsFriends(HttpServletRequest request){
        return imfriendsService.getIsFriends(request);
    }

}
