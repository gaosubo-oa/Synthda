package com.xoa.service.comlicense;

import com.xoa.model.comlicense.ComlicenseType;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;

import javax.servlet.http.HttpServletRequest;

public interface ComlicenseTypeService {
    ToJson addComlicenseType(HttpServletRequest request, ComlicenseType comlicenseType);

    ToJson deleteComlicenseType(HttpServletRequest request, Integer typeId);

    ToJson updateComlicenseType(HttpServletRequest request, ComlicenseType comlicenseType);

    ToJson queryAll(HttpServletRequest request, PageParams pageParams);

    ToJson queryByTypeId(HttpServletRequest request, Integer typeId);
}
