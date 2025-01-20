<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취업지원</title>
<style>
	/* CSS 기본초기값 */
	*,
	*::before,
	*::after {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
	}
	body { font-family: 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif; }
	button { background: none; color: inherit; border: none; cursor: pointer; outline: inherit; }
	a { text-decoration: none; color: inherit; }
	li { list-style: none; }
	input:focus { outline:none; }
	
	
	/* welfare card */
	.container  { width: 1280px; margin: 0 auto; }
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
	
	.welfare-content { overflow: hidden; /* 내용이 넘치지 않도록 숨김 처리 */ } 
	.welfare-option input { 
		padding: 10px 50px 10px 10px;
		background-image: url(./images/external-link.png);
		background-repeat: no-repeat;
		background-position: 205px center;
		background-size: 12px 12px;
	 }
	
</style>
</head>
<body>
	<div class="container"> 
		<div class="welfare-content">  <!-- welfare 박스(옵션+결과) -->
			<div class="welfare-option"> 
				<form action="welfareJoin" method="get">
					<input type="text" name="regionNm" placeholder="원하는 지역을 입력해 주세요.">
				</form>
				<div class="modal">
					<div class="modal-header">
					</div>
					<div class="modal-body">
						<form action="">
							<ul>
								
								<li>전라도
									<ul class="regionList">
										<li><input type="checkbox" name="selectAll" value="selectAll" onclick="selectAll(this)">모두 선택하기</li>
										<li><input type="checkbox" name="regionSelec1" value="regionSlec1">목포시</li>
										<li><input type="checkbox" name="regionSelec2" value="regionSlec2">여수시</li>
										<li><input type="checkbox" name="regionSelec3" value="regionSlec3">순천시</li>
										<li><input type="checkbox" name="regionSelec4" value="regionSlec4">나주시</li>
									</ul>
								</li>
							</ul>
						</form>
					</div>
				</div>
				
			</div> <!-- welfare-option -->
			<div class="welfare-card-group">
				<div class="welfare-card">
					<a href="#" target="_blank">
						<p class="welfare-title">복지 제목</p>
						<p class="welfare-period">복지 기간</p>
						<p class="welfare-content">복지내용입니다.복지내용입니다.복지내용입니다.복지내용입니다.</p>
					</a>	
				</div>
				<div class="welfare-card">
					<a href="#" target="_blank">
						<p class="welfare-title">복지 제목</p>
						<p class="welfare-period">복지 기간</p>
						<p class="welfare-content">복지내용입니다.복지내용입니다.복지내용입니다.복지내용입니다.</p>
					</a>	
				</div>
				<div class="welfare-card">
					<a href="#" target="_blank">
						<p class="welfare-title">복지 제목</p>
						<p class="welfare-period">복지 기간</p>
						<p class="welfare-content">복지내용입니다.복지내용입니다.복지내용입니다.복지내용입니다.</p>
					</a>	
				</div>
				<div class="welfare-card">
					<a href="#" target="_blank">
						<p class="welfare-title">복지 제목</p>
						<p class="welfare-period">복지 기간</p>
						<p class="welfare-content">복지내용입니다.복지내용입니다.복지내용입니다.복지내용입니다.</p>
					</a>	
				</div>
				<div class="welfare-card">
					<a href="#" target="_blank">
						<p class="welfare-title">복지 제목</p>
						<p class="welfare-period">복지 기간</p>
						<p class="welfare-content">복지내용입니다.복지내용입니다.복지내용입니다.복지내용입니다.</p>
					</a>	
				</div>
			</div> <!-- welfare-card-group -->
		</div> <!-- welfare-content -->
	</div> <!-- container -->
	
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script>
		$("input[name=selectAll]").click(function(){
			if($("input[name=selectAll]").is(":checked")){
				for(let i=0; i<select)
				$("input[name=regionSelec1]").prop("checked", true);
			}else{
				$("input[name=regionSelec1]").prop("checked", false);
			}
		});
		
	</script>
</body>
</html>