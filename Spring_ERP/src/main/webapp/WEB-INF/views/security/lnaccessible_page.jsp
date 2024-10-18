<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>접근 불가</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <style>
        body, html {
            height: 100%;
            margin: 0;
        }
        .access-denied-container {
            max-width: 600px;
            padding: 20px;
        }
    </style>
</head>
<body class="d-flex justify-content-center align-items-center bg-light">

<div class="access-denied-container bg-white rounded-3 shadow p-5 text-center mt-5">
    <!-- 강조된 접근 불가 텍스트 -->
    <h1 class="display-4 fw-bold text-dark mb-4">접근 불가</h1>
    <p class="lead text-secondary mb-4">죄송합니다. 이 페이지에 접근할 수 있는 권한이 없습니다.</p>
    <!-- 메인으로 가기 버튼 -->
    <a href="<c:url value='/main'/>" class="btn btn-primary btn-lg">메인으로 가기</a>
</div>

<!-- Bootstrap JS (Optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>
</body>
</html>
