<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>영화 목록</h1>
<style>
#movies{
overflow:hidden;
width:850px;
margin:0 auto;

}
.box{
float:left;
width:150px;
margin:10px 5px;
height:200px;


}
.box .title{

width:120px;
background: white;
color:black;
text-align:center;
}
</style>
<h3 id="total"></h3>
<div id="movies" ></div>
<script id="temp" type="text/x-handlebars-template">

   {{#each list}}
<div class="box">
<div class="image">
<img src="/display?file={{image}}" width=100 >
</div>
<div class="title">{{title}}</div>
</div>
   {{/each}}
</script>
<div id="pagination" class="pagination"></div>
<script src="/resources/pagination.js"></script>
<script>
var page=1;
getList()
function getList(){
	$.ajax({
		
		type:'get',
		url:'/movie.json',
		dataType:'json',
		data:{"page":page},
		success:function(data){
			var temp=Handlebars.compile($("#temp").html());
			$("#movies").html(temp(data));
			 $("#pagination").html(getPagination(data))
	            $("#total").html("총"+data.pm.totalCount+"건")
		}
	})
}
$("#pagination").on("click","a",function(e){
	e.preventDefault();
	page=$(this).attr("href")
	getList();
})
</script>