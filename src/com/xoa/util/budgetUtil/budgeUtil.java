package com.xoa.util.budgetUtil;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.TypeReference;
import com.xoa.model.budget.BudgetingProcess;
import com.xoa.model.budget.BudgetingProcessFlowRunPrcs;
import com.xoa.util.DateFormat;
import com.xoa.util.common.StringUtils;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by gaosubo on 2018/11/9.
 */
public class budgeUtil {

    // 暂时废弃方法 根据流程步骤判断不对
    public static String switchSetpName(Integer realPrcsId,Integer prcsId,Integer prFlag){
        String setpName = "";
        switch (realPrcsId){
            case 1:
                setpName = "执行中(预扣款)";
                break;
            case 2:
                setpName = "执行中(预扣款)";
                break;
            case 3:
                setpName = "执行中(预扣款)";
                break;
            case 4:
                setpName = "执行中(预扣款)";
                break;
            case 5:
                setpName = "执行中(预扣款)";
                break;
            case 6:
                setpName = "执行中(预扣款)";
                break;
            case 7:
                setpName = "执行中(预扣款)";
                break;
            case 8:
                setpName = "终止";
                break;
            case 9:
                if(prFlag==4){
                    setpName = "已结束(已扣款)";
                }else{
                    setpName = "执行中(已扣款)";
                }
                break;
            case 10:
                if(prcsId == 2){
                    setpName = "执行中(预扣款)";
                    break;
                }else {
                    setpName = "已结束(已扣款)";
                    break;
                }
        }
        return setpName;
    }

    public static String switchSetpName(BudgetingProcessFlowRunPrcs b){
        BigDecimal advance = b.getAdvance();
        BigDecimal actualExpenditure = b.getActualExpenditure();
        Integer realPrcsId = b.getRealPrcsId();
        Integer prFlag = b.getPrFlag();
        if(b.getFrEndtime()==null){
            if(advance.compareTo(BigDecimal.ZERO)!=0&&actualExpenditure.compareTo(BigDecimal.ZERO)==0){
                return "执行中(预扣款)";
            } else if(advance.compareTo(BigDecimal.ZERO)==0&&actualExpenditure.compareTo(BigDecimal.ZERO)!=0){
                return "执行中(已扣款)";
            }
        } else {
            if(advance.compareTo(BigDecimal.ZERO)!=0&&actualExpenditure.compareTo(BigDecimal.ZERO)==0){
                return "执行中(预扣款)";
            } else if(advance.compareTo(BigDecimal.ZERO)==0&&actualExpenditure.compareTo(BigDecimal.ZERO)!=0){
                if(realPrcsId.equals(9)){
                    if(!prFlag.equals(4)){
                        return "执行中(已扣款)";
                    }
                }
                return "已结束(已扣款)";
            }
        }
        return "执行中";
    }


    public static BudgetingProcess insertBudgetProcess(BudgetingProcess budgetingProcess, Map<Object, Object> flowHookMaps) {
        BudgetingProcess process = new BudgetingProcess();
        //判断映射表中字段并插入
        for (Map.Entry<Object, Object> entry : flowHookMaps.entrySet()) {
            if (entry.getKey().equals("applicant")) {
                budgetingProcess.setApplicant(entry.getValue().toString());
            } else if (entry.getKey().equals("dept_id")) {
                budgetingProcess.setDeptId(entry.getValue().toString());
            } else if (entry.getKey().equals("application_date")) {
                budgetingProcess.setApplicationDate(DateFormat.getDate(entry.getValue().toString()));
            } else if (entry.getKey().equals("per_pay")) {
                budgetingProcess.setPerPay(entry.getValue().toString());
            } else if (entry.getKey().equals("is_per")) {
                budgetingProcess.setIsPer(entry.getValue().toString());
            } else if (entry.getKey().equals("fixed_assets")) {
                budgetingProcess.setFixedAssets(entry.getValue().toString());
            } else if (entry.getKey().equals("budget_item_name")) {
                budgetingProcess.setBudgetItemName(entry.getValue().toString());
            } else if (entry.getKey().equals("budget_id")) {
                budgetingProcess.setBudgetId(Integer.valueOf(entry.getValue().toString()));
                process.setBudgetId(Integer.valueOf(entry.getValue().toString()));
            } else if (entry.getKey().equals("payment")) {
                budgetingProcess.setPayment(getTwoDecimal(entry.getValue().toString()));
                process.setPayment(getTwoDecimal(entry.getValue().toString()));
            } else if (entry.getKey().equals("is_payment")) {
                budgetingProcess.setIsPayment(getTwoDecimal(entry.getValue().toString()));
            } else if (entry.getKey().equals("line_no")) {
                budgetingProcess.setLineNo(entry.getValue().toString());
            } else if (entry.getKey().equals("instructions")) {
                budgetingProcess.setInstructions(entry.getValue().toString());
            } else if (entry.getKey().equals("department_head")) {
                budgetingProcess.setDepartmentHead(entry.getValue().toString());
            } else if (entry.getKey().equals("is_opinion")) {
                budgetingProcess.setIsOpinion(entry.getValue().toString());
            } else if (entry.getKey().equals("school_supervisor_opinion")) {
                budgetingProcess.setSchoolSupervisorOpinion(entry.getValue().toString());
            } else if (entry.getKey().equals("accounting_advice")) {
                budgetingProcess.setAccountingAdvice(entry.getValue().toString());
            } else if (entry.getKey().equals("is_break_up")) {
                budgetingProcess.setIsBreakUp(entry.getValue().toString());
            } else if (entry.getKey().equals("treasurer_signature")) {
                budgetingProcess.setTreasurerSignature(entry.getValue().toString());
            } else if (entry.getKey().equals("treasurer_opinion")) {
                budgetingProcess.setTreasurerOpinion(entry.getValue().toString());
            } else if (entry.getKey().equals("break_up_plan")) {
                budgetingProcess.setBreakUpPlan(entry.getValue().toString());
                process.setBreakUpPlan(entry.getValue().toString());
            } else if (entry.getKey().equals("headmaster_signature")) {
                budgetingProcess.setHeadmasterSignature(entry.getValue().toString());
            } else if (entry.getKey().equals("headmaster_opinion")) {
                budgetingProcess.setHeadmasterOpinion(entry.getValue().toString());
            } else if (entry.getKey().equals("actual_expenditure")) {
                budgetingProcess.setActualExpenditure(getTwoDecimal(entry.getValue().toString()));
            } else if (entry.getKey().equals("amount_words")) {
                budgetingProcess.setAmountWords(entry.getValue().toString());
            } else if (entry.getKey().equals("cashier_opinion")) {
                budgetingProcess.setCashierOpinion(entry.getValue().toString());
            } else if (entry.getKey().equals("run_id")) {
                budgetingProcess.setRunId(Integer.valueOf(entry.getValue().toString()));
            } else if (entry.getKey().equals("advance")) {
                budgetingProcess.setAdvance(getTwoDecimal(entry.getValue().toString().toString()));
            }
        }
        return process;
    }


