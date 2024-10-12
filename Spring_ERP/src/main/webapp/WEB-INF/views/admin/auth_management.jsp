<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ErpAuth</title>
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

        th, td {
            font-weight: 500;
        }


        .disabled {
            transition: background-color 0.5s ease, color 0.3s ease;
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>
<body>
<main class="bg-light pb-1px">
    <div class="content d-flex justify-content-between pt-2 pb-2 ps-4 pe-4 align-items-center">
        <div class="title fw-bold">
            권한 추가
        </div>
        <div class="d-flex">
            <div class="btn text-white" onclick="resetForm()">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                     class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z"/>
                    <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466"/>
                </svg>
                <span>초기화</span>
            </div>
        </div>
    </div>

    <div class="">
        <div class="m-1 p-2 border rounded bg-white">
            <form action="<c:url value="/admin/addAuth"/>" id="authForm" method="post">
                <div class="row mb-3">
                    <!-- 조직 ID -->
                    <div class="col-md-4">
                        <label for="selectAuth" class="form-label">권한 대상</label>
                        <select class="form-select" id="selectAuth" name="selectAuth" onchange="setInputName()">
                            <option value="userid">유저</option>
                            <option value="orgId">부서/매장</option>
                        </select>
                    </div>

                    <%-- 대상 ID --%>
                    <div class="col-md-4">
                        <label for="searchId" class="form-label">대상 ID</label>
                        <div class="d-flex">
                            <input type="text" class="form-control" id="searchId" name="userid" disabled>
                            <button type="button" id="idCheck" class="btn btn-secondary btn-sm text-nowrap">검색
                            </button>
                        </div>
                        <div id="searchMsg" class="error">대상을 검색해주세요</div>
                    </div>


                    <!-- 권한 -->
                    <div class="col-md-4">
                        <label for="auth" class="form-label">권한명<strong> [ROLE_] </strong>뒤에 추가로 입력</label>
                        <div class="d-flex form-control-position">
                            <input type="text" class="form-control text-uppercase" id="auth" name="auth" value="ROLE_">
                        </div>
                        <div id="authMsg" class="error">[ROLE_]이라는 단어가 포함되어야 합니다.</div>
                        <div id="authRegMsg" class="error">ROLE_ 뒤에 추가로 입력해주세요</div>
                        <div id="authInvalidMsg" class="error">영어 대문자와 '_'만 입력 가능합니다.</div>
                    </div>
                    <%-- 조직 타입: 조직 이름 선택시 자동으로 값 들어감 --%>
                    <input type="hidden" name="orgType" id="orgType" value="0">
                </div>
                <div class="text-start" id="alertContainer">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert" id="errorAlert">
                                ${errorMessage}
                        </div>
                    </c:if>
                </div>
                <div class="text-end">
                    <button type="submit" class="btn btn-primary">조직 생성</button>
                </div>
                <sec:csrfInput/>
            </form>
        </div>
    </div>
</main>
<section>
    <div class="content d-md-flex justify-content-between pt-2 pb-2 ps-4 pe-4 align-items-center">
        <div class="title fw-bold">
            권한 관리
        </div>

        <form action="<c:url value='/admin/auth'/>" method="post">
            <div class="row g-2 align-items-center">
                <div class="col-4">
                    <select name="column" class="form-select">
                        <option value="userid" selected>유저 ID</option>
                        <option value="orgId">부서 ID</option>
                        <option value="auth">권한</option>
                    </select>
                </div>
                <div class="col-5">
                    <input type="text" class="form-control" name="keyword" placeholder="검색어를 입력하세요">
                </div>
                <div class="col-3 d-flex justify-content-end">
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
    <div style="overflow-x: auto">
        <%-- 값 넘어오는지 테스트 --%>
        <%--<c:out value="${resultMap.erpAuthList}"/>--%>
        <%-- 유저 정보를 볼 수 있는 테이블 --%>
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th scope="col" class="text-center fs-6">유저 ID</th>
                <th scope="col" class="text-center fs-6">조직 ID</th>
                <th scope="col" class="text-center fs-6">권한</th>

                <th scope="col"></th>
            </tr>
            </thead>
            <c:choose>
                <c:when test="${empty resultMap.erpAuthList}">
                    <tr>
                        <td colspan="12" class="text-center">검색된 게시글이 없습니다</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="erpAuth" items="${resultMap.erpAuthList}">
                        <tr>
                            <td class="align-middle text-center">${erpAuth.userid}</td>
                            <td class="align-middle text-center">${erpAuth.orgId}</td>
                            <td class="align-middle text-center">${erpAuth.auth}</td>
                            <td>
                                <form action="<c:url value='/admin/deleteAuth'/>" method="POST">
                                    <input type="hidden" name="auth" value="${erpAuth.auth}">

                                    <c:if test="${not empty erpAuth.userid}">
                                        <input type="hidden" name="userid" value="${erpAuth.userid}">
                                    </c:if>

                                    <c:if test="${not empty erpAuth.orgId}">
                                        <input type="hidden" name="orgId" value="${erpAuth.orgId}">
                                    </c:if>

                                    <button type="submit"
                                            class="btn btn-danger"
                                            onclick="return confirm('해당 권한 [ ' + '${erpAuth.auth}' + ' ]을 정말 삭제하시겠습니까?')">
                                        삭제
                                    </button>

                                    <sec:csrfInput/>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </table>
    </div>
    <!-- 모달 -->
    <div class="modal fade" id="editOrgModal" tabindex="-1" aria-labelledby="editOrgModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editOrgModalLabel">조직 정보 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="editOrgForm" action="<c:url value="/admin/updateOrg"/>" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="orgName_modal" class="form-label">조직 이름</label>
                            <input type="text" class="form-control" id="orgName_modal" name="orgName">
                        </div>
                        <div class="mb-3">
                            <label for="orgId_modal" class="form-label">조직 ID</label>
                            <input type="text" class="form-control" id="orgId_modal" name="orgId" disabled>
                        </div>

                        <div class="mb-3">
                            <label for="orgType_modal" class="form-label">조직 유형</label>
                            <select class="form-select" id="orgType_modal" name="orgType" disabled>
                                <option value="0">부서</option>
                                <option value="1">매장</option>
                                <option value="9">부서 폐지/폐업</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="address_modal" class="form-label">주소</label>
                            <input type="text" class="form-control" id="address_modal" name="address">
                        </div>
                        <div class="mb-3">
                            <label for="phoneNumber_modal" class="form-label">조직 전화번호</label>
                            <input type="text" class="form-control" id="phoneNumber_modal" name="phoneNumber" disabled>
                        </div>
                        <sec:csrfInput/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                        <button type="submit" class="btn btn-primary" onclick="submitEditForm()">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="pagination-container text-center mt-4">
        <c:choose>
            <c:when test="${resultMap.pager.pageNum > 1}">
                <a class="btn btn-primary"
                   href="<c:url value='/admin/auth'/>?pageNum=${resultMap.pager.pageNum - 1}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
                    &laquo; 이전
                </a>
            </c:when>
            <c:otherwise>
      <span class="btn btn-secondary disabled">
        &laquo; 이전
      </span>
            </c:otherwise>
        </c:choose>

        <c:forEach var="i" begin="${resultMap.pager.startPage}" end="${resultMap.pager.endPage}" step="1">
            <c:choose>
                <c:when test="${resultMap.pager.pageNum == i}">
        <span class="btn btn-primary mx-1 active">
                ${i}
        </span>
                </c:when>
                <c:otherwise>
                    <a class="btn btn-outline-primary mx-1"
                       href="<c:url value='/admin/auth'/>?pageNum=${i}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
                            ${i}
                    </a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:choose>
            <c:when test="${resultMap.pager.pageNum < resultMap.pager.totalPage}">
                <a class="btn btn-primary"
                   href="<c:url value='/admin/auth'/>?pageNum=${resultMap.pager.pageNum + 1}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
                    다음 &raquo;
                </a>
            </c:when>
            <c:otherwise>
      <span class="btn btn-secondary disabled">
        다음 &raquo;
      </span>
            </c:otherwise>
        </c:choose>
    </div>
</section>
<script src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>
<script>
    window.onload = function () {
        const errorAlert = document.getElementById('errorAlert');
        const alertContainer = document.getElementById('alertContainer');

        if (errorAlert) {
            setTimeout(() => {
                errorAlert.classList.remove('show');  // fade-out 효과 적용
                errorAlert.classList.add('fade');     // 부드럽게 사라지도록 처리

                // 애니메이션 후 완전히 제거
                setTimeout(() => {
                    alertContainer.remove();  // div 자체 제거
                }, 500);  // fade-out 시간 후 삭제
            }, 3000);  // 3초 후 실행
        }
    };

    function setInputName() {
        const selectValue = document.getElementById("selectAuth").value;
        const inputField = document.getElementById("searchId");

        // 선택 값에 따라 input 필드의 name 속성 변경
        if (selectValue === "userid") {
            inputField.name = "userid";
        } else {
            inputField.name = "orgId";
        }
    }

    /* 중복 검사 */
    $("#idCheck").click(function () {
        // 화면 크기 및 브라우저 창 크기 계산
        var screenWidth = window.screen.width;
        var screenHeight = window.screen.height;

        var popupWidth = 700;
        var popupHeight = 500;

        // 창을 화면 가운데에 위치시키기 위한 좌표 계산
        var left = (screenWidth / 2) - (popupWidth / 2);
        var top = (screenHeight / 2) - (popupHeight / 2);

        // 새 창 열기
        window.open('<c:url value="/admin/searchId"/>?searchType=' + $("#selectAuth").val() + '&searchId=', 'idCheck', 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top);
    });

    const authReg = /^[A-Z_]+$/;

    $("#auth").on("input", function () {
        // 입력된 값을 대문자로 강제 변환
        this.value = this.value.toUpperCase();
    });

    $("#authForm").submit(function () {
        var submitResult = true;

        $(".error").css("display", "none").css("visibility", "hidden").removeClass("is-invalid");
        $("#searchId").removeClass("is-invalid");
        $("#auth").removeClass("is-invalid");

        $("#searchId").prop("disabled", false);

        if ($("#searchId").val() == "") {
            $("#searchMsg").css("display", "block").css("visibility", "visible");
            $("#searchId").addClass("is-invalid");
            submitResult = false;
        }

        if (!$("#auth").val().startsWith("ROLE_")) {
            $("#authMsg").css("display", "block").css("visibility", "visible");
            $("#auth").addClass("is-invalid");
            submitResult = false;
        } else if ($("#auth").val() === "ROLE_") {
            $("#authRegMsg").css("display", "block").css("visibility", "visible");
            $("#auth").addClass("is-invalid");
            submitResult = false;
        } else if (!authReg.test($("#auth").val())) {
            $("#authInvalidMsg").css("display", "block").css("visibility", "visible");
            $("#auth").addClass("is-invalid");
            submitResult = false;
        }

        console.log($("#searchId").val());
        console.log($("#auth").val());

        return submitResult;
    });
</script>

</body>
</html>
