package com.example.mapper;

import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.UserVO;

public interface UserDAO {
	public UserVO login(String uid);
	public void insert(UserVO vo);
	public void update(UserVO vo);
}
