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
#center{
height:700px;
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

.passForm,.passFormchk,.emailForm,.telForm,.nameForm{
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
.pwchk {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
.email {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
.tel {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
.name {
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
      <h2>Join</h2>
      <div class="idForm">
        <input type="text" class="id" name="uid" placeholder="ID">
      </div>
          <input type="button" value="????????????" id="chkid" style="margin-left:5px;"/>
      <div class="passForm">
        <input type="password" class="pw" name="upass" placeholder="PW">
      </div>
      <div class="passFormchk">
        <input type="password" class="pwchk" name="passcheck" placeholder="PW">
      </div>
      <div class="nameForm">
        <input type="text" class="name" name="uname" placeholder="name">
      </div>
      <div class="emailForm">
        <input type="email" class="email" name="uemail" placeholder="email">
      </div>
      <div class="telForm">
        <input type="tel" class="tel" name="tel" placeholder="tel">
      </div>
      <button type="submit" class="btn" >
        LOG IN
      </button>
  
     
    </form>
  
<script>

var chkid = 0;
$("#chkid").on("click",function(){
    var uid=$(frm.uid).val();
    
    if(uid==""){
       alert("???????????? ???????????????");
       return;
    }
    
    $.ajax({
       type:"post",
       url: "/user/chkid",
       data: {"uid": uid},
       success : function(result){ 
         if(result > 0 ){
            alert('?????? ???????????? ??????????????????.');
         } else{
            alert('??????????????? ??????????????????.');
            chkid =1;
         }
       }
    });
});


$(frm).on("submit", function(e){
   var email_rule = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
   var tel_rule =  /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;
   e.preventDefault();

    var uid=$(frm.uid).val();
    var upass=$(frm.upass).val();
    var uname=$(frm.uname).val();
    var tel=$(frm.tel).val();
    var uemail=$(frm.uemail).val();
    var passcheck=$(frm.passcheck).val();

    
    if(uid==""){
       alert("???????????? ???????????????!");
       $(frm.uid).focus();
       return;
    } else if(chkid==0){
       alert("????????? ??????????????? ?????????.");
       return;
    }else if(upass==""){
       $(frm.upass).focus();
       alert("??????????????? ???????????????!");
       return;
    }else if(upass!=passcheck){
       $(frm.passcheck).focus();   
       alert("??????????????? ???????????? ????????????.");
       return;
    }else if(uname==""){
        $(frm.uname).focus();
        alert("????????? ???????????????!");
        return;
    }
    
    else if(uemail==""){
        $(frm.uemail).focus();
        alert("??????????????? ???????????????!");
        return;
    }else if(!(email_rule.test(uemail))){
            alert("???????????? ????????? ?????? ??????????????????.");
          return false;
    }else if(tel==""){
       $(frm.tel).focus();
       alert("??????????????? ???????????????")
       return;
    }else if(!tel_rule.test(tel)){
       alert("?????????????????????'-'??? ??????????????????")
       return false;
    }
    if(!confirm("?????? ????????? ???????????????????")) return;
      
    frm.action="/user/join";
    frm.method="post";
    frm.submit();
    
    //location.href='/user/login'
 });

</script>
  