package com.example.mapper;

import java.util.List;

import com.example.domain.ChatVO;

public interface ChatDAO {
	public List<ChatVO> list(String chat_room);
public void chat_insert(ChatVO vo);
public int last_no(String chat_id);
public List<ChatVO> chatList();
}
