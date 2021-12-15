<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cf78a2922a055a85430f706c6ae132f3"></script>
<style>
#locals{
width:100%;
}
.localbtn{
float:right;
}
.row{

border-bottom:1px solid black;
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
<h1>지역검색</h1>    
<div>
   <input type="text" id="query" value="KFC"/>
  
   <h3 id="total" style="text-align:left;"></h3>
</div>
<hr/>
<table id="locals" style="margin-bottom:10px;"></table>
<script id="temp" type="text/x-handlebars-template">
   {{#each documents}}
   <tr class="row">
      <td class="name" width=200>{{{place_name}}}</td>
      <td class="address" width=380>{{{address_name}}}</td>
      <td class="phone" width=150>{{{phone}}}</td>
      <td class="localbtn"><button x="{{x}}" y="{{y}}">위치보기</button></td>
   </tr>
   {{/each}}
</script>
<div id="pagination" class="pagination"></div>
<script src="/resources/pagination.js"></script>
<div id="map" style="width:880px;height:400px;margin-top:20px;"></div>
<script>
   var page=1;
   getList();
   
   var x=126.570667 
   var y=33.450701;
   printMap();
   
   $("#locals").on("click", ".row button", function(){
      x=$(this).attr("x");
      y=$(this).attr("y");
      
      var row=$(this).parent().parent();
      var name=row.find(".name").html();
      var phone=row.find(".phone").html();
      printMap(name, phone);
   });
   
   function printMap(name, phone){
      var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
      var options = { //지도를 생성할 때 필요한 기본 옵션
         center: new kakao.maps.LatLng(y, x), //지도의 중심좌표.
         level: 3 //지도의 레벨(확대, 축소 정도)
      };
      var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
      
      var marker= new kakao.maps.Marker({ position: new kakao.maps.LatLng(y, x) });
      marker.setMap(map);
      
      var str ="<div style='padding:5px;font-size:12px;font-weight:bold;color:red'>";
      str += phone + "<br>" + name;
      str +="</div>";
      var info=new kakao.maps.InfoWindow({ content:str });
      kakao.maps.event.addListener(marker, "mouseover", function(){ info.open(map, marker); });
      kakao.maps.event.addListener(marker, "mouseout", function(){ info.close(map, marker); });
   }
   
   $("#btnInsert").on("click", function(){
      if(!confirm("데이터를 저장하실래요?")) return;
      
      $("#movies .box").each(function(){
         var image=$(this).find("img").attr("src");
         var title=$(this).find(".sub").text();
         $.ajax({
            type: "post",
            url: "/movie/insert",
            data: {"title":title, "image":image},
            success: function(){}
         });
      });
      
      alert("저장완료!");
   });
   
   $("#query").on("keypress", function(e){
      if(e.keyCode==13){
         page=1;
         getList();
      }
   });
   function getList(){
      var query=$("#query").val();
      $.ajax({
         type: "get",
         url: "/local.json",
         dataType: "json",
         data: {"page": page, "query": query},
         success:function(data){
            var temp=Handlebars.compile($("#temp").html());
            $("#locals").html(temp(data));
            $("#pagination").html(getPagination(data));
            $("#total").html("데이터: " + data.pm.totalCount + "건");
         }
      })
   }
   $("#pagination").on("click", "a", function(e){
      e.preventDefault();
      page=$(this).attr("href");
      getList();
   });
</script>