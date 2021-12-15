<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script> 

<title>Insert title here</title>
</head>
<body>
 <table id="tbl" border=1></table>
 <script id="temp" type="text/x-handlebars-template">
   {{#each .}}
 <tr class="row">
<td><input type="checkbox"/>  </td>
<td><img src="{{image}}" width=100/>  </td>
<td>{{rank}}</td>
<td>{{title}}</td>
<td>{{date}}</td>
</tr>
  
   {{/each}}
</script>
 
</body>

<script>

getList();




function getList(){
   $.ajax({
      type:"get",
      url: "/cgvmore.json",
      dataType: "json",
     
      success: function(data){
         var temp=Handlebars.compile($("#temp").html());
         $("#tbl").html(temp(data));
      }
   });
}


</script>
</html>