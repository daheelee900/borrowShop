package com.example.controller;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.HashMap;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.Criteria;
import com.example.domain.NaverAPI;
import com.example.domain.PageMaker;
import com.example.mapper.MovieDAO;

@Controller
public class MovieController {
	@Autowired
	MovieDAO dao;
	
@RequestMapping("/movie/list")
public String movieList(Model model){
	model.addAttribute("pageName","mlist.jsp");
	return "home";
	
	
}
@RequestMapping("/movie/search")
public String movieSearch(Model model){
	model.addAttribute("pageName","search.jsp");
	return "home";
	
	
}
@RequestMapping("/movie/search.json")
@ResponseBody
public JSONObject movieSearchJSON(Model model, String query, int page){
   String url="https://openapi.naver.com/v1/search/movie.json";
   String result=NaverAPI.search(url, query, page);
   
   JSONParser parser = new JSONParser();
   JSONObject object = null;
   try {
      object=(JSONObject)parser.parse(result);
      Criteria cri=new Criteria();
      cri.setPage(page);
      object.put("cri", cri);
      PageMaker pm=new PageMaker();
      pm.setCri(cri);
      String total=object.get("total").toString();
      pm.setTotalCount(Integer.parseInt(total));
      object.put("pm", pm);
   } catch (Exception e) {
      System.out.println("¿À·ù:" + e.toString());
   }
   return object;
}
@RequestMapping("/movie.json")
@ResponseBody
public HashMap<String, Object> movieJSON(Criteria cri){
	HashMap<String,Object> map=new HashMap<String,Object>();
	map.put("list", dao.list(cri));
	cri.setPerPageNum(12);
	map.put("cri", cri);
	PageMaker pm=new PageMaker();
	pm.setCri(cri);
	pm.setTotalCount(dao.totalCount());
	map.put("pm", pm);
	return map;
}
@RequestMapping(value="/movie/insert",method=RequestMethod.POST)
@ResponseBody
public void movieInsert(String title,String image){
	try{
			// imagecopy (cgv server->my tomcat server
		if(image!=null&& !image.equals(""))	{
		URL url = new URL(image);
			InputStream in = url.openStream();
			String path = "c:/zzz/upload";
			String file = "/movie/" + System.currentTimeMillis() + ".jpg";
			OutputStream out = new FileOutputStream(path + file);
			FileCopyUtils.copy(in, out);
			dao.insert(title, file);
		}
	}catch(Exception e){
		System.out.println(e.toString());
	}
	
	
}
}
