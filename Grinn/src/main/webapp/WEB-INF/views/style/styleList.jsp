<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/style.fav.js"></script>
    <style>
        /* Flexbox를 사용하여 가로 정렬 */
        .style_list {
            display: flex;
            flex-wrap: wrap; /* 아이템들을 여러 줄에 걸쳐 표시할 수 있도록 설정 */
            
        }

        .style-item {
            margin: 10px;
            text-align: left;
            max-width: 200px;
        }

        .style-item img {
            border-radius: 5px;
            max-width: 100%;
            height: auto;
        }

        .user-profile {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
            float:left;
        }

        .profile-photo {
            width: 30px;
            height: 30px;
            border-radius: 50%;
           
        }
        
        .like-button{
        	width: 20px;
            height: 20px;
            float:right;
            margin-bottom: 10px;
        }
        .phrase{
        	clear:both;
        }
    </style>

    <div class="page-main">
    	<div class="align-right">
    		<a href="write.do"><img src="${pageContext.request.contextPath}/images/upload_button.png" width="70" height="40"></a>
    	</div>
    	<div class="style_list">
    		<c:forEach var="style" items="${list}">
            	<div class="style-item">
                   
                	<a href="detail.do?st_num=${style.st_num}">
                    	<img src="${pageContext.request.contextPath}/image_upload/${style.st_photo1n}" width="300" height="300">
                	</a>
                	<div class="user-profile">
                        <img src="profile_picture.png" class="profile-photo"><!-- 프로필 사진 들어갈 자리 -->
                        <span>${style.mem_id}</span>
                    </div>
                    <div class="like-button">
                    	<img id="output_fav" data-num="${style.st_num}" src="${pageContext.request.contextPath}/images/no_like.png">
                    </div><br>
                    <div class="phrase">
                    	<p>${style.st_phrase}</p>
                    </div>
                	<!--  
                	${style.st_regdate}
                	<c:if test="${!empty style.st_mdate}">
                    ${style.st_mdate}
                	</c:if>
                	-->
            	</div>
        	</c:forEach>
    	</div>
    	<div class="align-center">${page}</div>
    </div>

