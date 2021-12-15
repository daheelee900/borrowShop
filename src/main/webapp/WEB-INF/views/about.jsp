<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
#center{

height:800;
background: black;
}
#background_image {
   position: relative;
   background-image: url("../resources/backg.jpg");
   /* background:black; */
   background-size: cover;
 
   height: 100%;
   width:100%;
   
   background-repeat: no-repeat;
}
#sub_back {
   position: absolute;
   top: 150px;
   left: 0;
   right: 0;
   display: flex;
   justify-content: center;
   align-content: center;
}

#slider {
   box-sizing: border-box;
 
   border-radius: 7px;
   box-shadow: 0 0 20px #ccc inset;
   overflow: hidden;
   width: 800px;
   height: 250px;
   position: relative;
}

#items {
   position: absolute;
   left: 0;
   display: flex;
   justify-content: center;
   align-content: center;
}
 .item {
   width: 200px;
   height: 250px;
 
   
}

.image-thumbnail {
   width: 100%;
   height: 250px;
  
   vertical-align: middle;
} 
#notice{
position: absolute;
bottom:50px;


left:20%;
border:1px dotted gray;
border-radius:10%;

   height: 300px;
   width:550px;;
   overflow: scroll;
 padding:10px;
 background: black;
 opacity:0.7;

}
#notice::-webkit-scrollbar{display: none}
#notice_data{
color: white;
}
</style>
<div id="background_image">


      <h1 style="position: absolute; top: 50px; left: 0; right: 0;"><span style="color: #ff0000">New</span>
         Movies</h1>
      <div id="sub_back">
         <div id="slider" >
            <div id="items" ></div>
            <script id="temp" type="text/x-handlebars-template">
            {{#each .}}
               <div class="item" style="padding:0;" title="{{camp_name}}">
            <div class="jb-wrap" >
               <img class="image-thumbnail" src="{{image}}"/>
            </div>
            <div class="jb-text">
               <p>HELLO</p>   
            </div>
               </div>
            {{/each}}
         </script>
         <div id="pre-next-image" style=""> 


<div id="prev" class="" style="margin-left:10px;"></div>
<div id="next" class="" style="margin-right:10px;"></div>
</div>


         </div>
               
      </div>
      
      <div id="notice">
      <h2 style="color:white;">공지사항</h2>
      <table id="notice_data">
      
      
      </table>
      <script id="temp2" type="text/x-handlebars-template">
   {{#each .}}
   <tr class="row">
      <td class="regdate" >{{regdate}}</td>
      <td class="content" >{{content}}</td>
      <td class="sender" >{{sender}}</td>
   </tr>
   {{/each}}
</script>
      </div>
      </div>
      <script type="text/javascript">
    //슬라이드 반복 실행
      var repeat=setInterval( function(){ $('#next').click(); }, 4500);

     $('#next').on('click', function(){
         clearInterval(repeat);  //슬라이드 반복 중지
         $('#items .item:first').animate({ marginLeft:-200 }, 300, function(){
             $(this).appendTo($('#items')).css({marginLeft:0});
         });
         repeat=setInterval(function(){ $('#next').click(); }, 4500);  //슬라이드 반복 실행
     });

     $('#prev').on('click', function(){
         clearInterval(repeat);  //슬라이드 반복 중지
         $('#items .item:first').animate({ marginLeft: 200 }, 300, function(){
             $(this).before($('#items .item:last')).css({marginLeft:0});
         });
         repeat=setInterval(function(){ $('#next').click(); }, 4500);  //슬라이드 반복 실행
     });
      $.ajax({
          type : "get",
          url : "/cgvSlide.json",
          dataType : "json",
          success : function(data) {
             var temp = Handlebars.compile($("#temp").html());
             $("#items").html(temp(data));
          }
       });
      $.ajax({
          type : "get",
          url : "/notice.json",
          dataType : "json",
          success : function(data) {
             var temp = Handlebars.compile($("#temp2").html());
             $("#notice_data").html(temp(data));
          }
       });
      
      
      
      </script>
