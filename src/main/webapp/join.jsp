<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="assets/css/common.css">
<script>
        $(document).ready(function() {
            // jQuery 코드
        });
</script>
</head>
<title>회원가입</title>
<style>
.join_container > h2 {
	text-align: center;
	margin-bottom: 50px;
}

/* 전체 폼을 감싸는 div */
.input-container {
	width: 400px;
	margin: 0 auto; /* 가운데 정렬 */
	padding: 20px;
	background-color: #f9f9f9;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* 각 입력 필드와 버튼들의 스타일 */
input[type="text"], input[type="password"], button {
	width: 100%; /* 입력 필드가 div 전체 너비를 차지 */
	height: 35px;
	margin-bottom: 15px; /* 입력 필드 사이 간격 */
	padding-left: 10px;
	font-size: 14px;
	border-radius: 5px;
	border: 1px solid #ccc;
	outline: none;
	background-color: #f0f0f0;
}

/* 라디오 버튼들을 가로로 배치 */
input[type="radio"] {
	width: auto;
	margin-right: 10px; /* 라디오 버튼 사이 간격 */
}

/* 버튼의 스타일 */
.btn {
	width: 250px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.button-container {
	display: flex; /* Flexbox 사용 */
	justify-content: center; /* 가로축 중앙 정렬 */
	gap: 10px; /* 버튼 간 간격 */
	margin-top: 20px; /* 입력 필드와의 간격 */
	
	width: 400px;
	margin: 0 auto; /* 가운데 정렬 */
	padding: 20px;
	background-color: #f9f9f9;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
</style>

</style>
</head>
<body>
	<!-- 해더  -->
	<%@ include file="Header.jsp"%>
	<div class="container join_container">
		<h2>회원가입</h2>
		<table>
			<form name="join" action="JoinCon" method="post" onsubmit="return sendIt();">
				<div class="input-container">
					<input type="text" name="USER_NAME" size="20" placeholder="이름">
					<input type="radio" name="USER_GENDER" value="m">남자 <input
						type="radio" name="USER_GENDER" value="f">여자 <input
						type="text" name="USER_BIRTHDATE" size="20" placeholder="생년월일">
					<input type="text" name="USER_ID" id="USER_ID" size="20"placeholder="아이디">
					<button type="button" class="btn" id="ID_CHECK"onclick="return checkId()">ID 중복 확인</button>
					<input type="password" name="USER_PW" size="20" placeholder="비밀번호">
					<input type="password" name="USER_PW_CHECK" size="20"placeholder="비밀번호확인"> 
					<input type="text" name="USER_PHONE"size="20" placeholder="전화번호 ex)010-1234-5678"> 
					<input type="text" name="USER_EMAIL" size="20" placeholder="이메일 ex)example@domain.com">
					<input type="text"name="FAV_WELFARE" size="20" placeholder="관심분야"> 
					<input type="text" name="FAV_REGION" size="20" placeholder="관심지역">
				</div>
				<div class="button-container">
					<input type="submit" value="가입하기" class="btn">
					<button type="button" class="btn"><a href="Main.jsp">취소하기</a></button>
					
				</div>
				<div id="idCheckResult" style="display: none;"></div>
			</form>
		</table>
	</div>
<!-- 풋터 -->
	<%@ include file="Footer.jsp"%>
	
	<script>
	let idCheck = 0;// ID 중복 체크 상태 (0: 미확인, 1: 사용 가능)
	
/* email중복확인 버튼 클릭 시 > 실행되는 함수 */ 
	function checkId() {
		let user_id = $('#USER_ID').val();
		// intput태그의 id값이 emailCheck인 데이터(입력된 이메일 값)가져오기
		// 이메일 입력 안 된 경우
		if (user_id == null) {
			alert("아이디를 입력해주세요!");
			return; // 함수 종료
		}// if절 끝
		//Ajex(Asynchronous javascript and xml), 비동기적인 webapp을 제작 할 때 사용
		$.ajax({
			url : "CheckIdCon", // 이메일 중복체크를 처리할 서버 url
			type : "post",
			data : {
				USER_ID : user_id
			},// 서버로 전송할 데이터
			success : function(response) {
				if (response == "duplicate") {
					alert("이미 사용중인 아이디입니다.")
				} else if (response == "available") {
					alert("사용 가능한 아이디입니다.")
				} else {
					alert("알 수 없는 오류가 발생했습니다.")
				}
			},
			error : function() {
				alert("서버와의 통신 오류가 발생했습니다.")
			}
		});
	}
	document.join.onsubmit = function(event) {
	    console.log('submit 이벤트 호출');
	    return sendIt();
	};

	const sendIt = () => {  // 회원가입 형식 체크하고 전송하는 함수
		const USER_NAME = document.forms['join'].USER_NAME;
	    const USER_GENDER = document.join.USER_GENDER;
	    const USER_BIRTHDATE = document.join.USER_BIRTHDATE;
	    const USER_PW = document.join.USER_PW;
	    const USER_PW_CHECK = document.join.USER_PW_CHECK;
	    const USER_PHONE = document.join.USER_PHONE;
	    const USER_EMAIL = document.join.USER_EMAIL;
	    const FAV_WELFARE = document.join.FAV_WELFARE;
	    const FAV_REGION = document.join.FAV_REGION;
	    
	 	// 이름 검사
	    if (USER_NAME.value.trim() === '') {
	        alert('이름을 입력해주세요.');
	        USER_NAME.focus();
	        return false;
	    } 
	   
	    // 성별 검사
	    if (!USER_GENDER.value) {
	        alert('성별을 선택해주세요.');
	        USER_GENDER[0].focus(); // 라디오 버튼의 첫 번째를 포커스
	        return false;
	    }

	    // 생년월일 검사
	    if (USER_BIRTHDATE.value.trim() === '') {
	        alert('생년월일을 입력해주세요.');
	        USER_BIRTHDATE.focus();
	        return false;
	    }

	    // ID 검사
	    if (USER_ID.value.trim() === '') {
	        alert('아이디를 입력해주세요.');
	        USER_ID.focus();
	        return false;
	    }
	 
	    // 비밀번호 검사
	    if (USER_PW.value.trim() === '') {
	        alert('비밀번호를 입력해주세요.');
	        USER_PW.focus();
	        return false;
	    }
	    if (USER_PW.value.length < 6 || USER_PW.value.length > 20) {
	        alert('비밀번호는 6~20자 사이로 입력해주세요.');
	        USER_PW.focus();
	        return false;
	    }
	    if (USER_PW.value !== USER_PW_CHECK.value) {
	        alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
	        USER_PW_CHECK.focus();
	        return false;
	    }
	    // 전화번호 검사
	    const expPhone = /^\d{3}-\d{3,4}-\d{4}$/;
	    if (!expPhone.test(USER_PHONE.value.trim())) {
	        alert('전화번호 형식이 올바르지 않습니다. 예: 010-1234-5678');
	        USER_PHONE.focus();
	        return false;
	    }
	 	// 이메일 검사
	    const expEmail = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
		if (!expEmail.test(USER_EMAIL.value.trim())) {
		    alert('이메일 형식이 올바르지 않습니다. 예: example@domain.com');
		    USER_EMAIL.focus();
		    return false;
		}
	    // 선호 분야 검사
	    if (!FAV_WELFARE.value) {
	        alert('선호 지역을 선택해주세요.');
	        FAV_REGION.focus();
	        return false;
	    }
	 	// 선호 지역 검사
	    if (!FAV_REGION.value) {
	        alert('선호 지역을 선택해주세요.');
	        FAV_REGION.focus();
	        return false;
	    }
	    
	    
	    // 모든 검사 통과 시 true 반환
	return true;
};


	</script>
</body>
</html>
