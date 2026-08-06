package com.hotel.dao;

import java.util.List;

public interface BaseDAO<T> {

    List<T> getAll();

    T getById(int id);

    boolean insert(T obj);

    boolean update(T obj);

    boolean delete(int id);

}