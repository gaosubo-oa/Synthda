package com.xoa.dao.diary.setting;

import com.xoa.model.diary.setting.DiarySetting;

public interface DiarySettingMapper {
    int saveDiarySetting(DiarySetting diarySetting);

    int updateDiarySetting(DiarySetting diarySetting);

    DiarySetting selectDiarySetting();
}
