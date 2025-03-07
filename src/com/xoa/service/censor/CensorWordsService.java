package com.xoa.service.censor;

import com.xoa.model.censor.CensorWords;
import com.xoa.util.ToJson;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @ClassName (类名):  CensorWordsService
 * @Description(简述): 敏感词语定义
 * @author(作者):      朱新元
 * @date(日期):        2018-4-18
 */
public interface CensorWordsService {


    ToJson<CensorWords> addCensorWords(HttpServletRequest request, CensorWords censorWords);

    ToJson<CensorWords> delCensorWords(HttpServletRequest request,Integer wordId);

    ToJson<CensorWords> updateCensorWords(HttpServletRequest request,CensorWords censorWords);

    ToJson<CensorWords> getCensorWordsInforById(HttpServletRequest request,Integer wordId);

    ToJson<CensorWords> getCensorWords(HttpServletResponse response, Integer page, Integer pageSize, boolean useFlag, HttpServletRequest request, CensorWords censorWords, String flag);

    ToJson<CensorWords> inputCensorWord(HttpServletRequest request, MultipartFile file) throws Exception;


}
