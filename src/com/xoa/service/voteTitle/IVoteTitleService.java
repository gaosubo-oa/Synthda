package com.xoa.service.voteTitle;

import com.baomidou.mybatisplus.service.IService;
import com.xoa.model.users.Users;
import com.xoa.model.voteTitle.VoteTitle;
import com.xoa.util.AjaxJson;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * <p>
 * 投票基本信息表 服务类
 * </p>
 *
 * @author 张丽军
 * @since 2017-09-16
 */
public interface IVoteTitleService extends IService<VoteTitle> {

    ToJson<VoteTitle> getVoteTitleList(HttpServletRequest request, VoteTitle voteTitle, Map<String, Object> maps, Integer page,
                                       Integer pageSize, boolean useFlag);

    ToJson<VoteTitle> newVoteTitle(HttpServletRequest request, VoteTitle voteTitle);

    ToJson<VoteTitle> updateVoteTitle(HttpServletRequest request, VoteTitle voteTitle);
    //获取投票信息与子投票信息
    ToJson<VoteTitle> getChildVoteList(HttpServletRequest request, VoteTitle voteTitle, Integer voteId);

    ToJson<VoteTitle> addChildVoteTitle(HttpServletRequest request, VoteTitle voteTitle);

    ToJson<VoteTitle> getChilddetail(HttpServletRequest request, Integer voteId);



    ToJson<VoteTitle> deleteByVoteId(HttpServletRequest request, String[] voteIds);

    ToJson<VoteTitle> getVoteDataByVoteId(HttpServletRequest request, HttpServletResponse response, String export, Integer voteId);

    ToJson<VoteTitle> searchVoteTitleList(HttpServletRequest request, VoteTitle voteTitle, Map<String, Object> maps, Integer page,
                                          Integer pageSize, boolean useFlag);

    ToJson<VoteTitle> getVoteTitleCount(HttpServletRequest request, VoteTitle voteTitle, Map<String, Object> maps, Integer page,
                                        Integer pageSize, boolean useFlag);
    //判断是否投过票
    boolean isVotite(String voteId, Users users);

    //保存投票
    AjaxJson addVoteTitle(HttpServletRequest request, VoteTitle voteTitle, String options, Integer voteId,String userName);
    //修改投票发布状态
    AjaxJson statusUpdate(HttpServletRequest request, Integer voteId);

    ToJson<VoteTitle> getOptionVoteList(HttpServletRequest request, VoteTitle voteTitle, Integer voteId);
    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年11月9日
     * 方法介绍:   投票查询（已发布）移动端接口
     * @param request
     * @param voteTitle
     * @return
     */
    ToJson<VoteTitle> getPublishVoteTitleList(HttpServletRequest request, VoteTitle voteTitle, Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag);
    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年11月9日
     * 方法介绍:   投票统计终止查询信息(未发布)移动端接口
     * @param request
     * @param voteTitle
     * @return
     */
    ToJson<VoteTitle> getPublishVoteTitleCount(HttpServletRequest request, VoteTitle voteTitle, Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag);

    ToJson<VoteTitle> clearSave(HttpServletRequest request, VoteTitle voteTitle);

    boolean checkEndTime(String resultId);

}
