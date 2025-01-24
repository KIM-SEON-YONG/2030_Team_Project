<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>Insert title here</title>
</head>
<style>
body {
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    min-height: 100vh; /* 화면의 최소 높이를 100vh로 설정 */
}
.main-content {
    flex-grow: 1; /* 본문 콘텐츠가 남는 공간을 채우도록 설정 */
}
footer {
	position: relative; /* 페이지 하단에 고정 */
    background-color: rgb(234, 197, 245);
    color: black;
    height: 150px; /* 푸터 높이 설정 */
    width: 100%; /* 푸터 너비 100% 설정 */
    display: flex;
    justify-content: center;
    align-items: center;
    bottom: 0; /* 항상 하단에 고정 */
}

.footer-content {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	text-align: center;
	height: 100%;
}

.footer-content h3 {
	font-size: 2rem;
	text-transform: capitalize;
	line-height: 2rem;
}

.footer-content p {
	font-size: 14px;
	color: black;
}

.socials {
	list-style: none;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 10px 0;
}

.socials li {
	margin: 0 10px;
}

.socials a {
	text-decoration: none;
	color: black;
	padding: 5px;
}

.socials a i {
	font-size: 1.1rem;
	width: 20px;
	transition: color .4s ease;
}

.socials a:hover i {
	color: aqua;
}

@media ( max-width :500px) {
	.footer-menu ul {
		display: flex;
		margin-top: 10px;
		margin-bottom: 20px;
	}
}
</style>
</head>
<body>
	<footer>
		<div class="footer-content">
			<h3>S.P.A.R.K</h3>
			<p>Support.Prepare.Achieve.Reach.Keep.</p>

			<ul class="socials">
				<li>Tel:000-000-0000</li>
				<li><a href="mailto:skapk@smhrd.kr"><i class="fa fa-envelope"></i> email:skapk@smhrd.kr</a></li>
				<li><a href="#"><i class="fa fa-facebook"></i> 페북</a></li>
				<li><a href="#"><i class="fa fa-twitter"></i> 트위터</a></li>
				<li><a href="#"><i class="fa fa-instagram"></i> 인스타그램</a></li><br>
				<p>S.P.A.R.K &copy;2025</p>
			</ul>
		</div>
	</footer>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
		rel="stylesheet">
		
	</script>
</body>
</html>