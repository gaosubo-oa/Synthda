package com.xoa.util;

import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.html2pdf.resolver.font.DefaultFontProvider;
import com.itextpdf.kernel.colors.Color;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.geom.Rectangle;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.canvas.PdfCanvas;
import com.itextpdf.kernel.pdf.canvas.draw.ILineDrawer;
import com.itextpdf.styledxmlparser.css.media.MediaDeviceDescription;
import com.itextpdf.styledxmlparser.css.media.MediaType;
import com.xoa.util.common.L;

import javax.servlet.http.HttpServletRequest;
import java.io.FileInputStream;

/**
 * Created by kamiyo on 2019/3/27.
 */
public class HtmlToPdfUtil {


    public static void htmlToPDF(Integer maxWidth, Integer maxHeight, String htmlPath, String dest, HttpServletRequest request) {
        FileInputStream fileInputStream = null;
        try ( PdfWriter pdfwriter = new PdfWriter(dest);
              PdfDocument pdfDocument = new PdfDocument(pdfwriter);
             ){

            pdfDocument.setTagged();
            pdfDocument.setDefaultPageSize(new PageSize(maxWidth == null ? PageSize.A4.getWidth() : maxWidth, maxHeight == null ? PageSize.A4.getHeight() : maxHeight));
            ConverterProperties props = new ConverterProperties();
            // 定义字体路径
            String font = request.getSession().getServletContext().getRealPath("") +
                    System.getProperty("file.separator") + "ui" +
                    System.getProperty("file.separator") + "fonts" +
                    System.getProperty("file.separator") + "NotoSansCJKsc-Regular.otf";
            // 设置字体
            DefaultFontProvider defaultFontProvider = new DefaultFontProvider(false, false, false);
            defaultFontProvider.addFont(font);
            props.setFontProvider(defaultFontProvider);
            // 设置显示
            MediaDeviceDescription mediaDeviceDescription = new MediaDeviceDescription(MediaType.SCREEN);
            mediaDeviceDescription.setWidth(maxWidth);
            props.setMediaDeviceDescription(mediaDeviceDescription);
            // 定位html源文件
            //props.setBaseUri(htmlPath);
            props.setCreateAcroForm(true);
            // html转换pdf

            fileInputStream = new FileInputStream(htmlPath);
            HtmlConverter.convertToPdf(fileInputStream, pdfDocument, props);
            fileInputStream.close();
            pdfDocument.close();
            pdfwriter.close();
        } catch (Exception e) {
            e.printStackTrace();
            L.e(e.getMessage());
        }finally {
            try {
                if (fileInputStream != null) {
                    fileInputStream.close();
                }
            }catch (Exception e){

            }

        }
    }

    static class EndPosition implements ILineDrawer {

        /**
         * A Y-position.
         */
        protected float y;

        /**
         * Gets the Y-position.
         *
         * @return the Y-position
         */
        public float getY() {
            return y;
        }

        /*
         * (non-Javadoc)
         *
         * @see
         * com.itextpdf.kernel.pdf.canvas.draw.ILineDrawer#draw(com.itextpdf.kernel.pdf.
         * canvas.PdfCanvas, com.itextpdf.kernel.geom.Rectangle)
         */
        @Override
        public void draw(PdfCanvas pdfCanvas, Rectangle rect) {
            this.y = rect.getY();
        }

        /*
         * (non-Javadoc)
         *
         * @see com.itextpdf.kernel.pdf.canvas.draw.ILineDrawer#getColor()
         */
        @Override
        public Color getColor() {
            return null;
        }

        /*
         * (non-Javadoc)
         *
         * @see com.itextpdf.kernel.pdf.canvas.draw.ILineDrawer#getLineWidth()
         */
        @Override
        public float getLineWidth() {
            return 0;
        }

        /*
         * (non-Javadoc)
         *
         * @see
         * com.itextpdf.kernel.pdf.canvas.draw.ILineDrawer#setColor(com.itextpdf.kernel.
         * color.Color)
         */
        @Override
        public void setColor(Color color) {
        }

        /*
         * (non-Javadoc)
         *
         * @see com.itextpdf.kernel.pdf.canvas.draw.ILineDrawer#setLineWidth(float)
         */
        @Override
        public void setLineWidth(float lineWidth) {
        }

    }

}
