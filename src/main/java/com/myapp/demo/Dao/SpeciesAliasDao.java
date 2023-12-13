package com.myapp.demo.Dao;

import com.myapp.demo.Entiy.SpeciesAlias;

import java.util.List;

public interface SpeciesAliasDao {

    public void insertSpeciesAlias(SpeciesAlias speciesAlias);

    public List<SpeciesAlias> selectSpeciesAliasBySpeciesId(int speciesId);

    public List< SpeciesAlias > selectSpeciesAliasByAlias(String alias);

}
