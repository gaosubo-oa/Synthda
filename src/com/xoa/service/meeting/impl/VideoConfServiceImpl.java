package com.xoa.service.meeting.impl;

import com.xoa.dao.meet.VideoConfMapper;
import com.xoa.model.meet.VideoConf;
import com.xoa.service.meeting.VideoConfService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class VideoConfServiceImpl implements VideoConfService {

    @Autowired
    private VideoConfMapper videoConfMapper;

    //查询视频会议
    @Override
    public List<VideoConf> getvideo(VideoConf videoConf) {
        Map map = new HashMap();
        map.put("id",videoConf.getId());
        map.put("confType",videoConf.getConfType());
        return videoConfMapper.selectByExampleMap(map);
    }


    //编辑
    @Override
    public Integer updetevideo(VideoConf videoConf) {
        return videoConfMapper.updateByPrimaryKeySelective(videoConf);
    }

    //新增
    @Override
    public Integer insertvideo(VideoConf videoConf) {
        return videoConfMapper.insertSelective(videoConf);
    }
}
