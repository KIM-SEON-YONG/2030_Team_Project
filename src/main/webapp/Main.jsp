<%@page import="com.TTteamProject.model.RegionDTO"%>
<%@page import="com.TTteamProject.model.RegionDAO"%>
<%@page import="com.TTteamProject.model.PolicyDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.TTteamProject.model.PolicyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<title>청년복지몰</title>
<!-- Link to external CSS file -->
<link rel="stylesheet" href="assets/css/common.css"><!-- 공용 -->
<link rel="stylesheet" href="assets/css/Main.css"><!-- main-->
<link rel="stylesheet" href="assets/css/policy.css" /><!-- 취업,결혼,출산 -->


<!-- 부트스트랩 코드 -->
<link src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
		rel="stylesheet">
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

	<div id="header"></div>

	<!-- Main Content -->
	<div class="main-box">
		<div class="main" id="main">
			<h1>S.P.A.R.K</h1>

			<div class="welfare-option">
				<div class="welfare_srch">
					<!-- 폼의 기본 제출 동작을 방지하고 AJAX로 받아서 처리할 예정 -->
					<form id="searchForm" onsubmit="return false;">
						<!-- onfocus="regionModalBtn()" 속성 사용하지 않고 JavaScript에서 이벤트를 바인딩하는 방식 사용 -->
						<input type="text" id="regionInput" name="regionInput"
							placeholder="지역을 입력해 주세요.">
						<button type="button" class="regionSrcBtn" onclick="invokeLoadData()">검색</button>
					</form>
				</div>
				<!-- 모달창 영역 -->
				<div class="modal">
					<div class="modal_body">
						<div class="modalClose" onclick="modalClose()"></div>
						<h2>모달창 제목</h2>
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

			</div>
			<!-- welfare-option -->


			<!-- 카테고리 -->
			<div id="categories">
				<div class="category">
					<button class="box" data-target="#list-item-1">취업</button>
					<button class="box" data-target="#list-item-2">결혼</button>
					<button class="box" data-target="#list-item-3">출산</button>
					<button class="box" data-target="#list-item-4">커뮤니티게시판</button>
				</div>
			</div>

			<!-- Sections -->
			<h4 id="list-item-1">취업</h4>
			<div class="welfare-card-group">
				<!-- 기본 데이터 표시 영역 -->
				<div id="default-container-job">
					<%
					/* 취업 복지정책 가져오기 */
					PolicyDAO policyDAO = new PolicyDAO();
					List<PolicyDTO> jobList = policyDAO.jobList();

					for (int i = 0; i < jobList.size(); i++) {
					%>

					<div class="welfare-card">
						<a href="<%=jobList.get(i).getWelfare_url()%>" target="_blank">
							<span class="welfare_sort welfare_sort_job">취업</span>
							<p class="welfare_title welfare_title_job"><%=jobList.get(i).getWelfare_title()%></p>
							<p class="welfare_period welfare_period_job"><%=jobList.get(i).getWelfare_period()%></p>
							<p class="welfare_content welfare_content_job"><%=jobList.get(i).getWelfare_content()%></p>
						</a>
					</div>
					<%} %><!-- for문 닫는 스크립틀릿 -->
				</div>

				<!-- AJAX로 검색 결과를 표시할 영역- 지역으로 검색한 값이 있다면 -->
				<div id="data-container-job">
					<!-- 비동기 데이터가 표기될 위치 -->
				</div>

			</div>
			<!-- welfare-card-group -->
			<!-- 더보기 -->
			<!-- <button class="more-btn">더보기</button> -->

			<!-- 지역혜택 더보기 -->
			<p>
				<button class="region">지역혜택 보러가기!!- 지역혜택이 있는 지역의 이미지를 넣어
					홍보가능함을 암시하기</button>
			<p>
			<h4 id="list-item-2">결혼</h4>
			<div class="welfare-card-group">
				<!-- 기본 데이터 표시 영역 -->
				<div id="default-container-wedding">
					<%
					/* 결혼 복지정책 가져오기 */
					List<PolicyDTO> weddingList = policyDAO.weddingList();

					for (int i = 0; i < weddingList.size(); i++) {
					%>

					<div class="welfare-card">
						<a href="<%=weddingList.get(i).getWelfare_url()%>" target="_blank">
							<span class="welfare_sort welfare_sort_wedding">결혼</span>
							<p class="welfare_title welfare_title_wedding"><%=weddingList.get(i).getWelfare_title()%></p>
							<p class="welfare_period welfare_perid_wedding"><%=weddingList.get(i).getWelfare_period()%></p>
							<p class="welfare_content welfare_content_wedding"><%=weddingList.get(i).getWelfare_content()%></p>
						</a>
					</div>
					<%} %><!-- for문 닫는 스크립틀릿 -->
				</div>

				<!-- AJAX로 검색 결과를 표시할 영역- 지역으로 검색한 값이 있다면 -->
				<div id="data-container-wedding">
					<!-- 비동기 데이터가 표기될 위치 -->
				</div>

			</div>
			<!-- welfare-card-group -->

			<h4 id="list-item-3">출산</h4>

			<div class="welfare-card-group">
				<!-- 기본 데이터 표시 영역 -->
				<div id="default-container-preg">
					<%
					/* 출산 복지정책 가져오기 */
					List<PolicyDTO> pregList = policyDAO.pregList();

					for (int i = 0; i < pregList.size(); i++) {
					%>

					<div class="welfare-card">
						<a href="<%=pregList.get(i).getWelfare_url()%>" target="_blank">
							<span class="welfare_sort welfare_sort_preg">출산</span>
							<p class="welfare_title welfare_title_preg"><%=pregList.get(i).getWelfare_title()%></p>
							<p class="welfare_period welfare_period_preg"><%=pregList.get(i).getWelfare_period()%></p>
							<p class="welfare_content welfare_content_preg"><%=pregList.get(i).getWelfare_content()%></p>
						</a>
					</div>
					<%} %><!-- for문 닫는 스크립틀릿 -->
				</div>
				<!-- AJAX로 검색 결과를 표시할 영역- 지역으로 검색한 값이 있다면 -->
				<div id="data-container-preg">
					<!-- 비동기 데이터가 표기될 위치 -->
				</div>

			</div>
			<!-- welfare-card-group -->
			<input type="checkbox" class="more-btn">
			<!-- 더보기 -->
			<div>
				<div class="region">지역혜택 더보기</div>
				<!-- 지역혜택 더보기 -->
			</div>


			<h4 id="list-item-4">커뮤니티 게시판</h4>
			<section class="section4">
				<div class="board-box">
					<div class="board">
						커뮤니티
						<div class="board-content">정책추천하기!!!!</div>
						<div class="board-content">설명설명</div>
						<div class="board-content">~~~~~~~</div>
						<div class="board-content">~~~~~!!!</div>
					</div>
				</div>
			</section>
		</div> <!-- main -->

		<div id="footer"></div>
	</div> <!-- main-box  -->
	
	<!-- 로딩 인디케이터 -->
	<div id="loading" style="display: none;">
	    <!-- 스피너 이미지 사용 예시 -->
	    <img src="images/loading.png" alt="Loading..." />
	    <!-- 또는 CSS로 스피너 만들기 -->
	    <!--
	    <div class="spinner"></div>
	    -->
	</div>
