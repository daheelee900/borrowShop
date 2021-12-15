package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class CrawlingController {
	@RequestMapping("/cgv.json")
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
}
