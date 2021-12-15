package com.example.controller;

import java.net.URLEncoder;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.Criteria;
import com.example.domain.KakaoAPI;
import com.example.domain.PageMaker;

@Controller
public class LocalController {
@RequestMapping("/local/search")
public String localSearch(Model model){
	model.addAttribute("pageName","lsearch.jsp");
	return "home";
}
	
	@RequestMapping("/local.json")
	@ResponseBody
	public JSONObject localJSON(String query,int page){
		JSONObject object=new JSONObject();
		try{
		  String text = URLEncoder.encode(query, "UTF-8");
		String url="https://dapi.kakao.com/v2/local/search/keyword.json?";
		url+="query="+text+"&page="+page+"&size=10";
		String result=KakaoAPI.search(url);
	
			JSONParser parser = new JSONParser();
			 object=(JSONObject)parser.parse(result);
		      Criteria cri=new Criteria();
		      cri.setPage(page);
		      object.put("cri", cri);
		      PageMaker pm=new PageMaker();
		      pm.setCri(cri);
		      JSONObject obj=(JSONObject)object.get("meta");
		      String total=obj.get("total_count").toString();
		      pm.setTotalCount(Integer.parseInt(total));
		      object.put("pm", pm);
		}catch(Exception e){
			System.out.println(e.toString());
		}
		
		return object;
		
	}
	
}
