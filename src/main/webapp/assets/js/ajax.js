

/* 참고!!!! 
* 해당 페이지는 취업, 결혼, 출산의 각각의 페이지를 1개의 js코드로 실행하기 위해 만들어진 페이지로 
* 현재는 각각의 페이지(policy_) 의 하단의 js코드로 돌아가고 있고 
* ajax.js 해당 파일의 코드는 사용 안하는 중입니다~ - 25.1.31 작성

*/



/* 지역 검색 후 결과 비동기통신 송출 */
// jQuery AJAX 방법(배운방법 사용) 

// ajax.js 파일을 사용 시 jsp에는 아래 코드 내용 작성
/*function invokeLoadData() {
	var contextPath = '<%=request.getContextPath() %>';
	var controllerUrl = "/PolicyJobSrcCon";
	var regionInputSelector = "#regionInput";
	var dataContainerSelector = "#data-container";
	var defaultContainerSelector = "#default-container"; // 필요시, 없으면 null
	
	loadData(contextPath, controllerUrl, regionInputSelector, dataContainerSelector, defaultContainerSelector);
}*/
 

/* 지역에 맞는 '취업' 정책 가져오기 */
function loadData(contextPath, controllerUrl, regionInputSelector, dataContainerSelector, defaultContainerSelector) {
	var regionInputVal = $(regionInputSelector).val(); // input값 가져오기

	// 지역 입력이 비어있을 경우 경고
	if (regionInputVal.trim() === "") {
		alert("지역을 선택해 주세요.");
		return;
	}

	// 로딩 인디케이터 표시
	$("#loading").show();

	// AJAX 요청
	// form에서 컨트롤러로 가지않고! AJAX로 컨트롤러에 접근하고 AJAX로 값을 리턴 받는 방식
	$.ajax({
		url: contextPath + controllerUrl,
		method: "GET",
		dataType: "json",
		data: { regionInput: regionInputVal }, // 'regionInput' 파라미터 전송
		success: function(dataList) {
			console.log("받은데이터:", dataList); // 데이터 확인
			$(dataContainerSelector).empty();

			// 검색이 이루어지면 무조건 기본 데이터 숨기기
			$(defaultContainerSelector).hide();

			if (dataList.length === 0) {
				// 이미지 요소 생성 및 클래스 추가
				var noBenefitImg = $('<img>')
					.attr('src', '../../images/policy_noBenefit.png')
					.attr('alt', '해당 지역에는 복지혜택이 없습니다.')
					.addClass('noBenefit');
					
				// #data-container에 이미지 추가
				$(dataContainerSelector).append(noBenefitImg);
				$(dataContainerSelector).addClass('no-data'); /* img를 가운데 정렬하기 위해 class 추가 */


				return;
			} else {
				
				$.each(dataList, function(index, policy) {
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
					link.append(
						$('<span>').addClass('welfare_sort welfare_sort_job').html('취업'),
						$('<p>').addClass('welfare_title welfare_title_job').text(policy.welfare_title),
						$('<p>').addClass('welfare_period welfare_period_job').text(policy.welfare_period),
						$('<p>').addClass('welfare_content welfare_content_job').text(policy.welfare_content)
					);

					// 링크를 상위 div에 추가
					welfareCard.append(link);

					// 상위 div를 #data-container-job에 추가
					$(dataContainerSelector).append(welfareCard);
				});

			}

		},
		error: function(jqXHR, textStatus, errorThrown) {
			console.error("AJAX 오류:", textStatus, errorThrown);
			console.error("응답 내용:", jqXHR.responseText);
			alert('데이터 로드 실패');
		},
		complete: function() {
			// 로딩 인디케이터 숨기기
			$("#loading").hide();
		}

	});

}

