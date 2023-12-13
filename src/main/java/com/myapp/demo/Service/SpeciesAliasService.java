package com.myapp.demo.Service;

import com.myapp.demo.Dao.SpeciesAliasDao;
import com.myapp.demo.Entiy.SpeciesAlias;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("speciesAliasService")
public class SpeciesAliasService {

    @Resource(name = "speciesAliasDao")
    SpeciesAliasDao speciesAliasDao;

    public void insertSpeciesAlias(SpeciesAlias speciesAlias) {
        speciesAliasDao.insertSpeciesAlias(speciesAlias);
    }

    public List<SpeciesAlias> selectSpeciesAliasByAlias(String alias) {
        return speciesAliasDao.selectSpeciesAliasByAlias(alias);
    }
    public List<SpeciesAlias> selectSpeciesAliasBySpeciesId(int speciesId) {
        return speciesAliasDao.selectSpeciesAliasBySpeciesId(speciesId);
    }

}
