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
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script src="/resources/js/board.js"></script>   
  <style type="text/css">
	.uploadedList{
		list-style: none;
	}  
	
	.board_img_icon{
		cursor: pointer;
	}
  
  </style>
   
</head>
<body>

   <div class="container">
      <div class="row">
         <h1>글 자세히 보기</h1>

         <div class="form-group">
            <label for="title">제목</label> <input id="title" readonly
               value="${vo.title}" class="form-control">
         </div>

         <div class="form-group">
            <label for="writer">작성자</label> <input id="writer" readonly
               value="${vo.writer}" class="form-control">
         </div>

         <div class="form-group">
            <label for="content">내용</label>
            <textarea readonly="readonly" rows="5" name="content" id="content"
               class="form-control">${vo.content}</textarea>
         </div>
		<div class="form-group">
			<label>첨부파일</label>
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
		
      </div>
      <div class="row">
         <form>
            <input type="hidden" name="bno" value="${vo.bno}">
            <input type="hidden" name="curPage" value="${curPage}">
         </form>
         <div class="form-group">
            <button id="reply_form" class="btn btn-info">댓글</button>
            <button class="btn btn-success">수정</button>
            <button class="btn btn-danger">삭제</button>
            <button class="btn btn-primary">목록</button>
         </div>
      </div>
      <!-- class row -->

      <div class="row">
         <div id="myCollapsible" class="collapse">
            <!-- collapse 는 열렸다가 닫혔다가 해주는 기능? -->
            <div class="form-group">
               <label for="replyer">작성자</label> <input class="form-control"
                  id="replyer" name="replyer">
            </div>

            <div class="form-group">
               <label for="replytext">내용</label> <input class="form-control"
                  id="replytext" name="replytext">
            </div>
            <div class="form-group">
               <button id="insertReply" class="btn btn-warning">댓글 등록</button>
               <button class="btn btn-default">댓글 취소</button>
            </div>
         </div>
      </div>
      <span id="msg"></span>

      <div class="row">
         <div id="replies">

            <!--                   맨처음 댓글 예제 만든 후 스크립트 작성 후 주석부분만 지워줘야 함... -->
            <!--             <div class="panel panel-info"> -->
            <!--                <div class="panel-heading"> -->
            <!--                   <span> rno: obj.rno , 작성자 : obj.replyer</span> -->
            <!--                   <span class="pull-right">obj.updatedate</span> -->
            <!--                </div> -->

            <!--                <div data-rno="3" data-ks='kk' data-cks='2' data-lhk='3' data-ca="1" class="panel-body"> -->
            <!--                 data-ks='kk' 사용자 속성임  -->
            <!--                   <p> obj.replytext</p> -->
            <!--                   <button class="btn btn-link btn-update">수정</button> -->
            <!--                   <button class="btn btn-link btn-delete">삭제</button> -->
            <!--                </div> -->
            <!--             </div>                  -->


         </div>
      </div>
      <!--   class row -->


      <div class="row">
         <div id="myModal" class="modal">
            <div class="modal-dialog">
               <div class="modal-header">
                  <button data-dismiss="modal" class="close">&times;</button>
                  <!-- 모달 없애는 버튼(class="close"), 사용자 속성 이용 -->
                  <p id="modal_rno">11</p>
               </div>

               <div class="modal-body">
                  <input id="modal_replytext" class="form-control">
               </div>

               <div class="modal-footer">
                  <button class="btn btn-warning btn-xs" id="modal_update"
                     data-dismiss="modal">수정</button>
                  <!-- data-dismiss="modal"때문에 이 버튼을 클릭하면 모달창이 없어짐 -->
                  <button class="btn btn-warning btn-xs" id="modal_close"
                     data-dismiss="modal">취소</button>
               </div>
            </div>
         </div>
      </div>
      <!-- class = row -->

   </div>
   <!--   class container -->

   <script type="text/javascript">
      var bno = ${vo.bno};
      
      $(document).ready(function() {
			
    	  var arr = ${filenames};
    	  for(var i=0;i<arr.length;i++){
    	  
    		  var filename = arr[i];
    		  iconAppend(filename, false);
    	  }
    	 $(".uploadedList").on("click",".board_img_icon",function(){
    		var filename = $(this).attr("data-url");
    		 if (checkImg(filename)) {
    			 filename = getImageName(filename);
			}
    		 location.assign("/display?filename="+filename);
    	 });
    	  
    	  
    	  
         $("#replies").on("click", ".btn-update", function() {
            $("#myModal").modal("show");
            var rno = $(this).parent().attr("data-rno"); // 주석처리된 수정버튼 위에있는 div태그에(class="panel-body") rno 값이 있음, this = #myModal
            var replytext = $(this).prev("p").text(); // 주석처리된 수정버튼 앞에있는 p태그에(댓글 입력하는곳) replytext 값이 있음

            $("#modal_rno").text(rno); //text()괄호가 비어있으면 값을 가져오는거고 text(rno) 이렇게 해주면 text에 rno값을 넣어주는것임
            $("#modal_replytext").val(replytext);

            $("#modal_update").click(function() { //모달창은 정적으로 만들었기 때문에 .on()이 아닌(동적으로 만든 것일때 사용) .click을 써도 된다

               var rno = $("#modal_rno").text();
               var replytext = $("#modal_replytext").val();

               $.ajax({

                  type : "put",
                  url : '/replies',
                  headers : {
                     'Content-Type' : 'application/json',
                     'X-HTTP-Method-Override' : 'put'
                  },

                  data : JSON.stringify({
                     rno : rno,
                     replytext : replytext
                  }),
                  dataType : 'text',
                  success : function(data) {
                     alert(data);
                     getList(bno);
                  }

               });

            });

         });

         $("#replies").on("click", ".btn-delete", function() {
            var rno = $(this).parent().attr("data-rno") //이벤트에 참여한 이벤트 소스를 가르킨다.. 댓글삭제 시 여러개의 댓글중 삭제하고싶은 댓글을 클릭 했을 때 그 댓글..?

            // $(this).parent().attr("data-rno") data-rno 에 있는 값을 넘겨주세요
            // $(this).parent().attr("data-rno","hello") data-rno 에 hello 값을 넘겨주세요  인자의 개수에 따라 의미가 다르다..

            $.ajax({
               type : "delete",
               url : '/replies/' + rno,
               headers : {
                  'Content-Type' : 'application/Json',
                  'X-HTTP-Method-Override' : 'DELETE'
               },
               dataType : 'text',
               success : function(result) {
                  getList(bno);
                  alert(result);
               }
            });
         });

         //       on() 동적으로생성된 이벤트를 
         //       정적으로 생성 된 조상 태그.on('이벤트' , '동적으로 생성된 이벤트 소스',function(이벤트핸들러))
         //       #동적으로 생성된건 아이디소스를 넣으면 안된다.#
         //       #클래스는 중복이 되어도 상관 없다.#

         getList(bno);
         $("#insertReply").click(function() {
            var replyer = $("#replyer").val();
            var replytext = $("#replytext").val();

            $.ajax({
               type : 'post',
               url : '/replies',
               headers : {
                  'Content-Type' : 'application/Json',
                  'X-HTTP-Method-Override' : 'POST'
               },
               data : JSON.stringify({
                  replyer : replyer,
                  replytext : replytext,
                  bno : bno
               }),
               dataType : 'text',
               success : function(result) {
                  //                alert("insert success")
                  $("#replyer").val(''); // '' 아무것도없다는의미 'hello' 는 인풋창에 보여주겠다.
                  $("#replytext").val('');
                  $("#msg").text("댓글 등록 완료.");
                  $("#msg").css("color", "blue");
                  $("#myCollapsible").collapse("toggle")
                  getList(bno);
               }
            });
         });

         $("#reply_form").click(function() {
            $("#myCollapsible").collapse("toggle")
         });

         $("btn-default").click(function() {

         });

         $(".btn-primary").click(function() { //클래스를 이용한 버튼 제어
            location.assign("/board/listpage?curPage=${curPage}"); //1. location.assign("/board/list"); 얘도 가능.. 혹은 
            //                                       2. $("form").attr("method" ,"get")
            //                                         $("form").attr("action" ,"/board/list");   
            //                                         $("form").submit();
            //             location.assign("/board/listpage?curPage=${param.curPage}");
         });

         $(".btn-success").click(function() {
            $("form").attr("method", "get")
            $("form").attr("action", "/board/update");
            $("form").submit();
         });

         $(".btn-danger").click(function() {
            $("form").attr("method", "post")
            $("form").attr("action", "/board/delete/${vo.bno}/${curPage}");
            $("form").submit();
         });
	
         getList(bn0);
         
      });

      //동적으로 하자 댓글 crud 작업중 r 은 제이슨을 사용한다.
      function getList(bno) {
         $
               .getJSON(
                     "/replies/" + bno,
                     function(data) {
                        var str = "";
                        //          document.getElementById('replies').innerHTML = str;
                        for (var i = 0; i < data.length; i++) {
                           var obj = data[i];
                           str += '<div class="panel panel-info"><div class="panel-heading"><span> rno: '
                                 + obj.rno
                                 + ', 작성자 :'
                                 + obj.replyer
                                 + '</span><span class="pull-right">'
                                 + obj.updatedate
                                 + '</span></div><div data-rno="'+obj.rno+'" class="panel-body"><p>'
                                 + obj.replytext
                                 + '</p><button class="btn btn-link btn-update">수정</button><button class="btn btn-link btn-delete">삭제</button></div></div>';
                        }
                        $("#replies").html(str);
                     });
      }
   </script>



</body>
</html>