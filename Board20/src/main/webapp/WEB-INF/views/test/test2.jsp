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
</head>
<body>
   <div class="container">
      <div class="row">
         <button class="btn btn-success">홍</button>
         <div id="test"></div>
      </div>
   </div>


<script type="text/javascript">
   $(document).ready(function() {
      $(".btn-success").click(function() {
         var arr = ["안녕" , "world" , "good" , "morning"]
         $.ajax({
            type : 'post',
            url  : "/test/test2",
            traditional : true,  //배열을 보낼 때는 속성이 추가 된다.
            data : {
               'arr' : arr
            },
            dataType : "text",
            success : function(result){
               console.log(result);
               var arr2 = eval(result);
               var msg = '';
               for(var i=0; i<arr2.length; i++){
                  msg += "<p>" + arr2[i] + "</p>";
               }
               alert(msg);
               $("div#test").append(msg);
//             eval(result) -> 자바스크립트 문법에 맞게 바 꿔준다 문자열을 넣으면 배열이 나온다.
//            var arr2 =["안녕","world","good","morning"]
//             typeof(result)   -> 문자열로 나온다  
            }
         });
      });
   });
</script>



</body>
</html>