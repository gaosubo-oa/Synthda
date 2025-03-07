package com.xoa.util.sendsmsyjt;

public class WebServiceSoapProxy implements WebServiceSoap {
  private String _endpoint = null;
  private WebServiceSoap webServiceSoap = null;
  
  public WebServiceSoapProxy() {
    _initWebServiceSoapProxy();
  }
  
  public WebServiceSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initWebServiceSoapProxy();
  }
  
  private void _initWebServiceSoapProxy() {
    try {
      webServiceSoap = new WebServiceLocator().getWebServiceSoap();
      if (webServiceSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)webServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)webServiceSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (webServiceSoap != null)
      ((javax.xml.rpc.Stub)webServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public WebServiceSoap getWebServiceSoap() {
    if (webServiceSoap == null)
      _initWebServiceSoapProxy();
    return webServiceSoap;
  }
  
  public MOMsg[] getMOMessage(String account, String password, int pagesize) throws java.rmi.RemoteException{
    if (webServiceSoap == null)
      _initWebServiceSoapProxy();
    return webServiceSoap.getMOMessage(account, password, pagesize);
  }
  
  public BusinessType[] getBusinessType(String account, String password) throws java.rmi.RemoteException{
    if (webServiceSoap == null)
      _initWebServiceSoapProxy();
    return webServiceSoap.getBusinessType(account, password);
  }
  
  public AccountInfo getAccountInfo(String account, String password) throws java.rmi.RemoteException{
    if (webServiceSoap == null)
      _initWebServiceSoapProxy();
    return webServiceSoap.getAccountInfo(account, password);
  }
  
  public int modifyPassword(String account, String old_password, String new_password) throws java.rmi.RemoteException{
    if (webServiceSoap == null)
      _initWebServiceSoapProxy();
    return webServiceSoap.modifyPassword(account, old_password, new_password);
  }
  
  public GsmsResponse post(String account, String password, MTPacks mtpack) throws java.rmi.RemoteException{
    if (webServiceSoap == null)
      _initWebServiceSoapProxy();
    return webServiceSoap.post(account, password, mtpack);
  }
  
  public int postSingle(String account, String password, String mobile, String content, String subid) throws java.rmi.RemoteException{
    if (webServiceSoap == null)
      _initWebServiceSoapProxy();
    return webServiceSoap.postSingle(account, password, mobile, content, subid);
  }
  
  public int postMass(String account, String password, String[] mobiles, String content, String subid) throws java.rmi.RemoteException{
    if (webServiceSoap == null)
      _initWebServiceSoapProxy();
    return webServiceSoap.postMass(account, password, mobiles, content, subid);
  }
  
  public int postGroup(String account, String password, MessageData[] mssages, String subid) throws java.rmi.RemoteException{
    if (webServiceSoap == null)
      _initWebServiceSoapProxy();
    return webServiceSoap.postGroup(account, password, mssages, subid);
  }
  
  public MTResponse[] getResponse(String account, String password, int pageSize) throws java.rmi.RemoteException{
    if (webServiceSoap == null)
      _initWebServiceSoapProxy();
    return webServiceSoap.getResponse(account, password, pageSize);
  }
  
  public MTReport[] getReport(String account, String password, int pageSize) throws java.rmi.RemoteException{
    if (webServiceSoap == null)
      _initWebServiceSoapProxy();
    return webServiceSoap.getReport(account, password, pageSize);
  }
  
  public MTResponse[] findResponse(String account, String password, String batchid, String mobile, int pageindex, int flag) throws java.rmi.RemoteException{
    if (webServiceSoap == null)
      _initWebServiceSoapProxy();
    return webServiceSoap.findResponse(account, password, batchid, mobile, pageindex, flag);
  }
  
  public MTReport[] findReport(String account, String password, String batchid, String mobile, int pageindex, int flag) throws java.rmi.RemoteException{
    if (webServiceSoap == null)
      _initWebServiceSoapProxy();
    return webServiceSoap.findReport(account, password, batchid, mobile, pageindex, flag);
  }
  
  public MediaItems[] setMedias(String fullPath) throws java.rmi.RemoteException{
    if (webServiceSoap == null)
      _initWebServiceSoapProxy();
    return webServiceSoap.setMedias(fullPath);
  }
  
  
}