<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>User ID Check</title>

    <style>
        .content {
            background-color: #6571ff;
            color: white;
        }

        .title {
            font-size: 18px;
        }

        .content > button:hover {
            background-color: #7782f8;
        }

        .error {
            color: red;
            display: none;
            visibility: hidden;
            height: 1.2em;
        }

        .is-invalid {
            border-color: red;
        <%-- 오류 발생 시 테두리 색상 --%> animation: shake 0.5s;
        <%-- 흔들림 애니메이션 --%>
        }

        @keyframes shake {
            0% {
                transform: translateX(0);
            }
            25% {
                transform: translateX(-5px);
            }
            50% {
                transform: translateX(5px);
            }
            75% {
                transform: translateX(-5px);
            }
            100% {
                transform: translateX(0);
            }
        }

        /* input 요소가 focus 상태일 때 배경색을 유지 */
        input:focus {
            background-color: #ffffff; /* 흰색 배경 유지 */
            box-shadow: none; /* 기본 파란색 테두리 효과 제거 */
            outline: none; /* 테두리 제거 */
        }
    </style>
    <%-- 부트스트랩 --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <%-- 구글 폰트 Noto Sans KR --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
          rel="stylesheet">
</head>
<body>
<header class="content d-md-flex justify-content-between pt-2 pb-2 ps-4 pe-4 align-items-center">
    <div class="container title fw-bold">
        대상 검색
    </div>
</header>
<section class="">
    <c:choose>
        <c:when test="${searchType == 'userid'}">
            <div class="content d-md-flex justify-content-center pt-2 pb-2 ps-4 pe-4 align-items-center">

                <form action="<c:url value='/admin/searchId'/>" method="post">
                    <input type="hidden" name="column" value="name">
                    <input type="hidden" name="searchType" value="userid">
                    <div class="row ">

                        <div class="col-11">
                            <input type="text" class="form-control" name="keyword" placeholder="유저 이름으로 입력하세요">
                        </div>
                        <div class="col-1 d-flex justify-content-end">
                            <button type="submit" class="btn btn-primary text-white d-flex align-items-center">
                                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor"
                                     class="bi bi-search" viewBox="0 0 16 16">
                                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                                </svg>
                                <span class="ms-2 text-nowrap">조회</span>
                            </button>
                        </div>
                    </div>
                    <sec:csrfInput/>
                </form>
            </div>
            <main style="overflow-x: auto" class="flex-fill">
                    <%-- 값 넘어오는지 테스트 --%>
                    <%--<c:out value="${resultMap.erpAuthList}"/>--%>
                    <%-- 유저 정보를 볼 수 있는 테이블 --%>
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th scope="col" class="text-center fs-6">유저 이름</th>
                        <th scope="col" class="text-center fs-6">유저 ID</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <c:choose>
                        <c:when test="${empty resultMap.erpUserList}">
                            <tr>
                                <td colspan="12" class="text-center">검색된 유저가 없습니다</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="erpUser" items="${resultMap.erpUserList}">
                                <tr>
                                    <td class="align-middle text-center">${erpUser.name}</td>
                                    <td class="align-middle text-center">${erpUser.userid}</td>
                                    <td>
                                        <button type="button" class="btn btn-warning"
                                                onclick="selectId('${erpUser.userid}')">선택
                                        </button>

                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </table>
            </main>
        </c:when>
        <c:when test="${searchType == 'orgId'}">
            <div class="content d-md-flex justify-content-center pt-2 pb-2 ps-4 pe-4 align-items-center">

                <form action="<c:url value='/admin/searchId'/>" method="post">
                    <input type="hidden" name="column" value="org_name">
                    <input type="hidden" name="searchType" value="orgId">
                    <div class="row ">

                        <div class="col-11">
                            <input type="text" class="form-control" name="keyword" placeholder="조직 이름으로 입력하세요">
                        </div>
                        <div class="col-1 d-flex justify-content-end">
                            <button type="submit" class="btn btn-primary text-white d-flex align-items-center">
                                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor"
                                     class="bi bi-search" viewBox="0 0 16 16">
                                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                                </svg>
                                <span class="ms-2 text-nowrap">조회</span>
                            </button>
                        </div>
                    </div>
                    <sec:csrfInput/>
                </form>
            </div>
            <main style="overflow-x: auto" class="flex-fill">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th scope="col" class="text-center fs-6">조직 이름</th>
                        <th scope="col" class="text-center fs-6">조직 ID</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <c:choose>
                        <c:when test="${empty resultMap.organizationList}">
                            <tr>
                                <td colspan="12" class="text-center">검색된 유저가 없습니다</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="organization" items="${resultMap.organizationList}">
                                <tr>
                                    <td class="align-middle text-center">${organization.orgName}</td>
                                    <td class="align-middle text-center">${organization.orgId}</td>
                                    <td>
                                        <button type="button" class="btn btn-warning"
                                                onclick="selectId('${organization.orgId}')">선택
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </table>
            </main>
        </c:when>
    </c:choose>
    <footer class="footer bg-light text-center py-3 position-sticky bottom-0 w-100">
        <div class="pagination-container">
            <c:choose>
                <c:when test="${resultMap.pager.pageNum > 1}">
                    <a class="btn btn-primary"
                       href="<c:url value='/admin/searchId'/>?pageNum=${resultMap.pager.pageNum - 1}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}&searchType=${searchType}">
                        &laquo; 이전 정해일
                    </a>
                </c:when>
                <c:otherwise>
                    <span class="btn btn-secondary disabled">&laquo; 이전</span>
                </c:otherwise>
            </c:choose>

            <c:forEach var="i" begin="${resultMap.pager.startPage}" end="${resultMap.pager.endPage}" step="1">
                <c:choose>
                    <c:when test="${resultMap.pager.pageNum == i}">
                        <span class="btn btn-primary mx-1 active">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a class="btn btn-outline-primary mx-1"
                           href="<c:url value='/admin/searchId'/>?pageNum=${i}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}&searchType=${searchType}">
                                ${i}
                        </a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:choose>
                <c:when test="${resultMap.pager.pageNum < resultMap.pager.totalPage}">
                    <a class="btn btn-primary"
                       href="<c:url value='/admin/searchId'/>?pageNum=${resultMap.pager.pageNum + 1}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}&searchType=${searchType}">
                        다음 &raquo;
                    </a>
                </c:when>
                <c:otherwise>
                    <span class="btn btn-secondary disabled">다음 &raquo;</span>
                </c:otherwise>
            </c:choose>
        </div>
    </footer>
</section>
<script src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>
<script>
    function selectId(id) {

        opener.document.getElementById("searchId").value = id;
        window.close();
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
