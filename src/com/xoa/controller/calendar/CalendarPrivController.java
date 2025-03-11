package com.xoa.controller.calendar;

import com.xoa.model.calendarLeaderPriv.CalendarLeaderPriv;
import com.xoa.service.calendar.CalendarPrivService;
import com.xoa.util.ToJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by 刘建 on 2020/7/30 11:15
 */
@Controller
@RequestMapping("/calendarPriv")
public class CalendarPrivController {

    @Autowired
    private CalendarPrivService calendarPrivService;

    @ResponseBody
    @RequestMapping("/saveCalendarPriv")
    public ToJson<CalendarLeaderPriv> saveCalendarPriv (CalendarLeaderPriv calendarLeaderPriv){
        return calendarPrivService.saveCalendarPriv(calendarLeaderPriv);
    }

    @ResponseBody
    @RequestMapping("/delCalendarPriv")
    public ToJson<CalendarLeaderPriv> delCalendarPriv (Integer privId){
        return calendarPrivService.delCalendarPriv(privId);
    }

    @ResponseBody
    @RequestMapping("/editCalendarPriv")
    public ToJson<CalendarLeaderPriv> editCalendarPriv (CalendarLeaderPriv calendarLeaderPriv){
        return calendarPrivService.editCalendarPriv(calendarLeaderPriv);
    }

    @ResponseBody
    @RequestMapping("/selAllCalendarPriv")
    public ToJson<CalendarLeaderPriv> selAllCalendarPriv (boolean useFlag ,Integer page, Integer pageSize){
        return calendarPrivService.selAllCalendarPriv(useFlag ,page, pageSize);
    }

    @ResponseBody
    @RequestMapping("/findCalendarPriv")
    public ToJson<CalendarLeaderPriv> findCalendarPriv (Integer privId){
        return calendarPrivService.findCalendarPriv(privId);
    }

    @ResponseBody
    @RequestMapping("/getLeader")
    public ToJson<CalendarLeaderPriv> getLeader (HttpServletRequest request){
        return calendarPrivService.getLeader(request);
    }
}
