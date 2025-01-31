
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


let regionNm = document.getElementsByClassName("regionNm");
let modalBtn = document.getElementById("modalBtn")
let regionInput = document.getElementById("regionInput")
let regionCheck = "";

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
$(document).ready(function() {
	$("#regionInput").on("focus", function() {
		$("#regionInput").val(" ");
		regionModalBtn();
	});

	$(".modalClose").on("click", function() {
		modalClose();
	});

	$(window).on("click", function(event) {
		if ($(event.target).hasClass('modal')) {
			modalClose();
		}
	});

	// 모달상태 초기화 - 모달을 열기 전에 초기 상태로 설정되도록
	modal.style.display = "none";

});


/* 모달창 - '선택 완료' 클릭하면 선택한 내용 input에 추가 및 모달창 display:none */
modalBtn.addEventListener("click", function() {
	// 선택 완료 시마다 이전 선택 값을 초기화
	let selectedRegions = [];

	for (let i = 0; i < regionNm.length; i++) {
		if (regionNm[i].checked) {
			selectedRegions.push(regionNm[i].value);
		}
	}

	// 선택된 지역이 selectedRegions 안에 있는데 여기서 중복된 지역 제거
	let uniqueRegions = [...new Set(selectedRegions)];

	// 선택한 지역이 없으면 빈 문자열로 설정
	if (uniqueRegions.length === 0) {
		$("#regionInput").val("");
	} else {
		// 선택한 지역들을 콤마로 구분하여 입력창에 설정
		let regionString = uniqueRegions.join(",");
		console.log("선택된지역: " + regionString);
		$("#regionInput").val(regionString);
	}

	// 모달 닫기
	modal.style.display = "none";
	modal.classList.remove("show");
});



/* 취업, 결혼, 출산 정책 관련한 js 코드들은 ajax 코드 위로 작성하기 */
/* ******************************************************************************** */
/* 지역 검색 후 결과 비동기통신 송출 */
// jQuery AJAX 방법(배운방법 사용) 

/*
* 특정 컨트롤러에 AJAX 요청을 보내고, 결과를 dataContainerSelector에 표시한다.
*
* @param {string} controllerUrl    - 예) "/PolicyJobSrcCon"
* @param {string} dataContainerSelector - 예) "#data-container-job"
* @param {string} regionInputVal   - 지역 입력값
*/

/* [Main.jsp] 지역에 맞는 '취업,결혼,출산'' 정책 가져오기 */

let pendingRequests = 0; // 로딩 인디케이터를 마지막 호출 시점에 숨기기 위한 카운터 변수

