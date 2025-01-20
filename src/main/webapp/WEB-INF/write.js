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
  