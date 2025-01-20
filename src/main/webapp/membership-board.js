document.addEventListener("DOMContentLoaded", function () {
    const tableBody = document.querySelector("#board-table tbody");
    const posts = JSON.parse(localStorage.getItem("posts")) || [];
  
    // 게시글 표시
    posts.forEach((post, index) => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td>${index + 1}</td>
        <td>
          ${post.categories.map((cat) => `<span class="badge bg-info me-2">${cat}</span>`).join("")}
          <a href="post.html?index=${index}" class="text-decoration-none">${post.title}</a>
        </td>
        <td>${post.author}</td>
        <td>${new Date(post.date).toLocaleDateString()}</td>
      `;
      tableBody.appendChild(row);
    });
  });
  document.addEventListener("DOMContentLoaded", function () {
    // "글쓰기" 버튼 이벤트 추가
    const writeButton = document.querySelector(".btn-pink");
    writeButton.addEventListener("click", function () {
      location.href = "write.html";
    });
  });
  
  