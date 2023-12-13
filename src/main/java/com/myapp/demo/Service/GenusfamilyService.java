package com.myapp.demo.Service;

import com.myapp.demo.Dao.GenusfamilyDao;
import com.myapp.demo.Entiy.Genusfamily;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("genusfamilyService")
public class GenusfamilyService {

    @Resource(name = "genusfamilyDao")
    GenusfamilyDao genusfamilyDao;

    public void insertGenusfamily(Genusfamily genusfamily) {
        genusfamilyDao.insertGenusfamily(genusfamily);
    }

    public Genusfamily selectGenusfamily(String family) {
        return genusfamilyDao.selectGenusfamily(family);
    }
}
