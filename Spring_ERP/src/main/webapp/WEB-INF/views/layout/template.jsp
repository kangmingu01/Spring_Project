<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%-- 페이지의 뼈대를 제공하기 위한 JSP 문서 - 템플릿 페이지 --%>
<!-- TilesView 기능을 제공하는 태그를 사용하기 위해 JSP 문서에 tags-tiles 태그 라이브러리 추가 -->
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SPRING</title>

    <%-- 폰트 어썸 --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

    <%-- 부트스트랩 --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">


    <%-- 구글 폰트 Noto Sans KR --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
          rel="stylesheet">
    <style>
        * {
            font-family: 'Roboto', 'Noto Sans KR', 'sans-serif';
        }

        #sidebar {
            z-index: 9999;
        }

        #header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 100;
        }

        #content {
            margin-top: 60px;
            overflow-y: auto;
            overflow-x: auto;
        }

    </style>

    <!-- color-modes:js -->
    <script src="<c:url value="/js/color-modes.js"/>"></script>
    <!-- endinject -->

    <!-- core:css -->
    <link rel="stylesheet" href="<c:url value="/css/core.css"/>"/>
    <%--	<link rel="stylesheet" href="assets/css/core.css" />--%>
    <!-- endinject -->

    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="<c:url value="/css/flatpickr.min.css"/>"/>
    <%--<link rel="stylesheet" href="assets/css/flatpickr.min.css" />--%>
    <!-- End plugin css for this page -->

    <!-- inject:css -->
    <link rel="stylesheet" href="<c:url value="/resources/css/iconfont.css"/>"/>
    <%--<link rel="stylesheet" href="assets/css/iconfont.css" />--%>
    <!-- endinject -->

    <!-- Layout styles -->
    <link rel="stylesheet" href="<c:url value="/css/style.css"/>"/>
    <%--<link rel="stylesheet" href="assets/css/style.css" />--%>
    <!-- End layout styles -->

    <link rel="shortcut icon" href="<c:url value="/images/favicon.png"/>"/>
</head>
<body>
<div class="main-wrapper d-flex flex-column min-vh-100">
    <%-- Side Bar(menu) --%>
    <div id="sidebar" class="position-fixed">
        <tiles:insertAttribute name="sidebar"/>
    </div>

    <!-- partial -->
    <div class="page-wrapper flex-grow-1">
        <div id="header" class="">
            <tiles:insertAttribute name="header"/>
        </div>

        <!-- content 부분(content 부분만 바뀌면 됨) -->
        <div id="content" class="flex-grow-1 overflow-auto">
            <tiles:insertAttribute name="content"/>
        </div>
    </div>

    <div id="footer" class="mt-auto">
        <tiles:insertAttribute name="footer"/>
    </div>
</div>

<%-- jquery --%>
<script src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>

<!-- core:js -->
<script src="<c:url value='/js/core.js'/>"></script>
<!-- endinject -->

<!-- Plugin js for this page -->
<script src="<c:url value="/js/flatpickr.min.js"/>"></script>
<script src="<c:url value="/js/apexcharts.min.js"/>"></script>
<!-- End plugin js for this page -->

<!-- inject:js -->
<script src="<c:url value="/js/feather.min.js"/>"></script>
<script src="<c:url value="/js/app.js"/>"></script>
<!-- endinject -->

<!-- Custom js for this page -->
<script src="<c:url value="/js/dashboard.js"/>"></script>
<!-- End custom js for this page -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>