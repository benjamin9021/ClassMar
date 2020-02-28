<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="com.naver.dto.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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

	<%
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		list.add(new MemberDTO("m001","kim",11));
		list.add(new MemberDTO("m002","lee",22));
		list.add(new MemberDTO("m003","park",33));
		
		ObjectMapper mapper = new ObjectMapper();
		String mList = mapper.writeValueAsString(list);
		pageContext.setAttribute("mList", mList);
	%>
	
	<div class="container">
	
		<div class="row">
			<input>
			<button class="btn btn-warning">test4</button>
		</div>
				
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("button").click(function () {
				var val = $("input").val();
			$.ajax({
				type : 'post',
				url: '/test/test4',
				data : {
					mList : JSON.stringify(${mList})
				},		
			dataType: 'text',
			success : function (result) {
				var arr = JSON.parse(result);
				for(var i =0;i<arr.length;i++){
					var obj = arr[i];
					alert(obj.id);
					alert(obj.name);
					alert(obj.age);
				}
			}
			
			});
			
			});
		});
		
	
	
	
	</script>
	
	
	
	
	
</body>
</html>