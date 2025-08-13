<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글보기</title>
<link rel="icon" type="image/jpg" href="/img/saitama.jpg" />
<link rel="stylesheet" href="/css/common.css" />
<style>
	#viewForm{
		text-align : center;
	
		tr td {
			border-color : gray;
			border : 1px solid gray;
		}
		td:nth-of-type(1) {
			width : 20%;
			background-color : gray;
			border-color:cyan;
		}
		td:nth-of-type(2) {
			text-align:center;
			width : 30%;
		}
		td:nth-of-type(3) {
			width : 20%;
			background-color : gray;
			border-color:cyan;
		}
		td:nth-of-type(4) {
			width : 30%;
		}
		input[type="button"] {
			width : 100px;
		}
		td[colspan="4"]{
			background-color:black;
			border-color:gray;
		}
		td[colspan="3"]{
			text-align:left;
		}
	
	}
</style>
</head>
<body bgcolor="black" style = "color:white">
	<main>
		<!-- 메뉴 리스트 -->
		<%@include file="/WEB-INF/include/top_menus.jsp" %>
		
		<h2>[${menuDto.menu_name}]&nbsp;&nbsp;||&nbsp;&nbsp;<a href="http://localhost:9090/">홈</a></h2>
		<form action="/Board/updateForm" method="POST">
		<input type="hidden" name="menu_id" value="${boardDto.menu_id}" />
		<input type="hidden" name="idx" value="${boardDto.idx}" />
			<table id="viewForm">
				<tr>
					<td>글번호</td>
					<td>${boardDto.idx}</td>
					<td>조회수</td>
					<td>${boardDto.hit}</td>
				</tr>
				<tr>
					<td>작성자 이름</td>
					<td>${boardDto.writer}</td>
					<td>작성일자</td>
					<td>${boardDto.regdate}</td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3">${boardDto.title}</td>
				</tr><tr>
					<td>내용</td>
					<td colspan="3">${boardDto.content}</td>
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
					<td colspan="4">
						<input type="button" value="수정" id="Update" />&nbsp;|&nbsp;
						<input type="button" value="삭제" id="Delete" />&nbsp;|&nbsp;
						<input type="button" value="목록" id="List" />
					</td>
					
				</tr>
			</table>
		</form>
	</main>
<script>

	function handleOnInput(e){
		e.value = e.value.replace(/[^A-Za-z0-9]/ig, '');
	}
	
	//const formEl = document.querySelectorAll("form")[0];//form이 2개 이상일 경우 가장 첫번째 form 가져오기
	const updateEl = document.getElementById("Update");
	const formEl = document.querySelectorAll("form")[0];
	updateEl.onclick = function(){
		location.href = '/Board/updateForm?idx=${boardDto.idx}';
		//formEl.submit();
	}
	
	const listEl = document.getElementById("List");
	listEl.onclick = function(){
		location.href = '/Board/boardList?menu_id=${boardDto.menu_id}';
	}
	
	const deleteEl = document.getElementById("Delete");
	deleteEl.onclick = function(e){
		if(confirm('삭제하시겠습니까? \n 삭제 후 복원 불가능 합니다.')){
			alert('삭제되었습니다.');
			location.href = '/Board/Delete?menu_id=${boardDto.menu_id}&idx=${boardDto.idx}';
		}else{
			e.stopPropagation();
			e.preventDefault();
			return false
		}
	}
</script>
</body>
</html>