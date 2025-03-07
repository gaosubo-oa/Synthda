package com.xoa.util.quartz.component;

import com.xoa.util.common.StringUtils;
import org.quartz.JobExecutionException;

/**
 * Created by 刘建 on 2020/7/12 13:20
 * 自定义定时任务执行类异常
 */
public class MyTaskException extends JobExecutionException {

    /**
     * 判读返回异常 是否可以算做成功
     */
    private boolean isSuccess = false;

    //异常信息中 detailMessage 包含 [200] 同样可以算作任务成功,否则关闭当前执行任务
    public MyTaskException(Throwable cause) {
        super(cause);
        if(!StringUtils.checkNull(cause.getMessage())&& cause.getMessage().contains("[200]")){
            this.isSuccess = true;
        }
    }
    public MyTaskException(String msg) {
        super(msg);
    }

    public boolean isSuccess() {
        return isSuccess;
    }
}
