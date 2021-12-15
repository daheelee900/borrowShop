/page list/
function getPagination(data){
	   var str="";
       if(data.pm.prev) str += "<a href='" + (data.pm.startPage-1) + "'>이전</a>&nbsp;";
       for(var i=data.pm.startPage; i<=data.pm.endPage; i++){
          if(data.cri.page == i){
             str += "<a href='" + i + "' class='active'>" + i + "</a>&nbsp;";
          }else{
             str += "<a href='" + i + "'>" + i + "</a>&nbsp;";
          }
       }
       if(data.pm.next) str += "<a href='"+ (data.pm.endPage+1)+ "'>다음</a>";
       return str;
}