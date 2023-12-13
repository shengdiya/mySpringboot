package com.myapp.demo.Entiy;

public class SpeciesArea {
    private int speciesId;
    private int AreaId;

    public int getSpeciesId() {
        return speciesId;
    }

    public void setSpeciesId(int speciesId) {
        this.speciesId = speciesId;
    }

    public int getAreaId() {
        return AreaId;
    }

    public void setAreaId(int areaId) {
        AreaId = areaId;
    }

    @Override
    public String toString() {
        return "SpeciesArea{" +
                "speciesId=" + speciesId +
                ", AreaId=" + AreaId +
                '}';
    }
}
