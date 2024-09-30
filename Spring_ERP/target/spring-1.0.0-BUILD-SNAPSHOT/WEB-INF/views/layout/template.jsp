<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%-- 페이지의 뼈대를 제공하기 위한 JSP 문서 - 템플릿 페이지 --%>
<!-- TilesView 기능을 제공하는 태그를 사용하기 위해 JSP 문서에 tags-tiles 태그 라이브러리 추가 -->
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link>
<meta charset="UTF-8">
<title>SPRING</title>
<style type="text/css">
    /*#header {
        border: 2px solid red;
        height: 150px;
        margin: 10px;
        padding: 10px;
        text-align: center;
    }

    #content {

        border: 2px solid green;
        min-height: 550px;
        margin: 10px;
        padding: 10px;
    }

    #footer {
        border: 2px solid blue;
        height: 150px;
        margin: 10px;
        padding: 10px;
        text-align: center;
    }*/
</style>

<!-- color-modes:js -->
<script src="<c:url value="/js/color-modes.js"/>"></script>
<!-- endinject -->

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
<link
        href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap"
        rel="stylesheet"
/>

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
<div class="main-wrapper">
    <%-- Side Bar(menu) --%>
    <div id="sidebar" class="">
        <tiles:insertAttribute name="sidebar"/>
    </div>
    <!-- partial -->

    <div class="page-wrapper">

        <div id="header" class="">
            <tiles:insertAttribute name="header"/>
        </div>

        <!-- content 부분(content 부분만 바뀌면 됨) -->
        <div id="content" class="mt-6">
            <tiles:insertAttribute name="content"/>
        </div>

        <div id="footer" class="">
            <tiles:insertAttribute name="footer"/>
        </div>
        <!-- partial -->
    </div>

</div>
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
</body>
</html>