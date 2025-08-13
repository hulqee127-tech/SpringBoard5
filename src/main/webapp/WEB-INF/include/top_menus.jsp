<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- 메뉴목록 -->
	<table id="top_menu">
		<tr>
			<c:forEach var="menu" items="${menuList}">
			<td>
				<a href="/Board/boardList?menu_id=${menu.menu_id}">${menu.menu_name}</a>
			</td>
			</c:forEach>
		</tr>
	</table>