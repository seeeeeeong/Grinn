<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/style.fav.js"></script>

<style>
.like-button {
	width: 20px;
	height: 20px;
	float: right;
	margin-bottom: 10px;
}

.page-main {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	text-align: center;
	padding: 20px;
}

.user-id {
	font-size: 20px;
	margin: 5px 0;
}

.user-nickname, .user-intro {
	font-size: 14px;
	opacity: 70%;
	margin: 1px 0;
}

.user-stats {
	display: flex;
	justify-content: space-between;
	margin-top: 10px;
}

.user-stats p {
	font-size: 16px;
	text-align: center;
	padding: 0 20px;
}

.style-container {
	display: flex;
	flex-wrap: wrap;
}

.style {
	margin-right: 20px;
	margin-bottom: 20px;
}

.style:last-child {
	margin-right: 0;
}

.user-like-section {
	display: flex;
	align-items: center;
	margin-top: 10px;
}

.user-profile {
	margin-right: 10px;
}

.like-section {
	margin-left: auto;
	display: flex;
	align-items: center;
}

.style-phrase {
	text-align: left;
	margin-top: 5px;
}

.output-fav, .output-fcount {
	margin-right: 5px;
}

.user-profile {
	display: flex;
	align-items: center;
}

.user-profile img {
	margin-right: 5px;
}

.user-profile span {
	display: block;
}

.follow-button {
	background-color: #222222; /* 배경색 */
	color: white; /* 글자색 */
	font-size: 14px; /* 글자 크기 */
	border-radius: 10px; /* 모서리 둥글기 */
	padding: 12px 52px;; /* 패딩 (상하 0px, 좌우 52px) */
	border: none; /* 버튼 테두리 제거 */
	cursor: pointer;
}

.unfollow-button {
	background-color: white; /* 배경색 */
	color: black; /* 글자색 */
	font-size: 14px; /* 글자 크기 */
	border-radius: 10px; /* 모서리 둥글기 */
	padding: 12px 52px;; /* 패딩 (상하 0px, 좌우 52px) */
	border: 1px solid #222222; /* 버튼 테두리 제거 */
	cursor: pointer;
}

