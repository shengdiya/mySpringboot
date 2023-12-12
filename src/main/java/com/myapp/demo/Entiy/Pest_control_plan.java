package com.myapp.demo.Entiy;

/**
 * 病虫害防治方案表
 *
 */
public class Pest_control_plan {
    int pestId;//引用病虫害表的外键
    int pesticideId;//引用药剂表的外键
    String controlMethod;//防治方法
    String pesticideDose;//药剂用量
    String effectDuration;//作用期限

    public int getPestId() {
        return pestId;
    }

    public void setPestId(int pestId) {
        this.pestId = pestId;
    }

    public int getPesticideId() {
        return pesticideId;
    }

    public void setPesticideId(int pesticideId) {
        this.pesticideId = pesticideId;
    }

    public String getControlMethod() {
        return controlMethod;
    }

    public void setControlMethod(String controlMethod) {
        this.controlMethod = controlMethod;
    }

    public String getPesticideDose() {
        return pesticideDose;
    }

    public void setPesticideDose(String pesticideDose) {
        this.pesticideDose = pesticideDose;
    }

    public String getEffectDuration() {
        return effectDuration;
    }

    public void setEffectDuration(String effectDuration) {
        this.effectDuration = effectDuration;
    }
}
