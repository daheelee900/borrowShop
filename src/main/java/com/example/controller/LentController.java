package com.example.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.Criteria;
import com.example.domain.LentVO;
import com.example.domain.OderVO;
import com.example.domain.PageMaker;
import com.example.mapper.LentDAO;
import com.example.mapper.UserDAO;

@Controller
public class LentController {
	@Autowired
	LentDAO ldao;
	@Autowired
	UserDAO udao;
	
	@RequestMapping("/mycart")
	public String cartList(Model model,HttpSession session){
		String uid = (String) session.getAttribute("uid");
		String uname = udao.login(uid).getUname();
		session.setAttribute("uname", uname);
		model.addAttribute("pageName","mypage.jsp");
		model.addAttribute("myPageName","mycart.jsp");
		return "home";
		
		
	}
	@RequestMapping(value="/order_insert", method=RequestMethod.POST)
	@ResponseBody
	public int pay_insert(OderVO ovo, int quantity, String item_name, HttpSession session){
		//System.out.println(pvo);
		//세션에 상품명, 수량 저장
		session.setAttribute("quantity", quantity);
		session.setAttribute("item_name", item_name);
		ldao.order_insert(ovo);
	String pay_uid = ovo.getOuid();
	int order_no = ldao.max_pay_no(pay_uid);
	System.out.println(order_no);
		return order_no;
	}
	@RequestMapping(value = "/orderSuccess", method = RequestMethod.GET)
	public String orderSuccess(Model model) {
		model.addAttribute("pageName", "mypage.jsp");
		model.addAttribute("myPageName", "orderSuccess.jsp");
		return "home";
	}
	
