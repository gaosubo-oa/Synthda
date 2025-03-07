
package com.xoa.controller.portalColumn;

import com.xoa.model.portalColumn.PortalColumn;
import com.xoa.service.portalColumn.PortalColumnService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;


@Controller
@RequestMapping("/column")
public class PortalColumnController {

    @Resource
    private PortalColumnService portalColumnService;

    @RequestMapping("/column")
    public String goIndex() {
        return "app/column/index";
    }


    /**
     * @作者：张海叶
     * @时间：2018/2/27
     * @介绍: 显示栏目
     */
    @ResponseBody
    @RequestMapping("/selectPortalColumn")
    public ToJson selectPortalColumn(){

        return portalColumnService.selectPortalColumn();
    }
    /**
     * @作者：张海叶
     * @时间：2018/3/06
     * @介绍: 回显栏目

     */
    @ResponseBody
    @RequestMapping("/selectPortalColumnById")
    public ToJson selectPortalColumnById(Integer columnId){

        return portalColumnService.selectPortalColumnById(columnId);
    }
    /**
     * @作者：张海叶
     * @时间：2018/2/27
     * @介绍:添加栏目

     */
    @ResponseBody
    @RequestMapping("/insertPortalColumn")
    public ToJson insertPortalColumn(PortalColumn portalColumn){

        return portalColumnService.insertPortalColumn(portalColumn);
    }
    /**
     * @作者：张海叶
     * @时间：2018/2/27
     * @介绍:修改栏目

     */
    @ResponseBody
    @RequestMapping("/upPortalColumn")
    public ToJson upPortalColumn(PortalColumn portalColumn){

        return portalColumnService.upPortalColumn(portalColumn);
    }
    /**
     * @作者：张海叶
     * @时间：2018/2/27
     * @介绍:删除栏目
     *
     */
    @ResponseBody
    @RequestMapping("/delPortalColumn")
    public ToJson delPortalColumn(  @RequestParam(value="ids[]" )Integer[] ids){

        return portalColumnService.delPortalColumn(ids);
    }
    /**
     * @作者：张海叶
     * @时间：2018/3/01
     * @介绍: 
     *
     */
    @ResponseBody
    @RequestMapping("/ColumnTreeController")
    public ToJson ColumnTreeController(@RequestParam(value="id")String id, @RequestParam(value="portalIds" , required=false)Integer[] portalIds, @RequestParam(value="colIds" , required=false)Integer[] colIds){

        return portalColumnService.ColumnTree(id,portalIds,colIds);
    }

}
