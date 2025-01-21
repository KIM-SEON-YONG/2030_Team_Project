// 검색 기능 구현
document.addEventListener("DOMContentLoaded", function () {
    const searchInput = document.getElementById("search-input");
    const tableRows = document.querySelectorAll("#board-table tbody tr");

    // 검색창에 입력 이벤트 리스너 추가
    searchInput.addEventListener("input", function (event) {
        const query = event.target.value.toLowerCase();

        tableRows.forEach(row => {
            const rowText = row.textContent.toLowerCase();
            if (rowText.includes(query)) {
                row.style.display = ""; // 검색어가 포함된 행 표시
            } else {
                row.style.display = "none"; // 검색어가 포함되지 않은 행 숨기기
            }
        });
    });

    // 글쓰기 버튼 클릭 이벤트
    const writeButton = document.querySelector(".btn-pink");
    writeButton.addEventListener("click", function () {
        alert("글쓰기 페이지로 이동합니다!");
        // location.href = "/write"; // 실제 글쓰기 페이지로 이동
    });

    console.log("Membership Board JS loaded!");
});
