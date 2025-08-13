<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새메뉴추가</title>
<link rel="icon" type="image/jpg" href="/img/saitama.jpg" />
<link rel="stylesheet" href="/css/common.css" />
<style>
	td {
		padding : 10px;
		width : 700px;
		text-align : center;
	}
	
	td:nth-of-type(1) {
		width : 200px;
	}
	/*
	input[type="text"], input[type="number"] {
		width : 100%;
	}
	*/
	input {
		width : 100%;
	}
	input[type="submit"] {
		width : 100px;
	}
</style>
</head>
<body bgcolor="black" style = "color:white">
	<main>
		<h2>새메뉴추가&nbsp;&nbsp;||&nbsp;&nbsp;<a href="http://localhost:9090/">홈</a></h2>
		<form action="/Menus/Write" method="POST">
			<table>
				<tr>
					<td>메뉴 아이디</td>
					<td><input type="text" name="menu_id" value="${insertData.menu_id}" readonly /></td>
				</tr>
				<tr>
					<td>메뉴 이름</td>
					<td><input type="text" name="menu_name" /></td>
				</tr>
				<tr>
					<td>메뉴 순서</td>
					<td><input type="number" name="menu_seq" value="${insertData.menu_seq}" /></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="등록" /></td>
				</tr>
			</table>
		</form>
	</main>
<script>
	//const formEl = document.querySelectorAll("form")[0];//form이 2개 이상일 경우 가장 첫번째 form 가져오기
	const formEl = document.querySelector("form");
	formEl.addEventListener('submit',function(e){
		//alert('OK');
		const inputEl1 = document.querySelector('[name="menu_id"]');
		const inputEl2 = document.querySelector('[name="menu_name"]');
		const inputEl3 = document.querySelector('[name="menu_seq"]');
		if(inputEl1.value.trim() == ''){
			alert('메뉴 아이디가 입력되지 않았습니다');
			inputEl1.focus();
			e.stopPropagation();	// 이벤트 버블링 방지
			e.preventDefault();		// 이벤트 취소
			//return false
		}else if(inputEl2.value.trim() == ''){
			alert('메뉴이름이 입력되지 않았습니다.');
			inputEl2.focus();
			e.stopPropagation();
			e.preventDefault();
			//return false
		}else if(inputEl3.value.trim() == ''){
			alert('메뉴순서가 입력되지 않았습니다.');
			inputEl3.focus();
			e.stopPropagation();
			e.preventDefault();
			//return false
		}else{
			if(confirm('입력하시겠습니까?')){
				alert('입력되었습니다.');
			}else{
				e.stopPropagation();	// 이벤트 버블링 방지
				e.preventDefault();		// 이벤트 취소
			}
		}
	})
</script>
</body>
</html>