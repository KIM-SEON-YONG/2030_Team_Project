
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
			$("#regionInput").val(" ");
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

	
	
