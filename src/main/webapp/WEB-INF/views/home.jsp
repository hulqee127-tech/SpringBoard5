<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈</title>
<link rel="icon" type="image/jpg" href="/img/saitama.jpg" />
<link rel="stylesheet" href="/css/common.css" />
<style>
	hr {
		height:5px;
		width : 250px;
	}
</style>
</head>
<body bgcolor="black" style = "color:white">
	<table id="table1">
		<tr>
			<td>
				<main>
					<h2>홈</h2>
					<!-- <a href="/test" >인사말</a> -->
					<hr />
					<a href="/Menus/menuList">메뉴목록</a>
					&nbsp;&nbsp;&nbsp;||
					<a href="/Menus/WriteForm">메뉴추가</a><br />
					<hr />
					<a href="/Users/userList">사용자목록</a>
					||
					<a href="/Users/WriteForm">사용자추가</a>
					<hr />
					<a href="/Board/boardList?menu_id=MENU01">게시글목록</a>
					||
					<a href="/Board/WriteForm?menu_id=MENU01">게시글추가</a>
				</main>
			</td>
			<td>
				<main>
					<h2><a onclick="login_chk()">Log-In</a></h2>
					<hr />
					<form name="form1" action="/Users/LogIn" method="POST">
					ID &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;||<input type="text" name="uid" id="uid" /><br />
					PASSWD||<input type="password" name="pwd" id="pwd" />
					</form>
				</main>
			</td>
		</tr>
	</table>
<script>
	function login_chk(e){
		//getElementsByNAme은 S 이므로 [0] 넣어서 데이터 받을 것.
		//const idEl = document.getElementsByName('uid')[0];
		//const pwdEl = document.getElementsByName('pwd')[0];
		const idEl = document.getElementById('uid');
		const pwdEl = document.getElementById('pwd');
		if (idEl.value == ''){
			alert('ID를 입력하세요');
			idEl.focus();
			return false;
			//e.stopPropagation();	// 이벤트 버블링 방지
			//e.preventDefault();
		}else if (pwdEl.value == ''){
			alert('PASSWD를 입력하세요');
			pwdEl.focus();
			return false;
			//e.stopPropagation();	// 이벤트 버블링 방지
			//e.preventDefault();
		}else{
			//location.href="/Users/userList";
			//form1.submit();
			userchk();
		}
	}
	
	function userchk(){
		//alert('a');
		form1.submit();
	}
</script>
</body>
</html>