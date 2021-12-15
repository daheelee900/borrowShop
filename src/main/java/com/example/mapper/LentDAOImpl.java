package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.LentVO;
import com.example.domain.OderVO;
@Repository
public class LentDAOImpl implements LentDAO{
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.LentMapper";
	@Override
	public void cart_insert(String cuid, String c_image, String c_title) {
		  HashMap<String,Object> map=new HashMap<>();
		  map.put("c_title",c_title);
		  map.put("c_image", c_image);
		  map.put("cuid", cuid);
		  session.insert(namespace+".cart_insert",map);
		
	}
	@Override
	public List<LentVO> cart_list(String cuid) {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".list",cuid);
	}
	@Override
	public void cart_status_update(String cuid, int c_no) {
		 HashMap<String,Object> map=new HashMap<>();
		
		  map.put("c_no", c_no);
		  map.put("cuid", cuid);
		  session.insert(namespace+".cart_update",map);
		
	}
	@Override
	public List<LentVO> cart_list2(String cuid) {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".cart_list",cuid);
	}
	@Override
	public void paycheck_status(int c_no) {
		// TODO Auto-generated method stub
		session.insert(namespace+".paycheck_status",c_no);
		
	}
	@Override
	public void order_insert(OderVO ovo) {
		session.insert(namespace+".order_insert",ovo);
	}
	@Override
	public int max_pay_no(String ouid) {
		return session.selectOne(namespace+".max_pay_no",ouid);
	}
	@Override
	public void order_update(OderVO ovo) {
	session.update(namespace+".order_update",ovo);
		
	}
	@Override
	public List<OderVO> order_list(String ouid) {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".order_list",ouid);
	}
	@Override
	public void pay_cancel(int c_no) {
		session.update(namespace+".pay_cancel",c_no);
		
	}
	@Override
	public void cartDelete(int c_no) {
session.delete(namespace+".delete",c_no);		
	}
	@Override
	public List<OderVO> orderlist(String ouid) {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".orderlist",ouid);
	}


}
