package com.myapp.demo.Service;

import com.myapp.demo.Dao.FamilyspeciesDao;
import com.myapp.demo.Entiy.Familyspecies;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("familyspeciesService")
public class FamilyspeciesService {

    @Resource(name = "familyspeciesDao")
    FamilyspeciesDao familyspeciesDao;

    public void insertfamilySpecies(Familyspecies familyspecies) {
        familyspeciesDao.insertfamilySpecies(familyspecies);
    }

    public Familyspecies selectfamilyspeciesByFamily(String family) {
        return familyspeciesDao.selectfamilyspeciesByFamily(family);
    }

    public Familyspecies selectfamilyspeciesBySpecies(String species) {
        return familyspeciesDao.selectfamilyspeciesBySpecies(species);
    }

}
