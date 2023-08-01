<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 회원정보 시작 -->
<div class="page-main">
    <!-- 프로필 이미지 -->
    <img src="${pageContext.request.contextPath}/member/photoView.do" width="200" height="200" class="my-photo">
    <!-- 닉네임 -->
    <p>닉네임: ${mem_nickname}</p>

    <!-- 프로필 이미지 변경 버튼 -->
    <input type="button" value="이미지 변경" id="photo_change_button">

    <!-- 프로필 이미지 삭제 버튼 -->
    <input type="button" value="이미지 삭제" id="photo_delete_button">

    <!-- 이메일주소 -->
    <p>이메일: ${mem_email}</p>
    <!-- 이메일 변경 버튼 -->
    <input type="button" value="이메일 변경" id="email_change_button">

    <!-- 비밀번호 -->
    <p>비밀번호: ********</p>
    <!-- 비밀번호 변경 버튼 -->
    <input type="button" value="비밀번호 변경" id="password_change_button">

    <!-- 휴대폰번호 -->
    <p>휴대폰번호: ********</p>
    <!-- 휴대폰번호 변경 버튼 -->
    <input type="button" value="휴대폰번호 변경" id="phone_change_button">

    <!-- 주소록 -->
    <p>주소록: [주소 정보]</p>
    <!-- 주소록 변경 버튼 -->
    <input type="button" value="주소록 변경" id="address_change_button">

    <!-- 추가 정보 -->
    <h2>추가 정보</h2>
    <!-- 닉네임 변경 버튼 -->
    <input type="button" value="닉네임 변경" id="nickname_change_button">
    <!-- 이름 변경 버튼 -->
    <input type="button" value="이름 변경" id="name_change_button">
    <!-- 소개 변경 버튼 -->
    <input type="button" value="소개 변경" id="introduction_change_button">
</div>
<!-- 회원정보 끝 -->
