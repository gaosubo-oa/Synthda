package com.xoa.controller.portal;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/portal")
public class PortalPageController {

    @RequestMapping("/portalStationIndex")
    public String portalStationIndex(HttpServletRequest request) {
      return "app/portal/portal_station/index";
    }
    @RequestMapping("/flowIndex")
    public String flowIndex(HttpServletRequest request) {
        return "app/main/menu/flowIndex";
    }

}
