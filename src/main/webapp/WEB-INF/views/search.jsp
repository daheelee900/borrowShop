<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>영화검색</h1>


<style>
#movies{
overflow: hidden;
margin:0 auto;
text-align: center;

}
#tbl{
overflow: hidden;
margin:0 auto;
text-align: center;
}
.box{
float:left;
width:170px;
height:290px;
margin:20px;
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
#query {
text-align:center;
   background-image: url("../resources/search.png");
   background-repeat: no-repeat;
   background-size: 20px;
   background-position: 95%;
   height: 50px;
   width: 500px;
   border-radius: 10px;
 
}
</style>
<div>
<input type="text" id="query" value=""/>

<h3 id="total" style="text-align:left;"></h3>
<button id="btnInsert">장바구니담기</button>
</div>
 <table id="tbl" ></table>
 <script id="temp2" type="text/x-handlebars-template">
   {{#each .}}
 <div class="box">


<div><img src="{{image}}" width=150 height=150/>  </div>

<div style="background:black; color:white;width:50px;height:20px;">{{rank}}</div>

<div>{{title}}</div>
<div>{{date}}</div>
<div>3000￦</div>
<div><span>대여하기</span><input type="checkbox" class="chkLent"/>  </div>
</div>
  
   {{/each}}
</script>
 
<div id="movies" ></div>
<script id="temp" type="text/x-handlebars-template">

   {{#each items}}
<div class="box">

<img src="{{image}}" width=150 height=150 >
<div class="title">{{{title}}}</div>
<div class="pubDate">{{{pubDate}}}년</div>
<div>3000￦</div>
<div><span>대여하기</span><input type="checkbox" class="chkLent"/>  </div>

</div>
   {{/each}}
</script>
<!-- 태그가 안나오게 {{{}}}3개해줌 -->
 <div id="pagination" class="pagination"></div>
<script src="/resources/pagination.js"></script> 
<script>
var page=1;
var query=$("#query").val();
var uid="${uid}"
getList2()

function getList2(){
   $.ajax({
      type:"get",
      url: "/cgv.json",
      dataType: "json",
     
      success: function(data){
         var temp=Handlebars.compile($("#temp2").html());
         $("#tbl").html(temp(data));
      }
   });
}

$("#btnInsert").on("click",function(){
	
	if(!confirm('dataSave?'))return;
	
	$("#movies .box .chkLent:checked,#tbl .box .chkLent:checked").each(function(){
		
	
		var image=$(this).parent().parent().find("img").attr("src");
		
		var title=$(this).parent().parent().find(".title").text();
		
		$.ajax({
			type:"post",
			url:"/cart_insert",
			data:{"c_title":title,"c_image":image,"cuid":uid},
			success:function(){
				
				alert('success')
			}
		})
		
	})
	alert("done!")
})
$("#query").on("keypress",function(e){
	if(e.keyCode==13){
		page=1;
		query=$("#query").val();
		if(query==""){
			getList2()
			$('#tbl').css('display','block')
			$('#movies').css('display','none')
		}else{
		getList();
		$('#tbl').css('display','none')
		$('#movies').css('display','block')
		}
	}
})
function getList(){
	var query=$("#query").val();
	$.ajax({
		type:'get',
		url:'/movie/search.json',
		dataType:'json',
		data:{"page":page,"query":query},
		success:function(data1){
			var temp=Handlebars.compile($("#temp").html());
			$("#movies").html(temp(data1));
			 $("#pagination").html(getPagination(data1))
	            $("#total").html("총"+data1.total+"건")
	          
		}
	})
}
$("#pagination").on("click","a",function(e){
	e.preventDefault();
	page=$(this).attr("href")
	getList();
})
</script>