<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/profile.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$(".nickname-button")
								.click(
										function() {
											var $nicknameContainer = $(this)
													.closest(
															".nickname-section");
											var $nicknameText = $nicknameContainer
													.find(".nickname-text");
											var $nicknameInput = $nicknameContainer
													.find(".nickname-input");
											var $button = $(this);

											if ($nicknameText.is(":visible")) {
												$nicknameText.hide();
												$nicknameInput.show();
												$nicknameInput
														.val($nicknameText
																.text());
												$button.text("저장 ");
												$nicknameContainer.find("h5")
														.css("font-weight",
																"bold").css(
																"opacity", 1);
											} else {
												var newNickname = $nicknameInput
														.val();
												$
														.post(
																"/user/modifyNickname",
																{
																	newNickname : newNickname
																},
																function(
																		response) {
																	if (response === "success") {
																		$nicknameText
																				.text(newNickname);
																		$nicknameInput
																				.hide();
																		$nicknameText
																				.show();
																		$button
																				.text("변경");
																		$nicknameContainer
																				.find(
																						"h5")
																				.css(
																						"font-weight",
																						"normal")
																				.css(
																						"opacity",
																						0.3);
																	} else {
																		alert("닉네임 변경에 실패했습니다.");
																	}
																});
											}
										});

						$(".int-button")
								.click(
										function() {
											var $intContainer = $(this)
													.closest(".int-section");
											var $intText = $intContainer
													.find(".int-text");
											var $intInput = $intContainer
													.find(".int-input");
											var $button = $(this);

											if ($intText.is(":visible")) {
												$intText.hide();
												$intInput.show();
												$intInput.val($intText.text()); // Set the input value to the existing text
												$button.text("저장 ");
												$intContainer.find("h5").css(
														"font-weight", "bold")
														.css("opacity", 1);
											} else {
												var newInt = $intInput.val();
												$
														.post(
																"/user/modifyInt",
																{
																	newInt : newInt
																},
																function(
																		response) {
																	if (response === "success") {
																		$intText
																				.text(newInt);
																		$intInput
																				.hide();
																		$intText
																				.show();
																		$button
																				.text("변경");
																		$intContainer
																				.find(
																						"h5")
																				.css(
																						"font-weight",
																						"normal")
																				.css(
																						"opacity",
																						0.3);
																	} else {
																		alert("소개 변경에 실패했습니다.");
																	}
																});
											}
										});

					});
</script>
<style>
.bordered-heading {
	border-bottom: 2px solid #000;
	padding-bottom: 20px;
}

.user-info-container {
	display: flex;
	align-items: center;
	border: 1px solid rgba(34, 34, 34, 0.3);
	padding: 20px;
	margin: 20px 0;
	border-radius: 5px;
}

.user-info-content {
	display: flex;
	align-items: center;
	gap: 16px;
}

.my-photo {
	width: 100px;
	height: 100px;
}

.user-info-details {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.user-info-buttons {
	display: flex;
	align-items: center;
}

.menu-btn {
	font-size: 12px;
	color: rgba(0, 0, 0, 0.5);
	background-color: transparent;
	border: 1px solid rgba(34, 34, 34, 0.3);
	border-radius: 5px;
	padding: 5px 10px;
	margin-right: 10px;
}

.user-info-meta {
	display: flex;
	align-items: center;
	margin-left: auto;
	text-align: right;
}

.user-info-names {
	font-size: 16px;
	line-height: 1.5;
}

.user-info-names strong {
	font-size: 16px;
	font-weight: bold;
}

.user-info-names span {
	font-size: 14px;
	opacity: 0.5;
}

.section-border {
	border-bottom: 0.5px solid rgba(0, 0, 0, 0.3);
	width: 50%;
}

h5 {
	margin-bottom: -15px;
	opacity: 0.3;
	font-weight: normal;
}

.button {
	background-color: white;
	color: black;
	border: 1px solid rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	padding: 5px 10px;
	cursor: pointer;
}

.nickname-input-container {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
}

.nickname-input {
	border: none;
	border-bottom: 1px solid rgba(0, 0, 0, 0.3);
	border-radius: 0;
	padding: 5px 0;
	margin-top: 25px;
}

.button-container {
	display: flex;
	align-items: center;
	justify-content: space-between;
	"
}

.int-input-container {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
}

.int-input {
	border: none;
	border-bottom: 1px solid rgba(0, 0, 0, 0.3);
	border-radius: 0;
	padding: 5px 0;
	margin-top: 25px;
}

#change_image_btn {
	font-size: 12px;
	color: rgba(0, 0, 0, 0.5);
	background-color: transparent;
	border: 1px solid rgba(34, 34, 34, 0.3);
	border-radius: 5px;
	padding: 5px 10px;
	margin-right: 10px;
}

#photo_choice {
	display: none;
	border: 1px solid rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	background-color: white;
	padding: 10px;
}

#upload {
	display: block;
	margin-bottom: 10px;
}

#selected_file_name {
	display: block;
	margin-bottom: 10px;
	font-size: 12px;
}

#photo_submit, #photo_reset {
	background-color: rgba(0, 0, 0, 0.5);
	border: none;
	border-radius: 5px;
	color: white;
	padding: 5px 10px;
	margin-right: 5px;
	cursor: pointer;
}

#photo_submit:hover, #photo_reset:hover {
	background-color: rgba(0, 0, 0, 0.7);
}
</style>
<!-- 회원정보 시작 -->
<div class="page-main">
	<h2 class="bordered-heading" style="font-size: 24px;">프로필 관리</h2>
	<br>
	<div class="user-info-container">
		<div class="user-info-content">
			<img src="${pageContext.request.contextPath}/user/photoView.do"
				class="my-photo">
			<div class="user-info-details">
				<div class="user-info-names">
					<strong>${member.mem_id}</strong><br> <span>${member.mem_email}</span>
				</div>
				<div id="photo_btn">
					<button id="change_image_btn">이미지 변경</button>
				</div>
				<div id="photo_choice" style="display: none;">
					<input type="file" id="upload"
						accept="image/gif,image/png,image/jpeg"><br> <span
						id="selected_file_name"></span><br> <input type="button"
						value="전송" id="photo_submit"> <input type="button"
						value="취소" id="photo_reset">
				</div>

			</div>
		</div>
	</div>
	<br>
	<br>

	<div class="nickname-section section-border">
		<h2 style="font-size: 18px;">프로필 정보</h2>
		<h5 style="font-size: 13px; margin-bottom: 1px;">닉네임</h5>
		<div class="button-container">
			<p style="font-size: 16px; margin-right: 10px;" class="nickname-text">${member.mem_nickname}</p>
			<div class="nickname-input-container">
				<input type="text" class="nickname-input" style="display: none;">
			</div>
			<button class="button nickname-button">변경</button>
		</div>
	</div>

	<div class="int-section section-border">
		<h5 style="font-size: 13px; margin-bottom: 1px;">소개</h5>
		<div class="button-container">
			<p style="font-size: 16px; margin-right: 10px;" class="int-text">${member.mem_int}</p>
			<div class="int-input-container">
				<input type="text" class="int-input" style="display: none;">
			</div>
			<button class="button int-button">변경</button>
		</div>
	</div>
</div>
<!-- 회원정보 끝 -->
