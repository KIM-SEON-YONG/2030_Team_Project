<%@page import="com.TTteamProject.model.RegionDAO"%>
<%@page import="com.TTteamProject.model.RegionDTO"%>
<%@page import="com.TTteamProject.model.PolicyDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.TTteamProject.model.PolicyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취업 지원</title>
<!-- favicon에러를 위해 favicon.ico 파일추가  => 엥그래도 뜸-->
<link rel="icon" href="<%= request.getContextPath() %>/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="assets/css/common.css"><!-- 공용 -->
<link rel="stylesheet" href="assets/css/policy.css" />
</head>
<body>
<div id="header"></div>
	<div class="container">
		<div class="welfare-content">
			<p class="welfare_header_title">취업 지원</p>
			
			<!-- welfare 박스(옵션+결과) -->

			<div class="welfare-option">
				<div class="welfare_srch">
					<!-- 폼의 기본 제출 동작을 방지하고 AJAX로 받아서 처리할 예정 -->
					<form id="searchForm" onsubmit="return false;">
					<!-- onfocus="regionModalBtn()" 속성 사용하지 않고 JavaScript에서 이벤트를 바인딩하는 방식 사용 -->
						<input type="text" id="regionInput" name="regionInput" placeholder="원하는 지역을 입력해 주세요.">
						<button type="button" class="regionSrcBtn" onclick="loadData()">검색</button>
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
			<div class="welfare-card-group">
				<!-- 기본 데이터 표시 영역 -->
				<div id="default-container">
				<%-- <c:if test="${selecJobList == null }"> --%>
				<!-- 지역으로 검색한 값이 없다면 -->
					<%
					/* 복지정책 가져오기 */
					PolicyDAO policyDAO = new PolicyDAO();
					List<PolicyDTO> jobList = policyDAO.jobList();

					for (int i = 0; i < jobList.size(); i++) {
					%>

					<div class="welfare-card">
						<a href="<%=jobList.get(i).getWelfare_url() %>" target="_blank">
							<span class="welfare_sort welfare_sort_job">취업</span>
							<p class="welfare_title welfare_title_job"><%=jobList.get(i).getWelfare_title()%></p>
							<p class="welfare_period welfare_period_job"><%=jobList.get(i).getWelfare_period()%></p>
							<p class="welfare_content welfare_content_job"><%=jobList.get(i).getWelfare_content()%></p>
						</a>
					</div>

					<%} %>
				<%-- </c:if> --%>
				</div>
				
				<!-- AJAX로 검색 결과를 표시할 영역- 지역으로 검색한 값이 있다면 -->
				<div id="data-container-job">
					<!-- 비동기 데이터가 표기될 위치 -->
				</div>

			</div>
			<!-- welfare-card-group -->
		</div>
		<!-- welfare-content -->
	</div>
	<!-- container -->
	
	<!-- 로딩 인디케이터 -->
	<div id="loading" style="display: none;">
	    <!-- 스피너 이미지 사용 예시 -->
	    <img src="images/loading.png" alt="Loading..." />
	    <!-- 또는 CSS로 스피너 만들기 -->
	    <!--
	    <div class="spinner"></div>
	    -->
	</div>
<div id="footer"></div>
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
		
	<!-- 취업,결혼,출산 js , 지역 선택 시 가져오는 정보 ajax -->
	<script src="assets/js/policy.js"></script>
	<script src="assets/js/ajax.js"></script>
	
	<script>
	
	
	/* 해더 및 풋터 */
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

	
	/* main처럼 불러올 수 있는데, 그냥 이대로 두기 - 시간 있으면 수정  */
	
	/* ***주의*** AJAX 코드는 해당 jsp 하단에 위치해야됨!!! 별도로 .js 파일로 빼지 않기!! */
	
	/* 지역 검색 후 결과 비동기통신 송출 */
	// jQuery AJAX 방법(배운방법 사용) 
	
	// 컨텍스트 패스 가져오기
	var contextPath = '<%=request.getContextPath() %>';
	function loadData(){
		var regionInputVal = $("#regionInput").val(); // input 값 가져오기
		
		// 지역 입력이 비어있을 경우 경고
		if(regionInputVal.trim() === ""){
			alert("검색할 지역을 입력해 주세요.");
			return;
		}
		
		// 로딩 인디케이터 표시
		$("#loading").show();
		
		console.log("contextPath: "+contextPath); // contextPath: 2030_Team_Project
		
		// form에서 컨트롤러로 가지않고! AJAX로 컨트롤러에 접근하고 AJAX로 값을 리턴 받는 방식
		$.ajax({
			url: contextPath + "/PolicyJobSrcCon",
			method: "GET",
			dataType: "json",
			data: { regionInput: regionInputVal }, // 'regionInput' 파라미터 전송
			success: function(dataList){
				console.log("받은데이터:", dataList); // 데이터 확인
				$("#data-container").empty();
				
				// 검색이 이루어지면 무조건 기본 데이터 숨기기
				$("#default-container").hide();
				
				if(dataList.length === 0){
					// 이미지 요소 생성 및 클래스 추가
					 var noBenefitImg = $('<img>').attr('src', 'images/policy_noBenefit.png').attr('alt', '해당 지역에는 복지혜택이 없습니다.').addClass('noBenefit');
					// #data-container에 이미지 추가
					$("#data-container").append(noBenefitImg);
					$("#data-container").addClass('no-data'); /* img를 가운데 정렬하기 위해 class 추가 */
					
					
					return;
				}else {
					
					$.each(dataList, function(index, policy){
						console.log("처리중인 정책:", policy); // 각 정책 데이터 확인
						console.log("welfare_title:", policy.welfare_title);
						console.log("welfare_period:", policy.welfare_period);
						console.log("welfare_content:", policy.welfare_content);
						
						
						
						// 템플릿 리터럴 사용하여 HTML 사용함 => jQuery 방식
					    // 상위 div 생성
					   var welfareCard = $('<div>').addClass('welfare-card');

					    // 링크 생성
					    var link = $('<a>').attr('href', policy.welfare_url).attr('target', '_blank');

					    // 동적 텍스트 추가
					    link.append($('<span>').addClass('welfare_sort welfare_sort_job').html('취업'));
					    link.append($('<p>').addClass('welfare_title welfare_title_job').text(policy.welfare_title));
					    link.append($('<p>').addClass('welfare_period welfare_period_job').text(policy.welfare_period));
					    link.append($('<p>').addClass('welfare_content welfare_content_job').text(policy.welfare_content));

					    // 링크를 상위 div에 추가
					    welfareCard.append(link);

					    // 상위 div를 #data-container에 추가
					    $("#data-container").append(welfareCard);
					});
					
				}
				
			},
			error: function(jqXHR, textStatus, errorThrown) {
                console.error("AJAX 오류:", textStatus, errorThrown);
                console.error("응답 내용:", jqXHR.responseText);
                alert('데이터 로드 실패');
            },
            complete: function(){
            	// 로딩 인디케이터 숨기기
            	$("#loading").hide();
            }
            
		});
		
	}
	
	</script>

</body>
</html>