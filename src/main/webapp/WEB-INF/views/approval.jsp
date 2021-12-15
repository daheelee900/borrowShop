<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>결제 승인</title>
<style>
	@font-face {
    font-family: 'IBMPlexSansKR-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-07@1.0/IBMPlexSansKR-Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

body{
 font-family: 'IBMPlexSansKR-Regular';
 text-align:center;
 margin-top:130px;
}

.blackBtn{
	font-size:85%;
	padding:8px 26px;
	background-color:black;
	color:white;
	border:none;
	margin-top:25px;
}

</style>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>

</head>
<body>
		<% 
			String pg_token = request.getQueryString().toString();
			request.setAttribute("pg_token", pg_token);
		%>		
		<h3>결제가 진행중입니다.</h3>


		
	<script>
	//부모창 url 변경
		opener.location.href  = '/orderSuccess';
	var pg_token = "${pg_token}";
	var tid = localStorage.getItem("tid"); //mycart.jsp에서 세션에 저장한 tid 가져오기
	
	
	
		$.ajax({
			type:'post',
			url:'/kakaoPayApproval',
			data:{"pg_token":pg_token, "tid":tid},
			dataType:'json',
			success:function(data){
				alert(data.created_at)
				 var created_at = data.created_at;
				$.ajax({
					type:'post',
					url:'/shop/kakaoSuccess',
					data:{"order_date":created_at},
					success:function(){
					 alert('yay')
					} 
				});
			

				self.close(); //팝업창 닫기 */
	
			}
		});
	
</script>
</body>

</html>