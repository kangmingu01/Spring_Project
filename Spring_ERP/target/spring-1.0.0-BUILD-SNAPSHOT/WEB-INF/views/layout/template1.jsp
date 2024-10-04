<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 페이지의 뼈대를 제공하기 위한 JSP 문서 - 템플릿 페이지 --%>
<!-- TilesView 기능을 제공하는 태그를 사용하기 위해 JSP 문서에 tags-tiles 태그 라이브러리 추가 -->    
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>SPRING</title>

</head>
<body>
<!-- content 부분(content 부분만 바뀌면 됨) -->

<div id="content">
	<tiles:insertAttribute name="content"/>
</div>
</body>
</html>