<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>비밀번호 변경</title>
    <style>
        .logo {
            width: 30px;
            height: auto;
        }

        .content {
            background-color: #6571ff;
            color: white;
        }

        .title {
            font-size: 18px;
        }
    </style>
</head>
<body class="vh-100">
<sec:authentication property="principal" var="loginUser"/>

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
<%--<section class="content d-md-flex justify-content-between pt-2 pb-2 ps-4 pe-4 align-items-center">
    <div class="container title fw-bold">
        비밀번호 변경
    </div>
</section>--%>

<main class="d-flex justify-content-center align-items-center" style="height: calc(100vh - 140px);">
    <div class="card p-5 shadow-lg" style="max-width: 400px; width: 100%;">
        <h3 class="text-center mb-4">비밀번호 변경</h3>
        <form action="<c:url value='/change_password'/>" method="post">
            <div class="form-group mb-3">
                <label for="currentPassword" class="form-label">현재 비밀번호</label>
                <input type="password" class="form-control" id="currentPassword"
                       name="currentPassword" placeholder="현재 비밀번호를 입력하세요" required>
            </div>
            <div class="form-group mb-3">
                <label for="newPassword" class="form-label">새 비밀번호</label>
                <input type="password" class="form-control" id="newPassword"
                       name="newPassword" placeholder="새 비밀번호를 입력하세요" required>
            </div>
            <div class="form-group mb-4">
                <label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
                <input type="password" class="form-control" id="confirmPassword"
                       name="confirmPassword" placeholder="비밀번호를 다시 입력하세요" required>
            </div>
            <button type="submit" class="btn btn-primary w-100 mb-3">비밀번호 변경</button>

            <c:if test="${not empty error}">
                <div class="alert alert-danger text-center" role="alert">
                        ${error}
                </div>
            </c:if>

            <sec:csrfInput/>
        </form>
    </div>
</main>
<script src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>
</body>
</html>