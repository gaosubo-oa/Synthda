package com.xoa.service.voteItem.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.xoa.dao.voteItem.VoteItemMapper;
import com.xoa.dao.voteTitle.VoteTitleMapper;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.users.Users;
import com.xoa.model.voteItem.VoteItem;
import com.xoa.service.users.UsersService;
import com.xoa.service.voteItem.IVoteItemService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.GetAttachmentListUtil;
import com.xoa.util.I18nUtils;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * <p>
 * 投票选项信息表 服务实现类
 * </p>
 *
 * @author 张丽军
 * @since 2017-09-18
 */
@Service
public class VoteItemServiceImpl extends ServiceImpl<VoteItemMapper, VoteItem> implements IVoteItemService {

    @Resource
    VoteItemMapper voteItemMapper;

    @Resource
    VoteTitleMapper voteTitleMapper;

    @Resource
    UsersService usersService;

    @Override
    public ToJson<VoteItem> addVoteItem(HttpServletRequest request, VoteItem voteItem) {
        ToJson<VoteItem> toJson=new ToJson<VoteItem>(1,"error");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try{
            VoteItem voteItem1 = voteItemMapper.getOneVoteItem(voteItem);
            if (voteItem1==null){
                int a=voteItemMapper.addVoteItem(voteItem);
                if(a>0){
                    toJson.setMsg(I18nUtils.getMessage("depatement.th.Newsuccessfully"));
                    toJson.setFlag(0);
                }else {
                    toJson.setMsg(I18nUtils.getMessage("depatement.th.Newfailed"));
                    toJson.setFlag(1);
                }
            }else {
                toJson.setMsg(I18nUtils.getMessage("vote.th.creationFailedThisNameAlreadyExists"));
                toJson.setFlag(1);
            }

        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteItemServiceImpl addvoteItem:"+e);
        }
        return toJson;
    }

    @Override
    public ToJson<VoteItem> updateVoteItem(HttpServletRequest request, VoteItem voteItem) {
        ToJson<VoteItem> toJson=new ToJson<VoteItem>(1,"error");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try{
            int a=voteItemMapper.updateVoteItem(voteItem);
            if(a>0){
                toJson.setMsg(I18nUtils.getMessage("depatement.th.Modifysuccessfully"));
                toJson.setFlag(0);
            }else {
                toJson.setMsg(I18nUtils.getMessage("depatement.th.modifyfailed"));
                toJson.setFlag(1);
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteItemServiceImpl updateVoteItem:"+e);
        }
        return toJson;
    }

    @Override
    public ToJson<VoteItem> deleteByItemId(HttpServletRequest request, Integer itemId) {
        ToJson<VoteItem> toJson=new ToJson<VoteItem>(1,"error");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try{
            int a=voteItemMapper.deleteByItemId(itemId);
            if(a>0){
                toJson.setMsg(I18nUtils.getMessage("workflow.th.delsucess"));
                toJson.setFlag(0);
            }else {
                toJson.setMsg(I18nUtils.getMessage("lang.th.deleSucess"));
                toJson.setFlag(1);
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteItemServiceImpl deleteByItemId:"+e);
        }
        return toJson;
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月23日
     * 方法介绍:   查询投票项目中的列表
     * @param request
     * @param voteId
     * @return
     */
    @Override
    public ToJson<VoteItem> getVoteItemList(HttpServletRequest request, Integer voteId) {
        ToJson<VoteItem> toJson=new ToJson<>(1,"error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        String sqlType = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try{
            List<VoteItem> list=voteItemMapper.getVoteItemList(voteId);

            for(VoteItem voteItem :list){
                if(!StringUtils.checkNull(voteItem.getVoteUser())){
                    if(voteItem.getVoteUser().split(",").length>3){
                        String indexStr = StringUtils.getIndexStr(voteItem.getVoteUser(), ",", 3);
                        String userId = usersService.getUserNameById(indexStr,",");
                        if(StringUtils.checkNull(userId)){
                            String indexStr1 = StringUtils.getIndexStr(voteItem.getVoteUser(), ",", 3);
                            voteItem.setVoteUserName(indexStr1);
                        }else{
                            voteItem.setVoteUserName(userId+"...");
                        }
                    }
                    else{
                        String anonymous=voteItem.getAnonymous().substring(0,voteItem.getAnonymous().length()-1);
                        voteItem.setAnonymous(anonymous);
                        String userId = usersService.getUserNameById(voteItem.getVoteUser(),",");
                        voteItem.setVoteUserName(userId);
                    }
                }

                String attachmentId   = voteItem.getAttachmentId();
                String attachmentName = voteItem.getAttachmentName();
                if (!StringUtils.checkNull(attachmentId) && !StringUtils.checkNull(attachmentName)) {
                    List<Attachment> atts = GetAttachmentListUtil.returnAttachment(attachmentName, attachmentId, sqlType, "vote");
                    voteItem.setAttachmentList(atts);
                }

            }
            if(list!=null){
                toJson.setObj(list);
                toJson.setMsg("ok");
            }else {
                toJson.setMsg(I18nUtils.getMessage("vote.th.empty"));
            }
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteItemServiceImpl getVoteItemList:"+e);
        }
        return toJson;
    }

    @Override
    public ToJson<VoteItem> updateVoteCount(HttpServletRequest request, VoteItem voteItem) {
        ToJson<VoteItem> toJson=new ToJson<>(1,"error");
        try{
            voteItem.getItemId();
            int con=voteItem.getVoteCount();
            voteItem.setVoteCount(con+1);
            int a=voteItemMapper.updateVoteCount(voteItem);
            if(a>0){
                toJson.setMsg("ok");
                toJson.setFlag(0);
            }else {
                toJson.setMsg("error");
                toJson.setFlag(1);
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteItemServiceImpl updateVoteCount:"+e);
        }
        return toJson;
    }

}
