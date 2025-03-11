package com.xoa.model.gw_device;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class GwDeviceAll {
    private String commissioningDateStr;
    private String returnDateStr;
    private String warrantyExpirationDateStr;
    private String createTimeStr;
    private String createUserName;
    private Integer serverId;

    private String nodeId;

    private String nodeName;

    private String safeArea;

    private String operationManagementIp;

    private String updateFlag;

    private String sendUpFlag;

    private String reportFlag;

    private String regulationMark;

    private String equipName;

    private String fullPathName;

    private String equipType;

    private String manufacturer;

    private String equipModdel;

    private String installationSite;

    private String runningState;

    private Integer devicesNumber;

    private String startUBit;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date commissioningDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date returnDate;

    private String personLiable;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date warrantyExpirationDate;

    private String assetNumber;

    private String sequenceCode;

    private String cpuModel;

    private String cpuWordLength;

    private String mainFrequencyOfCpu;

    private Integer cpuNumber;

    private Integer numberOfCpuCores;

    private String memorySize;

    private String hardDiskCapacity;

    private Integer numberOfPowerSupplies;

    private String operatingSystemType;

    private String createUserId;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    private String funcInfo;

    private Integer switchId;

    private String networkAddress;

    private String firmwareVersion;


    private Integer numberOfOpticalPorts;

    private Integer numberOfPorts;

    private String exchangeRate;

    private Integer stationId;

    private Integer numberOfScreens;

    public Integer getServerId() {
        return serverId;
    }

    public void setServerId(Integer serverId) {
        this.serverId = serverId;
    }

    public String getNodeId() {
        return nodeId;
    }

    public void setNodeId(String nodeId) {
        this.nodeId = nodeId;
    }

    public String getNodeName() {
        return nodeName;
    }

    public void setNodeName(String nodeName) {
        this.nodeName = nodeName;
    }

    public String getSafeArea() {
        return safeArea;
    }

    public void setSafeArea(String safeArea) {
        this.safeArea = safeArea;
    }

    public String getOperationManagementIp() {
        return operationManagementIp;
    }

    public void setOperationManagementIp(String operationManagementIp) {
        this.operationManagementIp = operationManagementIp;
    }

    public String getUpdateFlag() {
        return updateFlag;
    }

    public void setUpdateFlag(String updateFlag) {
        this.updateFlag = updateFlag;
    }

    public String getSendUpFlag() {
        return sendUpFlag;
    }

    public void setSendUpFlag(String sendUpFlag) {
        this.sendUpFlag = sendUpFlag;
    }

    public String getReportFlag() {
        return reportFlag;
    }

    public void setReportFlag(String reportFlag) {
        this.reportFlag = reportFlag;
    }

    public String getRegulationMark() {
        return regulationMark;
    }

    public void setRegulationMark(String regulationMark) {
        this.regulationMark = regulationMark;
    }

    public String getEquipName() {
        return equipName;
    }

    public void setEquipName(String equipName) {
        this.equipName = equipName;
    }

    public String getFullPathName() {
        return fullPathName;
    }

    public void setFullPathName(String fullPathName) {
        this.fullPathName = fullPathName;
    }

    public String getEquipType() {
        return equipType;
    }

    public void setEquipType(String equipType) {
        this.equipType = equipType;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getEquipModdel() {
        return equipModdel;
    }

    public void setEquipModdel(String equipModdel) {
        this.equipModdel = equipModdel;
    }

    public String getInstallationSite() {
        return installationSite;
    }

    public void setInstallationSite(String installationSite) {
        this.installationSite = installationSite;
    }

    public String getRunningState() {
        return runningState;
    }

    public void setRunningState(String runningState) {
        this.runningState = runningState;
    }

    public Integer getDevicesNumber() {
        return devicesNumber;
    }

    public void setDevicesNumber(Integer devicesNumber) {
        this.devicesNumber = devicesNumber;
    }

    public String getStartUBit() {
        return startUBit;
    }

    public void setStartUBit(String startUBit) {
        this.startUBit = startUBit;
    }

    public Date getCommissioningDate() {
        return commissioningDate;
    }

    public void setCommissioningDate(Date commissioningDate) {
        this.commissioningDate = commissioningDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public String getPersonLiable() {
        return personLiable;
    }

    public void setPersonLiable(String personLiable) {
        this.personLiable = personLiable;
    }

    public Date getWarrantyExpirationDate() {
        return warrantyExpirationDate;
    }

    public void setWarrantyExpirationDate(Date warrantyExpirationDate) {
        this.warrantyExpirationDate = warrantyExpirationDate;
    }

    public String getAssetNumber() {
        return assetNumber;
    }

    public void setAssetNumber(String assetNumber) {
        this.assetNumber = assetNumber;
    }

    public String getSequenceCode() {
        return sequenceCode;
    }

    public void setSequenceCode(String sequenceCode) {
        this.sequenceCode = sequenceCode;
    }

    public String getCpuModel() {
        return cpuModel;
    }

    public void setCpuModel(String cpuModel) {
        this.cpuModel = cpuModel;
    }

    public String getCpuWordLength() {
        return cpuWordLength;
    }

    public void setCpuWordLength(String cpuWordLength) {
        this.cpuWordLength = cpuWordLength;
    }

    public String getMainFrequencyOfCpu() {
        return mainFrequencyOfCpu;
    }

    public void setMainFrequencyOfCpu(String mainFrequencyOfCpu) {
        this.mainFrequencyOfCpu = mainFrequencyOfCpu;
    }

    public Integer getCpuNumber() {
        return cpuNumber;
    }

    public void setCpuNumber(Integer cpuNumber) {
        this.cpuNumber = cpuNumber;
    }

    public Integer getNumberOfCpuCores() {
        return numberOfCpuCores;
    }

    public void setNumberOfCpuCores(Integer numberOfCpuCores) {
        this.numberOfCpuCores = numberOfCpuCores;
    }

    public String getMemorySize() {
        return memorySize;
    }

    public void setMemorySize(String memorySize) {
        this.memorySize = memorySize;
    }

    public String getHardDiskCapacity() {
        return hardDiskCapacity;
    }

    public void setHardDiskCapacity(String hardDiskCapacity) {
        this.hardDiskCapacity = hardDiskCapacity;
    }

    public Integer getNumberOfPowerSupplies() {
        return numberOfPowerSupplies;
    }

    public void setNumberOfPowerSupplies(Integer numberOfPowerSupplies) {
        this.numberOfPowerSupplies = numberOfPowerSupplies;
    }

    public String getOperatingSystemType() {
        return operatingSystemType;
    }

    public void setOperatingSystemType(String operatingSystemType) {
        this.operatingSystemType = operatingSystemType;
    }

    public String getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(String createUserId) {
        this.createUserId = createUserId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getFuncInfo() {
        return funcInfo;
    }

    public void setFuncInfo(String funcInfo) {
        this.funcInfo = funcInfo;
    }

    public Integer getSwitchId() {
        return switchId;
    }

    public void setSwitchId(Integer switchId) {
        this.switchId = switchId;
    }

    public String getNetworkAddress() {
        return networkAddress;
    }

    public void setNetworkAddress(String networkAddress) {
        this.networkAddress = networkAddress;
    }

    public String getFirmwareVersion() {
        return firmwareVersion;
    }

    public void setFirmwareVersion(String firmwareVersion) {
        this.firmwareVersion = firmwareVersion;
    }

    public Integer getNumberOfOpticalPorts() {
        return numberOfOpticalPorts;
    }

    public void setNumberOfOpticalPorts(Integer numberOfOpticalPorts) {
        this.numberOfOpticalPorts = numberOfOpticalPorts;
    }

    public Integer getNumberOfPorts() {
        return numberOfPorts;
    }

    public void setNumberOfPorts(Integer numberOfPorts) {
        this.numberOfPorts = numberOfPorts;
    }

    public String getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(String exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public Integer getStationId() {
        return stationId;
    }

    public void setStationId(Integer stationId) {
        this.stationId = stationId;
    }

    public Integer getNumberOfScreens() {
        return numberOfScreens;
    }

    public void setNumberOfScreens(Integer numberOfScreens) {
        this.numberOfScreens = numberOfScreens;
    }

    public String getCreateUserName() {
        return createUserName;
    }

    public void setCreateUserName(String createUserName) {
        this.createUserName = createUserName;
    }

    public String getCommissioningDateStr() {
        return commissioningDateStr;
    }

    public void setCommissioningDateStr(String commissioningDateStr) {
        this.commissioningDateStr = commissioningDateStr;
    }

    public String getReturnDateStr() {
        return returnDateStr;
    }

    public void setReturnDateStr(String returnDateStr) {
        this.returnDateStr = returnDateStr;
    }

    public String getWarrantyExpirationDateStr() {
        return warrantyExpirationDateStr;
    }

    public void setWarrantyExpirationDateStr(String warrantyExpirationDateStr) {
        this.warrantyExpirationDateStr = warrantyExpirationDateStr;
    }

    public String getCreateTimeStr() {
        return createTimeStr;
    }

    public void setCreateTimeStr(String createTimeStr) {
        this.createTimeStr = createTimeStr;
    }
}
