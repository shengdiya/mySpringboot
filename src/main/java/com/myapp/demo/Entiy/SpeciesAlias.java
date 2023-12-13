package com.myapp.demo.Entiy;

public class SpeciesAlias {
    private int speciesId;
    private String speciesAlias;;

    @Override
    public String toString() {
        return "SpeciesAlias{" +
                "speciesId=" + speciesId +
                ", speciesAlias='" + speciesAlias + '\'' +
                '}';
    }

    public int getSpeciesId() {
        return speciesId;
    }

    public void setSpeciesId(int speciesId) {
        this.speciesId = speciesId;
    }

    public String getSpeciesAlias() {
        return speciesAlias;
    }

    public void setSpeciesAlias(String speciesAlias) {
        this.speciesAlias = speciesAlias;
    }
}
