<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
</style>
<div class="subheading">주문이 완료되었습니다.</div>
<button id="paysure">확인</button>
<script>
$('#paysure').on('click',function(){
/* 	 $.ajax({
		   type:'get',
		   url:'/shop/pay.json',
		   dataType:'json',
		   data:{"pay_no":pay_no},
		   success:function(data){
		      //orderSuccess 페이지에 값 넣기
		      $("#pay_no").html(data.pay_no);
		      $("#pay_date").html(data.pay_date);
		      $("#pay_price").html(data.pay_price);
		      if(data.pay_type == 'M'){
		         $("#pay_type").html("KAKAOPAY");
		      }else if(data.pay_type == 'C'){
		         $("#pay_type").html("CARD");
		      }else{
		         $("#pay_type").html("현금결제");
		      }
		      $("#deli_address1").html(data.deli_address1);
		      $("#deli_address2").html(data.deli_address2);
		      $("#deli_tel").html(data.deli_tel);
		      $("#deli_name").html(data.deli_name);
		      
		   }
		 });  */
})

</script>