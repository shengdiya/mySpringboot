package com.myapp.demo.Entiy;

public class Area {

    private Integer id;
    private Integer pid;
    private String cityName;
    private Integer type;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Area{" +
                "id=" + id +
                ", pid=" + pid +
                ", cityName='" + cityName + '\'' +
                ", type=" + type +
                '}';
    }
}
