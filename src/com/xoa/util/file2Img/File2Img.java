package com.xoa.util.file2Img;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

public class File2Img {

    /**
     *  pdf文件转换成jpg图片集
     * @param pdfFilePath pdf文件路径
     * @param pdfName pdf文件名称
     * @return 图片访问集合
     */
    public static List<String> pdf2jpg(String pdfFilePath, String pdfName, String attUrl) {
        List<String> imageUrls = new ArrayList<>();
        //Integer imageCount = this.getConvertedPdfImage(pdfFilePath);
        String imageFileSuffix = ".jpg";
        String pdfFolder = pdfName.substring(0, pdfName.lastIndexOf("."));
        String urlPrefix;
        try {
            urlPrefix = attUrl + URLEncoder.encode(pdfFolder, "UTF-8").replaceAll("\\+", "%20");
        } catch (UnsupportedEncodingException e) {
            //logger.error("UnsupportedEncodingException", e);
            urlPrefix = attUrl + pdfFolder;
        }
        /*if (imageCount != null && imageCount > 0) {
            for (int i = 0; i < imageCount; i++)
                imageUrls.add(urlPrefix + "/" + i + imageFileSuffix);
            return imageUrls;
        }*/
        try {
            File pdfFile = new File(pdfFilePath);
            PDDocument doc = PDDocument.load(pdfFile);
            int pageCount = doc.getNumberOfPages();
            PDFRenderer pdfRenderer = new PDFRenderer(doc);

            int index = pdfFilePath.lastIndexOf(".");
            String folder = pdfFilePath.substring(0, index);

            File path = new File(folder);
            if (!path.exists() && !path.mkdirs()) {
                //logger.error("创建转换文件【{}】目录失败，请检查目录权限！", folder);
            }
            String imageFilePath;
            for (int pageIndex = 0; pageIndex < pageCount; pageIndex++) {
                imageFilePath = folder + File.separator + pageIndex + imageFileSuffix;
                BufferedImage image = pdfRenderer.renderImageWithDPI(pageIndex, 105, ImageType.RGB);
                ImageIOUtil.writeImage(image, imageFilePath, 105);
                imageUrls.add(urlPrefix + "/" + pageIndex + imageFileSuffix);
            }
            doc.close();
            //this.addConvertedPdfImage(pdfFilePath, pageCount);
        } catch (IOException e) {
            //logger.error("Convert pdf to jpg exception, pdfFilePath：{}", pdfFilePath, e);
        }
        return imageUrls;
    }
}