/* 지역에 맞는 '결혼' 정책 가져오기 */
// 컨텍스트 패스 가져오기
var contextPath = '<%=request.getContextPath() %>';
function loadData() {
	var regionInputVal = $("#regionInput").val(); // input 값 가져오기

	// 지역 입력이 비어있을 경우 경고
	if (regionInputVal.trim() === "") {
		alert("검색할 지역을 입력해 주세요.");
		return;
	}

	// 로딩 인디케이터 표시
	$("#loading").show();


	// form에서 컨트롤러로 가지않고! AJAX로 컨트롤러에 접근하고 AJAX로 값을 리턴 받는 방식
	$.ajax({
		url: contextPath + "/PolicyWeddingSrcCon",
		method: "GET",
		dataType: "json",
		data: { regionInput: regionInputVal }, // 'regionInput' 파라미터 전송
		success: function(dataList) {
			console.log("받은데이터:", dataList); // 데이터 확인
			$("#data-container-wedding").empty();

			// 검색이 이루어지면 무조건 기본 데이터 숨기기
			$("#default-container").hide();

			if (dataList.length === 0) {

				// 이미지 요소 생성 및 클래스 추가
				var noBenefitImg = $('<img>').attr('src', 'images/policy_noBenefit.png').attr('alt', '해당 지역에는 복지혜택이 없습니다.').addClass('noBenefit');
				// #data-container-wedding에 이미지 추가
				$("#data-container-wedding").append(noBenefitImg);
				$("#data-container-wedding").addClass('no-data'); /* img를 가운데 정렬하기 위해 class 추가 */


				return;
			} else {

				$.each(dataList, function(index, policy) {
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
					link.append($('<span>').addClass('welfare_sort welfare_sort_wedding').html('결혼'));
					link.append($('<p>').addClass('welfare_title welfare_title_wedding').text(policy.welfare_title));
					link.append($('<p>').addClass('welfare_period welfare_period_wedding').text(policy.welfare_period));
					link.append($('<p>').addClass('welfare_content welfare_content_wedding').text(policy.welfare_content));

					// 링크를 상위 div에 추가
					welfareCard.append(link);

					// 상위 div를 #data-container-wedding에 추가
					$("#data-container-wedding").append(welfareCard);
				});

			}

		},
		error: function(jqXHR, textStatus, errorThrown) {
			console.error("AJAX 오류:", textStatus, errorThrown);
			console.error("응답 내용:", jqXHR.responseText);
			alert('데이터 로드 실패');
		},
		complete: function() {
			// 로딩 인디케이터 숨기기
			$("#loading").hide();
		}
	});

}


/* 지역에 맞는 '출산' 정책 가져오기 */
// 컨텍스트 패스 가져오기
var contextPath = '<%=request.getContextPath() %>';
function loadData() {
	var regionInputVal = $("#regionInput").val(); // input 값 가져오기

	// 지역 입력이 비어있을 경우 경고
	if (regionInputVal.trim() === "") {
		alert("검색할 지역을 입력해 주세요.");
		return;
	}

	$("#loading").show();

	// form에서 컨트롤러로 가지않고! AJAX로 컨트롤러에 접근하고 AJAX로 값을 리턴 받는 방식
	$.ajax({
		url: contextPath + "/PolicyPregSrcCon",
		method: "GET",
		dataType: "json",
		data: { regionInput: regionInputVal }, // 'regionInput' 파라미터 전송
		success: function(dataList) {
			console.log("받은데이터:", dataList); // 데이터 확인
			$("#data-container-preg").empty();

			// 검색이 이루어지면 무조건 기본 데이터 숨기기
			$("#default-container").hide();

			if (dataList.length === 0) {

				// 이미지 요소 생성 및 클래스 추가
				var noBenefitImg = $('<img>').attr('src', 'images/policy_noBenefit.png').attr('alt', '해당 지역에는 복지혜택이 없습니다.').addClass('noBenefit');
				// #data-container-preg에 이미지 추가
				$("#data-container-preg").append(noBenefitImg);
				$("#data-container-preg").addClass('no-data'); /* img를 가운데 정렬하기 위해 class 추가 */

				return;
			} else {

				$.each(dataList, function(index, policy) {
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
					link.append($('<span>').addClass('welfare_sort welfare_sort_preg').html('출산'));
					link.append($('<p>').addClass('welfare_title welfare_title_preg').text(policy.welfare_title));
					link.append($('<p>').addClass('welfare_period welfare_period_preg').text(policy.welfare_period));
					link.append($('<p>').addClass('welfare_content welfare_content_preg').text(policy.welfare_content));

					// 링크를 상위 div에 추가
					welfareCard.append(link);

					// 상위 div를 #data-container-preg에 추가
					$("#data-container-preg").append(welfareCard);
				});

			}

		},
		error: function(jqXHR, textStatus, errorThrown) {
			console.error("AJAX 오류:", textStatus, errorThrown);
			console.error("응답 내용:", jqXHR.responseText);
			alert('데이터 로드 실패');
		},
		complete: function() {
			// 로딩 인디케이터 숨기기
			$("#loading").hide();
		}

	});

}