function fetchData(contextPath, controllerUrl, dataContainerSelector, regionInputVal) {
	pendingRequests++;
	console.log("contextPath: " + contextPath);

	// form에서 컨트롤러로 가지않고! AJAX로 컨트롤러에 접근하고 AJAX로 값을 리턴 받는 방식
	$.ajax({
		url: contextPath + controllerUrl,
		method: "GET",
		dataType: "json",
		data: { regionInput: regionInputVal }, // 'regionInput' 파라미터 전송
		success: function(dataList) {
			console.log("[" + controllerUrl + "] 받은데이터:", dataList); // 데이터 확인
			$(dataContainerSelector).empty();

			// 검색이 이루어지면 기본 데이터 숨기기
			if (controllerUrl == '/PolicyJobSrcCon') {
				$("#default-container-job").hide();
			} else if (controllerUrl == '/PolicyWeddingSrcCon') {
				$("#default-container-wedding").hide();
			} else if (controllerUrl == '/PolicyPregSrcCon') {
				$("#default-container-preg").hide();
			}

			// 데이터 없을 시 noBenefit.png 띄우기
			if (controllerUrl == '/PolicyJobSrcCon') {
				if (dataList.length === 0) {
					// 이미지 요소 생성 및 클래스 추가
					var noBenefitImg = $('<img>')
						.attr('src', 'images/policy_noBenefit.png')
						.attr('alt', '해당 지역에는 복지혜택이 없습니다.')
						.addClass('noBenefit');

					// #data-container-job에 이미지 추가
					$("#data-container-job").append(noBenefitImg);
					// img를 가운데 정렬하기 위해 .no-data class 추가 
					$("#data-container-job").addClass('no-data');
					// return;
				} else {
					// 기존 no-data 클래스 제거
					$(dataContainerSelector).removeClass('no-data');


					// 데이터 표시 로직
					$.each(dataList, function(index, policy) {
						console.log(controllerUrl + " 정책:", policy);


						// 템플릿 리터럴 사용하여 HTML 사용함 => jQuery 방식
						// welfare-card 생성 (상위 div 생성)
						var welfareCard = $('<div>').addClass('welfare-card');

						// 링크 생성
						var link = $('<a>').attr('href', policy.welfare_url).attr('target', '_blank');
						// 구분에 따라 클래스 다르게 적용(취업, 결혼, 출산)
						// 동적 텍스트 추가
						link.append(
							$('<span>').addClass('welfare_sort welfare_sort_job').html('취업'),
							$('<p>').addClass('welfare_title welfare_title_job').text(policy.welfare_title),
							$('<p>').addClass('welfare_period welfare_period_job').text(policy.welfare_period),
							$('<p>').addClass('welfare_content welfare_content_job').text(policy.welfare_content)
						);
						// 링크를 상위 div에 추가
						welfareCard.append(link);

						// 상위 div를 #data-container-에 추가
						$(dataContainerSelector).append(welfareCard);
						}); // each 끝
					} // else 끝
						
				}else if (controllerUrl == '/PolicyWeddingSrcCon') {
					if (dataList.length === 0) {
						// 이미지 요소 생성 및 클래스 추가
						var noBenefitImg = $('<img>')
							.attr('src', 'images/policy_noBenefit.png')
							.attr('alt', '해당 지역에는 복지혜택이 없습니다.')
							.addClass('noBenefit');
		
						// #data-container-job에 이미지 추가
						$("#data-container-wedding").append(noBenefitImg);
						// img를 가운데 정렬하기 위해 .no-data class 추가 
						$("#data-container-wedding").addClass('no-data');
						// return;
						} else {
						// 기존 no-data 클래스 제거
						$(dataContainerSelector).removeClass('no-data');
		
		
						// 데이터 표시 로직
						$.each(dataList, function(index, policy) {
							console.log(controllerUrl + " 정책:", policy);


							// 템플릿 리터럴 사용하여 HTML 사용함 => jQuery 방식
							// welfare-card 생성 (상위 div 생성)
							var welfareCard = $('<div>').addClass('welfare-card');
		
							// 링크 생성
							var link = $('<a>').attr('href', policy.welfare_url).attr('target', '_blank');
							// 구분에 따라 클래스 다르게 적용(취업, 결혼, 출산)
							// 동적 텍스트 추가
							link.append(
								$('<span>').addClass('welfare_sort welfare_sort_wedding').html('결혼'),
								$('<p>').addClass('welfare_title welfare_title_wedding').text(policy.welfare_title),
								$('<p>').addClass('welfare_period welfare_period_wedding').text(policy.welfare_period),
								$('<p>').addClass('welfare_content welfare_content_wedding').text(policy.welfare_content)
							);
							// 링크를 상위 div에 추가
							welfareCard.append(link);

							// 상위 div를 #data-container-에 추가
							$(dataContainerSelector).append(welfareCard);
						}); // each 끝
					}
				} else if (controllerUrl == '/PolicyPregSrcCon') {
					if (dataList.length === 0) {
					// 이미지 요소 생성 및 클래스 추가
					var noBenefitImg = $('<img>')
						.attr('src', 'images/policy_noBenefit.png')
						.attr('alt', '해당 지역에는 복지혜택이 없습니다.')
						.addClass('noBenefit');
		
					// #data-container-job에 이미지 추가
					$("#data-container-preg").append(noBenefitImg);
					// img를 가운데 정렬하기 위해 .no-data class 추가 
					$("#data-container-preg").addClass('no-data');
					// return;
					} else {
						// 기존 no-data 클래스 제거
						$(dataContainerSelector).removeClass('no-data');
			
			
						// 데이터 표시 로직
						$.each(dataList, function(index, policy) {
							console.log(controllerUrl + " 정책:", policy);
			
			
						// 템플릿 리터럴 사용하여 HTML 사용함 => jQuery 방식
						// welfare-card 생성 (상위 div 생성)
						var welfareCard = $('<div>').addClass('welfare-card');
		
						// 링크 생성
						var link = $('<a>').attr('href', policy.welfare_url).attr('target', '_blank');
						// 구분에 따라 클래스 다르게 적용(취업, 결혼, 출산)
						// 동적 텍스트 추가
						link.append(
							$('<span>').addClass('welfare_sort welfare_sort_preg').html('출산'),
							$('<p>').addClass('welfare_title welfare_title_preg').text(policy.welfare_title),
							$('<p>').addClass('welfare_period welfare_period_preg').text(policy.welfare_period),
							$('<p>').addClass('welfare_content welfare_content_preg').text(policy.welfare_content)
						);
						// 링크를 상위 div에 추가
						welfareCard.append(link);

						// 상위 div를 #data-container-에 추가
						$(dataContainerSelector).append(welfareCard);
						}); // each 끝
					} // else 문 끝
				} // else if문 끝
		}, // success 끝
		error: function(jqXHR, textStatus, errorThrown) {
			console.error("[" + controllerUrl + "] AJAX 오류:", textStatus, errorThrown);
			alert('데이터 로드 실패');
		},
		complete: function() {
			pendingRequests--;
			if (pendingRequests === 0) {
				// 3개의 요청(취업,결혼,출산 컨트롤러 호출) 모두 완료 
				// 로딩 인디케이터 숨기기
				$("#loading").hide();
			}
		} // complete 끝
	}); // ajax 끝
}
