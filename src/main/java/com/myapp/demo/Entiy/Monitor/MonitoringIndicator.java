package com.myapp.demo.Entiy.Monitor;

public class MonitoringIndicator {
    private int monitoringIndicatorId;
    private String monitoringIndicatorValues;

    // 无参构造方法
    public MonitoringIndicator() {

    }

    // 带参构造方法
    public MonitoringIndicator(int monitoringIndicatorId, String monitoringIndicatorValues) {
        this.monitoringIndicatorId = monitoringIndicatorId;
        this.monitoringIndicatorValues = monitoringIndicatorValues;
    }

    // Getter 和 Setter 方法

    public int getMonitoringIndicatorId() {
        return monitoringIndicatorId;
    }
    public void setMonitoringIndicatorId(int monitoringIndicatorId) {
        this.monitoringIndicatorId = monitoringIndicatorId;
    }
    public String getMonitoringIndicatorValues() {
        return monitoringIndicatorValues;
    }
    public void setMonitoringIndicatorValues(String monitoringIndicatorValues) {
        this.monitoringIndicatorValues = monitoringIndicatorValues;
    }
}
