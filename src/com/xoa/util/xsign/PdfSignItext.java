package com.xoa.util.xsign;


import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Image;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfSignatureAppearance;
import com.itextpdf.text.pdf.PdfSignatureAppearance.RenderingMode;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.security.*;
import com.itextpdf.text.pdf.security.MakeSignature.CryptoStandard;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.GeneralSecurityException;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.cert.Certificate;

public class PdfSignItext {
        /**
         * @作者 廉立深
         * @日期 2021/3/8
         * @说明 itext5
         **/
        public static void sign(InputStream src  //需要签章的pdf文件路径
                , OutputStream dest  // 签完章的pdf文件路径
                , InputStream p12Stream  //p12 路径
                , char[] password
                ,String chapterPath)
                throws GeneralSecurityException, IOException, DocumentException {
                //读取keystore ，获得私钥和证书链
                KeyStore ks = KeyStore.getInstance("PKCS12");
                ks.load(p12Stream, password);
                String alias = (String)ks.aliases().nextElement();
                PrivateKey pk = (PrivateKey) ks.getKey(alias, password);
                Certificate[] chain = ks.getCertificateChain(alias);

                // Creating the reader and the stamper，开始pdfreader
                PdfReader reader = new PdfReader(src);
                //目标文件输出流
                //创建签章工具PdfStamper ，最后一个boolean参数
                //false的话，pdf文件只允许被签名一次，多次签名，最后一次有效
                //true的话，pdf可以被追加签名，验签工具可以识别出每次签名之后文档是否被修改
                PdfStamper stamper = PdfStamper.createSignature(reader, dest, '\0', null, false);
                // 获取数字签章属性对象，设定数字签章的属性
                PdfSignatureAppearance appearance = stamper.getSignatureAppearance();
                appearance.setReason("OA电子文档签名");
                appearance.setLocation("速卓电子印章");
                //设置签名的位置，页码，签名域名称，多次追加签名的时候，签名预名称不能一样
                //签名的位置，是图章相对于pdf页面的位置坐标，原点为pdf页面左下角
                //四个参数的分别是，图章左下角x，图章左下角y，图章右上角x，图章右上角y
                appearance.setVisibleSignature(new Rectangle(0, 700, 300, 1000), 1, "sig1");
                //读取图章图片，这个image是itext包的image
                Image image = Image.getInstance(chapterPath);
                appearance.setSignatureGraphic(image);
                appearance.setCertificationLevel(PdfSignatureAppearance.CERTIFIED_NO_CHANGES_ALLOWED);
                //设置图章的显示方式，如下选择的是只显示图章（还有其他的模式，可以图章和签名描述一同显示）
                appearance.setRenderingMode(RenderingMode.GRAPHIC);

                // 这里的itext提供了2个用于签名的接口，可以自己实现，后边着重说这个实现
                // 摘要算法
                ExternalDigest digest = new BouncyCastleDigest();
                // 签名算法
                ExternalSignature signature = new PrivateKeySignature(pk, DigestAlgorithms.SHA1, null);
                // 调用itext签名方法完成pdf签章CryptoStandard.CMS 签名方式，建议采用这种
                MakeSignature.signDetached(appearance, digest, signature, chain, null, null, null, 0, CryptoStandard.CMS);
        }

}
