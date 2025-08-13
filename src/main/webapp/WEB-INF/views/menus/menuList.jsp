<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴리스트</title>
<link rel="icon" type="image/jpg" href="/img/saitama.jpg" />
<link rel="stylesheet" href="/css/common.css" />
<!-- SCSS 문법을 가능하게 하는 라이브러리
<script src="https://cdn.jsdelivr.net/npm/browser-scss@1.0.3/dist/browser-scss.min.js"></script> 
-->
<style>
	td { text-align : center; }
	tr:first-child {
		background-color : gray;
		font-weight : bold;
		/*  SCSS 문법 - 별로 라이브러리 필요 / 그런데 지금은 됨 / 스타일 안에 스타일을 넣는 방법? */
		/* 원래는 라이브러리를 링크 걸어서 나와야 하는데 된다 ㅋㅎㅋㅎㅋㅎㅋㅎㅋㅎ */
		td {
			border-color : cyan;
			color : white;
		}
	}
	td[colspan="5"]{
		text-align : right;
	}
	/*
	tr:first-child td {
		border-color : white;
	}
	*/
</style>
</head>
<body bgcolor="black" style = "color:white">
	<main>
		<h2>메뉴목록&nbsp;&nbsp;||&nbsp;&nbsp;<a href="http://localhost:9090/">홈</a></h2>
		<table>
			<tr>
				<td>Menu_ID</td>
				<td>Menu_NAME</td>
				<td>Menu_SEQ</td>
				<td>Delete</td>
				<td>Modify</td>
			</tr>
			<tr>
				<td colspan="5">
					<a href="/Menus/WriteForm">새메뉴추가</a>
				</td>
			</tr>
			<% //for(int i=0; i<menuList.size();i++){ %>
			<% //for(MenuDTO menu : menuList ){ %>
			<% //MenuDTO menu = new menuList.get(i); %>
			<c:forEach var="menu" items="${menuList}">		<!-- JSTL 문법 -->
			<tr>
				<td>${ menu.menu_id   }</td>	<!-- Expression Langauge => EL el문법 -->
				<td>${ menu.menu_name }</td>
				<td>${ menu.menu_seq  }</td>
				<td><a href="/Menus/Delete?menu_id=${ menu.menu_id   }" onclick="return confirm('삭제하시겠습니까? \n 삭제 후 되돌릴 수 없습니다.');">Delete</a></td>
				<td><a href="/Menus/UpdateForm?menu_id=${ menu.menu_id   }">Modify</a></td>
			</tr>
			</c:forEach>
			<% //} %>
		</table>
	</main>
</body>
</html>