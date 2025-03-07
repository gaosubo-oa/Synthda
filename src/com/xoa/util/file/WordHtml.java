package com.xoa.util.file;

import com.sun.xml.internal.messaging.saaj.util.ByteInputStream;
import com.xoa.model.enclosure.Attachment;
import com.xoa.util.Convert;
import com.xoa.util.FileUploadUtil;
import com.xoa.util.common.StringUtils;
import fr.opensagres.poi.xwpf.converter.core.BasicURIResolver;
import fr.opensagres.poi.xwpf.converter.core.FileImageExtractor;
import fr.opensagres.poi.xwpf.converter.xhtml.XHTMLConverter;
import fr.opensagres.poi.xwpf.converter.xhtml.XHTMLOptions;
import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.converter.PicturesManager;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
import org.apache.poi.hwpf.usermodel.Picture;
import org.apache.poi.hwpf.usermodel.PictureType;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.w3c.dom.Document;

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class WordHtml {
    //内容
    private static final String CONTENT = "content";
    //图片
    private static final String ATTENDLST = "attendList";

/*    public static void main(String[] args) {
        String ym = new SimpleDateFormat("yyMM").format(new Date());
        try {
            String concent = "";
            //word 文件地址
            String path = "D:\\11.doc";
            //图片/附件存放地址
            String imagePath = "D:\\image";
            Map map = docxToHtml(path, imagePath, ym);
            concent = map.get(CONTENT).toString();
            System.out.println(concent);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }*/

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-06-22 14:57
     * 方法介绍: 提取 word 文档中的正文生成 html （公文转存公告用）
     * @param company 当前组织
     * @param model   正文图片地址（model）
     * @param path    word正文地址
     * @return java.util.Map
     */
    public static Map wordToHtml(String company, String model, String path) {
        Map map = new HashMap();
        if (!StringUtils.checkNull(path)) {
            // 当前年月
            String ym = new SimpleDateFormat("yyMM").format(new Date());
            //文件上传路径
            StringBuilder newFilePathBd = FileUploadUtil.getUploadHead();
            newFilePathBd.append(System.getProperty("file.separator")).
                    append(company).append(System.getProperty("file.separator")).
                    append(model).append(System.getProperty("file.separator")).append(ym);
            //图片存放地址
            String imagePath = newFilePathBd.toString();
            map = docxToHtml(path, imagePath, ym);
        }
        return map;
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-06-22 14:56
     * 方法介绍:提取 word 文档中的正文生成 html （公文转存公告用）
     * @param sourceFileName 文件地址
     * @param imagePath      图片上传路径
     * @param ym             当前年月
     * @return java.util.Map
     */
    public static Map docxToHtml(String sourceFileName, String imagePath, String ym) {
        Map map = new HashMap();
        //读取内容
        String concent = "";
        //图片附件
        List<Attachment> attachmentList = new ArrayList<>();
        map.put(ATTENDLST, attachmentList);
        File workFile = new File(sourceFileName);
        if (!workFile.exists()) {
            return map;
        }
        File imageFile = new File(imagePath);
        //附件地址不存在创建
        if (!imageFile.exists()) {
            imageFile.mkdirs();
        }
        String readfile = extractText(sourceFileName, imagePath).toString();
        //因为公文使用 所有 去掉html头尾
        //doc 文件特殊文本 包含换行 所有去掉html 尾之前 需要先去掉最后的换行
        boolean b = readfile.endsWith("\r\n");
        if (b)
            readfile = readfile.substring(0, readfile.length() - 3);
        if(readfile.length()>6){
            concent = readfile.substring(6, readfile.length() - 7);
        }

        //判断存在图片（图片标签前缀）
        int beginInt = concent.indexOf("<img src=\"");
        int endInt = 0;
        if (beginInt > 0) {
            //图片标签后缀
            endInt = concent.substring(beginInt).indexOf(">") + beginInt;
        }
        //将图片存文附件,并替换图片位置为<img>attachId</img>
        int attachIdTab = 0;
        while (beginInt >= 0 && endInt > 0) {
            //需要替换的字符串
            String imgString = concent.substring(beginInt, endInt + 1);
            //取出文件地址
            String srcStr = imgString.substring(imgString.indexOf("\"") + 1);
            srcStr = srcStr.substring(0, srcStr.indexOf("\""));

            // 如果是doc文件 需要特殊处理
            if("doc".equalsIgnoreCase(sourceFileName.substring(sourceFileName.lastIndexOf(".")+1))){
                String realFilePath = srcStr.substring(0,srcStr.lastIndexOf(System.getProperty("file.separator"))+1);
                String oldImgFileName = srcStr.substring(srcStr.lastIndexOf(System.getProperty("file.separator"))+1);
                String realFileName = oldImgFileName.substring(0,13)+oldImgFileName.substring(oldImgFileName.length()-4);
                srcStr = realFilePath + realFileName;
            }

            File imgFile = new File(srcStr);
            //文件名
            String imgName = "";
            endInt = 0;
            if (imgFile.exists()) {
                imgName = imgFile.getName();
                int attachIDs = Math.abs((int) System.currentTimeMillis() + attachIdTab);
                attachIdTab++;
                String FileName = imgName;
                String FName = attachIDs + "." + FileName;
                String FilePath = imagePath + System.getProperty("file.separator") + FName;
                File file = new File(FilePath);
                imgFile.renameTo(file);
                if (file.exists()) {
                    Attachment attachment = new Attachment();
                    attachment.setAttachId(String.valueOf(attachIDs));
                    attachment.setModule(0);
                    attachment.setAttachFile(FileName);
                    attachment.setAttachName(FileName);
                    attachment.setYm(ym);
                    attachment.setAttachSign(new Long(0));
                    attachment.setDelFlag(0);
                    attachment.setPosition(2);
                    attachment.setFileSize(Convert.convertFileSize(file.length()));
                    attachment.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                    attachmentList.add(attachment);
                }
                //替换字符串
                concent = concent.replace(imgString, "<img>" + attachIDs + "</img>");
                //判断图片位置
                beginInt = concent.indexOf("<img src=\"");
                if (beginInt > 0) {
                    endInt = concent.substring(beginInt).indexOf(">") + beginInt;
                }
            }
        }
        map.put(CONTENT, concent);
        return map;
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-06-22 15:02
     * 方法介绍: 提取word 的正文内容 为 html 字符 并 单独保存图片
     * @param sourceFileName word 正文路径
     * @param imagePath      提取出的图片存贮路径
     * @return java.lang.StringBuffer
     */
    public static StringBuffer extractText(String sourceFileName, String imagePath) {
        StringBuffer buffer = new StringBuffer();
        File workFile = new File(sourceFileName);
        //文件不存在返回
        if (!workFile.exists()) {
            return null;
        }
        File imageFile = new File(imagePath);
        //附件地址不存在创建
        if (!imageFile.exists()) {
            imageFile.mkdirs();
        }
        if (workFile.getName().matches("^.+\\.(?i)(doc)$")) {
            try {
                // 读取doc文件
                readDoc(sourceFileName, imagePath, buffer);
            } catch (IllegalArgumentException e){
                // 如果报错 说明该doc文件可能是 docx改拓展名改来的 改成用读取docx的方法读取
                readDocx(sourceFileName, imagePath, buffer, imageFile);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (workFile.getName().matches("^.+\\.(?i)(docx)$")) {
            // 读取docx文件
            readDocx(sourceFileName, imagePath, buffer, imageFile);
        } else {
            return buffer;
        }
        return buffer;
    }

    // 读取doc文件
    private static void readDoc(String sourceFileName, String imagePath, StringBuffer buffer) throws IOException, ParserConfigurationException, TransformerException {
        String names = String.valueOf(System.currentTimeMillis());
        HWPFDocument wordDocument = new HWPFDocument(new FileInputStream(sourceFileName));
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        String FEATURE = null;
        FEATURE = "http://javax.xml.XMLConstants/feature/secure-processing";
        dbf.setFeature(FEATURE, true);
        FEATURE = "http://apache.org/xml/features/disallow-doctype-decl";
        dbf.setFeature(FEATURE, true);
        FEATURE = "http://xml.org/sax/features/external-parameter-entities";
        dbf.setFeature(FEATURE, false);
        FEATURE = "http://xml.org/sax/features/external-general-entities";
        dbf.setFeature(FEATURE, false);
        FEATURE = "http://apache.org/xml/features/nonvalidating/load-external-dtd";
        dbf.setFeature(FEATURE, false);
        dbf.setXIncludeAware(false);
        dbf.setExpandEntityReferences(false);
        DocumentBuilder builder = dbf.newDocumentBuilder();
        Document rootDoc = builder.newDocument();
        WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(rootDoc);
        wordToHtmlConverter.setPicturesManager(new PicturesManager() {
            public String savePicture(byte[] content, PictureType pictureType, String suggestedName, float widthInches, float heightInches) {
                return imagePath + System.getProperty("file.separator") + names + suggestedName;
            }
        });
        wordToHtmlConverter.processDocument(wordDocument);
        // 保存图片
        List<Picture> pics = wordDocument.getPicturesTable().getAllPictures();
        if (pics != null) {
            for (int i = 0; i < pics.size(); i++) {
                Picture pic = (Picture) pics.get(i);
                try {
                    copyByteToFile(pic.getContent(), imagePath + System.getProperty("file.separator") + names +"."+ pic.suggestFileExtension());
                    //pic.writeImageContent(new FileOutputStream(imagePath + System.getProperty("file.separator") + names + pic.suggestFullFileName()));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        Document htmlDocument = wordToHtmlConverter.getDocument();
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        DOMSource domSource = new DOMSource(htmlDocument);
        StreamResult streamResult = new StreamResult(out);

        TransformerFactory tf = TransformerFactory.newInstance();
        //tf.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");
        //tf.setAttribute(XMLConstants.ACCESS_EXTERNAL_STYLESHEET, "");

        Transformer serializer = tf.newTransformer();
        serializer.setOutputProperty(OutputKeys.ENCODING, "utf-8");
        serializer.setOutputProperty(OutputKeys.INDENT, "yes");
        serializer.setOutputProperty(OutputKeys.METHOD, "html");
        serializer.transform(domSource, streamResult);
        out.close();
        buffer.append(new String(out.toByteArray(), "utf-8"));
        wordDocument.close();
    }

    // 读取docx文件
    private static void readDocx(String sourceFileName, String imagePath, StringBuffer buffer, File imageFile) {
        //html临时存放地址
        String targetFileName = imagePath + System.getProperty("file.separator") + "1.html";
        File file = new File(targetFileName);
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        try (InputStreamReader isr = new InputStreamReader(new FileInputStream(file), "UTF-8");
             OutputStreamWriter outputStreamWriter = new OutputStreamWriter(new FileOutputStream(file), "utf-8")) {
            //docx
            BufferedReader br = new BufferedReader(isr);
            XWPFDocument documentx = new XWPFDocument(new FileInputStream(sourceFileName));
            XHTMLOptions options = XHTMLOptions.create();
            // 存放图片的文件夹
            options.setExtractor(new FileImageExtractor(imageFile));
            // html中图片的路径
            options.URIResolver(new BasicURIResolver(imagePath));
            XHTMLConverter xhtmlConverter = (XHTMLConverter) XHTMLConverter.getInstance();
            xhtmlConverter.convert(documentx, outputStreamWriter, options);
            while (br.ready()) {
                buffer.append(br.readLine());
            }
            documentx.close();

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            //提取后删除临时文件
            file.delete();
        }
    }

    public static void copyByteToFile(byte[] imgByte,String path) throws Exception {

        InputStream in = new ByteInputStream(imgByte, 0, imgByte.length);
        byte[] buff = new byte[1024];
        OutputStream out = new FileOutputStream(path);

        int len = 0;
        while ((len = in.read(buff)) > 0) {
            out.write(buff, 0, len);
        }

        out.flush();
        out.close();
        in.close();
    }

}
