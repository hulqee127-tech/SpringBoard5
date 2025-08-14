<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="startnum" value="${searchDto.pagination.startPage}" />
<c:set var="endnum" value="${searchDto.pagination.endPage}" />
<c:set var="totalpagecount" value="${searchDto.pagination.totalPageCount}" />

<div id="paging">
	<table>
		<tr>
		<!-- 처음/이전 -->
			<c:if test="${ startnum gt 1 }">
				<td><a href="/BoardPaging/boardList?nowpage=1&menu_id=${menuDto.menu_id}">⏮</a></td>
				<td><a href="/BoardPaging/boardList?nowpage=${ startnum - 1 }&menu_id=${menuDto.menu_id}">⏪</a></td>
			</c:if>
			
			<c:forEach var="pagenum" begin="${startnum}" end="${endnum}" step="1">
				<td><a href="/BoardPaging/boardList?nowpage=${pagenum}&menu_id=${menuDto.menu_id}">${pagenum}</a></td>
			</c:forEach>
			
		<!-- 다음/마지막 -->
			<c:if test="${ endnum lt totalpagecount }">	
				<td><a href="/BoardPaging/boardList?nowpage=${ endnum + 1 }&menu_id=${menuDto.menu_id}">⏩</a></td>
				<td><a href="/BoardPaging/boardList?nowpage=${ totalpagecount }&menu_id=${menuDto.menu_id}">⏭</a></td>
			</c:if>
		</tr>
	</table>
</div>