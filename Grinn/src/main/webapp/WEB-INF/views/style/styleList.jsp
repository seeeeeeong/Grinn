<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Style List</title>
    <style>
        /* Flexbox를 사용하여 가로 정렬 */
        .style_list {
            display: flex;
            flex-wrap: wrap; /* 아이템들을 여러 줄에 걸쳐 표시할 수 있도록 설정 */
            justify-content: center; /* 가로 방향으로 가운데 정렬 */
        }

        .style-item {
            margin: 10px;
            text-align: center;
            max-width: 300px;
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
        }

        .user-profile img {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <div class="page-main">
    	<div class="align-right">
    		<a href="write.do"><img src="${pageContext.request.contextPath}/images/upload_button.png" width="70" height="40"></a>
    	</div>
    	<div class="style_list">
    		<c:forEach var="style" items="${list}">
            	<div class="style-item">
                    <div class="user-profile">
                        <img src="profile_picture.png" alt="Profile Picture">
                        <span>User123</span>
                    </div>
                	<a href="detail.do?style_num=${style.st_num}">
                    	<img src="${pageContext.request.contextPath}/image_upload/${style.st_photo1n}" width="300" height="300">
                	</a>
                	<p>${style.st_phrase}</p>
                	${style.st_regdate}
                	<c:if test="${!empty style.st_mdate}">
                    ${style.st_mdate}
                	</c:if>
            	</div>
        	</c:forEach>
    	</div>
    </div>
</body>
</html>
