package com.example.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UploadController {
  @Resource(name="uploadPath")
  private String path;
  
  
  @RequestMapping("/uploadForm")
  public void uploadForm(){
	  
  }
	@RequestMapping(value="/uploadForm",method=RequestMethod.POST)
	public void FormPost(MultipartFile file) throws Exception{
		System.out.println("filesize"+file.getSize());
		System.out.println("filetype"+file.getContentType());
		System.out.println("filename"+file.getOriginalFilename());
		
		UUID uid=UUID.randomUUID();
		String saveName=uid.toString()+"_"+file.getOriginalFilename();
		File target=new File(path,saveName);
		FileCopyUtils.copy(file.getBytes(), target);
	}
	 @RequestMapping("/uploadAjax")
	  public void uploadAjax(){
		  
	  }
	 //upload
	 @RequestMapping(value="/uploadFile",method=RequestMethod.POST,produces="text/plain;charset=UTF-8")
	 @ResponseBody
		public String AjaxPost(MultipartFile file) throws Exception{
			System.out.println("filesize"+file.getSize());
			System.out.println("filetype"+file.getContentType());
			System.out.println("filename"+file.getOriginalFilename());
			
			UUID uid=UUID.randomUUID();
			String saveName=uid.toString()+"_"+file.getOriginalFilename();
			File target=new File(path,saveName);
			FileCopyUtils.copy(file.getBytes(), target);
			return saveName;
		}
	 
	 //delete file
	 @RequestMapping(value="/deleteFile", method=RequestMethod.POST)
	 @ResponseBody
	 public void deleteFile(String fileName){
		 new File(path+"/"+fileName).delete();
	 }
	  //이미지파일 보기
		 @ResponseBody
		 @RequestMapping("/displayFile")
		 public byte[] display(String fullName) throws Exception{
			 FileInputStream in =new FileInputStream(path+"/"+fullName);
			 byte[] image=IOUtils.toByteArray(in);
			 in.close();
			return image;
			 
		 }
  
}
