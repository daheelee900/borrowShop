package com.example.controller;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.ChatVO;
import com.example.domain.UserVO;
import com.example.mapper.ChatDAO;
import com.example.mapper.UserDAO;

@Controller
public class MyPageController {

	@Autowired
	UserDAO udao;
	@Autowired
	ChatDAO cdao;
	@RequestMapping(value = "/myinfo/update", method = RequestMethod.POST)
	public String myinfoUpdate(UserVO vo, HttpSession session) {
		udao.update(vo);
		session.setAttribute("uid", vo.getUid());
		return "redirect:/mypage";
	}

	@RequestMapping(value = "/beforeMyinfo", method = RequestMethod.GET)
	public String beforeMyinfo(Model model) {
		model.addAttribute("pageName", "mypage.jsp");
		model.addAttribute("myPageName", "beforeMyinfo.jsp");
		return "home";
	}
	@RequestMapping(value = "/checkMyinfo", method = RequestMethod.POST)
	@ResponseBody
	public int checkMyinfo(String upass, HttpSession session) {
		String uid = (String) session.getAttribute("uid");
		UserVO vo = udao.login(uid);
		if (vo.getUpass().equals(upass)) {
			return 1;
		} else {
			return 0;
		}
	}
	@RequestMapping(value = "/myinfo", method = RequestMethod.GET)
	public String myinfo(Model model, HttpSession session) {
		String uid = (String) session.getAttribute("uid");
		UserVO vo = udao.login(uid);
		model.addAttribute("vo", vo);
		model.addAttribute("pageName", "mypage.jsp");
		model.addAttribute("myPageName", "myinfo.jsp");
		return "home";
	}
	@RequestMapping(value = "/myshop", method = RequestMethod.GET)
	public String myshop(Model model, HttpSession session) {
		String uid = (String) session.getAttribute("uid");
		UserVO vo = udao.login(uid);
		model.addAttribute("vo", vo);
		model.addAttribute("pageName", "mypage.jsp");
		model.addAttribute("myPageName", "myshop.jsp");
		return "home";
	}
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String mypage(Model model, HttpSession session) {
		/*String uid = (String) session.getAttribute("uid");
		String uname = udao.login(uid).getUname();*/
		String uid = (String) session.getAttribute("uid");
		String uname = udao.login(uid).getUname();
		// 현재 날짜 구하기 (시스템 시계, 시스템 타임존)
		LocalDate now = LocalDate.now(ZoneId.of("Asia/Seoul"));
		
	session.setAttribute("uname", uname);
//		model.addAttribute("campReserNextList", campDAO.campReservationUserNext(uid));
//		model.addAttribute("campReserPrevList", campDAO.campReservationUserPrev(uid));
//		model.addAttribute("campReserCancelList", campDAO.campReservationUserCancel(uid,"0"));
//		model.addAttribute("now", now);
	model.addAttribute("pageName", "mypage.jsp");
//		model.addAttribute("myPageName", "mycamping.jsp");
		return "home";
	}
	@RequestMapping("/chat")
	public String chat(Model model, String chat_id) {
		model.addAttribute("chat_room", chat_id);
		return "/chat";
	}

	// ä�õ����� ��������
	@RequestMapping(value = "/chat.json", method = RequestMethod.GET)
	@ResponseBody
	public List<ChatVO> list(String chat_room) {
		System.out.println(chat_room);
		
		return cdao.list(chat_room);
	}

	// ä�� �Է�
	@RequestMapping(value = "/chat/insert", method = RequestMethod.POST)
	@ResponseBody
	public int ChatInsert(ChatVO vo) {
		cdao.chat_insert(vo);;
		int lastNo = cdao.last_no(vo.getChat_id());
		return lastNo;
	}

	// ä�� ����
//	@RequestMapping(value = "/chat/delete", method = RequestMethod.POST)
//	@ResponseBody
//	public void delete(int chat_no) {
//		cdao.delete(chat_no);
//	}

//	@RequestMapping(value = "/chatList.json", method = RequestMethod.GET)
//	@ResponseBody
//	public List<ChatVO> chatList() {
//		return cdao.chatList();
//	}
}
