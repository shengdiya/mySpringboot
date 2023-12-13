package com.myapp.demo.Dao;

import com.myapp.demo.Entiy.Species;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SpeciesDao {
    public void insertSpecies(Species species);

//    findSpeciesById
    Species findSpeciesById(int id);

    List<Integer> findPlantIdsByParams(@Param("genus") String genus,
                                       @Param("family") String family,
                                       @Param("species") String species,
                                       @Param("alias") String alias,
                                       @Param("distribution") String distribution);
    Integer findSpeciesIdByName(String speciesName);

}
