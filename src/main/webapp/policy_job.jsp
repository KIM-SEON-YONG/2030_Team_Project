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
<title>취업지원</title>
<!-- favicon에러를 위해 favicon.ico 파일추가  => 엥그래도 뜸-->
<link rel="icon" href="<%= request.getContextPath() %>/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="assets/css/policy.css" />
</head>
<body>
	<div class="container">
		<div class="welfare-content">
			<p class="welfare_title">취업 지원</p>
			<!-- welfare 박스(옵션+결과) -->

			<div class="welfare-option">
				<!-- 폼의 기본 제출 동작을 방지하고 AJAX로 받아서 처리할 예정 -->
				<form id="searchForm" onsubmit="return false;">
				<!-- onfocus="regionModalBtn()" 속성 사용하지 않고 JavaScript에서 이벤트를 바인딩하는 방식 사용 -->
					<input type="text" id="regionInput" name="regionInput" placeholder="원하는 지역을 입력해 주세요.">
					<button type="button" class="regionSrcBtn" onclick="loadData()">검색</button>
				</form>
				
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
							<p class="welfare-title"><%=jobList.get(i).getWelfare_title()%></p>
							<p class="welfare-period"><%=jobList.get(i).getWelfare_period()%></p>
							<p class="welfare-content"><%=jobList.get(i).getWelfare_content()%></p>
						</a>
					</div>

					<%}	%>
				<%-- </c:if> --%>
				</div>
				
				<!-- AJAX로 검색 결과를 표시할 영역- 지역으로 검색한 값이 있다면 -->
				<div id="data-container">
					<!-- 비동기 데이터가 표기될 위치 -->
				</div>

			</div>
			<!-- welfare-card-group -->
		</div>
		<!-- welfare-content -->
	</div>
	<!-- container -->

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script>
	
	
		/* 모달창 - 지역 전체선택, 전체해제 버튼 */
		$("input[name=selectAll]").click(function() {
			if ($("input[name=selectAll]").is(":checked")) {
				console.log($("input[name=selectAll]").val())

				$("#selectAll").html("전체선택해제");

				/* 
				---트러블슈팅!!!!
				->li태그 안의 input태그와 텍스트 "전체선택"을 "전체선택해제"로 변경하는 과정에서 input의 html을 변경하니, input이 태그가 사라지고 텍스트만 입력됨
				->input태그의 부모를 (ex_.parent()) 가리켜서 input태그 함께 작성해서 변경했는데, 이벤트 클릭을 인식하지 못하는 현상이 나타남
				=> 해결방안! "전체선택"이라는 텍스트를 span 태그로 감싸서 span 태그의 id를 가리켜서 텍스트를 변경함!!!!! 
				
				$("input[name=selectAll]").parent().html("<input type='checkbox' name='selectAll' value='selectAll' checked>전체선택해제");
				parent(): input태그 안의 텍스트는 변경되었는데 감싸고 있는 li를 가르켜서 변경해야되므로 parent()추가 
				 */

				$("input[name=regionNm]").prop("checked", true);
			} else {
				console.log("선택해제됨");
				$("input[name=regionNm]").prop("checked", false);
				$("#selectAll").html("전체선택");
			}
		});

		/* 모달창에서 선택한 지역명을 input 박스로 넣기 */
		let regionNm = document.getElementsByClassName("regionNm");
		let modalBtn = document.getElementById("modalBtn")
		let regionInput = document.getElementById("regionInput")
		let regionCheck= "";

		let modal = document.querySelector(".modal");

		/* 모달창 - input 태그에 포커스하면 모달창 띄우기 (작업하기) */
		function regionModalBtn() {
			modal.style.display = "flex";
			modal.classList.add("show");
		}
		
		// 모달상태 초기화 - 모달을 열기 전에 초기 상태로 설정되도록 
		function modalClose() {
			modal.style.display = "none";
			modal.classList.remove("show");
		}
		
		
		// 이벤트 리스너를 JavaScript 코드내에서 동적으로 바인딩
		$(document).ready(function(){
			$("#regionInput").on("focus", function(){
				regionModalBtn();	
			});
			
			$(".modalClose").on("click", function(){
				modalClose();	
			});
			
			$(window).on("click", function(event){
				if($(event.target).hasClass('modal')){
					modalClose();
				}
			});
			
			// 모달상태 초기화 - 모달을 열기 전에 초기 상태로 설정되도록
			modal.style.display = "none";
			
		});
		
		
		/* 모달창 - 선택완료 클릭하면 선택한 내용 input에 추가 및 모달창 display:none */
		let getRegionCheck = ""; /* 변수만 선언하면 처음 undefined가 출력됨 */
		
		modalBtn.addEventListener("click", function() {
			for (let i = 0; i < regionNm.length; i++) {
				if (regionNm[i].checked) {
					getRegionCheck += regionNm[i].value;
					getRegionCheck += ","; /* 선택한 지역들에 대한 구분기호 */
				}
			}
			
			// 마지막 ',' 제거
			if(getRegionCheck.endsWith(",")){
				getRegionCheck = getRegionCheck.slice(0, -1);
			}
			
			console.log("선택된지역: " + getRegionCheck);
			$("#regionInput").val(getRegionCheck);

			modal.style.display = "none";
		})
		
		
		/* 지역 검색 후 결과 비동기통신 송출 */
		// jQuery AJAX 방법(배운방버)
		
		// 컨텍스트 패스 가져오기
		var contextPath = '<%=request.getContextPath() %>';
		function loadData(){
			var regionInputVal = $("#regionInput").val(); // input 값 가져오기
			
			// 지역 입력이 비어있을 경우 경고
			if(regionInputVal.trim() === ""){
				alert("검색할 지역을 입력해 주세요.");
				return;
			}
			
			
			
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
						$("#data-container").html("<p>해당 지역에는 복지혜택이 없습니다.</p>");
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
						    link.append($('<p>').addClass('welfare-title').text(policy.welfare_title));
						    link.append($('<p>').addClass('welfare-period').text(policy.welfare_period));
						    link.append($('<p>').addClass('welfare-content').text(policy.welfare_content));
	
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
                }
			});
			
		}
		
		
	</script>
</body>
</html>