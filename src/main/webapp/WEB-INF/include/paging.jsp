<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="paging">
	<table>
		<tr>
		<!-- 처음/이전 -->
			<td><a href="/BoardPaging/List?nowpage=1&menu_id=MENU01">⏮</a></td>
			<td><a href="">⏪</a></td>
			<c:forEach var="pagenum" begin="${startnum}" end="${endnum}" step="1">
				<td><a href="/BoardPaging/List?nowpage=${pagenum}&menu_id=MENU01">${pagenum}</a></td>
			</c:forEach>
			
		<!-- 다음/마지막 -->	
			<td><a href="">⏩</a></td>
			<td><a href="">⏭</a></td>
		</tr>
	</table>
</div>
<%-- <div id="paging">
	<table>
		<tr>
			<c:forEach var="pagenum" begin="${startnum}" end="${endnum}" step="1">
			<td>
				<a href="">
					${pagenum}
				</a>
			</td>
			</c:forEach>
		</tr>
	</table>
</div> --%>