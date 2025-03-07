package com.xoa.util.edu;

import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.common.wrapper.BaseWrappers;

import java.util.List;

/**
 * Created By 廉梦凡
 * Date: 2018/7/24
 * Time: 14:24
 */
public class WrapperUtil {


    /**
     * Created By 廉梦凡
     * 分页
     * @param pagingWrappers
     * @param msg
     * @param datas
     * @param totleNum
     */
    public static void setListPaging(PagingWrappers pagingWrappers, String msg, List datas, Integer totleNum){
        pagingWrappers.setDatas(datas);
        pagingWrappers.setFlag(true);
        pagingWrappers.setStatus(true);
        pagingWrappers.setMsg(msg);
        pagingWrappers.setTotleNum(totleNum);
    }

    public static void setListSuccess(BaseWrappers wrappers, String msg, List datas){
       wrappers.setDatas(datas);
       wrappers.setFlag(true);
       wrappers.setStatus(true);
       wrappers.setMsg(msg);
    }
    public static void setListError(BaseWrappers wrappers, String msg){
        wrappers.setFlag(false);
        wrappers.setStatus(false);
        wrappers.setMsg(msg);
    }
    public static void setSuccess(BaseWrapper wrapper, String msg, String code, Object result) {
        wrapper.setData(result);
        wrapper.setMsg(msg);
        wrapper.setCode(code);
        wrapper.setFlag(true);
        wrapper.setStatus(true);
    }

    public static void setError(BaseWrapper wrapper, String msg, String code) {
         wrapper.setStatus(false);
         wrapper.setFlag(false);
         wrapper.setCode(code);
         wrapper.setMsg(msg);
    }
}
