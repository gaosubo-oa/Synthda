package com.xoa.util.systeminfo;

import org.apache.commons.codec.Decoder;
import org.apache.commons.codec.DecoderException;
/**
 *@创建作者:     韩成冰
 *@创建日期:     2017/6/29 9:41
 *@类介绍:       jar包问题 ，copy自  org.apache.commons.codec.binary包，有修改
 *@构造参数:
 **/
public interface BinaryDecoder extends Decoder {
    byte[] decode(byte[] var1) throws DecoderException;
}
