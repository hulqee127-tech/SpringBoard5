<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="icon" type="image/jpg" href="/img/saitama.jpg" />
<link rel="stylesheet" href="/css/common.css" />
</head>
<body bgcolor="black" style = "color:white">
	<main>
		<form action="/Users/Login" method="POST">
			<input type="hidden" name="uri" value="${ uri }" />
			<input type="hidden" name="menu_id" value="${ menu_id }" />
			<input type="hidden" name="nowpage" value="${ nowpage }" />
			
			<h2>Log-In</h2>
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="userid" /></td>
				</tr>
				<tr>
					<td>암호</td>
					<td><input type="password" name="passwd" /></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="LOGIN" /></td>
				</tr>
			</table>
		</form>
	</main>

</body>
</html>