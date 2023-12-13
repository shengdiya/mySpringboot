package com.myapp.demo.Dao;

import com.myapp.demo.Entiy.Familyspecies;

public interface FamilyspeciesDao {
    public void insertfamilySpecies(Familyspecies familyspecies);

    public Familyspecies selectfamilyspeciesByFamily(String family);

    public Familyspecies selectfamilyspeciesBySpecies(String species);

}
