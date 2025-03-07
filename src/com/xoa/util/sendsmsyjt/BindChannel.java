/**
 * BindChannel.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.xoa.util.sendsmsyjt;

public class BindChannel  implements java.io.Serializable {
    private String channelNum;

    private String carrier;

    private String sendType;

    public BindChannel() {
    }

    public BindChannel(
           String channelNum,
           String carrier,
           String sendType) {
           this.channelNum = channelNum;
           this.carrier = carrier;
           this.sendType = sendType;
    }


    /**
     * Gets the channelNum value for this BindChannel.
     * 
     * @return channelNum
     */
    public String getChannelNum() {
        return channelNum;
    }


    /**
     * Sets the channelNum value for this BindChannel.
     * 
     * @param channelNum
     */
    public void setChannelNum(String channelNum) {
        this.channelNum = channelNum;
    }


    /**
     * Gets the carrier value for this BindChannel.
     * 
     * @return carrier
     */
    public String getCarrier() {
        return carrier;
    }


    /**
     * Sets the carrier value for this BindChannel.
     * 
     * @param carrier
     */
    public void setCarrier(String carrier) {
        this.carrier = carrier;
    }


    /**
     * Gets the sendType value for this BindChannel.
     * 
     * @return sendType
     */
    public String getSendType() {
        return sendType;
    }


    /**
     * Sets the sendType value for this BindChannel.
     * 
     * @param sendType
     */
    public void setSendType(String sendType) {
        this.sendType = sendType;
    }

    private Object __equalsCalc = null;
    public synchronized boolean equals(Object obj) {
        if (!(obj instanceof BindChannel)) return false;
        BindChannel other = (BindChannel) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.channelNum==null && other.getChannelNum()==null) || 
             (this.channelNum!=null &&
              this.channelNum.equals(other.getChannelNum()))) &&
            ((this.carrier==null && other.getCarrier()==null) || 
             (this.carrier!=null &&
              this.carrier.equals(other.getCarrier()))) &&
            ((this.sendType==null && other.getSendType()==null) || 
             (this.sendType!=null &&
              this.sendType.equals(other.getSendType())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        if (getChannelNum() != null) {
            _hashCode += getChannelNum().hashCode();
        }
        if (getCarrier() != null) {
            _hashCode += getCarrier().hashCode();
        }
        if (getSendType() != null) {
            _hashCode += getSendType().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(BindChannel.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://www.139130.net", "BindChannel"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("channelNum");
        elemField.setXmlName(new javax.xml.namespace.QName("http://www.139130.net", "ChannelNum"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("carrier");
        elemField.setXmlName(new javax.xml.namespace.QName("http://www.139130.net", "Carrier"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("sendType");
        elemField.setXmlName(new javax.xml.namespace.QName("http://www.139130.net", "SendType"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           String mechType,
           Class _javaType,
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           String mechType,
           Class _javaType,
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
