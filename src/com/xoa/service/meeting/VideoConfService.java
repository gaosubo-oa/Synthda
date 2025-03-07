package com.xoa.service.meeting;

import com.xoa.model.meet.VideoConf;

import java.util.List;

public interface VideoConfService {
    List<VideoConf> getvideo(VideoConf videoConf);

    Integer updetevideo(VideoConf videoConf);

    Integer insertvideo(VideoConf videoConf);
}
