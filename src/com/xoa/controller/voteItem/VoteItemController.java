package com.xoa.controller.voteItem;

import com.xoa.model.voteItem.VoteItem;
import com.xoa.service.voteItem.IVoteItemService;
import com.xoa.util.ToJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * <p>
 * 投票选项信息表 前端控制器
 * </p>
 *
 * @author 张丽军
 * @since 2017-09-18
 */
@Controller
@RequestMapping("/voteItem")
public class VoteItemController {

    @Autowired
    IVoteItemService voteItemService;

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月18日
     * 方法介绍:   新建投票项目
     * @param request
     * @param voteItem
     * @return
     */
    @ResponseBody
    @RequestMapping("/addVoteItem")
    public ToJson<VoteItem> addVoteItem(HttpServletRequest request, VoteItem voteItem){
        return voteItemService.addVoteItem(request,voteItem);
    }
    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月18日
     * 方法介绍:   修改投票项目
     * @param request
     * @param voteItem
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateVoteItem")
    public ToJson<VoteItem> updateVoteItem(HttpServletRequest request, VoteItem voteItem){
        return voteItemService.updateVoteItem(request,voteItem);
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年10月13日
     * 方法介绍:   修改投票结果
     * @param request
     * @param voteItem
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateVoteCount")
    public ToJson<VoteItem> updateVoteCount(HttpServletRequest request, VoteItem voteItem){
        return voteItemService.updateVoteCount(request,voteItem);
    }



    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月18日
     * 方法介绍:   删除投票项目根据itemId
     * @param request
     * @param itemId
     * @return
     */
    @ResponseBody
    @RequestMapping("/deleteByItemId")
    public ToJson<VoteItem> deleteByItemId(HttpServletRequest request,Integer itemId){
        return voteItemService.deleteByItemId(request,itemId);
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月23日
     * 方法介绍:   查询投票项目中的选项
     * @param request
     * @param voteId
     * @return
     */
    @ResponseBody
    @RequestMapping("/getVoteItemList")
    public ToJson<VoteItem> getVoteItemList(HttpServletRequest request,Integer voteId){
        return voteItemService.getVoteItemList(request,voteId);
    }
}
