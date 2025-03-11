package com.xoa.service.voteItem;

import com.baomidou.mybatisplus.service.IService;
import com.xoa.model.voteItem.VoteItem;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;

/**
 * <p>
 * 投票选项信息表 服务类
 * </p>
 *
 * @author 张丽军
 * @since 2017-09-18
 */
public interface IVoteItemService extends IService<VoteItem> {

    ToJson<VoteItem> addVoteItem(HttpServletRequest request, VoteItem voteItem);

    ToJson<VoteItem> updateVoteItem(HttpServletRequest request, VoteItem voteItem);

    ToJson<VoteItem> deleteByItemId(HttpServletRequest request, Integer itemId);

    ToJson<VoteItem> getVoteItemList(HttpServletRequest request, Integer voteId);

    ToJson<VoteItem> updateVoteCount(HttpServletRequest request, VoteItem voteItem);
}
