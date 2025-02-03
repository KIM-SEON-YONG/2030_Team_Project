// 다크 모드 토글 함수
function toggleDarkMode() {
    document.body.classList.toggle("dark-mode");
    const isDarkMode = document.body.classList.contains("dark-mode");
    localStorage.setItem("darkMode", isDarkMode);

    updateButtonText(isDarkMode);
}

// 버튼 텍스트 및 아이콘 업데이트
function updateButtonText(isDarkMode) {
    const modeText = document.getElementById("mode-text");
    const modeIcon = document.getElementById("mode-icon");

    if (isDarkMode) {
        modeText.textContent = "라이트 모드 활성화";
        modeIcon.innerHTML = "🌞"; // 밝은 태양 아이콘
    } else {
        modeText.textContent = "다크 모드 활성화";
        modeIcon.innerHTML = "🌙"; // 어두운 달 아이콘
    }
}

// 페이지 로드 시 저장된 다크 모드 상태 적용
window.onload = function () {
    const isDarkMode = localStorage.getItem("darkMode") === "true";
    if (isDarkMode) {
        document.body.classList.add("dark-mode");
    }
    updateButtonText(isDarkMode);
};
/**
 * 
 */