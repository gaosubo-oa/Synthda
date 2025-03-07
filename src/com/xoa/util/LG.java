package com.xoa.util;

import com.xoa.util.common.L;

public class LG {

    private static final boolean DEBUG = true;
    //打印警告信息
    public static void w(Object... msgs){
        if (DEBUG){
            L.w(msgs);
        }
    }
    //打印异常信息
    public static void e(Object... msgs){
        if (DEBUG){
            L.e(msgs);
        }
    }
    //打印普通信息
    public static void a(Object... msgs){
        if (DEBUG){
            L.a(msgs);
        }
    }

}