	@RequestMapping("/cartList.json")
	@ResponseBody
	public List<LentVO> movieJSON(String cuid){
		
		return ldao.cart_list(cuid);
	}
	@RequestMapping("/myOrder.json")
	@ResponseBody
	public List<OderVO> order_JSON(String ouid){
		return ldao.orderlist(ouid);
		
		
	}
	@RequestMapping("/orderList.json")
	@ResponseBody
	public List<OderVO> orderJSON(String ouid){
		
		return ldao.order_list(ouid);
	}
	@RequestMapping("/cartPay.json")
	@ResponseBody
	public List<LentVO> cartJSON(String cuid){
		
		return ldao.cart_list2(cuid);
	}
	@RequestMapping(value = "/cart_insert", method = RequestMethod.POST)
	public String cartInsert(String cuid,String c_image,String c_title){
		
		try{
			// imagecopy (cgv server->my tomcat server
		if(c_image!=null&& !c_image.equals(""))	{
		URL url = new URL(c_image);
			InputStream in = url.openStream();
			String path = "c:/zzz/upload";
			String file = "/movie/" + System.currentTimeMillis() + ".jpg";
			OutputStream out = new FileOutputStream(path + file);
			FileCopyUtils.copy(in, out);
			ldao.cart_insert(cuid, c_image, c_title);
			
		}
	}catch(Exception e){
		System.out.println(e.toString());
	}
	
		return"redirect:/";
		
	}
	@RequestMapping(value = "/cart/update", method = RequestMethod.POST)
	public String cartInsert(String cuid,int c_no,Model model){

	ldao.cart_status_update(cuid, c_no);
		return"redirect:/";
		
	}
	@RequestMapping(value = "/cart/delete", method = RequestMethod.POST)
	public String cartDelete(int c_no,Model model){
		
		ldao.cartDelete(c_no);
		return"redirect:/";
		
	}
	@RequestMapping(value = "/pay_cancel", method = RequestMethod.POST)
	public String pay_cancel(int c_no,Model model){
		
		ldao.pay_cancel(c_no);
		return"redirect:/";
		
	}
	@RequestMapping(value = "/paycheck_status", method = RequestMethod.POST)
	public String cartInsert(int c_no,Model model){
		
	ldao.paycheck_status(c_no);
		return"redirect:/";
		
	}
	//카카오페이
		@RequestMapping(value="/kakaoPay", method=RequestMethod.POST)
		@ResponseBody
		public String kakaoPay(String item_name, int quantity, String total_amount ,HttpSession session,int order_no){
			SSLTrust.sslTrustAllCerts();
			session.setAttribute("order_no", order_no);
			try {
				URL url = new URL("https://kapi.kakao.com/v1/payment/ready");
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestProperty("Authorization", "KakaoAK 956ed9671910d705fc2f851a38d250e1");
				conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
				conn.setDoOutput(true);
				
				String param = "cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id";
				param +="&quantity="+quantity;
				param +="&tax_free_amount=0";
				param +="&item_name="+item_name;
				param +="&total_amount="+total_amount;
				param +="&vat_amount=200";
				param +="&approval_url=http://localhost:8088/approval";
				param +="&fail_url=http://localhost:8088";
				param +="&cancel_url=http://localhost:8088";
				
				OutputStream out = conn.getOutputStream();
				DataOutputStream dataout = new DataOutputStream(out);
				//dataout.writeBytes(param);
				dataout.write(param.getBytes("utf-8")); //한글깨짐 방지
				dataout.close(); //flush() 자동 호출
				
				//통신
				int rst = conn.getResponseCode(); //확인
				
				InputStream in;
				if(rst==200){ //성공
					in = conn.getInputStream();
				}else{ //실패
					in = conn.getErrorStream();
				}
				
			
				//데이터 읽어오기
				InputStreamReader reader = new InputStreamReader(in);
				BufferedReader br = new BufferedReader(reader);
				String str =  br.readLine();
				System.out.println(str);
				return str;
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return "null";
		}
		
		//결제 승인
		@RequestMapping(value="/kakaoPayApproval", method=RequestMethod.POST)
		@ResponseBody
		public String kakaoPayApproval(String pg_token,String tid, Model model, HttpSession httpSession) { 
			//String user_id = (String) httpSession.getAttribute("user_id"); 
			//System.out.println("kakaoPaySuccess pg_token : " + pg_token.substring(9)); 
			pg_token = pg_token.substring(9);
			SSLTrust.sslTrustAllCerts();
			try {
				URL url = new URL("https://kapi.kakao.com/v1/payment/approve");
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestProperty("Authorization", "KakaoAK 956ed9671910d705fc2f851a38d250e1");
				conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
				conn.setDoOutput(true);
				
				String param = "cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id";
				param +="&tid="+tid;
				param +="&pg_token="+pg_token;
				
				OutputStream out = conn.getOutputStream();
				DataOutputStream dataout = new DataOutputStream(out);
				dataout.writeBytes(param);
				dataout.close(); //flush() 자동 호출
				
				//통신
				int rst = conn.getResponseCode(); //확인
				System.out.println(rst);
				InputStream in;
				if(rst==200){ //성공
					in = conn.getInputStream();
				}else{ //실패
					in = conn.getErrorStream();
				}

				InputStreamReader reader = new InputStreamReader(in,"UTF-8"); //한글깨짐 방지

				BufferedReader br = new BufferedReader(reader);
				String str =  br.readLine();
				System.out.println(str);
				return str;
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return null;
			
		}

		//결제 완료
		@RequestMapping(value="/shop/kakaoSuccess", method=RequestMethod.POST)
		@ResponseBody
		public void kakaoPaySuccess(String order_date,HttpSession session) { 

			StringBuilder st_pay_date = new StringBuilder(order_date);
	//st_pay_date.setCharAt(10, ' '); //10번째 문자 T대신 공백으로 대체
			order_date = st_pay_date.toString();
			 
//			pay_type = pay_type.substring(0,1);
//			System.out.println("pay_type: "+ pay_type);
		
			int order_no = (int) session.getAttribute("order_no"); //세션에서 불러오기
		  OderVO ovo=new OderVO();
		  ovo.setOrder_date(order_date);
		  ovo.setPay_status(2);
			ovo.setOrder_no(order_no);
			ldao.order_update(ovo);//tbl_shop_payment update
			System.out.println("hi");

		}
		@RequestMapping(value = "/approval", method = RequestMethod.GET)
		public String approval() {	
			return "approval";
		}
		
}
