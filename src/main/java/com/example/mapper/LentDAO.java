package com.example.mapper;

import java.util.List;

import com.example.domain.LentVO;
import com.example.domain.OderVO;

public interface LentDAO {
	public void cart_insert(String cuid,String c_image,String c_title);
	public List<LentVO> cart_list(String cuid);
	public List<OderVO> order_list(String ouid);
	public void cart_status_update(String cuid,int c_no);
	public void paycheck_status(int c_no);
	public List<LentVO> cart_list2(String cuid);
	public void order_insert(OderVO ovo);
	public int max_pay_no(String ouid);
	public void order_update(OderVO ovo);
	public void pay_cancel(int c_no);
	public void cartDelete(int c_no);
	public List<OderVO> orderlist(String ouid);
}
