<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자리스트</title>
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
	td[colspan="8"]{
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
		<h2>사용자목록&nbsp;&nbsp;||&nbsp;&nbsp;<a href="http://localhost:9090/">홈</a></h2>
		<table>
			<tr>
				<td>UserID</td>
				<!-- <td>PassWD</td> -->
				<td>UserNAME</td>
				<td>Email</td>
				<td>POINT</td>
				<td>가입일자</td>
				<td>삭제</td>
				<td>수정</td>
			</tr>
			<tr>
				<td colspan="8">
					<a href="/Users/WriteForm">새사용자추가</a>
				</td>
			</tr>
			<c:forEach var="user" items="${userList}">		<!-- JSTL 문법 -->
			<tr>
				<td>${ user.userid   }</td>	<!-- Expression Langauge => EL el문법 -->
				<%-- <td>${ user.passwd }</td> --%>
				<td>${ user.username  }</td>
				<td>${ user.email  }</td>
				<td>${ user.upoint  } (${ user.grade  })</td>
				<td type="date">${ user.indate  }</td>
				<c:choose>  <%-- if, else의 시작임을 정의 --%>
					<c:when test="${'127' == user.userid}"> <%-- if와 동일 --%>
						<td><a href="/Users/Delete?userid=${ user.userid   }" onclick="return confirm('삭제하시겠습니까? \n 삭제 후 되돌릴 수 없습니다.');">Delete</a></td>
						<%-- <td><a href="/Users/UpdateForm?userid=${ user.userid   }">Modify</a></td> --%>
						<td><a href="/Users/UpdateForm?userid=${ user.userid   }">Modify</a></td>
					</c:when> 	<%-- if 종료 --%>
					<c:otherwise> <%-- else와 동일 --%>
						<td></td><td></td>
					</c:otherwise> <%-- else 종료 --%>
				</c:choose>  <%-- if, else의 종료임을 정의--%>
			</tr>
			</c:forEach>
		</table>
		
	</main>
</body>
</html>