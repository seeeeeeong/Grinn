<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type = "text/javascript" src="${pageContext.request.contextPath}/js/click.item.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sys/header.css">
<body>

<div id = "layout">
   <div id = "wrap" tabindex = "0" class = "layout_base lg wrap has_tap etc lg">
   <div class = "board_line">
      <div class = "header fixed">
         <div class = "header_top">
            <div class = "top_inner"> 
               <ul class = "top_list">
                  <li class = "top_item">
                     <c:if test="${!empty user && user.mem_auth == 9}">
                     <a class = "top_link" href="${pageContext.request.contextPath}/main/admin.do"><b>[관리자메인]</b></a>
                     </c:if>
                  </li>
                  <c:if test="${!empty user && user.mem_auth == 9}">
                  <li class = "top_item">
                     <a class = "top_link" href="${pageContext.request.contextPath}/admin/point.do">포인트내역</a>
                  </li>
                  </c:if>
                  <c:if test="${user.mem_auth != 9}">
                  <li class = "top_item">
                     <a class = "top_link" href="${pageContext.request.contextPath}/notice/noticeList.do">고객센터</a>
                  </li>
                  <li class = "top_item">
                     <a class = "top_link" href="${pageContext.request.contextPath}/user/myPage.do">MY페이지</a>
                  </li>
                  <li class = "top_item">
                     <a class = "top_link" href="${pageContext.request.contextPath}/user/userFavoriteItems.do">관심상품</a>
                  </li>
                  <li class = "top_item">
                     <a class = "top_link" href="${pageContext.request.contextPath}/alert/alert.do">알림</a>
                  </li>
                  </c:if>
                  <li class = "top_item" id = "logout">
                     <c:if test="${!empty user}">
                     <a class = "top_link" href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
                     </c:if>
                  </li>
                  <li class = "top_item">
                     <c:if test="${empty user}">
                     <a class = "top_link" href="${pageContext.request.contextPath}/member/login.do"><b>로그인</b></a>
                     </c:if>
                  </li>
               </ul>
            </div>
         </div>
         <!--  -->
         
         
         
         
         <div class = "header_main">
            <div class = "main_inner">
            <div style = "display: flex;">
               <h1>
                  <a id = "logo" class = "logo" href = "${pageContext.request.contextPath}/main/main.do">Grinn</a>
               </h1>
            </div>
               <div class = "center"></div>
               <div class = "right">
                  <div class = "gnb_area">
                     <nav class = "gnb">
                        <ul class = "gnb_list">
                           <li class = "gnb_item">
                              <a class = "gnb_link" href = "${pageContext.request.contextPath}/main/main.do">HOME</a>
                           </li>
                           <li class = "gnb_item">
                              <a class = "gnb_link" href = "${pageContext.request.contextPath}/style/list.do">STYLE</a>
                           </li>
                           <li class = "gnb_item">
                              <a class = "gnb_link" href = "${pageContext.request.contextPath}/item/itemList.do">SHOP</a>
                           </li>
                           <li class = "gnb_item">
                              <a class = "gnb_link" href = "${pageContext.request.contextPath}/fleamarket/marketSelect.do">FLEA MARKET</a>
                           </li>
                        </ul>
                     </nav>
                     <div class = "search_btn_box">
                        <input type = "search" value = "검색">
                     </div>
                  </div>
               </div>
            </div>
         </div> 
         <div class = "portal_target vue-portal-target">
            <nav class = "tabs">
               <ul class = "ul_tab home_tabs">
                  <li class = "li_tab">
                     <a class = "tab" href = "">
                        <span class = "tab_name">추천</span>
                     </a>
                  </li>
                  <li class = "li_tab">
                     <a class = "tab" href = "${pageContext.request.contextPath}/main/main.do?item_gender=1">
                        <span class = "tab_name">남성</span>
                     </a>
                  </li>
                  <li class = "li_tab">
                     <a class = "tab" href = "${pageContext.request.contextPath}/main/main.do?item_gender=2">
                        <span class = "tab_name">여성</span>
                     </a>
                  </li>
                  <li class = "li_tab">
                     <a class = "tab" href = "${pageContext.request.contextPath}/main/main.do?item_gender=3">
                        <span class = "tab_name">럭셔리</span>
                     </a>
                  </li>
               </ul>
            </nav>
         </div> 
      </div>
   </div>
   </div>
</div>
</body>







