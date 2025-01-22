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


/////////////////////////////////////////////////////////////////////////// write.js
document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    const postIndex = urlParams.get("index");
    const posts = JSON.parse(localStorage.getItem("posts")) || [];
    const post = postIndex !== null ? posts[postIndex] : null;
  
    if (post) {
      // 기존 게시글 데이터 로드
      document.getElementById("title").value = post.title;
      document.getElementById("author").value = post.author;
      document.getElementById("content").value = post.content;
  
      post.categories.forEach((category) => {
        const checkbox = document.querySelector(`input[value="${category}"]`);
        if (checkbox) checkbox.checked = true;
      });
    }
  
    document.getElementById("write-form").addEventListener("submit", function (event) {
      event.preventDefault();
  
      const title = document.getElementById("title").value;
      const author = document.getElementById("author").value;
      const content = document.getElementById("content").value;
      const categories = [];
      
      document.querySelectorAll("input[type=checkbox]:checked").forEach((checkbox) => {
        categories.push(checkbox.value);
      });
  
      const postData = { title, author, content, categories, date: new Date().toISOString() };
  
      if (post) {
        // 수정
        posts[postIndex] = postData;
        alert("게시글이 수정되었습니다.");
      } else {
        // 새 글 작성
        posts.push(postData);
        alert("새 게시글이 작성되었습니다.");
      }
  
      localStorage.setItem("posts", JSON.stringify(posts));
      location.href = "index.html";
    });
  });
  //////////////////////////////////////////////////////////////////////////post.js 미정
  