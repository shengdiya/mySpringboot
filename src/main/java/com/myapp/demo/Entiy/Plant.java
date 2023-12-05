package com.myapp.demo.Entiy;

public class Plant {
    private Integer plantId; //植物Id
    private String plantName; //植物别名（在此处存储别名，根据别名可以查出科、属、种名）
    private String feature; //形态特征
    private String cultivation; //栽培技术要点
    private String value; //应用价值
    private Integer number; // 同种植物的编号
    public Integer getPlantId() {
        return plantId;
    }

    public void setPlantId(Integer plantId) {
        this.plantId = plantId;
    }

    public String getPlantName() {
        return plantName;
    }

    public void setPlantName(String plantName) {
        this.plantName = plantName;
    }

    public String getFeature() {
        return feature;
    }

    public void setFeature(String feature) {
        this.feature = feature;
    }

    public String getCultivation() {
        return cultivation;
    }

    public void setCultivation(String cultivation) {
        this.cultivation = cultivation;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }
}
