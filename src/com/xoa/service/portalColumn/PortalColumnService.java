package com.xoa.service.portalColumn;


import com.xoa.model.portalColumn.PortalColumn;
import com.xoa.model.portalColumn.TeeZTreeModel;
import com.xoa.util.ToJson;


public interface PortalColumnService {

    ToJson<PortalColumn> selectPortalColumn();
    ToJson selectPortalColumnById(Integer columnId);
    ToJson<PortalColumn> insertPortalColumn(PortalColumn portalColumn);
    ToJson<PortalColumn> upPortalColumn(PortalColumn portalColumn);
    ToJson<PortalColumn> delPortalColumn(Integer[] ids);
    ToJson<TeeZTreeModel> ColumnTree(String id, Integer[] portalIds, Integer[] colIds);

}