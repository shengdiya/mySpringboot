package com.myapp.demo.Service;

import com.myapp.demo.Dao.SpeciesDao;
import com.myapp.demo.Entiy.Species;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("speciesService")
public class SpeciesService {

    @Resource(name = "speciesDao")
    SpeciesDao speciesDao;

    public void insertSpecies(Species species) {
        speciesDao.insertSpecies(species);
    }

    public List<Integer> findPlantIdsByParams(String family, String genus, String species, String alias, String distribution) {
        System.out.println(family+" "+genus+" "+species+" "+alias+" "+distribution);
        return speciesDao.findPlantIdsByParams(family, genus, species, alias, distribution);
    }

//    Species findSpeciesById(int id);
    public Species findSpeciesById(int id) {
        return speciesDao.findSpeciesById(id);
    }

    public Integer findSpeciesIdByName(String speciesName){
        return speciesDao.findSpeciesIdByName(speciesName);
    }
}
