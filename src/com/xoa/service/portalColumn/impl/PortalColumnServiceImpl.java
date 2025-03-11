package com.xoa.service.portalColumn.impl;


import com.xoa.dao.portalColumn.PortalColumnMapper;
import com.xoa.model.portalColumn.PortalColumn;
import com.xoa.model.portalColumn.TeeZTreeModel;
import com.xoa.service.portalColumn.PortalColumnService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;


@Service
public class PortalColumnServiceImpl implements PortalColumnService {

    @Resource
    private PortalColumnMapper portalColumnMapper;


    @Override
    @Transactional
    public ToJson<PortalColumn> selectPortalColumn() {
        ToJson<PortalColumn> json = new ToJson<PortalColumn>();
        try {
            List<PortalColumn> list =  portalColumnMapper.selectPortalColumn();
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
    public ToJson selectPortalColumnById(Integer columnId) {
        ToJson<PortalColumn> json = new ToJson<PortalColumn>();
        try {
            PortalColumn  portalColumn =  portalColumnMapper.selectByPrimaryKey(columnId);
            json.setObject(portalColumn);
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
    public ToJson<PortalColumn> insertPortalColumn(PortalColumn PortalColumn) {
        ToJson<PortalColumn> toJson = new ToJson<PortalColumn>(1, "error");

        try {
            int temp = portalColumnMapper.insertSelective(PortalColumn);
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
    public ToJson<PortalColumn> upPortalColumn(PortalColumn PortalColumn) {
        ToJson<PortalColumn> toJson = new ToJson<PortalColumn>(1, "error");

        try {
            int temp = portalColumnMapper.updateByPrimaryKeySelective(PortalColumn);
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
    public ToJson<PortalColumn> delPortalColumn(Integer[] ids) {
        ToJson<PortalColumn> toJson = new ToJson<PortalColumn>(1, "error");

        try {
            int temp = portalColumnMapper.delPortalColumn(ids);
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
    public ToJson<TeeZTreeModel> ColumnTree(String id,Integer[] portalIds,Integer[] colIds) {
        ToJson<TeeZTreeModel> json = new ToJson<TeeZTreeModel>();
        List<TeeZTreeModel> list = new ArrayList<TeeZTreeModel>();
        Integer childCount = 0;
        if(id==null && portalIds.length>0){


        }else if(id!=null && id.equals("0")){//展开站点信息


        }else{
            String sp [] = id.split(";");
            Integer sid = Integer.valueOf(sp[0]);
            String type = sp[1];
            List<PortalColumn> columnsList = null;
            if(type.equals("site")) {//展开该站点下的栏目
                columnsList =    portalColumnMapper.siteExpandColumn(sid,colIds);
            }else if(type.equals("chnl")){//展开栏目下的栏目
                columnsList =    portalColumnMapper.columnExpandColumn(sid,colIds);
            }
             for(PortalColumn portalColumn:columnsList){
                 TeeZTreeModel model = new TeeZTreeModel();
                 model.setOpen(true);
                 model.setParent(true);
                 model.setName(portalColumn.getColumnName());
                 model.setTitle(portalColumn.getColumnName());
                 model.setIconSkin("channel");
                 model.setId(portalColumn.getColumnId()+";chnl");
                 model.setExtend1(portalColumn.getColumnId()+"");
                 //检测该栏目下有无栏目
                 childCount =  portalColumnMapper.columnCount(portalColumn.getPortalId(),portalColumn.getColumnId());
                 if(childCount!=0){
                     model.setParent(true);
                 }else{
                     model.setParent(false);
                 }
                 list.add(model);
             }

        }
        try {
            if(list.size()>0) {

                json.setObj(list);
                json.setFlag(0);
                json.setMsg("ok");

            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();

        }

        return json;
    }



}