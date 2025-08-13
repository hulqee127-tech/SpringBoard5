<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물리스트</title>
<link rel="icon" type="image/jpg" href="/img/saitama.jpg" />
<link rel="stylesheet" href="/css/common.css" />
<!-- SCSS 문법을 가능하게 하는 라이브러리
<script src="https://cdn.jsdelivr.net/npm/browser-scss@1.0.3/dist/browser-scss.min.js"></script> 
-->
<style>
	/*  SCSS 문법 - 별로 라이브러리 필요 / 그런데 지금은 됨 / 스타일 안에 스타일을 넣는 방법? */
	/* 원래는 라이브러리를 링크 걸어서 나와야 하는데 된다 ㅋㅎㅋㅎㅋㅎㅋㅎㅋㅎ */
	#listForm {
		td{
			padding : 10px;
			text-align:center;
		}
		td:nth-of-type(1) { width : 100px; }	
		td:nth-of-type(2) { width : 400px; text-align:left; }	
		td:nth-of-type(3) { width : 100px; }
		td:nth-of-type(4) { width : 100px; }	
		td:nth-of-type(5) { width : 100px; }
		
		tr:first-child td{
			text-align:center;
			background-color : gray;
			border-color:cyan;
			color : white;
		}
		td[colspan="5"]{
			text-align : right;
		}
	}
</style>
</head>
<body bgcolor="black" style = "color:white">
	<main>
		<!-- 대체 명령어로 변경 -->
		<!-- 메뉴 리스트 -->
		<%@include file="/WEB-INF/include/top_menus.jsp" %>
		
		<h2>[${menuDto.menu_name}] 게시물 목록&nbsp;&nbsp;||&nbsp;&nbsp;<a href="http://localhost:9090/">홈</a></h2>

		<!-- 게시물 목록 -->
		<table id="listForm">
			<tr>
				<td>글번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일자</td>
				<td>조회수</td>
				<!-- <td>Delete</td>
				<td>Modify</td> -->
			</tr>
			<tr>
				<td colspan="5">
					<a href="/Board/WriteForm?menu_id=${menuDto.menu_id}">새 게시글 추가</a>
				</td>
			</tr>
			<% //for(int i=0; i<menuList.size();i++){ %>
			<% //for(MenuDTO menu : menuList ){ %>
			<% //MenuDTO menu = new menuList.get(i); %>
			<c:forEach var="board" items="${boardList}">		<!-- JSTL 문법 -->
			<tr>
				<td>${ board.idx     }</td>	<!-- Expression Langauge => EL el문법 -->
				<td><a href="/Board/boardView?idx=${ board.idx }&menu_id=${board.menu_id}">${ board.title   }</a></td>
				<td>${ board.writer  }</td>
				<td>${ board.regdate }</td>
				<td>${ board.hit     }</td>
				<%-- <td><a href="/Borad/Delete?idx=${ board.idx   }" onclick="return confirm('삭제하시겠습니까? \n 삭제 후 되돌릴 수 없습니다.');">Delete</a></td>
				<td><a href="/Board/UpdateForm?idx=${ board.idx   }">Modify</a></td> --%>
			</tr>
			</c:forEach>
			<% //} %>
		</table>
	</main>
</body>
</html>