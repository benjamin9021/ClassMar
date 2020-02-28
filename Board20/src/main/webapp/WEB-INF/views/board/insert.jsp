<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>  
  
  <script src="/resources/js/board.js" type="text/javascript"></script>      
<!--   외부파일을 불러올때 이렇게 사용 -->
  
  <style type="text/css">
     .fileDrop{
        width : 100%;
        height : 200px;
        border : 1px solid green;
        background-color: lightslategray;
        margin: auto;
     }
     .uploadedList{
        list-style: none;
     }
     
     .uploadedList li{
        margin-top: 20px;
     }
  </style>
  
</head>
<body>

   <div class="container">
      <div class="row">
      
         <h1 class="jumbotron">글쓰기</h1>
         
         <form method="post">
         
            <div class="form-group">
               <label for="title">제목</label>
               <input name="title" id="title" class="form-control">
            </div>
            
            <div class="form-group">
               <label for="writer">작성자</label>
               <input name="writer" id="writer" class="form-control">
            </div>
            
            <div class="form-group">
               <label for="content">내용</label>
               <textarea rows="5" name="content" id="content" class="form-control"></textarea>
            </div>
            
         </form>
         
         
         <div class="form-group"> <!-- 이미지파일 삽입 --> <!-- form-control은 한줄 다먹음 form-group은 묶어줌 -->
            <label>업로드할 파일을 드랍시키세요.</label>
            <div class="fileDrop"> <!-- head종료태그 위에 style태그에 이미지드랍하는곳 css 만들어줬음-->
            <!-- 이미지파일을 드랍해서 놓는 순간 업로드는 되어있음, 그러나 DB에 저장된 것은 아님 -->
            </div>
         </div>
         
         <!-- 위에서 이미지파일 드랍한게 여기서 뜬다 --- ajax의 success란에 한줄로 복붙해서 들어갈 코드임 -->
         <ul class="uploadedList clearfix"> <!-- clearfix: 작업한게 혹시나 이상하게 나올때 잡아줌 -->
<!--             <li class="col-xs-3"> -->
<!--                <img alt="일반파일썸네일" src="/resources/img/gt.png"> -->
<!--                <div> -->
<!--                   <span>gt.png</span> -->
<!--                   <a class="btn btn-danger btn-xs delbtn" href=''><span class="glyphicon glyphicon-remove"></span></a>이 버튼을 누르면 나중에 삭제가 되도록 delbtn클래스 추가 -->
<!--                </div> -->
<!--             </li> -->

         
         </ul>
         
         
         <div class="form-group"><!-- 원래 form태그 안에 썼지만 javascript(jquery) 이용하여 보내는 것이 더 좋음 -->
            <button type="submit" class="btn btn-primary">등록</button>
            <button type="reset" class="btn btn-warning">초기화</button>
         </div>
         
      </div>
   </div>


<script type="text/javascript">
   $(document).ready(function() {
      
      $(".uploadedList").on("click" , ".delbtn",function(event){
         event.preventDefault();
            
         var that =$(this);
         var filename = that.attr("href");
         
         $.ajax({
            type : "post",
            url : "/deletefile",
            data : {
               filename :filename
            },
            dataType: "text",
            success :function(data){
               that.parent("div").parent("li").remove();
            }
         });
      });
      
      
      $("button[type='submit']").click(function(event) { /* 그냥 button이면 지금 버튼이 2개이기때문에 type이 submit인 애를 찾음(등록 버튼) */
           event.preventDefault();
           
           var msg = "";
      
           $(".delbtn").each(function(index){      //each 는 제이쿼리 포문이다..
              var filename = $(this).attr("href");
              msg += "<input name='filename["+index+"]' type ='hidden' value ='"+filename+"'>";
           });          // 파일이름의 배열이 나온다..
           
           $("form").append(msg);
           
           $("form").submit();
      });             //          $("form").submit(); /* 그냥 이거만 써도 스프링은 알아서 board/insert로 제출됨(form이 post방식이기떄문에 post로) */
      
      $("button[type='reset']").click(function() { /* 초기화 버튼을 누르면 list로 감 */
         location.href = "/board/list";
      }); 
      
      $(".fileDrop").on("dragenter dragover", function(event) {
         event.preventDefault();
      });
      
      $(".fileDrop").on("drop", function(event) {
         event.preventDefault();
         
         var arr = event.originalEvent.dataTransfer.files;
         
         //for(var i; i < files.length; i=+) { //여러개의 이미지를 올리고싶으면 이렇게쓰면됨 나머지 밑에 코드는 똑같음, 프로잭트할때는 이렇게
         //var file = files[i];
         //}
         
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

               iconAppend(data, true); /* 외부 자바스크립트 파일로 뺏기때문에 이렇게씀 */
               
               
               /* updateajax에서 쓴것과는 따옴표 쌍따옴표가 반대임 */
               /*var str = '<li class="col-xs-3">';
               if(checkImg(data)) {
                  str += '<img alt="이미지파일 썸네일" src="/display?filename='+data+'">';
               }else {
                  str += '<img alt="일반파일 썸네일" src="/resources/img/gt.png">';
               }
               str += '<div>';
               str += '<span>' + getOriginalName(data) + '</span>';
               str += '<a class="btn btn-danger btn-xs delbtn" href="#"><span class="glyphicon glyphicon-remove"></span></a>'
               str += '</div>';
               $(".uploadedList").append(str);*/
               
               /* 이렇게도 할 수 있다.(한줄에 쭉)            
               var str = "";
                    if (checkImg(data)) {     
                       str += '<li class="col-xs-3"><img src ="/display?filename='+data+'"><div><span>'+getOriginalName(data)+'</span><a class="btn btn-danger btn-xs delbtn" href="#"><span class="glyphicon glyphicon-remove"></span></a></div></li>';
                    }else{
                       str += '<li class="col-xs-3"><img src ="/resources/img/gt.png"><div><span>'+getOriginalName(data)+'</span><a class="btn btn-danger btn-xs delbtn" href="#"><span class="glyphicon glyphicon-remove"></span></a></div></li>';
                    } */
            }
         });
      });
   });
   
</script>
</body>
</html>