.popup {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	width: 448px;
	height: 480px;
	transform: translate(-50%, -50%);
	flex-direction: column;
	z-index: 1000;
	align-items: center;
	justify-content: center;
	overflow-y: auto; /* 스크롤이 필요할 경우 스크롤을 추가 */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

.popup-content {
	background-color: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	width: 100%;
	height: 100%;
	box-sizing: border-box;
}

.profile-link {
	border: 1px solid black;
	padding: 10px 16px;
	display: inline-block;
	border-radius: 10px;
	opacity: 0.3;
}

.profile-link a {
	text-decoration: none; /* 링크의 밑줄 제거 */
	color: black; /* 글자 색상 지정 */
}
</style>
<script type="text/javascript">
	$(document).ready(
			function() {
				$(".follow-button").on("click", function() {
					var toUser = $(this).data("user-id");
					followUser(toUser);
				});

				$(".unfollow-button").on("click", function() {
					var toUser = $(this).data("user-id");
					unfollowUser(toUser);
				});

				// 함수 toUser에 해당하는 사용자를 팔로우합니다.
				function followUser(toUser) {
					$.ajax({
						type : "POST",
						url : "/user/follow",
						data : {
							to_user : toUser
						},
						success : function(response) {
							if (response === "follow") {
								$(
										".follow-button[data-user-id='"
												+ toUser + "']").hide();
								$(
										".unfollow-button[data-user-id='"
												+ toUser + "']").show();
							}
						}
					});
				}

				// 함수 toUser에 해당하는 사용자의 팔로우를 취소합니다.
				function unfollowUser(toUser) {
					$.ajax({
						type : "POST",
						url : "/user/follow",
						data : {
							to_user : toUser
						},
						success : function(response) {
							if (response === "unfollow") {
								$(
										".follow-button[data-user-id='"
												+ toUser + "']").show();
								$(
										".unfollow-button[data-user-id='"
												+ toUser + "']").hide();
							}
						}
					});
				}

				// 페이지 로딩 시 팔로우 상태를 확인하여 버튼을 적절히 표시합니다.
				$(".follow-button, .unfollow-button").each(
						function() {
							var toUser = $(this).data("user-id");
							$.get("/user/getFollowStatus", {
								to_user : toUser
							}, function(response) {
								if (response === "following") {
									$(
											".follow-button[data-user-id='"
													+ toUser + "']").hide();
									$(
											".unfollow-button[data-user-id='"
													+ toUser + "']").show();
								} else {
									$(
											".follow-button[data-user-id='"
													+ toUser + "']").show();
									$(
											".unfollow-button[data-user-id='"
													+ toUser + "']").hide();
								}
							});
						});
			});

	$(function() {
		// 좋아요 읽기
		function selectFav(st_num, button) {
			$.ajax({
				url : 'getStyleFav.do',
				type : 'post',
				data : {
					st_num : st_num
				},
				dataType : 'json',
				success : function(param) {
					displayFav(param, button);
				},
				error : function() {
					alert('네트워크 오류 발생');
				}
			});
		}

		// 좋아요 등록/삭제 버튼 클릭 이벤트 처리
		$(document).on('click', '.output-fav', function() {
			var st_num = $(this).data('num'); // 스타일 번호 가져오기
			var button = $(this); // 현재 클릭한 버튼

			$.ajax({
				url : 'writeStyleFav.do',
				type : 'post',
				data : {
					st_num : st_num
				},
				dataType : 'json',
				success : function(param) {
					if (param.result == 'logout') {
						alert('로그인 후 이용 가능합니다.');
						location.href = '/member/login.do';
					} else if (param.result == 'success') {
						displayFav(param, button);
					} else {
						alert('등록시 오류 발생');
					}
				},
				error : function() {
					alert('네트워크 오류 발생');
				}
			});
		});

		// 좋아요 표시 공통 함수
		function displayFav(param, button) {
			let output;
			if (param.status == 'yesFav') {
				output = '${pageContext.request.contextPath}/images/yes_like.png';
			} else if (param.status == 'noFav') {
				output = '${pageContext.request.contextPath}/images/no_like.png';
			}
			// 버튼에 추가
			button.attr('src', output);

			// 좋아요 개수 엘리먼트 찾아 업데이트
			var st_num = button.data('num');
			var countElement = button.closest('.like-button').siblings(
					'.output-fcount[data-num="' + st_num + '"]');
			countElement.text(param.count);
		}

		// 초기 데이터 표시
		$('.output-fav').each(function() {
			var button = $(this);
			var st_num = button.data('num');
			selectFav(st_num, button);
		});
	});

	function showFollowingPopup() {
		document.getElementById('following-popup').style.display = 'flex';
	}

	function closeFollowingPopup() {
		document.getElementById('following-popup').style.display = 'none';
	}

	document.addEventListener('DOMContentLoaded', function() {
		var followingText = document.getElementById('following-text');
		var closePopupButton = document.getElementById('close-popup-button');

		followingText.addEventListener('click', showFollowingPopup);
		closePopupButton.addEventListener('click', closeFollowingPopup);
	});

	function showFollowerPopup() {
		document.getElementById('follower-popup').style.display = 'flex';
	}

	function closeFollowerPopup() {
		document.getElementById('follower-popup').style.display = 'none';
	}

	document.addEventListener('DOMContentLoaded', function() {
		var followingText = document.getElementById('following-text');
		var followerText = document.getElementById('follower-text');
		var closePopupButton1 = document.getElementById('close-popup-button1');
		var closePopupButton2 = document.getElementById('close-popup-button2');

		followingText.addEventListener('click', showFollowingPopup);
		followerText.addEventListener('click', showFollowerPopup);
		closePopupButton2.addEventListener('click', closeFollowingPopup);
		closePopupButton1.addEventListener('click', closeFollowerPopup);
	});
</script>
<div class="page-main">
	<!-- 회원정보 시작 -->
	<c:choose>
		<c:when test="${not empty userStyles[0].st_num}">
			<img src="/user/StyleProfile.do?st_num=${userStyles[0].st_num}"
				width="120" height="120" class="my-photo">
		</c:when>
		<c:otherwise>
			<img src="${pageContext.request.contextPath}/user/photoView.do"
				width="120" height="120" class="my-photo">
		</c:otherwise>
	</c:choose>
	<p class="user-id">${member.mem_id}</p>
	<p class="user-nickname">${member.mem_nickname}</p>
	<p class="user-intro">${member.mem_int}</p>
	<br>
	<c:choose>
		<c:when test="${isOwnProfile}">
			<div class="profile-link">
				<a href="/user/userProfileInfo.do">프로필 관리</a>
			</div>
		</c:when>
		<c:otherwise>



			<button class="unfollow-button" data-user-id="${member.mem_num}">팔로잉</button>
			<button class="follow-button" data-user-id="${member.mem_num}">팔로우</button>


		</c:otherwise>
	</c:choose>
	<br>
	<!-- 회원정보 끝 -->
	<div class="user-stats">
		<p>
			게시물 <strong>${totalStyleCount}</strong>
		</p>
		<a id="follower-text" href="#"><p>
				팔로워 <strong>${followerCount}</strong>
			</p></a> <a id="following-text" href="#"><p>
				팔로잉 <strong>${followingCount}</strong>
			</p></a>
	</div>

	<div id="follower-popup" class="popup">
		<div class="popup-content">
			<h2
				style="font-size: 18px; display: flex; justify-content: space-between; align-items: center;">
				<span style="flex: 1; text-align: center;">팔로워</span>
				<button id="close-popup-button1"
					style="font-size: 18px; border: none; background: none; padding: 0; cursor: pointer;">X</button>
			</h2>
			<c:choose>
				<c:when test="${empty followerInfo}">
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<p style="opacity: 50%;">팔로우하는 사용자가 없습니다.</p>
				</c:when>
				<c:otherwise>
					<c:forEach items="${followerInfo}" var="follower">
						<div
							style="display: flex; align-items: center; margin-bottom: 10px;">
							
							<img
								src="${pageContext.request.contextPath}/user/FollowerProfileImage.do?mem_num=${follower.mem_num}"
								width="44" height="44" class="my-photo"
								style="margin-right: 10px;">
							<a href="/user/userStyle.do?mem_num=${follower.mem_num}">
							<p style="font-size: 14px; font-weight: bold;">${follower.mem_id}</p>
							</a>
							<div style="margin-left: auto;">
								<button class="follow-button" style="padding: 6px 26px;"
									data-user-id="${follower.mem_num}">팔로우</button>
								<button class="unfollow-button" style="padding: 6px 26px;"
									data-user-id="${follower.mem_num}" style="display: none;">팔로잉</button>
							</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>

			<br>
		</div>
	</div>



	<div id="following-popup" class="popup">
		<div class="popup-content">
			<h2
				style="font-size: 18px; display: flex; justify-content: space-between; align-items: center;">
				<span style="flex: 1; text-align: center;">팔로잉</span>
				<button id="close-popup-button2"
					style="font-size: 18px; border: none; background: none; padding: 0; cursor: pointer;">X</button>
			</h2>
			<c:choose>
				<c:when test="${empty followingInfo}">
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<p style="opacity: 50%;">팔로잉하는 사용자가 없습니다.</p>
				</c:when>
				<c:otherwise>
					<c:forEach items="${followingInfo}" var="following">
						<div
							style="display: flex; align-items: center; margin-bottom: 10px;">
							
							<img
								src="${pageContext.request.contextPath}/user/FollowerProfileImage.do?mem_num=${following.mem_num}"
								width="44" height="44" class="my-photo"
								style="margin-right: 10px;">
							<a href="/user/userStyle.do?mem_num=${following.mem_num}">
							<p style="font-size: 14px; font-weight: bold;">${following.mem_id}</p>
							</a>
							<div style="margin-left: auto;">
								<button class="follow-button" style="padding: 6px 26px;"
									data-user-id="${following.mem_num}">팔로우</button>
								<button class="unfollow-button" style="padding: 6px 26px;"
									data-user-id="${following.mem_num}" style="display: none;">팔로잉</button>
							</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>

			<br>
		</div>
	</div>


	<br>
	<div class="style-container">
		<c:choose>
			<c:when test="${empty userStyles}">
				<div class="style"
					style="display: flex; align-items: center; justify-content: center; width: 100%;">
					<p style="font-size: 12px; opacity: 0.3;">게시물이 없습니다.</p>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${userStyles}" var="style">
					<div class="style">
						<div class="style-image">
							<a href="/style/detail.do?st_num=${style.st_num}"> <img
								src="/user/StyleImageView.do?st_num=${style.st_num}" width="200"
								height="200" alt="Style Image" style="border-radius: 10px;">
							</a>
						</div>
						<div class="style-content">
							<div class="user-like-section">
								<a href="/user/userStyle.do?mem_num=${member.mem_num}">
									<div class="user-profile">
										<img
											src="${pageContext.request.contextPath}/user/ProfileImageView.do?st_num=${style.st_num}"
											width="25" height="25" class="my-photo">
										${member.mem_id}
									</div>
								</a>
								<div class="like-section">
									<div class="like-button">
										<img class="output-fav" data-num="${style.st_num}"
											src="${pageContext.request.contextPath}/images/no_like.png"
											width="18" height="18">
									</div>
									<span class="output-fcount" data-num="${style.st_num}"
										style="color: rgba(34, 34, 34, .5);"></span>
								</div>
							</div>
							<div class="style-phrase">
								<a href="/style/detail.do?st_num=${style.st_num}">
									${style.st_phrase} </a>
							</div>
						</div>
					</div>

				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
	<!-- 사용자가 작성한 스타일 게시물 정보 끝 -->