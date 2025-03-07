/**
 * WebServiceSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.xoa.util.sendsmsyjt;

public interface WebServiceSoap extends java.rmi.Remote {
    public MOMsg[] getMOMessage(String account, String password, int pagesize) throws java.rmi.RemoteException;
    public BusinessType[] getBusinessType(String account, String password) throws java.rmi.RemoteException;
    public AccountInfo getAccountInfo(String account, String password) throws java.rmi.RemoteException;
    public int modifyPassword(String account, String old_password, String new_password) throws java.rmi.RemoteException;
    public GsmsResponse post(String account, String password, MTPacks mtpack) throws java.rmi.RemoteException;
    public int postSingle(String account, String password, String mobile, String content, String subid) throws java.rmi.RemoteException;
    public int postMass(String account, String password, String[] mobiles, String content, String subid) throws java.rmi.RemoteException;
    public int postGroup(String account, String password, MessageData[] mssages, String subid) throws java.rmi.RemoteException;
    public MTResponse[] getResponse(String account, String password, int pageSize) throws java.rmi.RemoteException;
    public MTReport[] getReport(String account, String password, int pageSize) throws java.rmi.RemoteException;
    public MTResponse[] findResponse(String account, String password, String batchid, String mobile, int pageindex, int flag) throws java.rmi.RemoteException;
    public MTReport[] findReport(String account, String password, String batchid, String mobile, int pageindex, int flag) throws java.rmi.RemoteException;
    public MediaItems[] setMedias(String fullPath) throws java.rmi.RemoteException;
}
