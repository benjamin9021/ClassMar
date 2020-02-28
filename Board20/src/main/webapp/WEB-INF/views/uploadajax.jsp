<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
.fileDrop {
	width: 100%;
	height: 200px;
	border: 1px dotted red;
}
</style>

</head>
<body>
	<div class="container">
		<div class="row">
			<div class="fileDrop"></div>
			<div class="uploadedList"></div>
		</div>
		<!--    class = row -->
	</div>
	<!--    class = container -->

	<!--    <img alt="" src ="/resources/img/gt.png">  경로 이런식으로 이용..   -->

	<!--    기존 파일 드래그 했을 때 켜지는 기능이 아닌 업로드를 할것이기에 기존 filedrop 기능을 막는 작업을 할것 이다. -->

	<p>
		hello<small>x</small>
	</p>

	<script type="text/javascript">
      $(document).ready(function() {
    	  $(".uploadedList").on("click","small",function(event) {
    		 	var that = $(this);
    		  
    		  $.ajax({
    			type : "post",
    			url : "/deletefile",
    			data : {
    				filename : $(this).attr("data-src")
    			},
				dataType : "text",    			
    			success : function(data) {
					that.parent("p").parent("div").remove();								
    			}
    		 }); 
    	  });
    	  
    	  
         $(".fileDrop").on("dragenter dragover", function(event) {
            event.preventDefault();  
//             preventDefault -> event 발생을 막아라
         });
//          동적으로 만들어진 태그에 이벤트를 걸어줄 때 on 을 주로 사용.

         $(".fileDrop").on("drop", function(event) {
            event.preventDefault();     //드랍 기능을 막았다.
            
            var files = event.originalEvent.dataTransfer.files;
         //  event.originalEvent.dataTransfer.files; -> 한개의 파일을  드래그 했을 때 파일들의 정보를 받아온다..
         // 여러개의 파일은 알아서 하기   
            var file = files[0];  //우리는 하나만 가져오기에 0을 넣었다 여러개 넣을 때는 배열이 올라갈 것.
            var formData = new FormData();   // 객체 생성 폼태그의 역할을 한다.
               formData.append("file" , file);   //파일을 file 이란 이름으로 추가 했다 . ajax를 이용해서 업로드 할것이다.
               $.ajax({
                  type: "post",
                  url : "/uploadajax",
                  data : formData,
                  dataType: "text",
                  processData : false,   //파일업로드시 ajax 에는 processData 를 추가 해야함.. 기본값은 true
                  contentType : false,   //파일업로드시 ajax 에는 contentType 를 추가 해야함.. 기본값은 true multipart/form-data 로들어가기에 false
                  success: function(data) {
                    
                	  var str = "<div class='up_thumb'>";
                     
                	  if (checkImg(data)) {      //크롬은 c 드라이브에서 바로 이미지 로딩을 할수 없기에 바이트르 ㄹ가져 와야 한다..
                          str += "<a target='_blank' href = 'display?filename="+getImageName(data)+"'><img src = 'display?filename="+data+"'></a>"
                       }else{
                          str  +=  "<a href= 'display?filename="+data+"'><img alt='일반파일썸네일' src ='/resources/img/gt.png'></a>";
                       }
                       str += "<p>" + getOriginalName(data)+ " <small data-src='"+data+"'>X</small>"+"</p>";
                       str += "</div>";
                       $(".uploadedList").append(str);
                    }
                 });

               
         }); 

      });   
   
      function checkImg(filename) {
         
         var type = filename.substring(filename.lastIndexOf(".")+1);
         type = type.toLowerCase();
         if (type == "png" || type == "jpg" || type == "jpeg" || type == "gif") {
            return true;
         }else{
            return false;
         }
//          정규식을 이용하면 간단하게 된다!.
//          var pattern = /jpg|jpeg|png|gif/i;      // 이런 패턴이냐? 라는 정규식임..
         
//                if (filename.test(pattern) == true) {
//                   return true;
//                }else{
//                   return false;
//                }
         
//          return filename.test(pattern);         // 파일네임에 패턴이들어갔냐?? 라는 의미.. 파일명이 패턴에 작성한 파일이 껴있다면 오작동 할수있으니 이름 조심..
      }
      
      
      function getOriginalName(filename) {
            
            if(checkImg(filename)) {   //  ex) /2020/02/26/s_708bce98-196e-4b1c-a222-c50dfd9bdb59_123.png
               //s_는 앞에서부터 13번째 인덱스에 있음 따라서 14번째부터 찾으면 됨
               var idx = filename.indexOf("_", 14) +1;
            }else{   //이미지파일이 아닌 파일의  원본 파일명   
               var idx = filename.indexOf("_") +1;
            }
            
            filename = filename.substring(idx); // 파일오리지널 네임만 추출 하여 다시 대입하는과정
            return filename;
       }
      
      function getImageName(filename) {
			var prefix = filename.substring(0,12);		
			var suffix = filename.substring(14)
    	  
    	  return prefix + suffix;
	}
      
   </script>


</body>
</html>