<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Ajax 개요</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	</head>
	<body>
	<p style="font-size:25px;">
	Ajax는 Asynchronous Javascript And XML이란 용어로<br>
		서버로부터 데이터를 가져와 전체 페이지를 새로 고치지 않고 일부만 로드할 수 있도록 비동기식 요청을 함.
	</p>
	<h3>동기식/비동기식이란?</h3>
	<p>
		동기식은 서버와 클라이언트가 동시에 통신하여 프로세스를 수행 및 종료까지 같이하는 방식 <br>
		이에 반해 비동기식은 페이지 리로딩없이 서버요청 사이사이 추가적인 요청과 처리 가능
	</p>
	<h3>Ajax 구현(Javascript)</h3>

	<h4>1.ajax 로 서버에 전송값 보내기</h4>
	<p>버튼 클릭 시 전송값을 서버에서 출력</p>
	<input type="text" id="msg-1">
	<button type="button" onclick="ajaxJquery();">보내기(js)</button>

	<h4>2.버튼 클릭 시 서버에서 보낸 값 수신</h4>
	<p>버튼 클릭 시 서버에서 보낸값 수신</p>
	<button type="button" onclick="recvMsgJquery();">받기(js)</button>

	<h4>3.서버로 전송값 보내고 결과 문자열 받아서 처리</h4>
	<p>숫자 2개를 전송하고 더한 값 받기</p>
	<input type="number" id="num-1">
	<input type="number" id="num-2">
	<button type="button" onclick="sendAndRecvJquery();">전송 및 결과 확인(js)</button>
	
	<h3>4.서버로 전송값 보내고 결과 JSON으로 받아서 처리</h3>
	유저 번호 입력: <input type="text" id="user-id">
	<button id="sendAndJson">실행 및 결과 확인</button>
	<p id="p55"></p>

	<h3>5.서버로 전송값 보내고 JsonArray로 결과값 받아서 처리</h3>
	<p>유저 아이디를 보내서 해당유저를 가져오고, 없는 경우 전체 리스트 가져오기</p>
	유저번호 입력: <input type="text" id="find-id">
	<p id="p5"></p>
	<button id="sendAndJsonList">실행 및 결과 확인</button>
	<script>
	
		document.querySelector("#sendAndJsonList").addEventListener("click", function(){
			var findId= document.querySelector("#find-id").value;
			$.ajax({
				url:"/ajax/sendAndJsonList",
				data:{"userId": findId },
				dataType:"json",
				type:"GET",
				success: function(data){
						/* alert(data); */
					for(var i=0; i<data.length; i++){	
					document.querySelector("#p5").innerHTML
					+="아이디 :" + data[i].userId + ", 비밀번호" + data[i].userPw + "<br>";
					}
				},
				error: function(){
					alert("실패");	
				}
			})
		});
	
		
		document.querySelector("#sendAndJson").addEventListener("click", function(){
			var userId = document.querySelector("#user-id").value;
			$.ajax({
				url:"/ajax/sendAndJsonJackson",
				data:{ "userId" : userId },
				dataType: "json",
				type:"GET",
				success:function(data){
					document.querySelector("#p55").innerHTML+=data.userId + "<br>";
					document.querySelector("#p55").innerHTML+=data.userPw + "<br>";
					/* alert(data); */
				},
				error:function(){
					alert("실패");	
				}
			})
		});
	
		/* document.querySelector("#msg-1").value="값을 입력함"; */	
		/* $("#msg-1").val("값을 입력함"); */
		function sendAndRecv(){
			var num1 = document.querySelector("#num-1").value;
			var num2 = document.querySelector("#num-2").value;
			var xhr = new XMLHttpRequest();
			xhr.open("GET","/ajax/sendAndRecv?num1="+num1+"&num2="+num2,true);
			//xhr.open("POST","/ajax/sendAndRecv",true);
			//xhr.setRequestHeader("Content-type","application/x-www-form-urlendcoded")
			xhr.onload = function(){
				if(xhr.status == 200){
					alert("결과: " + xhr.responseText);
				}else{
					alert("실패");
				}
			}
			//xhr.send("num1="+num1+"&num2="+num2);
			xhr.send();
		}
	
	
		function recvMsg(){
			var xhttp=new XMLHttpRequest();
			xhttp.open("GET","/ajax/sendMsg", true);
			// true 는 비동기 통신 뜻하
			xhttp.onreadystatechange=function(){
			//xhttp.onload = function(){
				if(this.readyState ==4 && this.status==200){
					alert(xhttp.responseText);
				}else{
					alert("실패");
				}
			}
			xhttp.send();
		}
			
		function sendAndRecvJquery(){
			var num1 = $("#num-1").val();
			var num2 = $("#num-2").val();
			$.ajax({
				url:"/ajax/sendAndRecv",
				data:{"num1" : num1 , "num2" : num2},
				type:"GET",
				success:function(data){
					alert("계산 결과 : "+ data);
					},
				error:function(){
					alert("실패");
				}	
			});
		}
			
		function recvMsgJquery(){
			$.ajax({
				url:"/ajax/sendMsg",	
	/* 			data:"";   없으면 안써돋 됨*/
				type:"GET",
				success:function(data){
					alert(data);
				},
				error:function(){
					alert("통신 오류");
				}
			});
		}
		
			
		function ajaxJquery() {
			/* 중괄호 -> JSON
			Ajax 기본 형태보다 훨씬 간단하고 간결*/
			var msg = $("#msg-1").val(); 
			$.ajax({
				url: "/ajax/javascript",
				data: { "msg" : msg },
				type: "GET",
				success: function(){
					console.log("서버 전송 성공");
				},
				error:function(){
					console.log("실패");
				}
			});	
		}	
			
			
		function ajaxJs(){
			//1.XMLHttpRequest 객체 생성
			var xhttp=new XMLHttpRequest();
			var msg= document.querySelector("#msg-1").value;
			//2. 요청 정보 설정
			xhttp.open("GET","/ajax/javascript?msg="+msg, true);
			//3. 데이터 처리에 따른 동작 함수 설정
			xhttp.onreadystatechange=function(){
				if(this.readyState ==4 && this.status==200){
					//통신이 성공 하였을 때
					console.log("서버 전송 성공");
				}else{
					console.log("실패");
				}	
			}
			//4. 전송
			xhttp.send();
		}
	
	</script>

	</body>
</html>