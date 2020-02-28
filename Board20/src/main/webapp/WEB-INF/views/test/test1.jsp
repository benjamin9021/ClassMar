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
			
			<button class="btn btn-info">test1</button> 
			
		</div>
		
	</div>
	
	<script type="text/javascript">
   $(document).ready(function() {
      $("button").click(function() {
         $.ajax({
            type : 'post',
            url  : "/test/test1",
            data : {
               'str' : 'hello'
            },
            dataType: 'text',           // 서버쪽에서 넘겨지는 데이터의 형식
            success: function(result) {
               alert(result);
            }
         });
      });
   });


</script>

</body>
</html>