package com.myapp.demo.Dao;

import com.myapp.demo.Entiy.SpeciesArea;

import java.util.List;

public interface SpeciesAreaDao {

    public void insertSpeciesArea(SpeciesArea speciesArea);

    public List< SpeciesArea > selectSpeciesArea(int speciesId);

    public SpeciesArea selectArea(int areaId);

}
