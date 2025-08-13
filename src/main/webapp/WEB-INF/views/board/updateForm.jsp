<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글수정</title>
<link rel="icon" type="image/jpg" href="/img/saitama.jpg" />
<link rel="stylesheet" href="/css/common.css" />
<style>
	#updateForm{
		td {
			padding : 10px;
			width : 700px;
			text-align : center;
		}
		tr td {
			border : 1px solid gray;		
		}
		
		td:nth-of-type(1) {
			width : 200px;
			background-color : gray;
			border-color : cyan;
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
		td[colspan="2"]{
			background-color:black;
			border : 1px solid gray;
		}
	}
	
	
</style>
</head>
<body bgcolor="black" style = "color:white">
	<main>
		<!-- 메뉴 리스트 -->
		<%@include file="/WEB-INF/include/top_menus.jsp" %>
		
		<h2>게시글 수정&nbsp;&nbsp;||&nbsp;&nbsp;<a href="http://localhost:9090/">홈</a></h2>
		<form action="/Board/Update?idx=${boardDto.idx}" method="POST">
		<input type="hidden" name="menu_id" value="${boardDto.menu_id}" />
			<table id="updateForm">
				<tr>
					<td>제목</td>
					<td><input type="text" name="title" value="${boardDto.title}" /></td>
				</tr>
				<tr>
					<td>작성자 이름</td>
					<td><input type="text" name="writer" value="${boardDto.writer}" readonly /></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="content" >${boardDto.content}</textarea></td>
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
					<td colspan="2"><input type="submit" value="수정" />&nbsp;&nbsp;|&nbsp;&nbsp;<input type="button" value="취소" id="cancel" /></td>
				</tr>
			</table>
		</form>
	</main>
<script>

	function handleOnInput(e){
		e.value = e.value.replace(/[^A-Za-z0-9]/ig, '');
	}
	
	//const formEl = document.querySelectorAll("form")[0];//form이 2개 이상일 경우 가장 첫번째 form 가져오기
	const cancelEl = document.getElementById("cancel");
	cancelEl.onclick = function(){
		//alert('a');
		window.history.back();
	}
	
	const formEl = document.querySelector("form");
	formEl.addEventListener('submit',function(e){
		//alert('OK');
		const inputEl1 = document.querySelector('[name="title"]');
		//const inputEl2 = document.querySelector('[name="writer"]');
		if(inputEl1.value.trim() == ''){
			alert('제목을 입력하세요');
			inputEl1.focus();
			e.stopPropagation();	// 이벤트 버블링 방지
			e.preventDefault();		// 이벤트 취소
			//return false
		}else{
			if(confirm('수정하시겠습니까?')){
				alert('수정되었습니다.');
			}else{
				e.stopPropagation();
				e.preventDefault();
			}
		}
		
	})
</script>
</body>
</html>