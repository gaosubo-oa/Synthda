package com.xoa.controller.serviceReminding;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2018/1/19/019.
 */
@Controller
@RequestMapping("/serviceReminding")
public class InformationController {
    @RequestMapping("/InformationReminding")
    public String InformationReminding() {
        return "app/serviceReminding/InformationReminding";
    }

}
