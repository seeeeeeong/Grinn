<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/style.fav.js"></script>
    <style>
        .like-button{
        	width: 20px;
            height: 20px;
            float:right;
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
    
    	.user-nickname,
    	.user-intro {
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

.user-profile,
.like-section {
    margin-right: 10px; 
    
}

.like-section {
    margin-left: auto; 
    display: flex;
    align-items: center;
}

.output-fav,
.output-fcount {
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
    padding: 12px 52px; ; /* 패딩 (상하 0px, 좌우 52px) */
    border: none; /* 버튼 테두리 제거 */
    cursor: pointer;
}
    </style>
    <script type="text/javascript">
    function followUser(toUser) {
        
    	// AJAX 요청 보내기
        $.ajax({
            url: '/user/follow',
            method: 'POST',
            data: { to_user: toUser }, // toUser 값을 데이터로 전달합니다.
            success: function (data) {
                // 요청이 성공적으로 완료되었을 때 처리
                if (data === 'follow') {
                    alert('팔로우 성공!');
                } else if (data === 'unfollow') {
                    alert('팔로우 취소!');
                } else {
                    alert('알 수 없는 응답입니다.');
                }
                // 추가적인 처리를 수행하거나 화면을 갱신할 수 있습니다.
            },
            error: function () {
                // 요청이 실패했을 때 처리
                alert('팔로우 실패...');
            }
        });
    }
    $(function() {
        // 좋아요 읽기
        function selectFav(st_num, button) {
            $.ajax({
                url: 'getStyleFav.do',
                type: 'post',
                data: { st_num: st_num },
                dataType: 'json',
                success: function(param) {
                    displayFav(param, button);
                },
                error: function() {
                    alert('네트워크 오류 발생');
                }
            });
        }

        // 좋아요 등록/삭제 버튼 클릭 이벤트 처리
        $(document).on('click', '.output-fav', function() {
            var st_num = $(this).data('num'); // 스타일 번호 가져오기
            var button = $(this); // 현재 클릭한 버튼

            $.ajax({
                url: 'writeStyleFav.do',
                type: 'post',
                data: { st_num: st_num },
                dataType: 'json',
                success: function(param) {
                    if (param.result == 'logout') {
                        alert('로그인 후 이용 가능합니다.');
                        location.href = '/member/login.do';
                    } else if (param.result == 'success') {
                        displayFav(param, button);
                    } else {
                        alert('등록시 오류 발생');
                    }
                },
                error: function() {
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
            var countElement = button.closest('.like-button').siblings('.output-fcount[data-num="' + st_num + '"]');
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
<div class="page-main">
	<!-- 회원정보 시작 -->
    <c:choose>
        <c:when test="${not empty userStyles[0].st_num}">
            <img src="/user/StyleProfile.do?st_num=${userStyles[0].st_num}" width="120" height="120" class="my-photo">
        </c:when>
        <c:otherwise>
            <img src="${pageContext.request.contextPath}/user/photoView.do" width="120" height="120" class="my-photo">
        </c:otherwise>
    </c:choose>
    <p class="user-id">${member.mem_id}</p>
	<p class="user-nickname">${member.mem_nickname}</p>
	<p class="user-intro">${member.mem_int}</p>
 	<br>
 	<c:choose>
    <c:when test="${isOwnProfile}">
        <!-- "Profile Management(프로필 관리)" 버튼 표시 -->
        <a href="/user/userLoginInfo.do">프로필 관리</a>
    </c:when>
    <c:otherwise>
        <button class="follow-button" onclick="followUser(${member.mem_num})">팔로우</button>

    </c:otherwise>
	</c:choose>
 	<br>  
	<!-- 회원정보 끝 -->
	<div class="user-stats">
    <p>게시물 <strong>${totalStyleCount}</strong></p>
    <p>팔로워 <strong>${followerCount}</strong></p>
    <p>팔로잉 <strong>${followingCount}</strong></p>
	</div>
	<br>
    
    <div class="style-container">
<c:choose>
    <c:when test="${empty userStyles}">
    <div class="style" style="display: flex; align-items: center; justify-content: center; width: 100%;">
        <p style="font-size: 12px; opacity: 0.3;">게시물이 없습니다.</p>
    </div>    
    </c:when>
<c:otherwise>
<c:forEach items="${userStyles}" var="style">
    <div class="style">
        <div class="style-image">
        	<a href="/style/detail.do?st_num=${style.st_num}">
            <img src="/user/StyleImageView.do?st_num=${style.st_num}" width="200" height="200" alt="Style Image" style="border-radius: 10px;">
        	</a>
        </div>
        <div class="user-like-section">
            <a href="/user/userStyle.do?mem_num=${style.mem_num}">
            <div class="user-profile" style="color: rgba(34,34,34,.8); font-size:15px;">
                <img src="${pageContext.request.contextPath}/user/ProfileImageView.do?st_num=${style.st_num}" width="25" height="25" class="my-photo">
                ${member.mem_id}
            </div>
            </a> 
            <div class="like-section">
                <div class="like-button">
                    <img class="output-fav" data-num="${style.st_num}" src="${pageContext.request.contextPath}/images/no_like.png" width="18" height="18">
                </div>
                <span class="output-fcount" data-num="${style.st_num}" style="color: rgba(34,34,34,.5);"></span> 
            </div>
        </div>
        <div class="style-phrase" style="margin-top: 10px; font-size:14px;">
        <a href="/style/detail.do?st_num=${style.st_num}">
            ${style.st_phrase}
        </a>    
        </div>
    </div>
</c:forEach>
</c:otherwise>
</c:choose>
</div>
<!-- 사용자가 작성한 스타일 게시물 정보 끝 -->

<img src="${pageContext.request.contextPath}/user/viewFollowerProfile.do?mem_num=${style.st_num}" width="25" height="25" class="my-photo">
<img src="${pageContext.request.contextPath}/user/viewFollowingProfile.do?mem_num=${style.st_num}" width="25" height="25" class="my-photo">
