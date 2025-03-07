package com.xoa.util.xsign;

import com.itextpdf.io.image.ImageData;
import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.geom.Rectangle;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.layout.element.Image;
import com.itextpdf.pdfa.PdfADocument;
import com.itextpdf.signatures.*;
import com.itextpdf.signatures.PdfSignatureAppearance.RenderingMode;
import com.itextpdf.signatures.PdfSigner.CryptoStandard;
import org.bouncycastle.jce.provider.BouncyCastleProvider;

import java.io.*;
import java.security.GeneralSecurityException;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.Security;
import java.security.cert.Certificate;

public class SignPDF7 {

    static{
        try{
            Security.addProvider(new BouncyCastleProvider());
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    /**
     * @作者 廉立深
     * @日期 2021/3/8
     * @说明 itext7
     * src 需要签章的pdf文件路径
     * dest 签完章的pdf文件路径
     * stream 证书路径
     * password 证书密码
     * chapterPath 图片路径
     **/
    public static void sign(InputStream src, OutputStream dest, FileInputStream stream, char[] password, String chapterPath,Float x,Float y,Float width,Float height,Integer PDFPageNumber)
            throws GeneralSecurityException, IOException {
        // 读取keystore ，获得私钥和证书链
        KeyStore ks = KeyStore.getInstance("PKCS12");
        ks.load(stream, password);
        String alias = (String) ks.aliases().nextElement();
        PrivateKey pk = (PrivateKey) ks.getKey(alias, password);
        Certificate[] chain = ks.getCertificateChain(alias);

        //下边的步骤都是固定的，照着写就行了，没啥要解释的
        PdfReader reader = null;
        try{
            reader = new PdfReader(src);
            //目标文件输出流
            //创建签章工具PdfSigner ，最后一个boolean参数
            //false的话，pdf文件只允许被签名一次，多次签名，最后一次有效
            //true的话，pdf可以被追加签名，验签工具可以识别出每次签名之后文档是否被修改
            PdfSigner stamper = new PdfSigner(reader, dest, true);
            // 获取数字签章属性对象，设定数字签章的属性
            PdfDocument document = stamper.getDocument();
            document.setDefaultPageSize(PageSize.TABLOID);
            PdfSignatureAppearance appearance = stamper.getSignatureAppearance();
            appearance.setReason("OA电子文档签名");
            appearance.setLocation("速卓电子印章");
            ImageData img = ImageDataFactory.create(chapterPath);
            //读取图章图片，这个image是itext包的image
            //Image image = new Image(img);
            //设置签名的位置，页码，签名域名称，多次追加签名的时候，签名与名称不能一样
            //签名的位置，是图章相对于pdf页面的位置坐标，原点为pdf页面左下角
            //四个参数的分别是，图章左下角x，图章左下角y，图章宽度，图章高度

            if(x==null||x==0){
                x= 350F;
            }
            if(y==null||y==0){
                y= 100F;
            }
            if(width==null||width==0){
                width= 100F;
            }
            if(height==null||height==0){
                height= 100F;
            }
            if(PDFPageNumber==null||PDFPageNumber==0){
                PDFPageNumber = 1;
            }
            appearance.setPageNumber(PDFPageNumber);
            appearance.setPageRect(new Rectangle(x, y, width, height));
            //插入盖章图片
            appearance.setSignatureGraphic(img);
            //设置图章的显示方式，如下选择的是只显示图章（还有其他的模式，可以图章和签名描述一同显示）
            appearance.setRenderingMode(RenderingMode.GRAPHIC);
            // 这里的itext提供了2个用于签名的接口，可以自己实现，后边着重说这个实现
            // 摘要算法
            IExternalDigest digest = new BouncyCastleDigest();
            // 签名算法
            IExternalSignature signature = new PrivateKeySignature(pk, DigestAlgorithms.SHA1, BouncyCastleProvider.PROVIDER_NAME);
            // 调用itext签名方法完成pdf签章
            stamper.setCertificationLevel(1);
            stamper.signDetached(digest,signature, chain, null, null, null, 0, CryptoStandard.CMS);

        }catch (Exception e){
            e.printStackTrace();
            if(reader!=null){
                reader.close();
            }
            if(src!=null){
                src.close();
            }
        }finally {
            if(reader!=null){
                reader.close();
            }
            if(src!=null){
                src.close();
            }
        }
    }

}