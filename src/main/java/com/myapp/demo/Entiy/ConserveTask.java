package com.myapp.demo.Entiy;

import java.sql.Date;

/**
 * 养护任务表
 */
public class ConserveTask {
    int taskId;//养护任务编号
    String taskName;//任务名称
    //在前台向后台传数据时，必须要使用url拼接参数的方式才生效 https://blog.csdn.net/weixin_46460843/article/details/115705802
    Date executionTime;//执行时间
    String executionLocation;//执行地点
    int executionPersonnel;//执行人员
    String taskDescription;//任务描述
    int plantId;//养护对象
    int pestId;//病虫害编号(id) (如果有的话)
    int status;//任务状态（未开始、进行中、已结束）

    public final int STATUS_NOT_START = 0;
    public final int STATUS_IN_PROGRESS = 1;
    public final int STATUS_FINISHED = -1;

    public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public Date getExecutionTime() {
        return executionTime;
    }

    public void setExecutionTime(Date executionTime) {
        this.executionTime = executionTime;
    }

    public String getExecutionLocation() {
        return executionLocation;
    }

    public void setExecutionLocation(String executionLocation) {
        this.executionLocation = executionLocation;
    }

    public int getExecutionPersonnel() {
        return executionPersonnel;
    }

    public void setExecutionPersonnel(int executionPersonnel) {
        this.executionPersonnel = executionPersonnel;
    }

    public String getTaskDescription() {
        return taskDescription;
    }

    public void setTaskDescription(String taskDescription) {
        this.taskDescription = taskDescription;
    }

    public int getPlantId() {
        return plantId;
    }

    public void setPlantId(int plantId) {
        this.plantId = plantId;
    }

    public int getPestId() {
        return pestId;
    }

    public void setPestId(int pestId) {
        this.pestId = pestId;
    }

    public int getStatus() {
        return status;
    }

    public void setSTATUS_NOT_START() {
        this.status = STATUS_NOT_START;
    }
    public void setSTATUS_IN_PROGRESS() {
        this.status = STATUS_IN_PROGRESS;
    }
    public void setSTATUS_FINISHED() {
        this.status = STATUS_FINISHED;
    }
}
