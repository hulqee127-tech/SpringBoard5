<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글추가</title>
<link rel="icon" type="image/jpg" href="/img/saitama.jpg" />
<link rel="stylesheet" href="/css/common.css" />
<style>
	#writeForm{
		td {
			padding : 10px;
			width : 700px;
			text-align : center;
		}
		
		td:nth-of-type(1) {
			width : 200px;
		}
		
		input {
			width : 100%;
			align : left;
			padding:5px;
		}
		input[type="submit"] {
			width : 100px;
		}
		input[type="button"] {
			width : 100px;
		}
		textarea {
			width:100%;
			height:150px;
		}
	}
</style>
</head>
<body bgcolor="black" style = "color:white">
	<main>
		<!-- 메뉴 리스트 -->
		<%@include file="/WEB-INF/include/top_menus.jsp" %>
		
		<h2>[${menuDto.menu_name}] 새 게시글 추가&nbsp;&nbsp;||&nbsp;&nbsp;<a href="http://localhost:9090/">홈</a></h2>
		<form action="/Board/Write" method="POST">
		<input type="hidden" id="menu_id" value="${menuDto.menu_id}" />
			<table id="writeForm">
				<tr>
					<td>제목</td>
					<td><input type="text" name="title" /></td>
				</tr>
				<tr>
					<td>작성자 이름</td>
					<td><input type="text" name="writer" /></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="content"></textarea></td>
				</tr>
				<!-- tr>
					<td style="width:20%">제목</td>
					<td style="width:50%"><input type="text" name="userid" maxlength="300" style="width:85%;" /></td>
					<td style="width:15%">메뉴</td>
					<td style="width:15%">
						<select name="menu" style="width:80%">
							<option value="" selected >-선택-</option>
							<c:forEach var="cate" items="${categoryData}">
							<option value="${cate.menu_id}">${cate.menu_name }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3"><textarea name="content" cols="100" rows="20"></textarea></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td colspan="3" style="text-align:left"><input type="text" name="writer" value="" style="width:25%;" /></td>
				</tr-->
				<tr>
					<td colspan="2"><input type="submit" value="등록" /> <input type="button" value="목록" id="goList" /></td>
				</tr>
			</table>
		</form>
	</main>
<script>

	function handleOnInput(e){
		e.value = e.value.replace(/[^A-Za-z0-9]/ig, '');
	}
	
	//const formEl = document.querySelectorAll("form")[0];//form이 2개 이상일 경우 가장 첫번째 form 가져오기
	const golistEl = document.getElementById("goList");
	const menu_id = document.getElementById("menu_id").value;
	golistEl.onclick = function(){
		//location.href='/Board/boardList?menu_id='+menu_id;
		location.href='/Board/boardList?menu_id=${menuDto.menu_id}';
	}
	
	const formEl = document.querySelector("form");
	formEl.addEventListener('submit',function(e){
		//alert('OK');
		const inputEl1 = document.querySelector('[name="title"]');
		const inputEl2 = document.querySelector('[name="writer"]');
		if(inputEl1.value.trim() == ''){
			alert('제목을 입력하세요');
			inputEl1.focus();
			e.stopPropagation();	// 이벤트 버블링 방지
			e.preventDefault();		// 이벤트 취소
			//return false
		}else if(inputEl2.value.trim() == ''){
			alert('작성자를 입력하세요');
			inputEl2.focus();
			e.stopPropagation();
			e.preventDefault();
			//return false
		}else{
			if(confirm('등록하시겠습니까?')){
				alert('등록되었습니다.');
			}else{
				e.stopPropagation();
				e.preventDefault();
			}
		}
		
	})
</script>
</body>
</html>