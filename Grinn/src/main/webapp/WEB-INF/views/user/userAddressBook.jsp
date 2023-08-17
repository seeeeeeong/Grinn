<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
.bordered-heading {
	border-bottom: 2px solid #000;
	padding-bottom: 20px;
}

.user-address {
	display: flex;
	align-items: flex-start;
}

#change_button {
	margin-left: auto;
	border: none;
	background-color: transparent;
	opacity: 0.5;
}

#popup {
	display: none;
	width: 480px;
	height: 380px;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background-color: white;
	border: 1px solid #ccc;
	padding: 20px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
	z-index: 1000;
}
</style>

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    const changeButton = document.getElementById("change_button");
    const popup = document.getElementById("popup");
    const closePopupButton = document.getElementById("close-popup-button");

    changeButton.addEventListener("click", () => {
        popup.style.display = "block";
    });

    closePopupButton.addEventListener("click", () => {
        popup.style.display = "none";
    });
});
</script>

<!-- 회원정보 시작 -->
<div class="page-main">

	<h2 class="bordered-heading" style="font-size: 24px;">주소록</h2>
	<br>
	<div class="user-info">
		<strong>${member.mem_name}</strong><br> ${member.mem_phone}<br>
		<br>
		<!-- ... (기타 코드) ... -->

		<div class="user-address">
			<!-- 배송지가 없을 때 -->
			<c:choose>
				<c:when
					test="${empty member.mem_zipcode && empty member.mem_address1 && empty member.mem_address2}">
					<p>등록된 배송지가 없습니다.</p>
					<input type="button" value="등록" id="change_button">
				</c:when>
				<c:otherwise>
					<!-- 배송지가 있을 때 -->
					<p>
						(${member.mem_zipcode}) ${member.mem_address1}
						${member.mem_address2} <input type="button" value="수정"
							id="change_button">
					</p>
				</c:otherwise>
			</c:choose>
		</div>

		<!-- ... (기타 코드) ... -->

	</div>
</div>

<!-- 추가된 주소 정보 입력 폼 -->
<div id="popup" style="display: none;">
	<h2
		style="font-size: 18px; display: flex; justify-content: space-between; align-items: center;">
		<span style="flex: 1; text-align: center;">배송지 변경</span>
		<button id="close-popup-button"
			style="font-size: 18px; border: none; background: none; padding: 0; cursor: pointer;">X</button>
	</h2>
	<br>
	<br> <label for="zipcode"
		style="color: rgba(0, 0, 0, 0.8); font-size: 12px;"><strong>우편번호&nbsp;</strong></label>
	<input type="text" id="zipcode" name="zipcode" class="address-input"
		readonly
		style="border: none; border-bottom: 1px solid rgba(0, 0, 0, 0.5); opacity: 0.5;">
	<input type="button" value="변경" id="address_change_button"
		style="border: 1px solid rgba(0, 0, 0, 0.5); background-color: transparent; opacity: 0.5; border-radius: 12px; padding: 8px 14px; font-size: 12px; color: rgba(0, 0, 0, 0.9);">
	<br>
	<br> <label for="address1"
		style="color: rgba(0, 0, 0, 0.8); font-size: 12px;"><strong>주소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></label>
	<input type="text" id="address1" name="address1" class="address-input"
		readonly
		style="border: none; border-bottom: 1px solid rgba(0, 0, 0, 0.5); opacity: 0.5;">
	<br>
	<br> <label for="address2"
		style="color: rgba(0, 0, 0, 0.8); font-size: 12px;"><strong>상세주소&nbsp;</strong></label>
	<input type="text" id="address2" name="address2" class="address-input"
		style="border: none; border-bottom: 1px solid rgba(0, 0, 0, 0.5); opacity: 0.5;">
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div style="text-align: center;">
		<input type="button" value="주소 저장" id="address_save_button"
			style="border: 1px solid rgba(0, 0, 0, 0.5); background-color: transparent; border-radius: 12px; padding: 10px 20px; font-size: 12px; color: rgba(0, 0, 0, 0.5); opacity: 0.8; background-color: white;">
	</div>
</div>


<!-- 회원정보 끝 -->

<script type="text/javascript">
$(document).ready(function () {
 	//주소 변경 버튼 클릭 시
    $("#address_change_button").on("click", function () {
        //우편번호 검색 API 실행
        execDaumPostcode();
    });

    //주소 저장 버튼 클릭 시
    $("#address_save_button").on("click", function () {
        //입력한 주소 정보를 AJAX를 통해 컨트롤러로 전달
        var zipcode = $("#zipcode").val();
        var address1 = $("#address1").val();
        var address2 = $("#address2").val();

        $.ajax({
            url: "/user/saveAddress",
            type: "POST",
            data: {
                zipcode: zipcode,
                address1: address1,
                address2: address2
            },
            success: function (data) {
                if (data === "success") {
                    alert("주소 저장 성공");
                    //주소 정보 갱신 등 화면 업데이트 처리
                    $("p:contains('주소록: ')").text("주소록: " + zipcode + ", " + address1 + ", " + address2); // 주소 정보 업데이트
                } else {
                    alert("주소 저장 실패");
                }
            },
            error: function () {
                alert("주소 저장 오류");
            }
        });
    });
});
</script>
<!-- 우편번호 검색 시작 -->
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer"
	style="display: none; position: fixed; overflow: hidden; z-index: 1001; -webkit-overflow-scrolling: touch;">

	<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
		id="btnCloseLayer"
		style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
		onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    //(주의)address1에 참고항목이 보여지도록 수정
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //(수정) document.getElementById("address2").value = extraAddr;
                
                } 
                //(수정) else {
                //(수정)    document.getElementById("address2").value = '';
                //(수정) }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                //(수정) + extraAddr를 추가해서 address1에 참고항목이 보여지도록 수정
                document.getElementById("address1").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
<!-- 우편번호 검색 끝 -->