    public static Map<Object, Object> queryTriggerField(String modifydata, String fromdate, String maps, Integer num) {

        //获取json串 进行判断
        //获取业务引擎接口的数据进行分开，组合map
        /**
         * 拿自己内置的数据去写的
         */

        String[] a = maps.split(",");
        Map<String, Object> map = new HashMap<String, Object>();
        for (int i = 0; i < a.length; i++) {
            String i1 = a[i];
            String i2[] = i1.split("=>");
            String i3 = i2[0];
            String i4 = i2[1];
            map.put(i3, i4);
            //key           USER_ID
            //value         申请人

        }
        JSONArray json = new JSONArray();
        //String fromdateOne="["+fromdate+"]";
        Map<String, Object> from = json.parseObject(
                fromdate, new TypeReference<Map<String, Object>>() {
                });


        List<Map<String, Object>> modify = json.parseObject(modifydata, List.class);
        //List<Map<String, Object>> from = json.parseObject(fromdate, List.class);
        Map<Object, Object> analysis = new HashMap<Object, Object>();
        Map<Object, Object> returnMap = new HashMap<Object, Object>();
        for (Map<String, Object> mapmodify : modify) {
            for (Map.Entry<String, Object> entry1 : from.entrySet()) {
                if (mapmodify.get("key").equals(entry1.getValue())) {
                    analysis.put(entry1.getKey(), mapmodify.get("value"));
                }

            }                        // 申请人   value   USER_ID
        }

        if ("1".equals(num)) {
            for (Map.Entry<Object, Object> entry : analysis.entrySet()) {//key 申请人 value  1
                for (Map.Entry<String, Object> entry1 : map.entrySet()) {
                    if (entry.getKey().equals(entry1.getValue())) {
                        returnMap.put(entry1.getKey(), entry.getValue());

                    }

                }

            }
        } else if ("2".equals(num)) {

        }
        for (Map.Entry<Object, Object> entry : analysis.entrySet()) {//key 申请人 value  1
            for (Map.Entry<String, Object> entry1 : map.entrySet()) {
                if (entry.getKey().equals(entry1.getKey())) {
                    returnMap.put(entry1.getValue(), entry.getValue());

                }

            }


        }


        return returnMap;
    }


    public static BigDecimal getTwoDecimal(String num) {
        if(StringUtils.checkNull(num)) return BigDecimal.ZERO;
        BigDecimal bd=new BigDecimal(num.replace(" ",""));//构造以字符串内容为值的BigDecimal类型的变量
        return bd.setScale(2, BigDecimal.ROUND_HALF_UP);//设置小数位数，第一个变量是小数位数，第二个变量是取舍方法(四舍五入)
    }

    public static BigDecimal getTwoDecimal(Integer num) {
        if(num == null) return BigDecimal.ZERO;
        BigDecimal bd=new BigDecimal(num);//构造以字符串内容为值的BigDecimal类型的变量
        return bd.setScale(2, BigDecimal.ROUND_HALF_UP);//设置小数位数，第一个变量是小数位数，第二个变量是取舍方法(四舍五入)
    }
}
