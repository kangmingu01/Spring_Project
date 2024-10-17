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
                    src="<c:url value='/images/logo_icon.png'/>"
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
        <%--<div class="mb-4">
            <i class="fa-solid fa-gifts fa-bounce" style="font-size: 100px; color: #ff8c00;"></i>
        </div>--%>
        <h1 class="display-4 fw-bold mb-4" style="color: #ff6f61;">
            ${loginUser.name}님, 새롭게 시작하는 이 여정을 함께할 수 있어<br> 정말 기쁩니다. 🌸
        </h1>
            <p class="lead fw-light mb-4" style="color: #6c757d;">
                당신의 첫 출근일은 <span class="fw-bold">
                     <fmt:formatDate value="${parsedDate}" pattern="yyyy년 MM월 dd일"/>
                </span>입니다.<br>
                이 여정 속에서 매일이 특별한 순간이 되길 바랍니다.
            </p>
        <%--<a href="/" class="btn btn-outline-danger btn-lg px-5">
            메인 페이지로 돌아가기
        </a>--%>
    </div>
</main>
</body>
<script src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>
</html>
