   function checkImg(filename) {
      
       var type = filename.substring(filename.lastIndexOf(".")+1);
      
      if(type.toLowerCase() == "png" || type.toLowerCase() == "jpg" || type.toLowerCase() == "jpeg" || type.toLowerCase() == "gif") {
         return true;
      } else {
         return false;
      } 
      
   }
   
   
   function getOriginalName(filename) {
      
      if(checkImg(filename)) {
         
         var idx = filename.indexOf("_", 14) +1;
      }else{
         var idx = filename.indexOf("_") +1;
      }
      
      filename = filename.substring(idx);
      return filename;
      
   }
   
   
   
   function getImageName(filename) {
      var idx = filename.indexOf("s");
      var idx2 = filename.indexOf("_");
      
      var prefix = filename.substring(0, 12);   
      var suffix = filename.substring(14);
      
      return prefix + suffix;
      
   }
   
   /* insert, update에서는 이 함수 그대로 사용, read에서는 이 함수 사용하는데 X버튼은 나오면안된다  따라서 X버튼 출력되는 곳에 if문을 써줌*/
   function iconAppend(data, ok) {   //ok파라미터는 X버튼을 출력할지 말지 정하는 if문에서 쓰기위해서 받아옴
      
      /* updateajax에서 쓴것과는 따옴표 쌍따옴표가 반대임 */
      var str = '<li class="col-xs-3">';
      
      if(checkImg(data)) {
         str += '<img data-url="'+data+'" class="board_img_icon" alt="이미지파일 썸네일" src="/display?filename='+data+'">';
         
      }else {
         str += '<img data-url="'+data+'" class="board_img_icon" alt="일반파일 썸네일" src="/resources/img/gt.png">';
      }
      
      str += '<div>';
      
      str += '<span>' + getOriginalName(data) + '</span>';
      
      if(ok) {   //ok가 true면 X버튼 출력(insert, update) false면 X버튼 출력안됨(read) 
      str += '<a class="btn btn-danger btn-xs delbtn" href="'+data+'"><span class="glyphicon glyphicon-remove"></span></a>'
      }
      str += '</div>';
      
      $(".uploadedList").append(str);
      
      /* 이렇게도 할 수 있다.(한줄에 쭉)            
      var str = "";

        if (checkImg(data)) {     
           str += '<li class="col-xs-3"><img src ="/display?filename='+data+'"><div><span>'+getOriginalName(data)+'</span><a class="btn btn-danger btn-xs delbtn" href="#"><span class="glyphicon glyphicon-remove"></span></a></div></li>';
        }else{
           str += '<li class="col-xs-3"><img src ="/resources/img/gt.png"><div><span>'+getOriginalName(data)+'</span><a class="btn btn-danger btn-xs delbtn" href="#"><span class="glyphicon glyphicon-remove"></span></a></div></li>';
        } */
      
   }