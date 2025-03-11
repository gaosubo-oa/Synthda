package com.xoa.util;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;

public class JacobUtil {

    public static ActiveXComponent app;
    // 8 代表word保存成html
    public static final int WORD_HTML = 8;

    public static ActiveXComponent getWordInstance(){
        if (app == null) {
            // 创建word程序
            app = new ActiveXComponent("Word.Application");
            // 设置word应用程序不可见
            app.setProperty("Visible", new Variant(false));
        }
        return app;
    }

    /**
     * WORD转HTML
     *
     * @param docFilePath  WORD文件全路径
     * @param htmlFilePath 转换后HTML存放路径
     */
    public static void wordToHtml(String docFilePath, String htmlFilePath) throws Exception {

        if("/".equals(docFilePath.substring(0,1))){
            docFilePath = docFilePath.substring(1);
        }

        if("/".equals(htmlFilePath.substring(0,1))){
            htmlFilePath = htmlFilePath.substring(1);
        }

        app = getWordInstance();

        app.setProperty("Visible", new Variant(false));
        // documents表示word程序的所有文档窗口，（word是多文档应用程序）
        Dispatch docs = app.getProperty("Documents").toDispatch();
        // 打开要转换的word文件
        Dispatch doc = Dispatch.invoke(
                docs,
                "Open",
                Dispatch.Method,
                new Object[]{docFilePath, new Variant(false),
                        new Variant(true)}, new int[1]).toDispatch();
        // 作为html格式保存到临时文件
        Dispatch.invoke(doc, "SaveAs", Dispatch.Method, new Object[]{
                htmlFilePath, new Variant(WORD_HTML)}, new int[1]);
        // 关闭word文件
        Dispatch.call(doc, "Close", new Variant(false));
    }

    // 获取word中的内容转换成html 然后返回字符串
    public static String getHtmlWordContent(String docFilePath) throws Exception {
        StringBuilder result = new StringBuilder();
        app = getWordInstance();

            String htmlFilePath = docFilePath.substring(0,docFilePath.lastIndexOf("."))+".html";
            // 先生成html
            wordToHtml(docFilePath,htmlFilePath);
            // 获取html中的字符串

            File htmlFile = new File(htmlFilePath);
            if(htmlFile.exists()){
                InputStreamReader read = new InputStreamReader(
                        new FileInputStream(htmlFile),"GBK");//考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt;
                while((lineTxt = bufferedReader.readLine()) != null){
                    result.append(lineTxt);
                    System.out.println(lineTxt);
                }
                bufferedReader.close();
                read.close();
            }


        return result.toString();
    }
}