package com.myapp.demo.Dao;

import com.myapp.demo.Entiy.Genusfamily;

public interface GenusfamilyDao {
    public void insertGenusfamily(Genusfamily genusfamily);

    public Genusfamily selectGenusfamily(String family);
}
