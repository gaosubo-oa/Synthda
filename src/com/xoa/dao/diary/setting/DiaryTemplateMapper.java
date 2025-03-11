package com.xoa.dao.diary.setting;

import com.xoa.model.diary.setting.DiaryTemplate;

import java.util.List;
import java.util.Map;

public interface DiaryTemplateMapper {

    int addDiaryTemplate(DiaryTemplate diaryTemplate);

    int deleteDiaryTemplateById(Integer templateId);

    int updateDiaryTemplate(DiaryTemplate diaryTemplate);

    List<DiaryTemplate> selectAllDiaryTemplate(Map<String, Object> map);
}
