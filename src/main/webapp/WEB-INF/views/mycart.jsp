<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>



<style>

#tbl{
overflow: hidden;
margin:0 auto;
text-align: center;
}
.box{
float:left;
width:170px;
height:290px;

padding:10px;
text-align:left;
border:1px dotted gray;

}
.box div{
margin-top:5px;
}
.box .title{

width:120px;
background: white;
color:black;
text-align:center;
}
#my_modal {
width:700px;
height:450px;
   display: none;
  overflow:scroll;

   padding: 20px 60px;
   background-color: #fefefe;
   border: 1px solid #888;
   border-radius: 20px;

}
#my_modal::-webkit-scrollbar{ display:none; }


#my_modal .modal_close_btn {
   position: absolute;
   top: 10px;
   right: 10px;
}
#paycheck{


text-align: center;
margin-bottom:20px;
height:30px;
margin-top:30px;

}
#pay,#cancel{
text-align:center;
float:left;
width:150px;
padding: 10px;

}
#cartbtn button{
width:150px;
}
</style>
<div>



</div>
 <div id="tbl" >
 
 </div>
 
 <script id="temp2" type="text/x-handlebars-template">
   {{#each .}}
 <div class="box" style="height:240px;margin:5px;">


<div><img src="{{c_image}}" width=150 height=150/>  </div>

<div>{{c_title}}</div>


<div>3000￦</div>
<div style="background:green;color:white;padding:5px;">선택하기<input type="checkbox" class="chkLent2" /><input type="hidden" value="{{c_no}}" class="c_no"/></div>
</div>
  
   {{/each}}
</script>
<div id="cartbtn">
<button id="btnInsert" style="display:none;margin-left:30px;float:left;">결제창으로</button>
<button id="btnDelete" style="display:none;margin-left:30px;">장바구니삭제</button>
</div>
 <!-- 캠핑장 리뷰 모달창 부분 시작 -->
<div id="my_modal">
   <h2>  결제하기</h2>
 <div id="order_amount" style="display:none;"></div>
 <div id="cartList" style="overflow: hidden;" >
 
 </div>
 
 <script id="temp3" type="text/x-handlebars-template">
   {{#each .}}
 <div class="box"style="height:240px; margin:20px;">


<div><img src="{{c_image}}" width=150 height=150/>  </div>

<div class="title">{{c_title}}</div>



<div>3000￦</div>
<div style="background:green;color:white;padding:5px;">선택하기<input type="checkbox" class="chkLent2" />
<input type="hidden" value="{{order_no}}" class="order_no"/>
<input type="hidden" value="{{c_no}}" class="c_no"/></div>
</div>
  
   {{/each}}
</script>
<div  id="paycheck">
       
         <input type="button" id="pay"value="결제하기" />
         <input type="button" id="cancel" value="삭제하기" />
   </div>
   <a class="modal_close_btn">닫기</a>
</div>
<!-- 캠핑장 모달창 부분 끝 -->

<!-- 태그가 안나오게 {{{}}}3개해줌 -->
 <div id="pagination" class="pagination"></div>
<script src="/resources/pagination.js"></script> 
<script>
var page=1;
var query=$("#query").val();
var uid="${uid}"
getList2()
	function pay_cart() {
	$.ajax({
					      type:'get',
					      url: "/cartPay.json",
					      dataType:"json",
					      data:{"cuid":uid},
					      success: function(data){
					    	  var temp=Handlebars.compile($("#temp3").html());
					      	var arr=new Array();
					    	  if(Object.keys(data).length!=0){
					          $("#cartList").html(temp(data));
					        $('#cartList .box').each(function(){
					      	  arr.push('hi')
					        })
				
					          $('#pay').css('display','block')
					      }else{
					    	  var str="<h2>결제할 것이 없네요!</h2>"
					    		  $("#cartList").html(str);
					    	  $('#pay').css('display','none')
					      }
					           $('#pay').val(arr.length*3000+"원 결제하기") 
					      $('#order_amount').html(arr.length*3000)
					      }  
					   }); 
	}
	
	$('#btnDelete').on('click',function(){
		$('#tbl .box .chkLent2:checked').each(function(){
			var c_no=$(this).parent().find('.c_no').val()
			  $.ajax({
			      type:'post',
			      url: "/cart/delete",
			     
			      data:{"c_no":c_no},
			      success: function(data){
			    	 alert('삭제되었습니다!')
			    	 getList2()
			      }
			   });
			
		})
	})
$('#cancel').on('click',function(){
	$('#cartList .box .chkLent2:checked').each(function(){
	
		var c_no=$(this).parent().find('.c_no').val();
		
	$.ajax({
		  type:"post",
	      url: "/pay_cancel",
	      
	      data:{"c_no":c_no},
	      success: function(data){
	    	  pay_cart()
	     
	    	
	      }
		
	
		})
	 alert('삭제되었습니다.')
		})
	
})
document.getElementById('btnInsert').addEventListener('click',
		function() {
	
	$('#tbl .box .chkLent2:checked').each(function(){
		
		var c_no=$(this).parent().find('.c_no').val()
	
		
		  $.ajax({
			      type:'post',
			      url: "/cart/update",
			     
			      data:{"cuid":uid,"c_no":c_no},
			      success: function(data){
			    	 
			      }
			   }); 
		
	})
	pay_cart();

  
	// 모달창 띄우기
			modal('my_modal');
		
		});
		
		
$('#pay').on('click',function(){
		
		
	$('#cartList .box .c_no').each(function(){
		var c_no=$(this).val();
		
	  $.ajax({
	      type:"post",
	      url: "/paycheck_status",
	      
	      data:{"c_no":c_no},
	      success: function(data){
	     
	        
	      }
	   }); 
	})
 var pay_price=$('#order_amount').html()
 var quantity=pay_price/3000
	  $.ajax({
	      type:"post",
	      url: "/order_insert",
	     
	      data:{"quantity":quantity,"pay_price":pay_price,"ouid":uid,"order_date":'2021-12-03',"item_name":"대여료","pay_status":1},
	      success: function(data){
	    	  var order_no=data
	    	  
	    		$.ajax({
	    			type:'post',
	    			url:'/kakaoPay',
	    			dataType:'json',
	    			data:{"item_name":"대여료", "total_amount":pay_price,"quantity":quantity,"order_no":order_no},
	    			success:function(data){
	    				localStorage.setItem("tid",data.tid); //세션에 tid 저장
	    				var box = data.next_redirect_pc_url;
	    				window.open(box,'kakaoPay','width=500,height=600,top=80,left=1100');
	    				
	    			}
	    		});
	        
	      }
	   }); 

})

   $("#tab-2 .modal_close_btn").on("click", function(){
      modal('my_modal');
   });
// Element 에 style 한번에 오브젝트로 설정하는 함수 추가
   Element.prototype.setStyle = function(styles) {
   	for ( var k in styles)
   		this.style[k] = styles[k];
   	return this;
   };

//모달창
function modal(id) {
	var zIndex = 9999;
	var modal = document.getElementById(id);

	// 모달 div 뒤에 희끄무레한 레이어
	var bg = document.createElement('div');
	bg.setStyle({
		position : 'fixed',
		zIndex : zIndex,
		left : '0px',
		top : '0px',
		width : '100%',
		height : '100%',
		overflow : 'auto',
		// 레이어 색갈은 여기서 바꾸면 됨
		backgroundColor : 'rgba(0,0,0,0.4)'
	});
	document.body.append(bg);

	// 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
	modal.querySelector('.modal_close_btn').addEventListener('click',
			function() {
				bg.remove();
				modal.style.display = 'none';
			});

	modal.setStyle({
				position : 'fixed',
				display : 'block',
				boxShadow : '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

				// 시꺼먼 레이어 보다 한칸 위에 보이기
				zIndex : zIndex + 1,

				// div center 정렬
				top : '50%',
				left : '50%',
				transform : 'translate(-50%, -50%)',
				msTransform : 'translate(-50%, -50%)',
				webkitTransform : 'translate(-50%, -50%)'
			});
}

function getList2(){
   $.ajax({
      type:"get",
      url: "/cartList.json",
      dataType: "json",
      data:{"cuid":uid},
      success: function(data){
    	  
         var temp=Handlebars.compile($("#temp2").html());
         if(Object.keys(data).length!=0){
         $("#tbl").html(temp(data));
         $('#btnInsert').css('display','block')
         $('#btnDelete').css('display','block')
         }else{
        	 var str='<div style="font-size:25px;position:absolute;top:70%;left:45%;">장바구니가 비웠습니다!</div>'
        		 $("#tbl").html(str);
         }
      }
   });
}







</script>