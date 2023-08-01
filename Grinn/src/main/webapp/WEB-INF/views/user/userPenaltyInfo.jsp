<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 페널티 시작 -->
<h2>페널티 정보</h2>
<table>
  <thead>
    <tr>
      <th>통합 점수</th>
      <th>페널티 점수</th>
      <th>페널티 사유</th>
      <th>페널티 부과일</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach items="${penaltyInfo}" var="penalty">
      <tr>
        <td>${penalty.pe_total}</td>
        <td>${penalty.pe_score}</td>
        <td>
          <c:choose>
            <c:when test="${not empty penalty.peBoard_score}">
              <c:choose>
                <c:when test="${penalty.peBoard_score == 0}">음란, 불법</c:when>
                <c:when test="${penalty.peBoard_score == 1}">홍보</c:when>
                <c:when test="${penalty.peBoard_score == 2}">욕설</c:when>
                <c:when test="${penalty.peBoard_score == 3}">반복</c:when>
                <c:when test="${penalty.peBoard_score == 4}">개인정보노출</c:when>
                <c:otherwise>기타</c:otherwise>
              </c:choose>
            </c:when>
            <c:when test="${not empty penalty.peTrade_score}">
              <c:choose>
                <c:when test="${penalty.peTrade_score == 5}">가품 판정</c:when>
                <c:when test="${penalty.peTrade_score == 6}">손상/오염</c:when>
                <c:when test="${penalty.peTrade_score == 7}">판매 거부</c:when>
                <c:when test="${penalty.peTrade_score == 8}">발송 지연</c:when>
                <c:when test="${penalty.peTrade_score == 9}">정보 불일치</c:when>
                <c:otherwise>기타</c:otherwise>
              </c:choose>
            </c:when>
            <c:otherwise>기타</c:otherwise>
          </c:choose>
        </td>
        <td>
          <c:choose>
            <c:when test="${not empty penalty.peBoard_date}">
              ${penalty.peBoard_date}
            </c:when>
            <c:when test="${not empty penalty.peTrade_date}">
              ${penalty.peTrade_date}
            </c:when>
            <c:otherwise>기타</c:otherwise>
          </c:choose>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>
<!-- 페널티 끝 -->
