package com.example.controller;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.NoticeVO;
import com.example.mapper.NoticeDAO;


@Controller
public class HomeController {
	 @Resource(name="uploadPath")
	  private String path;
	 @Autowired
	 NoticeDAO dao;
	 
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
model.addAttribute("pageName","about.jsp");		
		return "home";
	}	
	
	
	@RequestMapping("/cgvSlide.json")
	@ResponseBody
	  public List<HashMap<String,Object>> cgv(){
		  List<HashMap<String,Object>> array=new ArrayList<HashMap<String,Object>>();
		  try{
			  Document doc=Jsoup.connect("http://www.cgv.co.kr/movies/").get();
		 Elements elements=doc.select(".sect-movie-chart ol");
		 //System.out.println(elements);
		 for(Element e:elements.select("li")){
			 HashMap<String, Object> map=new HashMap<String,Object>();
			 String rank=e.select(".rank").text();
			 String title=e.select(".title").text();
			 String date=e.select(".txt-info strong").text();
			 String image=e.select("img").attr("src");
			 if(!rank.equals("")){
			 map.put("rank", rank);
			 map.put("title", title);
			 map.put("date", date);
			 map.put("image", image);
			 array.add(map);
			//System.out.println(rank);
			 }
		 }
		  
		  }catch(Exception e){
			  System.out.println(e.toString());
		  }
		  
		return array;
		  
	  }
	@RequestMapping("/notice.json")
	@ResponseBody
	public List<NoticeVO> noticeList(){
		return dao.noticeList();
		
	}
	 //�̹������� ����
	 @ResponseBody
	 @RequestMapping("/display")
	 public byte[] display(String file) throws Exception{
		 FileInputStream in =new FileInputStream(path+"/"+file);
		 byte[] image=IOUtils.toByteArray(in);
		 in.close();
		return image;
		 
	 }
	
}
