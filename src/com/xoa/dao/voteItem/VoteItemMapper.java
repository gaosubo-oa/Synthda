package com.xoa.dao.voteItem;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.xoa.model.voteItem.VoteItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
  * 投票选项信息表 Mapper 接口
 * </p>
 *
 * @author ÕÅÀö¾ü
 * @since 2017-09-18
 */
public interface VoteItemMapper extends BaseMapper<VoteItem> {

    int addVoteItem(VoteItem voteItem);

    int updateVoteItem(VoteItem voteItem);

    int deleteByItemId(Integer itemId);

    List<VoteItem> getVoteItemList(Integer voteId);

    int updateVoteCount(VoteItem voteItem);

    VoteItem getOneVoteItem(VoteItem voteItem);

    void updateVote(VoteItem voteItem);

    VoteItem getVoteItem(Integer itemId);
    List<VoteItem> selectVoteEndTime(@Param("dateTime") String dateTime);

    Integer selVoteCountSum(@Param("voteId") Integer voteId);

    void deleteByVoteId(@Param("array") String[] voteIds);
}