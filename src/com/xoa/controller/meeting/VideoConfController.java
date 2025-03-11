package com.xoa.controller.meeting;


import com.xoa.model.meet.VideoConf;
import com.xoa.service.meeting.VideoConfService;
import com.xoa.util.ToJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * 视频会议设置
 */
@Controller
@RequestMapping("video")
public class VideoConfController {

    @Autowired
    private VideoConfService videoConfService;

    /**
     * 视频会议管理页面映射
     * @return
     */
    @RequestMapping("/videoIndex")
    private String videoIndex(){
        return "/app/meeting/videoconf/videoconf";
    }

    /**
     * 查询视频会议
     * @return
     */
    @RequestMapping("/getvideo")
    @ResponseBody
    private ToJson getvideo(HttpServletRequest request, VideoConf videoConf){
        ToJson toJson=new ToJson(1,"暂无数据");
        try {
            toJson.setObject(videoConfService.getvideo(videoConf));
            toJson.setFlag(0);
            toJson.setMsg("true");
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.toString());
        }
        return toJson;
    }


    /**
     * 编辑和新增视频会议
     * @return
     */
    @RequestMapping("/editvideo")
    @ResponseBody
    public ToJson editvideo(HttpServletRequest request, VideoConf videoConf){
        ToJson toJson=new ToJson(1,"失败");
        try {
            if ( videoConf.getId() != null ){
                videoConfService.updetevideo(videoConf);
            }else {
                videoConfService.insertvideo(videoConf);
            }
            toJson.setFlag(0);
            toJson.setMsg("true");
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.toString());
        }
        return toJson;
    }

}
