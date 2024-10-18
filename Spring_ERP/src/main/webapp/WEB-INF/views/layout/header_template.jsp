<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- partial:partials/_navbar.html -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SPRING</title>
    <script src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        .logo-mini {
            width: 50px;
            height: auto;
        }
    </style>

</head>
<body>
<%-- 사용자 로그인 정보가 담겨있는 변수 --%>
<sec:authentication property="principal" var="loginUser"/>

<nav class="navbar">
    <div class="navbar-content ">
        <div class="logo-mini d-sm-block d-lg-none">
            <a href="<c:url value="/main"/>" class="nav-link">
                <img
                        src="<c:url value="/images/logo_icon.png"/>"
                        class="logo-mini logo-mini-light"
                        alt="logo"
                />
                <%--<img
                        src="<c:url value="/images/logo-mini-dark.png"/>"
                        class="logo-mini logo-mini-dark"
                        alt="logo"
                />--%>
            </a>
        </div>
        <ul class="navbar-nav">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    ${loginUser.name}님 환영합니다
                    <i class="fas fa-caret-down ms-1"></i>
                </a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="<c:url value='/mypage'/>">
                            <i class="fas fa-user-circle me-2" style="font-size: 1.2em;"></i>
                            <span style="font-size: 1.1em;">마이페이지</span>
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="#"
                           onclick="document.getElementById('logoutForm').submit(); return false;">
                            <i class="fas fa-sign-out-alt me-2" style="font-size: 1.2em;"></i>
                            <span style="font-size: 1.1em;">로그아웃</span>
                        </a>
                        <form id="logoutForm" action="<c:url value='/logout'/>" method="post" style="display: none;">
                            <sec:csrfInput/>
                        </form>
                    </li>
                </ul>
            </li>
        </ul>

        <a href="#" class="sidebar-toggler">
            <i data-feather="menu"></i>
        </a>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script>
    $(document).ready(function() {
        // Bootstrap dropdown 초기화
        $('.dropdown-toggle').dropdown();
    });
    function logoutform() {
        document.getElementById("logoutForm").submit();
    }
    $(document).on('click', '.dropdown-toggle', function () {
        $(this).dropdown('toggle');
    });
</script>
</body>
</html>