</div><!-- container -->
	

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
		
	<!-- 취업,결혼,출산 js , 지역 선택 시 가져오는 정보 ajax -->
	<script src="assets/js/policy.js"></script>
	

	<!-- JavaScript -->

	<script>
	
	
		// Header.jsp 파일을 #header div에 로드
	    fetch('Header.jsp')
	      .then(response => response.text())
	      .then(data => {
	        document.getElementById('header').innerHTML = data;
	      })
	      .catch(error => console.error('Error loading header:', error));

	    // Footer.jsp 파일을 #footer div에 로드
	    fetch('Footer.jsp')
	      .then(response => response.text())
	      .then(data => {
	        document.getElementById('footer').innerHTML = data;
	      })
	      .catch(error => console.error('Error loading footer:', error));
		
	
		// 버튼 클릭 시 해당 섹션으로 이동
    document.querySelectorAll('.box').forEach(button => {
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
		
		
		// 지역 선택 시 취업, 결혼, 출산 데이터 호출
		function invokeLoadData() {
			var regionInputVal = $("#regionInput").val().trim();
			
			if(!regionInputVal) {
				alert("지역을 입력해 주세요.");
				return;
			}
			
			// 로딩 인디케이터 표시
			$("#loading").show();
			var contextPath = '<%=request.getContextPath() %>';
			
			// 1) 취업 컨트롤러 -> #data-container-job에 표시
			fetchData(contextPath, "/PolicyJobSrcCon", "#data-container-job", regionInputVal);
			
			// 2) 결혼 컨트롤러 -> #data-container-wedding에 표시
			fetchData(contextPath, "/PolicyWeddingSrcCon", "#data-container-wedding", regionInputVal);
			
			// 3) 출산 컨트롤러 -> #data-container-preg에 표시
			fetchData(contextPath, "/PolicyPregSrcCon", "#data-container-preg", regionInputVal);
			
			
		}
		
	</script>
</body>
</html>