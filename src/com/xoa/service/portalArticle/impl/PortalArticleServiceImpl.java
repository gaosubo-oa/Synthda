package com.xoa.service.portalArticle.impl;


import com.xoa.dao.portalArticle.PortalArticleMapper;
import com.xoa.dao.portalColumn.PortalColumnMapper;
import com.xoa.model.portalArticle.PortalArticle;
import com.xoa.model.portalArticle.PortalArticleWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.service.portalArticle.PortalArticleService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.List;


@Service
public class PortalArticleServiceImpl implements PortalArticleService {

    @Resource
    private PortalArticleMapper portalArticleMapper;
    @Resource
    private PortalColumnMapper portalColumnMapper;


    @Override
    @Transactional
    public ToJson<PortalArticleWithBLOBs> selectPortalArticle(PortalArticleWithBLOBs portalArticleWithBLOBs) {
        ToJson<PortalArticleWithBLOBs> json = new ToJson<PortalArticleWithBLOBs>();
        try {
            List<PortalArticleWithBLOBs> list =  portalArticleMapper.selectPortalArticle(portalArticleWithBLOBs);
            if (list.size() > 0) {
                json.setObj(list);
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }
    @Override
    @Transactional
    public ToJson selectPortalArticleById(Integer articleId) {
        ToJson<PortalArticleWithBLOBs> json = new ToJson<PortalArticleWithBLOBs>();
        try {
            PortalArticle  PortalArticle =  portalArticleMapper.selectByPrimaryKey(articleId);
            json.setObject(PortalArticle);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }
    @Override
    @Transactional
    public ToJson<PortalArticleWithBLOBs> insertPortalArticle(PortalArticleWithBLOBs portalArticleWithBLOBs, HttpServletRequest request) {
        ToJson<PortalArticleWithBLOBs> toJson = new ToJson<PortalArticleWithBLOBs>(1, "error");

        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            portalArticleWithBLOBs.setCreateUser(users.getUserName());
            int temp = portalArticleMapper.insertSelective(portalArticleWithBLOBs);
            if (temp > 0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    @Transactional
    public ToJson<PortalArticleWithBLOBs> upPortalArticle(PortalArticleWithBLOBs portalArticleWithBLOBs) {
        ToJson<PortalArticleWithBLOBs> toJson = new ToJson<PortalArticleWithBLOBs>(1, "error");

        try {
            int temp = portalArticleMapper.updateByPrimaryKeySelective(portalArticleWithBLOBs);
            if (temp > 0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    @Transactional
    public ToJson<PortalArticleWithBLOBs> delPortalArticle(Integer[] ids) {
        ToJson<PortalArticleWithBLOBs> toJson = new ToJson<PortalArticleWithBLOBs>(1, "error");

        try {
            int temp = portalArticleMapper.delPortalArticle(ids);
            if (temp > 0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }
    @Override
    @Transactional
    public  ToJson articleTree(String id, Integer[] colIds) {
        ToJson toJson = new ToJson(1, "error");
        try {
        if (id != null ) {
            String sp[] = id.split(";");
            Integer sid = Integer.valueOf(sp[0]);
            String type = sp[1];
            List<PortalArticleWithBLOBs> articlesList = null;
            if (type.equals("chnl")) {//展开栏目下的文档
                articlesList = portalArticleMapper.columnExpandArticle(sid);
            }
            if (articlesList.size() > 0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
                toJson.setObj(articlesList);
            }
        }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

}