<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="com.naver.dto.BoardVO"%>
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
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="/resources/js/board.js"></script>   
  <style type="text/css">
  .uploadedList {
  	list-style : none;
  }
  .fileDrop{
        width : 100%;
        height : 200px;
        border : 1px solid green;
        background-color: lightslategray;
        margin: auto;
     }
     .uploadedList li{
        margin-top: 20px;
     }
  </style>
</head>
<body>
   <div class="container">
      <div class="row">
         <h1>게시글 수정</h1>
         <form method="post" class="form-horizontal">
         	<input type="hidden" name="curPage" value="${curPage}">
         
            <div class= "form-group">
               <label for="bno" class="col-xs-2 control-label" >글번호</label>
               <div class="col-xs-10">
                  <input readonly="readonly" value="${vo.bno}" class="form-control" name ="bno" id="bno">
               </div>
            </div>
            
            <div class= "form-group">
               <label for="writer" class="col-xs-2 control-label" >작성자</label>
               <div class="col-xs-10">
                  <input value="${vo.writer}" class="form-control" name ="writer" id="writer">
               </div>
            </div>
            
            <div class= "form-group">
               <label for="title" class="col-xs-2 control-label" >제목</label>
               <div class="col-xs-10">
                  <input value="${vo.title}" class="form-control" name ="title" id="title">
               </div>
            </div>
            
            
            <div class= "form-group">
               <label for="content" class="col-xs-2 control-label" >내용</label>
               <div class="col-xs-10">
                  <textarea  rows="5" class="form-control" id="content" name ="content">${vo.content}</textarea>
               </div>
            </div>

         </form >
         
         <div class="form-group"> 
            <label>추가 업로드 할 파일을 드랍시키세요.</label>
            <div class="fileDrop"> 
            </div>
         </div>
         
         
         <div class="form-group">
         	<label>업로드한 파일 목록</label>
         	<ul class="uploadedList clearfix">
         		<%
         		BoardVO vo = (BoardVO) request.getAttribute("vo");	
				String[] arr = vo.getFilename();
				ObjectMapper mapper = new ObjectMapper();
				String filenames = mapper.writeValueAsString(arr);
				pageContext.setAttribute("filenames", filenames);    		
         		
         		%>
         	</ul> 
         
         </div>
         
         <div class="form-group">
            <div class="col-xs-offset-2 col-xs-10">
               <button class="btn btn-primary" type="submit">수정</button>
               <button class="btn btn-warning">초기화</button>
            </div>
         </div>
         
      </div>
   </div>


<script type="text/javascript">
   
   $(document).ready(function() {
	   
		var arr = ${filenames};
		
		for(var i = 0; i < arr.length; i++) {
			var filename = arr[i];
			iconAppend(filename, true);
		}
		
		$(".uploadedList").on("click", ".board_img_icon", function() {
			var filename = $(this).attr("data-url");
			if (checkImg(filename)) {
				filename = getImageName(filename);
			}
			location.assign("/display?filename=" + filename);
		});

		$("button[type='submit']").click(function() {
			//          $("form").attr("method","post");            //이렇게 따로 따로 지정 가능
			$("form").attr("action", "/board/update");
			
			 var msg = "";
		      
	           $(".delbtn").each(function(index){      //each 는 제이쿼리 포문이다..
	              var filename = $(this).attr("href");
	              msg += "<input name='filename["+index+"]' type ='hidden' value ='"+filename+"'>";
	           });          // 파일이름의 배열이 나온다..
	           
	           $("form").append(msg);
			
			$("form").submit(); // 스프링은 알아서 form 데이터가 서버로 간다 다만 form 태그에 post 방식으로 만들어 줘야 함.
			// form 이 여러개라면 배열 처럼 [] 사용 해야 함.
		});

		$(".btn-warning").click(function() {
			$("form").attr("method", "get");
			$("form").attr("action", "/board/read/${vo.bno}");
			$("form").submit();
		});
		
		$(".fileDrop").on("dragenter dragover", function(event) {
	         event.preventDefault();
	      });
	      
	      $(".fileDrop").on("drop", function(event) {
	         event.preventDefault();
	         
	         var arr = event.originalEvent.dataTransfer.files;
	         
	         var file = arr[0];
	         
	         var formData = new FormData();
	         formData.append("file", file);
	         
	         $.ajax({
	            type : "post",
	            url : "/uploadajax",
	            data : formData,
	            dataType : "text",
	            
	            processData : false,
	            contentType : false,
	            
	            success : function(data) {

	               iconAppend(data, true);
	            }
	         });
	      });

		
		$(".uploadedList").on("click", ".delbtn", function(event) {
			event.preventDefault();

			var that = $(this);
			var filename = that.attr("href");
			var go = confirm("경고!: 수정 버튼과 상관없이 파일이 삭제됩니다. \n 삭제하시겠습니까?");
			
			if (go) {
				
			
			
			$.ajax({
				type : "post",
				url : "/board/deletefile/${vo.bno}",
				data : {
					filename : filename
				},
				dataType : "text",
				success : function(data) {
					that.parent("div").parent("li").remove();
				}
			});
			}
		});
	});
</script>

</body>
</html>