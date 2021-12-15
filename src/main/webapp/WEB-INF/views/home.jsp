<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Jua&display=swap" rel="stylesheet">
  <style>
  
  #doc a{
  margin-left:50px;
  font-family: 'Jua', sans-serif;
  font-size:20px;
	text-decoration: none;
	color:gray;
  }
  #identify,#identify2{
  float:right;



  }
  #identify2{
padding-right:30px;
  }
   #identify a,#identify2 a{
display:block;
float:left;

  margin-left:10px;
  font-family: 'Jua', sans-serif;
  font-size:18px;
	text-decoration: none;
	color:gray;

  }
  #identify span{
  display:block;
float:left;
font-family: 'Jua', sans-serif;
  margin-left:5px;
  }
    #logout{
  float:right;
   margin-right:50px;
  
  }
  
 
  </style>  
<html>
<head>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script> 
	<title>빌려줄껭!</title>
	<link rel="stylesheet" href="/resources/home.css"/>
</head>
<body>
<div id="page">

<div id="header">
<a href="/"><img src="/resources/book.jpg" width=960 height=200/></a>
<c:if test="${pageName != 'login.jsp'}">
<div id="menu">
<div id="doc">

<a href="/book/search">도서검색</a>
<a href="/movie/search">영화검색</a>
<a href="/local/search">local검색</a>

 <c:if test="${uid==null}">
 <div id="identify2">
 <a href="/user/login" id="login"><span class='glyphicon glyphicon-share-alt'></span>LOGIN</a>
 <a href="/user/join" id="join"><span class='glyphicon glyphicon-share-alt'></span>JOIN</a>
 </div>
</c:if>


<c:if test="${uid!=null}">
<div id="identify">

<a href="/mypage" id="mypage_name" style="font-family: 'Black Han Sans', sans-serif;">${uid}</a><span>님 어서오세요!</span>
<span>|</span>
 <a href="/mycart" id="cart"><span class='glyphicon glyphicon-share-alt'></span>장바구니</a>
 <span>|</span>
 <a href="/user/logout" id="logout"><span class='glyphicon glyphicon-share-alt'></span>LOGOUT</a>
</div>
</c:if>
</div>


</div>
</c:if>
</div>

<div id="center">


<div id="content">
<jsp:include page="${pageName}"></jsp:include>
</div>
</div>

<div id="footer">

<h3>Copyright Dahee All Rights Reserved </h3>
</div>


</div>
</body>
</html>
