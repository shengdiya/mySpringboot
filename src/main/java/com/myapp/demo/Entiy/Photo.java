package com.myapp.demo.Entiy;

import java.sql.Blob;

public class Photo {
    private Integer photoId; //图片编号
    private Integer plantId; //植物编号（外键）
    private String photoPath; //图片路径
    private String photoPlace; //拍摄地点
    private String photoDescribe; //图片描述
    private String photographer; //拍摄人

    public Integer getPhotoId() {
        return photoId;
    }

    public void setPhotoId(Integer photoId) {
        this.photoId = photoId;
    }

    public Integer getPlantId() {
        return plantId;
    }

    public void setPlantId(Integer plantId) {
        this.plantId = plantId;
    }

    public String getPhotoPath() {
        return photoPath;
    }

    public void setPhotoPath(String photoPath) {
        this.photoPath = photoPath;
    }

    public String getPhotoPlace() {
        return photoPlace;
    }

    public void setPhotoPlace(String photoPlace) {
        this.photoPlace = photoPlace;
    }

    public String getPhotoDescribe() {
        return photoDescribe;
    }

    public void setPhotoDescribe(String photoDescribe) {
        this.photoDescribe = photoDescribe;
    }

    public String getPhotographer() {
        return photographer;
    }

    public void setPhotographer(String photographer) {
        this.photographer = photographer;
    }
}
