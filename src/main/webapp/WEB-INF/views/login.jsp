<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../resources/bootstrap-datepicker.js"></script>
<link rel="stylesheet" href="../resources/bootstrap-datepicker.css">

<link rel="stylesheet" href="../resources/login.css" />
<style>
*{
  margin: 0px;
  padding: 0px;
  text-decoration: none;
  font-family:sans-serif;

}


.loginForm {
 margin:0 auto;
  width:300px;
  height:400px;
  padding: 30px, 20px;
  background-color:#FFFFFF;
  text-align:center;
 
  border-radius: 15px;
}

.loginForm h2{
  text-align: center;
  margin: 30px;
}

.idForm{
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}

.passForm{
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}

.id {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.pw {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.btn {
  position:relative;
  left:40%;
  transform: translateX(-50%);
  margin-bottom: 40px;
  width:80%;
  height:40px;
  background: linear-gradient(125deg,#81ecec,#6c5ce7,#81ecec);
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}

.btn:hover {
  background-position: right;
}

.bottomText {
  text-align: center;
}
</style>

 <form name="frm" method="post" class="loginForm">
      <h2>Login</h2>
      <div class="idForm">
        <input type="text" class="id" name="uid" placeholder="ID">
      </div>
      <div class="passForm">
        <input type="password" class="pw" name="upass" placeholder="PW">
      </div>
      <button type="submit" class="btn" >
        LOG IN
      </button>
  
      <div class="bottomText">
        Don't you have ID? <a href="#">sign up</a>
      </div>
    </form>
  
<script>

	$(frm).on("submit", function(e){
		e.preventDefault();
		var uid=$(frm.uid).val();
		var upass=$(frm.upass).val();
		var isLogin=$(frm.chkLogin).is(":checked") ? true: false;
		
		if(uid=="" || upass==""){
			alert("아이디와 비밀번호를 입력하세요!");
			return;
		}
		
		$.ajax({
			type: "post",
			url: "/user/login",
			data: {"uid": uid, "upass":upass, "isLogin": isLogin},
			success: function(data){
				if(data==0){
					alert("아이디가 존재하지 않습니다!");
				}else if(data==2){
					alert("비밀번호가 일치하지 않습니다!")
				}else{
					var dest="${dest}";
					if(dest==null || dest=="") dest="/";
					
				location.href=dest;
					
				}
			}
		});
	});
	

</script>
  