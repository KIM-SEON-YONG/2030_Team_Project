document.addEventListener("DOMContentLoaded", function () {
  const postsPerPage = 12; // 페이지당 게시글 수
  const tableBody = document.querySelector("#postList");
  const pagination = document.querySelector(".pagination");
  const searchInput = document.getElementById("search-input");
  const allPosts = JSON.parse(localStorage.getItem("posts")) || [];
  let filteredPosts = [...allPosts];
  let currentPage = 1;

  // 게시글 표시
  function displayPosts(page, highlightQuery = "") {
    tableBody.innerHTML = ""; // 기존 데이터 제거
    const startIndex = (page - 1) * postsPerPage;
    const endIndex = startIndex + postsPerPage;
    const pagePosts = filteredPosts.slice(startIndex, endIndex);

    pagePosts.forEach((post, index) => {
      const postIndex = allPosts.indexOf(post); // 전체 게시글 중 인덱스 가져오기
      const isHighlighted =
        post.title.toLowerCase().includes(highlightQuery) ||
        post.author.toLowerCase().includes(highlightQuery);

      const row = document.createElement("tr");
      row.style.cursor = "pointer"; // 마우스 커서 변경
      row.style.backgroundColor = isHighlighted ? "#ffeff5" : ""; // 검색된 글 강조 배경
      row.addEventListener("click", () => {
        location.href = `post.html?index=${postIndex}`; // 게시글 클릭 시 상세보기로 이동
      });

      // 날짜를 YYYY-MM-DD 형식으로 변환
      const formattedDate = new Date(post.date).toLocaleDateString("ko-KR", {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
      }).replace(/\./g, "-");

      row.innerHTML = `
        <td>${startIndex + index + 1}</td>
        <td>
          ${post.categories.map((cat) => `<span class="badge bg-info me-2">${cat}</span>`).join("")}
          <a href="post.html?index=${postIndex}" class="text-decoration-none">${post.title}</a>
        </td>
        <td>${post.author}</td>
        <td>${formattedDate}</td> <!-- 날짜 형식 수정 -->
      `;
      tableBody.appendChild(row);
    });
  }

  // 페이지네이션 버튼 생성
  function setupPagination() {
    pagination.innerHTML = ""; // 기존 페이지네이션 제거
    const pageCount = Math.ceil(filteredPosts.length / postsPerPage);

    const createPageButton = (label, page) => {
      const li = document.createElement("li");
      li.classList.add("page-item");
      if (page === currentPage) li.classList.add("active");

      const link = document.createElement("a");
      link.classList.add("page-link");
      link.textContent = label;
      link.href = "#";
      link.addEventListener("click", (e) => {
        e.preventDefault();
        currentPage = page;
        displayPosts(currentPage, searchInput.value.toLowerCase());
        setupPagination();
      });

      li.appendChild(link);
      return li;
    };

    // "처음" 버튼
    if (currentPage > 1) {
      pagination.appendChild(createPageButton("처음", 1));
    }

    // "이전" 버튼
    if (currentPage > 1) {
      pagination.appendChild(createPageButton("이전", currentPage - 1));
    }

    // 번호 버튼
    for (let i = 1; i <= pageCount; i++) {
      pagination.appendChild(createPageButton(i, i));
    }

    // "다음" 버튼
    if (currentPage < pageCount) {
      pagination.appendChild(createPageButton("다음", currentPage + 1));
    }

    // "마지막" 버튼
    if (currentPage < pageCount) {
      pagination.appendChild(createPageButton("마지막", pageCount));
    }
  }

  // 검색 기능
  function filterPosts(query) {
    query = query.toLowerCase();
    filteredPosts = allPosts.filter(
      (post) =>
        post.title.toLowerCase().includes(query) ||
        post.author.toLowerCase().includes(query)
    );

    currentPage = 1; // 검색 시 첫 페이지로 이동
    displayPosts(currentPage, query);
    setupPagination();
  }

  // 검색 입력 이벤트 리스너
  searchInput.addEventListener("input", (event) => {
    filterPosts(event.target.value);
  });

  // 초기 실행
  displayPosts(currentPage);
  setupPagination();
});
