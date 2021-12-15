package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.domain.Criteria;

public interface MovieDAO {
public List<HashMap<String,Object>> list(Criteria cri);
public int totalCount();
public void insert(String title,String image);
}
