<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title"/></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="main_header">
	<div id="main_header">
		<tiles:insertAttribute name="header_chatbot"/>
	</div>
	<div id="body_chatbot">
		<tiles:insertAttribute name="body_chatbot"/>
	</div>
</div>
</body>
</html>