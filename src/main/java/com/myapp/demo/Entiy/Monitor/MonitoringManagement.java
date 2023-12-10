package com.myapp.demo.Entiy.Monitor;
import java.sql.Timestamp;

public class MonitoringManagement {
    private int monitoringManagementId; //监测管理id
    private Timestamp monitoringTime;//监测时间
    private int monitoringPersonnelId;//监测人员(id)
    private String monitoringLocation;//监测地点
    private int monitoringObject;//监测对象（植物基本信息表id）
    private String monitoringIndicatorValues;//监测指标值
    private int monitoringDeviceId;//监测设备(id)
    private String monitoringStatus;//任务状态（进行中、已结束）

    //无参构造函数

    public MonitoringManagement() {
    }
    // 构造方法

    public MonitoringManagement(int monitoringManagementId, Timestamp monitoringTime, int monitoringPersonnelId,
                                String monitoringLocation, int monitoringObject, String monitoringIndicatorValues, int monitoringDeviceId,
                                String monitoringStatus) {
        this.monitoringManagementId = monitoringManagementId;
        this.monitoringTime = monitoringTime;
        this.monitoringPersonnelId = monitoringPersonnelId;
        this.monitoringLocation = monitoringLocation;
        this.monitoringObject = monitoringObject;
        this.monitoringIndicatorValues = monitoringIndicatorValues;
        this.monitoringDeviceId = monitoringDeviceId;
        this.monitoringStatus = monitoringStatus;
    }

    // Getter 和 Setter 方法

    public int getMonitoringManagementId() {
        return monitoringManagementId;
    }
    public void setMonitoringManagementId(int monitoringManagementId) {
        this.monitoringManagementId = monitoringManagementId;
    }
    public Timestamp getMonitoringTime() {
        return monitoringTime;
    }
    public void setMonitoringTime(Timestamp monitoringTime) {
        this.monitoringTime = monitoringTime;
    }
    public int getMonitoringPersonnelId() {
        return monitoringPersonnelId;
    }
    public void setMonitoringPersonnelId(int monitoringPersonnelId) {
        this.monitoringPersonnelId = monitoringPersonnelId;
    }
    public String getMonitoringLocation() {
        return monitoringLocation;
    }
    public void setMonitoringLocation(String monitoringLocation) {
        this.monitoringLocation = monitoringLocation;
    }
    public int getMonitoringObject() {
        return monitoringObject;
    }
    public void setMonitoringObject(int monitoringObject) {
        this.monitoringObject = monitoringObject;
    }

    public String getMonitoringIndicatorValues() {
        return monitoringIndicatorValues;
    }

    public void setMonitoringIndicatorValues(String monitoringIndicatorValues) {
        this.monitoringIndicatorValues = monitoringIndicatorValues;
    }

    public int getMonitoringDeviceId() {
        return monitoringDeviceId;
    }
    public void setMonitoringDeviceId(int monitoringDeviceId) {
        this.monitoringDeviceId = monitoringDeviceId;
    }
    public String getMonitoringStatus() {
        return monitoringStatus;
    }
    public void setMonitoringStatus(String monitoringStatus) {
        this.monitoringStatus = monitoringStatus;
    }
}
