// 타이머 관련 변수
let lastInputTime = null;
let timeoutTimer = null;


// 챗봇 대화창 토글 (보이거나 숨기기)
function toggleChat() {
	var chatContainer = document.getElementById("chat-container");
	if (chatContainer.style.display === "none" || chatContainer.style.display === "") {
		chatContainer.style.display = "block"; // 채팅창 보이기
	} else {
		chatContainer.style.display = "none"; // 채팅창 숨기기
	}
}

// 메시지 전송 함수
function sendMessage() {
	var userMessage = document.getElementById("userMessage").value.trim(); // 사용자 입력메시지
	
	

	if (userMessage === "") {
		alert("메시지를 입력해 주세요.");
		return;
	}


	// 서버로 넘기기 전 사용자 입력값 검증
	// 자음만 입력된 경우 
	if (/^[ㄱ-ㅎ]+$/.test(userMessage)) {
		alert("잘못된 입력입니다. 유효한 질문을 입력해 주세요.");
		document.getElementById("userMessage").value = ""; // 입력 필드 초기화
		return;
	}
	// 모음만 입력된 경우 
	if (/^[ㅏ-ㅣ]+$/.test(userMessage)) {
		alert("잘못된 입력입니다. 유효한 질문을 입력해 주세요.");
		document.getElementById("userMessage").value = ""; // 입력 필드 초기화
		return;
	}
	// 영문 자음만 입력된 경우 (영문 자음만으로 이루어진 입력)
	if (/^[bcdfghjklmnpqrstvwxyz]+$/i.test(userMessage)) {
		alert("다시 입력해주세요");
		document.getElementById("userMessage").value = ""; // 입력 필드 초기화
		return;
	}
	// 영문 모음만 입력된 경우 (영문 모음만으로 이루어진 입력)
	if (/^[aeiou]+$/i.test(userMessage)) {
		alert("다시 입력해주세요");
		document.getElementById("userMessage").value = ""; // 입력 필드 초기화
		return;
	}


	// 사용자 메시지를 채팅창에 추가
	var chatBox = document.getElementById("chat-box");
	var userMsgElement = document.createElement("div");
	userMsgElement.classList.add("chat-message", "user-message");
	userMsgElement.innerText = userMessage;
	chatBox.appendChild(userMsgElement);

	// "종료!" 입력 시 타이머 취소하고 종료 메시지 출력
	if (userMessage === "종료!") {
		if (timeoutTimer !== null) {
			clearTimeout(timeoutTimer); // 타이머 취소
		}
		var botMessage = document.createElement("div");
		botMessage.classList.add("chat-message", "bot-message");
		botMessage.innerHTML = "궁금하신 사항은 해결되셨나요? 더 나은 챗봇이 되기 위해 열심히 학습할게요. 챗봇을 종료하겠습니다.";
		chatBox.appendChild(botMessage);

		// 입력 필드 초기화(input 초기화)
		document.getElementById("userMessage").value = "";
		return; // "종료!" 입력 시 더 이상 처리하지 않음 - 함수가 종료됨

	}

	// **영문으로 입력 시** 먼저 안내 메시지를 추가
	if (/^[a-zA-Z\s]+$/.test(userMessage)) {
		var botMessage = document.createElement("div");
		botMessage.classList.add("chat-message", "bot-message");
		botMessage.innerText = "영문으로 입력 시 제한된 답변을 받을 수 있습니다.";
		chatBox.appendChild(botMessage);
	}

	// 마지막 입력 시간 갱신
	lastInputTime = Date.now();

	// 타이머 리셋
	if (timeoutTimer !== null) {
		clearTimeout(timeoutTimer);
	}

	// 30초 후 알림을 표시하는 타이머 설정
	timeoutTimer = setTimeout(() => {
		// 30초 동안 입력이 없으면 알림을 표시
		var timeoutMessage = document.createElement("div");
		timeoutMessage.classList.add("chat-message", "bot-message");
		timeoutMessage.innerText = "문의사항이 없을 경우 '종료!'를 입력해 주세요.";
		chatBox.appendChild(timeoutMessage);

		// 채팅창 스크롤 자동 이동
		chatBox.scrollTop = chatBox.scrollHeight;
	}, 30000); // 30초 후 실행

	// AJAX 요청 (Servlet과 Flask 챗봇 API 연결)
	var xhr = new XMLHttpRequest();
	xhr.open("POST", "ChatbotCon", true);
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	// 요청이 완료되었을 때만 처리
	xhr.onload = function() {
		if (xhr.status === 200) {
			try {
				// JSON 응답 처리
				var response = JSON.parse(xhr.responseText);
				var botMessage = document.createElement("div");
				botMessage.classList.add("chat-message", "bot-message");
				botMessage.innerText = response.answer;
				chatBox.appendChild(botMessage);

				// 채팅창 스크롤 자동 이동
				chatBox.scrollTop = chatBox.scrollHeight;
			} catch (error) {
				// JSON 파싱 오류
				console.error("JSON 파싱 오류: ", error);
				alert("챗봇 응답을 불러오는 중 오류 발생!");
			}
		} else {
			// 서버 응답 오류 처리
			console.error("서버 응답 오류: " + xhr.status);
			alert("서버에서 오류가 발생했습니다!");
		}
	};

	// 오류가 발생했을 경우의 처리
	xhr.onerror = function() {
		alert("AJAX 요청 중 오류가 발생했습니다!");
	};

	// 요청 전송
	xhr.send("userMessage=" + encodeURIComponent(userMessage));

	// 입력 필드 초기화
	document.getElementById("userMessage").value = "";
}

// 엔터키로 메시지 전송
function handleKeyPress(event) {
	if (event.key === "Enter") {
		sendMessage();
	}
}