package com.xoa.dev.wzitem;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("WzItem")
public class WzItemController {

    @RequestMapping("/itemIndexa")
    public String itemIndex(){
        return "app/item/index";
    }
}
