<%@page import="com.TTteamProject.model.BoardDAO"%>
<%@page import="com.TTteamProject.model.BoardDTO"%>
<%@page import="com.TTteamProject.model.RegionDTO"%>
<%@page import="com.TTteamProject.model.RegionDAO"%>
<%@page import="com.TTteamProject.model.PolicyDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.TTteamProject.model.PolicyDAO"%>
<%@ page import="com.TTteamProject.model.UserDTO"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<title>청년복지몰</title>

<!-- 부트스트랩 코드 -->
<link
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- 공용 -->
<link rel="stylesheet" href="assets/css/common.css">
<!-- main-->
<link rel="stylesheet" href="assets/css/Main.css">
<!-- 취업,결혼,출산 -->
<link rel="stylesheet" href="assets/css/policy.css">
<!-- 커뮤니티 -->
<link rel="stylesheet" href="assets/css/board.css">
<!-- 다크모드 -->
<link rel="stylesheet" href="assets/css/DarkMode.css">
</head>

<body>
	<div class="container">
		<!-- Intro Page -->
		<div class="intro" id="intro">
			<div class="spark">
				<span>S.</span> <span>P.</span> <span>A.</span> <span>R.</span> <span>K.</span>
			</div>
			<div class="spark-sub">
				<span>Support.</span> <span>Prepare.</span> <span>Achieve.</span> <span>Reach.</span>
				<span>Keep.</span>
			</div>
		</div>

		<!-- 다크 모드 토글 버튼 -->
		<button class="toggle-btn" onclick="toggleDarkMode()">
			<span id="mode-icon">🌙</span> <span id="mode-text">다크 모드</span>
		</button>
		<!-- 해더  -->
		<%@ include file="Header.jsp"%>


		<!-- 첫번재 섹션  -->
		<section class="section01">
			<!-- Main Content -->
			<div class="main" id="main">
				<div class="text-box">
					<div class="welfare-option">
						<div class="welfare_srch">
							<!-- 폼의 기본 제출 동작을 방지하고 AJAX로 받아서 처리할 예정 -->
							<form id="searchForm" onsubmit="return false;">
								<!-- onfocus="regionModalBtn()" 속성 사용하지 않고 JavaScript에서 이벤트를 바인딩하는 방식 사용 -->
								<input type="text" id="regionInput" name="regionInput"
									placeholder="지역을 입력해 주세요.">
								<button type="button" class="regionSrcBtn"
									onclick="invokeLoadData()">검색</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- 모달창 영역 -->
			<div class="modal">
				<div class="modal_body">
					<div class="modalClose" onclick="modalClose()"></div>
					<h2>지역을 선택해주세요</h2>
					<form action="">
						<ul>
							<li>전라도
								<ul class="regionList">
									<li><input type="checkbox" name="selectAll"
										value="selectAll"><span id="selectAll">전체선택</span></li>
									<%
									/* 지역리스트 가져오기 */
									RegionDAO regionDAO = new RegionDAO();
									List<RegionDTO> regionList = regionDAO.regionList();
									for (int i = 0; i < regionList.size(); i++) {
									%>

									<li><input type="checkbox" class="regionNm"
										name="regionNm"
										value="<%=regionList.get(i).getRegion_name()%>"><%=regionList.get(i).getRegion_name()%></li>
									<%
									}
									%>

								</ul>
							</li>
						</ul>
						<!-- <button id="modalBtn" onclick="getCheckboxValue()">선택 완료</button> -->
						<button type="button" id="modalBtn">선택 완료</button>
					</form>
				</div>
			</div>
			<!-- modal창 종료 -->
			<!-- welfare-option -->
			<div id="categories">
				<div class="category">
					<button class="box" data-target="#list-item-1">취업</button>
					<button class="box" data-target="#list-item-2">결혼</button>
					<button class="box" data-target="#list-item-3">출산</button>
					<button class="box1" data-target="#list-item-4">커뮤니티게시판</button>
				</div>
			</div>
		</section>


		<!-- 두번째 색션- 취업  -->
		<section class="section02">
			<h4 id="list-item-1" class="section-tit">취업정보 확인하기</h4>
			<a href="policy_job.jsp" class="more">더보기 <i class="ico-add"
				aria-hidden="true"></i>
			</a>

			<!-- 기본 데이터 표시 영역 -->
			<div id="default-container-job">
				<%
				/* 취업 복지정책 가져오기 */
				PolicyDAO policyDAO = new PolicyDAO();
				List<PolicyDTO> jobList = policyDAO.jobList();

				// 상위 4개만 가져오기
	            int maxItemsToShow = 4;
	            if (jobList.size() > maxItemsToShow) {
	            	jobList = jobList.subList(0, maxItemsToShow); // 상위 4개만 추출
	            }
				
				for (int i = 0; i < jobList.size(); i++) {
				%>
				<div class="welfare-card">
					<a href="<%=jobList.get(i).getWelfare_url()%>" target="_blank">
						<span class="welfare_sort welfare_sort_job">취업</span>
						<span class="welfare_sort welfare_region"><%=jobList.get(i).getRegion_name() %></span>
						<p class="welfare_title welfare_title_job"><%=jobList.get(i).getWelfare_title()%></p>
						<p class="welfare_period welfare_period_job"><%=jobList.get(i).getWelfare_period()%></p>
						<p class="welfare_content welfare_content_job"><%=jobList.get(i).getWelfare_content()%></p>
					</a>
				</div>
				<%
				}
				%><!-- for문 닫는 스크립틀릿 -->
			</div>
			<!-- AJAX로 검색 결과를 표시할 영역- 지역으로 검색한 값이 있다면 -->
			<div id="data-container-job">
				<!-- 비동기 데이터가 표기될 위치 -->
			</div>
			<!-- 지역혜택 더보기 -->
			<div class="boon1">
				<a href="BS1.html">지역혜택 보러 가보자고~~ 홍보도 해보자고~~</a>
			</div>
		</section>


		<!-- 세번째 섹션 - 결혼 -->
		<section class="section03">
			<h4 id="list-item-2" class="section-tit">결혼정보 확인하기</h4>
			<a href="policy_wedding.jsp" class="more">더보기 <i class="ico-add"
				aria-hidden="true"></i>
			</a>
			<div class="welfare-card-group">
				<!-- 기본 데이터 표시 영역 -->
				<div id="default-container-wedding">
					<%
					/* 결혼 복지정책 가져오기 */
					List<PolicyDTO> weddingList = policyDAO.weddingList();

					// 상위 4개만 가져오기
		            if (weddingList.size() > maxItemsToShow) {
		            	weddingList = weddingList.subList(0, maxItemsToShow); // 상위 4개만 추출
		            }
					
					for (int i = 0; i < weddingList.size(); i++) {
					%>

					<div class="welfare-card">
						<a href="<%=weddingList.get(i).getWelfare_url()%>" target="_blank">
							<span class="welfare_sort welfare_sort_wedding">결혼</span>
							<span class="welfare_sort welfare_region"><%=weddingList.get(i).getRegion_name() %></span>
							<p class="welfare_title welfare_title_wedding"><%=weddingList.get(i).getWelfare_title()%></p>
							<p class="welfare_period welfare_perid_wedding"><%=weddingList.get(i).getWelfare_period()%></p>
							<p class="welfare_content welfare_content_wedding"><%=weddingList.get(i).getWelfare_content()%></p>
						</a>
					</div>
					<%
					}
					%><!-- for문 닫는 스크립틀릿 -->
				</div>

				<!-- AJAX로 검색 결과를 표시할 영역- 지역으로 검색한 값이 있다면 -->
				<div id="data-container-wedding">
					<!-- 비동기 데이터가 표기될 위치 -->
				</div>
			</div>
			<!-- 지역혜택 더보기 -->
			<div class="boon2">
				<a href="BS1.html">지역혜택 보러 가보자고~~ 홍보도 해보자고~~</a>
			</div>
		</section>

		<!-- 네번째 색션 - 출산 -->
		<section class="section04">
			<!-- welfare-card-group -->
			<h4 id="list-item-3" class="section-tit">출산정보 확인하기</h4>
			<a href="policy_pregnancy.jsp" class="more">더보기 <i class="ico-add"
				aria-hidden="true"></i>
			</a>
			<div class="welfare-card-group">
				<!-- 기본 데이터 표시 영역 -->
				<div id="default-container-preg">
					<%
					/* 출산 복지정책 가져오기 */
					List<PolicyDTO> pregList = policyDAO.pregList();

					// 상위 4개만 가져오기
		            if (pregList.size() > maxItemsToShow) {
		                pregList = pregList.subList(0, maxItemsToShow); // 상위 4개만 추출
		            }
					
					for (int i = 0; i < pregList.size(); i++) {
					%>
					<div class="welfare-card">
						<a href="<%=pregList.get(i).getWelfare_url()%>" target="_blank">
							<span class="welfare_sort welfare_sort_preg">출산</span>
							<span class="welfare_sort welfare_region"><%=pregList.get(i).getRegion_name() %></span>
							<p class="welfare_title welfare_title_preg"><%=pregList.get(i).getWelfare_title()%></p>
							<p class="welfare_period welfare_period_preg"><%=pregList.get(i).getWelfare_period()%></p>
							<p class="welfare_content welfare_content_preg"><%=pregList.get(i).getWelfare_content()%></p>
						</a>
					</div>
					<%
					}
					%><!-- for문 닫는 스크립틀릿 -->
				</div>
				<!-- AJAX로 검색 결과를 표시할 영역- 지역으로 검색한 값이 있다면 -->
				<div id="data-container-preg">
					<!-- 비동기 데이터가 표기될 위치 -->
				</div>

			</div>
			<!-- welfare-card-group -->

			<!-- 지역혜택 더보기 -->
			<div class="boon3">
				<a href="BS1.html">지역혜택 보러 가보자고~~ 홍보도 해보자고~~</a>
			</div>
		</section>
		<!-- 다섯번째 섹션 - 커뮤 -->
		<section class="section05">
			<h4 id="list-item-4" class="section-tit">커뮤니티 게시판</h4>
			<a href="boardList.jsp" class="more">더보기 <i class="ico-add"
				aria-hidden="true"></i></a>
			<%
			BoardDAO dao = new BoardDAO();
			List<BoardDTO> boardList = dao.boardList();

			// 게시글 갯수 제한: 상위 5개 게시글만 표시
			int maxPostsToShow = 5;
			if (boardList.size() > maxPostsToShow) {
				boardList = boardList.subList(0, maxPostsToShow); // 상위 5개만 추출
			}
			%>
			<div class="board_box1">
				<!-- 상단 제목 -->
				<div class="header">
					<h1>나만 알고 있는 복지 추천하기👍</h1>
					<p>오직 '나만'알고 있는 복지를 추천해주세요~ 당첨되신 분들에게 복지포인트를 드립니다.</p>
				</div>
				<!-- 게시판 테이블 -->
				<table class="table">
					<tbody id="postList">
						<!-- 게시글 항목 -->
						<%
						for (BoardDTO board : boardList) {
						%>
						<tr
							onclick="location.href='getBoard.jsp?b_idx=<%=board.getB_idx()%>';">
							<td><%=board.getB_idx()%></td>
							<td><%=board.getB_category()%></td>
							<td><%=board.getB_title()%></td>
							<td><%=board.getUserId()%></td>
							<td><%=board.getCreate_dt()%></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>

				<!-- 글쓰기 버튼 -->
				<div class="text-end mt-3">
					<button class="btn btn-pink"
						onclick="location.href='board-write.html'">글쓰기</button>
				</div>
				<!-- 지역혜택 더보기 -->
			</div>
			<div class="boon4">
				<a href="BS1.html">지역혜택 보러 가보자고~~ 홍보도 해보자고~~</a>
			</div>
		</section>
		<!-- board_box -->
	</div>
	<!-- container -->
	<!-- 풋터 -->
	<%@ include file="Footer.jsp"%>

	<!-- main-box  -->

	<!-- 로딩 인디케이터 -->
	<div id="loading" style="display: none;">
		<!-- 스피너 이미지 사용 예시 -->
		<img src="images/loading.png" alt="Loading..." />
		<!-- 또는 CSS로 스피너 만들기 -->
		<!--
	    <div class="spinner"></div>
	    -->
	</div>


	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>

	<!-- 취업,결혼,출산 js , 지역 선택 시 가져오는 정보 ajax -->
	<script src="assets/js/policy.js"></script>

	<!-- board -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>


	<!-- JavaScript -->
	<script>
	/* 다크모드!! */
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
	
	
	
	
		// 버튼 클릭 시 해당 섹션으로 이동
	    document.querySelectorAll('.box, .box1').forEach(button => {
	        button.addEventListener('click', function () {
	            const targetId = this.getAttribute('data-target');
	            const targetElement = document.querySelector(targetId);
	            
	            if (targetElement) {
	                targetElement.scrollIntoView({ behavior: 'smooth' });
	            }
	        });
	    });

	
	
		// Intro 페이지 숨기기
		window.addEventListener('load', () => {
			const intro = document.getElementById('intro');
			setTimeout(() => {
				intro.classList.add('hidden');
			}, 1000);
		});
		
		
		/* 취업, 결혼, 출산 영역 */
		// 지역 선택 시 취업, 결혼, 출산 데이터 호출
		function invokeLoadData() {
			var regionInputVal = $("#regionInput").val().trim();
			
			if(!regionInputVal) {
				alert("지역을 입력해 주세요.");
				return;
			}
			
			// 로딩 인디케이터 표시
			$("#loading").show();
			var contextPath = '<%=request.getContextPath()%>';
			
			// 1) 취업 컨트롤러 -> #data-container-job에 표시
			fetchData(contextPath, "/PolicyJobSrcCon", "#data-container-job", regionInputVal);
			
			// 2) 결혼 컨트롤러 -> #data-container-wedding에 표시
			fetchData(contextPath, "/PolicyWeddingSrcCon", "#data-container-wedding", regionInputVal);
			
			// 3) 출산 컨트롤러 -> #data-container-preg에 표시
			fetchData(contextPath, "/PolicyPregSrcCon", "#data-container-preg", regionInputVal);
			
			
		}
		
		/* 커뮤니티 영역 */
		document.addEventListener("DOMContentLoaded", function() {
			let rows = document.querySelectorAll(".clickable-row");
	 		rows.forEach(row => {
   				row.addEventListener("click", function() {
           			let url = this.getAttribute("data-href");
            		if (url) {
                		window.location.href = url;
	           		}
	        	});
	    	});
		});
		
		// 로컬 스토리지에서 게시글 불러오기
		document.addEventListener("DOMContentLoaded", function () {
			const posts = JSON.parse(localStorage.getItem("posts")) || [];
			const postList = document.getElementById("postList");

			// 게시글 데이터를 테이블에 추가
			posts.forEach((post, index) => {
				const row = document.createElement("tr");

				// 카테고리 표시 부분
				const categoryBadges = post.categories ? post.categories.split(", ").map(category =>
					`<span class="category-badge">${category}</span>`).join(" ") : "";

				// 각 td 태그에 클릭 이벤트 추가
				row.innerHTML = `
            <td onclick="viewPost(${index})">${index + 1}</td>
            <td>${categoryBadges}</td> <!-- 카테고리 배지 표시 -->
            <td onclick="viewPost(${index})">${post.title}</td>
            <td onclick="viewPost(${index})">${post.author}</td>
            <td onclick="viewPost(${index})">${post.date}</td>
          `;
				postList.appendChild(row);
			});
		});

		// 게시글 상세보기로 이동하는 함수
		function viewPost(index) {
			// 게시글의 인덱스를 URL에 추가하여 상세 페이지로 이동
			window.location.href = `board-post.html?index=${index}`;
		}
		
	
</script>
</body>
</html>