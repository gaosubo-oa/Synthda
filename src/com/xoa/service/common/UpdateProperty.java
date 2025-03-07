package com.xoa.service.common;

import com.xoa.util.common.StringUtils;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ResourceBundle;

@Service
public class UpdateProperty {


    public  void updatePro(){
        try {
            ResourceBundle rb =  ResourceBundle.getBundle("upload");
            String upload=rb.getString("upload.win");
            if(!StringUtils.checkNull(upload)&&upload.equals("1")){//1是修改 2 是不修改
                if(System.getProperty("user.dir").indexOf("\\xoa\\tomcat")!=-1){
                    String path=(System.getProperty("user.dir").replace("\\xoa\\tomcat",""));
                    String uploadWin=path+"/xoa";
                    String netdiskWin=path+"/xoa/netdisk";
                    setProper(uploadWin,netdiskWin);
                }

            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }





    public static void setProper(String key,String value){
/**
 * 将文件加载到内存中，在内存中修改key对应的value值，再将文件保存
 */
  String proFilePath = (System.getProperty("user.dir") +"\\webapps\\ROOT\\WEB-INF\\classes\\upload.properties").replace("\\tomcat","");
        try {
            File file = new File(proFilePath);
            FileWriter fileWriter = new FileWriter(file);
            fileWriter.write("upload.win=2");
            fileWriter.write(System.getProperty("line.separator"));
            fileWriter.write("netdisk.linux=/usr/netdisk");
            fileWriter.write(System.getProperty("line.separator"));
            fileWriter.write("netdisk.win="+value);
            fileWriter.write(System.getProperty("line.separator"));
            fileWriter.write("upload.win="+key);
            fileWriter.write(System.getProperty("line.separator"));
            fileWriter.write("upload.linux=/usr/upload");
            fileWriter.flush();
            fileWriter.close();

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {

    }
}
