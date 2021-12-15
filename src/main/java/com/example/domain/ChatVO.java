package com.example.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ChatVO {
	private int chat_no;
	private String chat_id;
	private String chat_msg;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="Asia/Seoul")
	private Date regdate;

	private String chat_room;

	
	public String getChat_room() {
		return chat_room;
	}

	public void setChat_room(String chat_room) {
		this.chat_room = chat_room;
	}

	public int getChat_no() {
		return chat_no;
	}

	public void setChat_no(int chat_no) {
		this.chat_no = chat_no;
	}

	public String getChat_id() {
		return chat_id;
	}

	public void setChat_id(String chat_id) {
		this.chat_id = chat_id;
	}

	public String getChat_msg() {
		return chat_msg;
	}

	public void setChat_msg(String chat_msg) {
		this.chat_msg = chat_msg;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}



	


		
}
