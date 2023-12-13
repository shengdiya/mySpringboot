package com.myapp.demo.Service;

import com.myapp.demo.Dao.SpeciesAreaDao;
import com.myapp.demo.Entiy.SpeciesArea;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("speciesAreaService")
public class SpeciesAreaService {

    @Resource(name = "speciesAreaDao")
    SpeciesAreaDao speciesAreaDao;

    public void insertSpeciesArea(SpeciesArea speciesArea){
        speciesAreaDao.insertSpeciesArea(speciesArea);
    }

    public List<SpeciesArea> selectSpeciesArea(int species){
        return speciesAreaDao.selectSpeciesArea(species);
    }

    public SpeciesArea selectArea(int area){
        return speciesAreaDao.selectArea(area);
    }
}
