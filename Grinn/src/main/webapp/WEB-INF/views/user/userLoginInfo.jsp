<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 회원정보 시작 -->
<div class="page-main">
   	<!-- 프로필 이미지 출력 -->
	<img src="${pageContext.request.contextPath}/member/photoView.do" width="200" height="200" class="my-photo">

    <!-- 닉네임 -->
    <p>닉네임: ${mem_nickname}</p>

    <!-- 프로필 이미지 변경 버튼 -->
    <input type="file" id="photoFileInput">
    <input type="button" value="프로필 이미지 변경" id="photo_change_button">

    <!-- 프로필 이미지 삭제 버튼 -->
    <input type="button" value="이미지 삭제" id="photo_delete_button">

    <!-- 이메일주소 -->
    <p>이메일: ${mem_email}</p>

    <!-- 이메일 변경 버튼 -->
    <input type="text" id="newEmailInput"> <!-- 이메일을 입력 받을 입력란 -->
    <input type="button" value="이메일 변경" id="email_change_button">

    <!-- 비밀번호 -->
    <p>비밀번호: ${mem_password}</p>
    <!-- 비밀번호 변경 버튼 -->
    <input type="button" value="비밀번호 변경" id="password_change_button">

    <!-- 휴대폰번호 -->
    <p>휴대폰번호: ${mem_phone}</p>
    <input type="text" id="newPhoneInput"> <!-- 전화번호 입력 받을 입력란 -->
    <input type="button" value="전화번호 변경" id="phone_change_button">

    <!-- 주소록 -->
	<!-- 주소 변경 버튼 -->
	<input type="button" value="주소 변경" id="address_change_button">

	<!-- 추가된 주소 정보 입력 폼 -->
	<label for="zipcode">우편번호:</label>
	<input type="text" id="zipcode" name="zipcode" readonly>
	<br>
	<label for="address1">주소1:</label>
	<input type="text" id="address1" name="address1" readonly>
	<br>
	<label for="address2">주소2:</label>
	<input type="text" id="address2" name="address2">
	<br>
	<input type="button" value="주소 저장" id="address_save_button">
  	
    <!-- 추가 정보 -->
    <h2>프로필 정보</h2>
    <!-- 닉네임 변경 버튼 -->
    <input type="text" id="newNicknameInput"> <!-- 닉네임을 입력 받을 입력란 -->
    <input type="button" value="닉네임 변경" id="nickname_change_button">
        
    <!-- 소개 변경 버튼 -->
    <input type="text" id="newIntInput"> <!-- 소개를 입력 받을 입력란 -->
    <input type="button" value="소개 변경" id="int_change_button">
</div>
<!-- 회원정보 끝 -->

<script type="text/javascript">
$(document).ready(function () {
    //이메일 변경 버튼 클릭 시
    $("#email_change_button").on("click", function () {
        var newEmail = $("#newEmailInput").val();

        $.ajax({
            url: "/user/updateEmail",
            type: "POST",
            data: { newEmail: newEmail },
            success: function (data) {
                if (data === "success") {
                    alert("이메일 변경 성공");
                    //이메일 정보 갱신 등 화면 업데이트 처리
                    $("p:contains('이메일: ')").text("이메일: " + newEmail); //이메일 정보 업데이트
                } else {
                    alert("이메일 변경 실패");
                }
            },
            error: function () {
                alert("이메일 변경 오류");
            }
        });
    });

    //전화번호 변경 버튼 클릭 시
    $("#phone_change_button").on("click", function () {
        var newPhone = $("#newPhoneInput").val();

        $.ajax({
            url: "/user/updatePhoneNumber",
            type: "POST",
            data: { newPhone: newPhone },
            success: function (data) {
                if (data === "success") {
                    alert("전화번호 변경 성공");
                    //전화번호 갱신 등 화면 업데이트 처리
                    $("p:contains('전화번호: ')").text("전화번호: " + newPhone); // 전화번호 업데이트
                } else {
                    alert("전화번호 변경 실패");
                }
            },
            error: function () {
                alert("전화번호 변경 오류");
            }
        });
    });

    //닉네임 변경 버튼 클릭 시
    $("#nickname_change_button").on("click", function () {
        var newNickname = $("#newNicknameInput").val();
        
        $.ajax({
            url: "/user/modifyNickname",
            type: "POST",
            data: { newNickname: newNickname },
            success: function (data) {
                if (data === "success") {
                    alert("닉네임 변경 성공");
                    //닉네임 정보 갱신 등 화면 업데이트 처리
                    $("p:contains('닉네임: ')").text("닉네임: " + newNickname); // 닉네임 정보 업데이트
                } else {
                    alert("닉네임 변경 실패");
                }
            },
            error: function () {
                alert("닉네임 변경 오류");
            }
        });
    });
    
    //소개 변경 버튼 클릭 시
    $("#int_change_button").on("click", function () {
        var newInt = $("#newIntInput").val();
        
        $.ajax({
            url: "/user/modifyInt",
            type: "POST",
            data: { newInt: newInt },
            success: function (data) {
                if (data === "success") {
                    alert("소개글 변경 성공");
                    //소개글 갱신 등 화면 업데이트 처리
                    $("p:contains('소개: ')").text("소개: " + newInt); // 닉네임 정보 업데이트
                } else {
                    alert("소개글 변경 실패");
                }
            },
            error: function () {
                alert("소개글 변경 오류");
            }
        });
    });

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
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
