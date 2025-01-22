<%@page import="com.TTteamProject.model.RegionDAO"%>
<%@page import="com.TTteamProject.model.RegionDTO"%>
<%@page import="com.TTteamProject.model.PolicyDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.TTteamProject.model.PolicyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취업지원</title>
<style>
	/* CSS 기본초기값 */
	*, *::before, *::after {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
	}
	
	body {
		font-family: 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif;
	}
	
	button {
		background: none;
		color: inherit;
		border: none;
		cursor: pointer;
		outline: inherit;
	}
	
	a {
		text-decoration: none;
		color: inherit;
	}
	
	li {
		list-style: none;
	}
	
	input:focus {
		outline: none;
	}
	
	/* welfare card */
	.container {
		width: 1280px;
		margin: 0 auto;
	}
	
	.welfare-card-group {
		display: flex;
		flex-wrap: wrap; /* 자식 요소가 부모의 너비를 초과하면 줄바꿈 */
		gap: 16px; /* 카드 간 간격 */
	}
	
	.welfare-card {
		background-color: #c0c0c0;
		border: 1px solid #333;
		width: 308px;
		height: 400px;
		padding: 16px;
		margin-bottom: 16px;
		border-radius: 20px;
	}
	
	.welfare-content {
		overflow: hidden; /* 내용이 넘치지 않도록 숨김 처리 */
	}
	
	.welfare-option input {
		padding: 10px 50px 10px 10px;
		background-image: url(./images/external-link.png);
		background-repeat: no-repeat;
		background-position: 205px center;
		background-size: 12px 12px;
	}
	
	/* 모달창 */
	.modal {
		position: absolute;
		display: none;
		
		justify-content: center;
		top: 0;
		left: 0;
		
		width: 100%;
		height: 100%;
		
		background-color: rgba(0,0,0,0.4);
	}
	
	.modal_body {
		position: absolute;
		top: 50%; /* 모달을 화면가운데 놓기 위함 */
		
		width: 400px;
		height: 600px;
		
		padding: 40px;
		
		text-align: center;
		
		background-color: rgb(255,255,255);
		border-radius: 10px;
		box-shadow: 0 2px 3px 0 rgba(34,36,38,0.15); /* 테두리 그림자 */
		
		transform: translateY(-50%); /* 모듈창 열었을 때 위치설정 가운데로 */
		
	}
	
	#modalBtn {border:1px solid #000; padding: 3px 30px; }
	
	.modalClose { 
		width: 100%;
		/* position: absolute 80px 0px; */
		background-image: url(./images/modalClose.png);
		background-repeat: no-repeat; 
		background-size: 12px 12px;
	 	background-position: right top;
		padding: 12px 12px;
		border: 3px solid #000;
	 }
	
	.modal_body>h2 { margin-top: 50px; }
</style>
</head>
<body>
	<div class="container">



		<div class="welfare-content">
			<!-- welfare 박스(옵션+결과) -->
			<div class="welfare-option">
				<form action="welfareJoin" method="get">
					<input type="text" id="regionInput" name="regionInput" onfocus="regionModalBtn()" placeholder="원하는 지역을 입력해 주세요.">
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
										<!-- <li><input type="checkbox"  name="selectAll" value="selectAll">전체선택</li> -->
										<li><input type="checkbox"  name="selectAll" value="selectAll"><span id="selectAll">전체선택</span></li>
										<%
										RegionDAO regionDAO = new RegionDAO();
										List<RegionDTO> regionList = regionDAO.regionList();
										for(int i=0; i<regionList.size(); i++) {
										%>
										
										<li><input type="checkbox" class="regionNm" name="regionNm" value="<%=regionList.get(i).getRegion_name() %>"
											><%=regionList.get(i).getRegion_name() %></li>
										<%} %>
										
									</ul>
								</li>
							</ul>
							<!-- <button id="modalBtn" onclick="getCheckboxValue()">선택 완료</button> -->
							<button type="button" id="modalBtn">선택 완료</button>
						</form>
					</div>
				</div>

			</div>
			<!-- welfare-option -->
			<div class="welfare-card-group">
				<%
				/* 복지정책 가져오기 */
				PolicyDAO policyDAO = new PolicyDAO();
				List<PolicyDTO> policyList = policyDAO.selectJob();
				
				for(int i=0; i<policyList.size(); i++) { %>

				<div class="welfare-card">
					<a href="#" target="_blank">
						<p class="welfare-title"><%=policyList.get(i).getWelfare_title()%></p>
						<p class="welfare-period"><%=policyList.get(i).getWelfare_period() %></p>
						<p class="welfare-content"><%=policyList.get(i).getWelfare_content() %></p>
					</a>
				</div>

				<%} %>
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
		$("input[name=selectAll]").click(function(){
			if($("input[name=selectAll]").is(":checked")){
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
			}else{
				console.log("선택해제됨");
				$("input[name=regionNm]").prop("checked", false);
				//$("input[name=selectAll]").parent().html("<input type='checkbox' name='selectAll' value='selectAll'>전체선택")
				$("#selectAll").html("전체선택");
			}
		});
		
		/* 모달창에서 선택한 지역명을 input 박스로 넣기 */
		let regionNm = document.getElementsByClassName("regionNm");
		let modalBtn = document.getElementById("modalBtn")
		let regionInput = document.getElementById("regionInput")
		let regionCheck;
		
		let modal = document.querySelector(".modal");
		
		/* 모달창 - input 태그에 포커스하면 모달창 띄우기 (작업하기) */
		
		function regionModalBtn(){
			modal.style.display="flex";
		} 
		
		/* 모달창- 모달창 x 아이콘 클릭 시 닫기 */
		function modalClose(){
			modal.style.display="none";
		}
		
		
		/* 모달창 - 선택완료 클릭하면 선택한 내용 input에 추가 및 모달창 display:none*/
		let getRegionCheck=""; /* 변수만 선언하면 처음 undefined가 출력됨 */
		modalBtn.addEventListener("click", function(){
			for(let i=0; i<regionNm.length; i++){
				console.log("1234"+regionNm[i].value);
				if(regionNm[i].checked) {
					
					getRegionCheck += regionNm[i].value;
					getRegionCheck += ","; /* 선택한 지역들에 대한 구분기호 */
				}else{
					getRegionCheck+=''; 
				}
			}
			console.log("선택된지역: "+getRegionCheck);
			$("#regionInput").val(getRegionCheck);
			
			modal.style.display="none";
		})
		
		
	</script>
</body>
</html>