package com.xoa.controller.censor;

import com.xoa.model.censor.CensorData;
import com.xoa.model.censor.CensorModule;
import com.xoa.model.censor.CensorWords;
import com.xoa.service.censor.CensorDataService;
import com.xoa.service.censor.CensorModuleService;
import com.xoa.service.censor.CensorWordsService;
import com.xoa.util.ToJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/censor")
public class CensorController {

    @Autowired
    private CensorWordsService censorWordsService;
    @Autowired
    private CensorModuleService censorModuleService;
    @Autowired
    private CensorDataService censorDataService;


    @RequestMapping("/management")
    public String Index(){
        return "app/censor/management";
    }

    @RequestMapping("/FilterWordManagement")
    public String Index1(){
        return "app/censor/FilterWordManagement";
    }

    @RequestMapping("/wordQuery")
    public String Index2(){
        return "app/censor/wordQuery";
    }



    @RequestMapping("/wordFiltering")
    public String wordFiltering(){
        return "app/censor/index";
    }

    @RequestMapping("/ModuleSettings")
    public String Index3(){
        return "app/censor/ModuleSettings";
    }

    @RequestMapping("/EditModule")
    public String Index4(){
        return "app/censor/EditModule";
    }

    /**
     * 创建作者:  朱新元
     * 创建日期:  2018年4月18日
     * 方法介绍:  新建词语定义
     * @param censorWords
     * @return
     */
    @ResponseBody
    @RequestMapping("/addCensorWords")
    public ToJson<CensorWords> addCensorWords(HttpServletRequest request, CensorWords censorWords){
        return censorWordsService.addCensorWords(request,censorWords);
    }

    /**
     * 创建作者:   朱新元
     * 创建日期:   2018年4月11日
     * 方法介绍:  根据id删除记录
     * @param wordId
     * @return
     */
    @ResponseBody
    @RequestMapping("/delCensorWords")
    public ToJson<CensorWords> delCensorWords(HttpServletRequest request,Integer wordId){
        return censorWordsService.delCensorWords(request,wordId);
    }

    /**
     * 创建作者:   朱新元
     * 创建日期:   2018年4月18日
     * 方法介绍:  编辑
     * @param censorWords
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateCensorWords")
    public ToJson<CensorWords> updateCensorWords(HttpServletRequest request,CensorWords censorWords){
        return censorWordsService.updateCensorWords(request,censorWords);
    }

    /**
     * 创建作者:   朱新元
     * 创建日期:   2018年4月18日
     * 方法介绍:  根据id获取数据
     * @param wordId
     * @return
     */
    @ResponseBody
    @RequestMapping("/getCensorWordsById")
    public ToJson<CensorWords> getCensorWordsInforById(HttpServletRequest request,Integer wordId){
        return censorWordsService.getCensorWordsInforById(request,wordId);
    }


    /**
     * 创建作者:   朱新元
     * 创建日期:   2018年4月18日
     * 方法介绍:  获取列表
     * @param censorWords
     * @return
     */
    @ResponseBody
    @RequestMapping("/getCensorWords")
    public ToJson<CensorWords> getCensorWords(HttpServletResponse response, Integer page, Integer pageSize, boolean useFlag, HttpServletRequest request, CensorWords censorWords,
                                              @RequestParam(value = "flag", required = false,defaultValue = "") String flag){
        return censorWordsService.getCensorWords(response,page,pageSize,useFlag,request,censorWords,flag);
    }

    /**
     * 创建作者:   朱新元
     * 创建日期:   2018年4月18日
     * 方法介绍:  过滤词导入
     * @return
     */
    @ResponseBody
    @RequestMapping("/inputCensorWord")
    public  ToJson<CensorWords> inputCensorWord(HttpServletRequest request, MultipartFile file) throws Exception {
        return censorWordsService.inputCensorWord(request,file);
    }



    /**
     * 创建作者:  朱新元
     * 创建日期:  2018年4月18日
     * 方法介绍:  敏感词语过滤模块设置
     * @param censorModule
     * @return
     */

    @ResponseBody
    @RequestMapping("/addCensorModule")
    public ToJson<CensorModule> addCensorModule(HttpServletRequest request, CensorModule censorModule){
        return censorModuleService.addCensorModule(request,censorModule);
    }

    @ResponseBody
    @RequestMapping("/delCensorModule")
    public ToJson<CensorModule> delCensorModule(HttpServletRequest request, Integer moduleId){
        return censorModuleService.delCensorModule(request,moduleId);
    }

    @ResponseBody
    @RequestMapping("/updateCensorModule")
    public ToJson<CensorModule> updateCensorModule(HttpServletRequest request,CensorModule censorModule){
        return censorModuleService.updateCensorModule(request,censorModule);
    }


    @ResponseBody
    @RequestMapping("/getCensorModuleInforById")
    public ToJson<CensorModule> getCensorModuleInforById(HttpServletRequest request,Integer moduleId){
        return censorModuleService.getCensorModuleInforById(request,moduleId);
    }


    @ResponseBody
    @RequestMapping("/getCensorModule")
    public ToJson<CensorModule> getCensorModule(Integer page, Integer pageSize, boolean useFlag, HttpServletRequest request, CensorModule censorModule){
        return censorModuleService.getCensorModule(page,pageSize,useFlag,request,censorModule);
    }


    /**
     * 创建作者:  朱新元
     * 创建日期:  2018年4月18日
     * 方法介绍:  待审核词
     * @param:   CensorData
     * @return
     */

    @ResponseBody
    @RequestMapping("/addCensorData")
    public ToJson<CensorData> addCensorData(HttpServletRequest request, CensorData censorData){
        return censorDataService.addCensorData(request,censorData);
    }

    @ResponseBody
    @RequestMapping("/delCensorData")
    public ToJson<CensorData> delCensorData(HttpServletRequest request, Integer id){
        return censorDataService.delCensorData(request,id);
    }

    @ResponseBody
    @RequestMapping("/updateCensorData")
    public ToJson<CensorData> updateCensorData(HttpServletRequest request,CensorData censorData){
        return censorDataService.updateCensorData(request,censorData);
    }


    @ResponseBody
    @RequestMapping("/getCensorDataInforById")
    public ToJson<CensorData> getCensorDataInforById(HttpServletRequest request,Integer id){
        return censorDataService.getCensorDataInforById(request,id);
    }


    @ResponseBody
    @RequestMapping("/getCensorData")
    public ToJson<CensorData> getCensorData(Integer page, Integer pageSize, boolean useFlag, HttpServletRequest request, CensorData censorData){
        return censorDataService.getCensorData(page,pageSize,useFlag,request,censorData);
    }

}
