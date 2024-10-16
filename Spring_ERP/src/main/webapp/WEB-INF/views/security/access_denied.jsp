<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
    <style>
        .logo {
            width: 30px;
            height: auto;
        }
    </style>
</head>
<body>
<sec:authentication property="principal" var="loginUser"/>
<c:set var="joinDate" value="${loginUser.joindate}" />
<fmt:parseDate value="${joinDate}" pattern="yyyy-MM-dd" var="parsedDate" />
<header class="border-bottom border-black">
    <div class="ms-md-4 me-md-4 ms-3 me-3 mt-3 mb-3 d-flex align-items-center justify-content-between text-center">
        <div>
            <img
                    src="<c:url value='/images/logo-mini-light.png'/>"
                    class="logo me-2"
                    alt="logo"
            />
        </div>
        <div>
            <span>${loginUser.name}님</span>
        </div>
    </div>
</header>

<main class="d-flex justify-content-center align-items-center" style="height: calc(100vh - 120px);">
    <div class="text-center">
        <h1 class="display-4 fw-bold mb-4" style="color: #ff6b6b;">
            ${loginUser.name}님은 <fmt:formatDate value="${parsedDate}" pattern="yyyy년 MM월 dd일"/>부터 <br>
                Spring Erp페이지에 접근 가능합니다.
        </h1>
        <p class="lead mb-4" style="color: #495057;">
            문제가 지속될 경우 관리자에게 문의하세요.
        </p>
    </div>
</main>
</body>
<script src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>
</html>
