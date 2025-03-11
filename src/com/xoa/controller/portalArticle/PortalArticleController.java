
package com.xoa.controller.portalArticle;


import com.xoa.model.portalArticle.PortalArticleWithBLOBs;
import com.xoa.service.portalArticle.PortalArticleService;
import com.xoa.util.ToJson;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;


@Controller
@RequestMapping("/article")
public class PortalArticleController {

    @Resource
    private PortalArticleService portalArticleService;

    @org.springframework.web.bind.annotation.InitBinder
    public void InitBinder(ServletRequestDataBinder binder) {
        //处理带日期的参数
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, null, new CustomDateEditor(dateFormat, true));
    }

    @RequestMapping("/article")
    public String goIndex() {
        return "app/article/index";
    }


    /**
     * @作者：张海叶
     * @时间：2018/3/7
     * @介绍: 显示文档

     */
    @ResponseBody
    @RequestMapping("/selectPortalArticle")
    public ToJson selectPortalArticle(PortalArticleWithBLOBs portalArticleWithBLOBs){

        return portalArticleService.selectPortalArticle(portalArticleWithBLOBs);
    }
    /**
     * @作者：张海叶
     * @时间：2018/3/06
     * @介绍: 回显文档

     */
    @ResponseBody
    @RequestMapping("/selectPortalArticleById")
    public ToJson selectPortalArticleById(Integer articleId){

        return portalArticleService.selectPortalArticleById(articleId);
    }
    /**
     * @作者：张海叶
     * @时间：2018/3/7
     * @介绍:添加文档

     */
    @ResponseBody
    @RequestMapping("/insertPortalArticle")
    public ToJson insertPortalArticle(PortalArticleWithBLOBs portalArticleWithBLOBs, HttpServletRequest httpServletRequest){

        return portalArticleService.insertPortalArticle(portalArticleWithBLOBs,httpServletRequest);
    }
    /**
     * @作者：张海叶
     * @时间：2018/3/7
     * @介绍:修改文档

     */
    @ResponseBody
    @RequestMapping("/upPortalArticle")
    public ToJson upPortalArticle(PortalArticleWithBLOBs portalArticleWithBLOBs){

        return portalArticleService.upPortalArticle(portalArticleWithBLOBs);
    }
    /**
     * @作者：张海叶
     * @时间：2018/3/7
     * @介绍:删除文档
     *
     */
    @ResponseBody
    @RequestMapping("/delPortalArticle")
    public ToJson delPortalArticle( @RequestParam(value="ids[]" )Integer[] ids){

        return portalArticleService.delPortalArticle(ids);
    }

    /**
     * @作者：张海叶
     * @时间：2018/3/7
     * @介绍:删除文档
     *
     */
    @ResponseBody
    @RequestMapping("/articleTree")
    public ToJson articleTreeController(String id,@RequestParam(value="colIds" , required=false)Integer[] colIds){

        return portalArticleService.articleTree(id,colIds);
    }

}
