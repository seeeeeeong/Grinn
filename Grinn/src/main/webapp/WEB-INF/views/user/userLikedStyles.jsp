<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
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
</script>
<style>
.style-container {
	display: flex;
	flex-wrap: wrap;
}

.style {
	width: 22%;
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

.user-profile, .like-section {
	margin-right: 10px;
}

.like-section {
	margin-left: auto;
	display: flex;
	align-items: center;
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

.style-phrase {
    max-width: 200px; /* 원하는 최대 너비로 조정하세요 */
    overflow: hidden;
    white-space: nowrap;
}

.ellipsis {
    display: block;
    overflow: hidden;
    text-overflow: ellipsis;
}

</style>
<!-- 좋아요 시작 -->
<h2>좋아요</h2>
<br>
<div class="style-container">
	<c:choose>
		<c:when test="${empty likedStyles}">
			<div class="style"
				style="display: flex; align-items: center; justify-content: center; width: 100%;">
				<p style="font-size: 12px; opacity: 0.3;">게시물이 없습니다.</p>
			</div>
		</c:when>
		<c:otherwise>
			<c:forEach items="${likedStyles}" var="post" varStatus="loop">
				<div class="style">
					<div class="style-image">
						<a href="/style/detail.do?st_num=${post.st_num}"> <img
							src="/user/StyleImageView.do?st_num=${post.st_num}" width="200"
							height="200" alt="Style Image" style="border-radius: 10px;">
						</a>
					</div>
					<div class="user-like-section">
						<a href="/user/userStyle.do?mem_num=${post.mem_num}">
							<div class="user-profile"
								style="color: rgba(34, 34, 34, .8); font-size: 15px;">
								<img
									src="${pageContext.request.contextPath}/user/ProfileImageView.do?st_num=${post.st_num}"
									width="25" height="25" class="my-photo">
								${profileIds[loop.index]}
							</div>
						</a>
						<div class="like-section">
							<div class="like-button">
								<img class="output-fav" data-num="${post.st_num}"
									src="${pageContext.request.contextPath}/images/no_like.png"
									width="18" height="18">
							</div>
							<span class="output-fcount" data-num="${post.st_num}"
								style="color: rgba(34, 34, 34, .5);"></span>
						</div>
					</div>
					<div class="style-phrase"
						style="margin-top: 10px; font-size: 14px;">
						<a href="/style/detail.do?st_num=${post.st_num}" class="ellipsis">
							${post.st_phrase} </a>
					</div>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</div>
<!-- 좋아요 끝 -->
