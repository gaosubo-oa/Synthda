package com.xoa.dao.voteTitle;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.xoa.model.voteTitle.VoteTitle;

import java.util.List;
import java.util.Map;

/**
 * <p>
  * 投票基本信息表 Mapper 接口
 * </p>
 *
 * @author 张丽军
 * @since 2017-09-16
 */
public interface VoteTitleMapper extends BaseMapper<VoteTitle> {


    List<VoteTitle> getVoteTitleList(Map<String, Object> maps);

    List<VoteTitle> selectVoteTitleLists(Map<String, Object> maps);

    int getcount(Map<String, Object> maps);

    int newVoteTitle(VoteTitle voteTitle);

    int updateVoteTitle(VoteTitle voteTitle);

    List<VoteTitle> getChildVoteList(Integer parentId);

    VoteTitle getChilddetail(Integer voteId);

    VoteTitle newGetChilddetail(Integer voteId);

    void deleteByVoteId(String[] voteIds);

    List<VoteTitle> getVoteDataByVoteId(Integer voteId);

    List<VoteTitle> searchVoteTitleList(Map<String, Object> maps);

    Integer searchVoteTitleListCount(Map<String, Object> maps);

    List<VoteTitle> searchVoteTitleListCopy(Map<String, Object> maps);

    List<VoteTitle> getVoteTitleCount(Map<String, Object> maps);

    Integer getCount(Integer voteId);

    int getcount1();

    int getcount2();

    /**
     * 根据ID查询投票
     * @param voteId
     * @return
     */
    VoteTitle  voteSelectOne(Integer voteId);

    VoteTitle  selectByVoteId(Integer voteId);

    /**
     * 查询当前人是否投票
     * @param map
     * @return
     */
    VoteTitle  slectUserTd(Map<String, Object> map);

    List<VoteTitle> getAdminVoteTitleList(Map<String, Object> map);

    List<VoteTitle> getNeedUpdate();

    VoteTitle getTextTypeList(Integer voteId);

    List<VoteTitle> selByParentId(Integer parentId);
}