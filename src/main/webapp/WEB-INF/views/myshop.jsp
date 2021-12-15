<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 모달창 -->
<style>
    #my_modal {
        display: none;
        width: 700px;
        height:450px;
        padding: 20px 60px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 20px;
    }
    #my_modal .modal_close_btn {
        position: absolute;
        top: 10px;
        right: 10px;
    }
    .orderbox{width:880px;}
</style>

<!-- 별점 리뷰 등록 / 이동예정 -->
<style>
	#prod_rstar fieldset{
	    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
	    border: 0; /* 필드셋 테두리 제거 */
	}
	#prod_rstar input[type=radio]{
	    display: none; /* 라디오박스 감춤 */
	}
	#prod_rstar label{
	    font-size: 3em; /* 이모지 크기 */
	    color: transparent; /* 기존 이모지 컬러 제거 */
	    text-shadow: 0 0 0 #f0f0f0; /* 새 이모지 색상 부여 */
	}
	#prod_rstar label:hover{
  	  text-shadow: 0 0 0 DeepPink; /* 마우스 호버 */
	}
	#prod_rstar label:hover ~ label{
 	   text-shadow: 0 0 0 DeepPink; /* 마우스 호버 뒤에오는 이모지들 */
	}
	#prod_rstar{
	    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
	    direction: rtl; /* 이모지 순서 반전 */
	    border: 0; /* 필드셋 테두리 제거 */
	}
	#prod_rstar{
    	text-align: left;
	}
	#prod_rstar input[type=radio]:checked ~ label{
    	text-shadow: 0 0 0 DeepPink; /* 마우스 클릭 체크 */
	}
</style>

<style>
.subheading{
   text-align:left;
   font-size:150%;
   margin:20px;
   font-weight:bold;
}

#condition {
	position: relative;
	height: 50px;
}

#condition input[type=text] {
	position: absolute;
	left: 0%;
}

.fa-search {
	color: #c2c2c3;
	position: absolute;
	left: 55%;
	top: 15px;
}

.container {
	width: 100%;
	text-align: left;
}

.container h1 {
	text-align: left;
	margin-left: 20px;
	margin-bottom: 20px;
}

ul.tabs {
	margin: 0px;
	padding: 0px;
}

ul.tabs li {
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current{
	border-bottom: 1px solid black;
	color: #222;
}

.tab-content{
	display: none;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}
</style>

<div class="container">
	<div class="subheading">주문내역</div>
	

<div id="tbl" >
 
 </div>
 
 <script id="temp2" type="text/x-handlebars-template">
   {{#each .}}
 <div class="box" style="height:240px;margin:5px;">


<div>{{order_date}} </div>

<div>{{item_name}}</div>
<div>{{quantity}}</div>
<div>{{pay_price}}</div>
<p>*모든 자료는 이메일로 발송해드렸습니다!</p>


</div>
  
   {{/each}}
</script>
</div>


<script>
var uid="${uid}"
$.ajax({
	type:'post',
	url: '/myOrder.json',
	data:{"ouid":uid},
	success:function(data){
		  var temp=Handlebars.compile($("#temp2").html());
		  $("#tbl").html(temp(data));
	}
});

</script>