package com.myapp.demo.Entiy.Monitor;

public class MonitoringDevice {
    private int monitoringDeviceId;//监测设备id
    private String monitoringDeviceName;//监测设备名字
    private String monitoringIndicatorCategories;//监测指标种类

    private String monitoringDeviceStatus;//监测设备状态（工作中或空闲中）

    // 无参构造方法
    public MonitoringDevice() {

    }

    // 带参构造方法
    public MonitoringDevice(int monitoringDeviceId, String monitoringIndicatorName,String monitoringIndicatorCategories, String monitoringDeviceStatus) {
        this.monitoringDeviceId = monitoringDeviceId;
        this.monitoringDeviceName = monitoringIndicatorName;
        this.monitoringIndicatorCategories = monitoringIndicatorCategories;
        this.monitoringDeviceStatus = monitoringDeviceStatus;
    }

    // Getter 和 Setter 方法


    public String getMonitoringDeviceStatus() {
        return monitoringDeviceStatus;
    }

    public void setMonitoringDeviceStatus(String monitoringDeviceStatus) {
        this.monitoringDeviceStatus = monitoringDeviceStatus;
    }

    public String getMonitoringDeviceName() {
        return monitoringDeviceName;
    }

    public void setMonitoringDeviceName(String monitoringDeviceName) {
        this.monitoringDeviceName = monitoringDeviceName;
    }

    public int getMonitoringDeviceId() {
        return monitoringDeviceId;
    }
    public void setMonitoringDeviceId(int monitoringDeviceId) {
        this.monitoringDeviceId = monitoringDeviceId;
    }
    public String getMonitoringIndicatorCategories() {
        return monitoringIndicatorCategories;
    }
    public void setMonitoringIndicatorCategories(String monitoringIndicatorCategories) {
        this.monitoringIndicatorCategories = monitoringIndicatorCategories;
    }
}
