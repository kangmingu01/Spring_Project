<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>user</title>
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

        .form-control-position {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            right: 110px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
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


        .active-button {
            transition: background-color 0.5s ease, color 0.3s ease;
            background-color: #198754;
            color: white;
        }


        .disabled {
            transition: background-color 0.5s ease, color 0.3s ease;
            background-color: #6c757d;
            color: white;
        }

    </style>
    <script src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>
</head>
<body>
<main class="bg-light pb-1px">
    <div class="content d-flex justify-content-between pt-2 pb-2 ps-4 pe-4 align-items-center">
        <div class="title fw-bold">
            유저 관리
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
            <form action="<c:url value="/admin/addUser"/>" id="userForm" method="post">
                <%-- 아이디 중복 체크 --%>
                <input type="hidden" id="idCheckResult" value="0">

                <div class="row mb-3">
                    <!-- 유저 ID -->
                    <div class="col-md-4">
                        <label for="userid" class="form-label">유저 ID</label>
                        <div class="d-flex">
                            <input type="text" class="form-control" id="userid" name="userid">
                            <button type="button" id="idCheck" class="btn btn-secondary btn-sm text-nowrap">중복검사
                            </button>
                        </div>

                        <div id="idMsg" class="error">아이디를 입력해주세요</div>
                        <div id="idRegMsg" class="error">아이디는 영문자로 시작되는 영문자, 숫자의 범위 6~15범위의 문자로만 작성 가능합니다</div>
                        <div id="idCheckMsg" class="error">아이디 중복 검사를 반드시 실행해주세요</div>

                    </div>

                    <!-- 비밀번호 -->
                    <div class="col-md-4">
                        <label for="passwd" class="form-label">비밀번호</label>
                        <%--<div class="d-flex form-control-position">
                            <input type="password" class="form-control" id="passwd" name="passwd" disabled
                                   readonly>
                            <span class="toggle-password" onclick="togglePassword()">
                            <i class="fa fa-eye-slash" id="toggleIcon"></i>
                            </span>
                            <button type="button" class="btn btn-secondary btn-sm text-nowrap"
                                    onclick="generateRandomPassword()">랜덤생성
                            </button>
                        </div>--%>
                        <div class="d-flex form-control-position">
                            <input type="text" class="form-control" id="passwd" name="passwd"
                            >
                            <button type="button" class="btn btn-secondary btn-sm text-nowrap"
                                    onclick="generateRandomPassword()">랜덤생성
                            </button>
                        </div>
                        <div id="passwdMsg" class="error">비밀번호를 입력해주세요</div>
                    </div>
                    <!-- 이름 -->
                    <div class="col-md-4">
                        <label for="name" class="form-label">이름</label>
                        <input type="text" class="form-control" id="name" name="name">
                        <div id="nameMsg" class="error">이름을 입력해 주세요.</div>
                        <div id="nameRegMsg" class="error">한글만 입력 가능합니다.</div>
                        <%-- 이름 입력 오류 메시지 --%>
                    </div>
                </div>

                <div class="row mb-3">
                    <!-- 주소 -->
                    <!-- 전화번호 -->
                    <div class="col-md-4">
                        <label for="phone" class="form-label">전화번호</label>
                        <input type="text" class="form-control" id="phone" name="phone">
                        <div id="phoneMsg" class="error">전화번호를 입력해 주세요.</div>
                        <div id="phoneHyphenMsg" class="error">전화번호에 (-) 빼고 입력해주세요</div>
                        <div id="phoneRegMsg" class="error">010이 포함되어야 하며 11자리 맞춰 입력해 주세요</div>
                        <%-- 전화번호 형식 오류 메시지 --%>
                    </div>
                    <div class="col-md-4">
                        <label for="address" class="form-label">주소</label>
                        <input type="text" class="form-control" id="address" name="address">
                        <div id="addressMsg" class="error">주소를 입력해 주세요.</div>
                        <%-- 주소 입력 오류 메시지 --%>
                    </div>
                    <!-- 이메일 -->
                    <div class="col-md-4">
                        <label for="email" class="form-label">이메일</label>
                        <input type="email" class="form-control" id="email" name="email">
                        <div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
                        <%-- 이메일 입력 오류 메시지 --%>
                        <div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>
                        <%-- 이메일 형식 오류 메시지 --%>
                    </div>

                </div>

                <div class="row mb-3">
                    <!-- 성별 -->
                    <div class="col-md-4">
                        <label for="gender" class="form-label">성별</label>
                        <select class="form-select" id="gender" name="gender">
                            <option value="1">남자</option>
                            <option value="2">여자</option>
                        </select>
                    </div>
                    <!-- 생일 -->
                    <div class="col-md-4">
                        <label for="birthday" class="form-label">생일</label>
                        <input type="date" class="form-control" id="birthday" name="birthday">
                        <div id="birthdayMsg" class="error">생년월일을 선택해주세요</div>
                    </div>
                    <!-- 입사일 -->
                    <div class="col-md-4">
                        <label for="joindate" class="form-label">입사일</label>
                        <input type="date" class="form-control" id="joindate" name="joindate">
                        <div id="joindateMsg" class="error">입사일을 선택해주세요</div>
                    </div>
                </div>
                <div class="row mb-3">
                    <!-- 상태 -->
                    <div class="col-md-4">
                        <label for="enabled" class="form-label">계정 상태</label>
                        <select class="form-select" id="enabled" name="enabled">
                            <option value="1">활성화</option>
                            <option value="0">비활성화</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="searchOrgId" class="form-label">조직 ID</label>
                        <div class="d-flex">
                            <input type="text" class="form-control" id="searchOrgId" name="orgId" disabled>
                            <button type="button" id="orgIdCheck" class="btn btn-secondary btn-sm text-nowrap">검색
                            </button>
                        </div>
                        <div id="searchMsg" class="error">조직ID를 검색해주세요</div>
                    </div>
                </div>
                <c:if test="${param.error == 'emailFailed'}">
                    <div class="alert alert-danger">
                        이메일 발송에 실패하였습니다. 다시 시도해 주세요.
                    </div>
                </c:if>
                <div class="text-end">
                    <button type="submit" class="btn btn-primary">유저 추가</button>
                </div>
                <sec:csrfInput/>
            </form>
        </div>
    </div>
</main>
<section>
    <div class="content d-md-flex justify-content-between pt-2 pb-2 ps-4 pe-4 align-items-center">
        <div class="title fw-bold">
            유저 정보 테이블
        </div>

        <form action="<c:url value='/admin/user'/>" method="post">
            <div class="row g-2 align-items-center">
                <div class="col-4">
                    <select name="column" class="form-select">
                        <option value="userid" selected>유저 ID</option>
                        <option value="name">이름</option>
                        <option value="org_Id">조직 ID</option>
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
        <%--<c:out value="${resultMap.erpUserList}"/>--%>
        <%-- 유저 정보를 볼 수 있는 테이블 --%>
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th scope="col" class="text-center fs-6">유저 ID</th>
                <%--<th scope="col">비밀번호</th>--%>
                <th scope="col" class="text-center fs-6">이름</th>
                <th scope="col" class="text-center fs-6">전화번호</th>
                <th scope="col" class="text-center fs-6">주소</th>
                <th scope="col" class="text-center fs-6">이메일</th>
                <th scope="col" class="text-center fs-6">성별</th>
                <th scope="col" class="text-center fs-6">생일</th>
                <th scope="col" class="text-center fs-6">가입일</th>
                <th scope="col" class="text-center fs-6">유저상태</th>
                <th scope="col" class="text-center fs-6">조직 ID</th>
                <th scope="col"></th>
                <th scope="col"></th>
            </tr>
            </thead>
            <c:choose>
                <c:when test="${empty resultMap.erpUserList}">
                    <tr>
                        <td colspan="12" class="text-center">검색된 게시글이 없습니다</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="erpUser" items="${resultMap.erpUserList}">
                        <tr>
                            <td class="text-center align-middle">${erpUser.userid}</td>
                            <td class="text-center align-middle">${erpUser.name}</td>
                            <td class="text-center align-middle">${erpUser.phone}</td>
                            <td class="text-center align-middle">${erpUser.address}</td>
                            <td class="text-center align-middle">${erpUser.email}</td>
                            <td class="text-center align-middle">
                                <c:choose>
                                    <c:when test="${erpUser.gender == 1}">남자</c:when>
                                    <c:otherwise>여자</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center align-middle">${erpUser.birthday}</td>
                            <td class="text-center align-middle">${erpUser.joindate}</td>
                            <td class="text-center align-middle">
                                <div class="d-flex justify-content-center align-items-center" style="height: 100%;">
                                    <c:choose>
                                        <c:when test="${erpUser.enabled == 0}">
                                            <p class="text-danger mb-0">비활성화</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-primary mb-0">활성화</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                            <td class="text-center align-middle">${erpUser.orgId}</td>
                            <td>
                                <button type="button" class="btn btn-secondary"
                                        data-bs-toggle="modal" data-bs-target="#editUserModal"
                                        data-userid="${erpUser.userid}"
                                        data-name="${erpUser.name}"
                                        data-phone="${erpUser.phone}"
                                        data-address="${erpUser.address}"
                                        data-email="${erpUser.email}"
                                        data-gender="${erpUser.gender}"
                                        data-birthday="${erpUser.birthday}"
                                        data-joindate="${erpUser.joindate}"
                                        data-enabled="${erpUser.enabled}"
                                        data-orgid="${erpUser.orgId}"
                                        data-isInitialPassword="${erpUser.isInitialPassword}"
                                        data-failedAttempts="${erpUser.failedAttempts}"
                                >
                                    수정
                                </button>
                            </td>
                            <td>
                                <form action="<c:url value="/admin/deleteUser"/>" method="post">
                                    <input type="hidden" name="userid" value="${erpUser.userid}">
                                    <button type="submit" class="btn btn-danger"
                                            onclick="return confirm('정말로 이 유저를 삭제하시겠습니까?')">삭제
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
    <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editUserModalLabel">유저 정보 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="editUserForm" action="<c:url value="/admin/updateUser"/>" method="post">
                    <input type="hidden" name="isInitialPassword" id="isInitialPassword_modal">
                    <input type="hidden" name="failedAttempts" id="failedAttempts_modal">

                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="userid_modal" class="form-label">유저 ID</label>
                            <input type="text" class="form-control" id="userid_modal" name="userid" disabled>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between text-center">
                                <label for="passwd_modal" class="form-label">비밀번호</label>
                                <div>
                                    <input type="checkbox" id="passwd_btn_active" onclick="togglePasswordButton()">
                                    <!-- 체크박스 클릭 시 함수 호출 -->
                                    <label for="passwd_btn_active" class="form-label">활성화</label>
                                </div>
                            </div>
                            <div class="d-flex">
                                <%-- 나중에 이부분 비밀번호 재설정이면 --%>
                                <input type="text" class="form-control" id="passwd_modal" name="passwd">
                                <button type="button" id="generate_passwd_btn"
                                        class="btn btn-secondary btn-sm text-nowrap disabled" disabled
                                        onclick="generateRandomPassword()">재생성
                                </button>
                            </div>
                            <span class="text-danger">비밀번호를 다시 생성할 경우 체크박스를 활성화하고 재생성 버튼을 눌러주세요</span>
                        </div>
                        <div class="mb-3">
                            <label for="name_modal" class="form-label">이름</label>
                            <input type="text" class="form-control" id="name_modal" name="name" disabled>
                        </div>
                        <div class="mb-3">
                            <label for="phone_modal" class="form-label">전화번호</label>
                            <input type="text" class="form-control" id="phone_modal" name="phone">
                        </div>
                        <div class="mb-3">
                            <label for="address_modal" class="form-label">주소</label>
                            <input type="text" class="form-control" id="address_modal" name="address">
                        </div>
                        <div class="mb-3">
                            <label for="email_modal" class="form-label">이메일</label>
                            <input type="text" class="form-control" id="email_modal" name="email">
                        </div>
                        <div class="mb-3">
                            <label for="gender_modal" class="form-label">성별</label>
                            <select class="form-select" id="gender_modal" name="gender" disabled>
                                <option value="1">남자</option>
                                <option value="2">여자</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="birthday_modal" class="form-label">생일</label>
                            <input type="text" class="form-control" id="birthday_modal" name="birthday" disabled>
                        </div>
                        <div class="mb-3">
                            <label for="joindate_modal" class="form-label">입사일</label>
                            <input type="text" class="form-control" id="joindate_modal" name="joindate" disabled>
                        </div>
                        <div class="mb-3">
                            <label for="enabled_modal" class="form-label">계정 상태</label>

                            <select class="form-select" id="enabled_modal" name="enabled">
                                <option value="1">활성화</option>
                                <option value="0">비활성화</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="orgId_modal" class="form-label">조직 ID</label>
                            <input type="text" class="form-control" id="orgId_modal" name="orgId">
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
                   href="<c:url value='/admin/user'/>?pageNum=${resultMap.pager.pageNum - 1}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
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
                       href="<c:url value='/admin/user'/>?pageNum=${i}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
                            ${i}
                    </a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:choose>
            <c:when test="${resultMap.pager.pageNum < resultMap.pager.totalPage}">
                <a class="btn btn-primary"
                   href="<c:url value='/admin/user'/>?pageNum=${resultMap.pager.pageNum + 1}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
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



<script>
    function togglePassword() {
        const passwordInput = document.getElementById("passwd");
        const toggleIcon = document.getElementById("toggleIcon");

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            toggleIcon.classList.remove("fa-eye-slash");
            toggleIcon.classList.add("fa-eye");
        } else {
            passwordInput.type = "password";
            toggleIcon.classList.remove("fa-eye");
            toggleIcon.classList.add("fa-eye-slash");
        }
    }

    // 초기화 버튼 누르면 form 초기화
    function resetForm() {
        document.getElementById("userForm").reset();
    }

    // 랜덤으로 비밀번호 10자리 생성하는 함수
    function generateRandomPassword() {
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        let password = '';
        for (let i = 0; i < 10; i++) {
            password += characters.charAt(Math.floor(Math.random() * characters.length));
        }

        let passwdField = document.getElementById("passwd");
        let passwdModalField = document.getElementById("passwd_modal");

        if (passwdModalField && passwdModalField.offsetParent !== null) {
            passwdModalField.value = password;
        } else if (passwdField) {
            passwdField.value = password;
        }

        $("#passwd").removeClass("is-invalid");
        $("#passwdMsg").css("display", "none").css("visibility", "hidden");
    }

    // 랜덤으로 비밀번호 10자리 생성하는 함수 => 모달
    function generateRandomPasswordModal() {
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        let password = '';
        for (let i = 0; i < 10; i++) {
            password += characters.charAt(Math.floor(Math.random() * characters.length));
        }
        document.getElementById("passwd_modal").value = password;
        $("#passwd").removeClass("is-invalid");
        $("#passwdMsg").css("display", "none").css("visibility", "hidden");
    }

    // 페이지 첫 로드시 입력 포커스 잡히게
    $("#userid").focus();

    /* 검증 정규표현식 */
    var idReg = /^[a-zA-Z]\w{5,19}$/;
    var passwdReg = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/;
    var emailReg = /^([a-zA-Z0-9._]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/;
    var phoneReg = /^010\d{8}$/;
    var nameReg = /^[가-힣]+$/;

    // 유저 추가 버튼 누르면 검증
    // => 입력 필드에 있는 값 다 검증하고 문제 있으면 다 잡아다가 에러메세지 띄워줘야됨
    $("#userForm").submit(function () {
            /* 제출 여부 확인 */
            var submitResult = true;

            /* 모든 에러 메세지 숨김 */
            $(".error").css("display", "none").css("visibility", "hidden").removeClass("is-invalid");

            // disabled 속성 있으면 값을 넘길 때 아무것도 들어가지 않음
            $("#passwd").prop("disabled", false);
            $("#searchOrgId").prop("disabled", false);

            if ($("#userid").val() == "") {
                $("#idMsg").css("display", "block").css("visibility", "visible");
                $("#userid").addClass("is-invalid");
                submitResult = false;
            } else if (!idReg.test($("#userid").val())) {
                $("#idRegMsg").css("display", "block").css("visibility", "visible");
                $("#userid").addClass("is-invalid");
                submitResult = false;
            } else if ($("#idCheckResult").val() == "0") {
                $("#idCheckMsg").css("display", "block").css("visibility", "visible");
                $("#userid").addClass("is-invalid");
                submitResult = false;
            }

            if ($("#passwd").val() == "") {
                $("#passwdMsg").css("display", "block").css("visibility", "visible");
                $("#passwd").addClass("is-invalid");
                submitResult = false;
            }

            if ($("#name").val() == "") {
                $("#nameMsg").css("display", "block").css("visibility", "visible");
                $("#name").addClass("is-invalid");
                submitResult = false;
            } else if (!nameReg.test($("#name").val())) { // 한글만 입력 가능
                $("#nameRegMsg").css("display", "block").css("visibility", "visible");
                $("#name").addClass("is-invalid");
                submitResult = false;
            }

            if ($("#email").val() == "") {
                $("#emailMsg").css("display", "block").css("visibility", "visible");
                $("#email").addClass("is-invalid");
                submitResult = false;
            } else if (!emailReg.test($("#email").val())) {
                $("#emailRegMsg").css("display", "block").css("visibility", "visible");
                $("#email").addClass("is-invalid");
                submitResult = false;
            }

            if ($("#phone").val() == "") {
                $("#phoneMsg").css("display", "block").css("visibility", "visible");
                $("#phone").addClass("is-invalid");
                submitResult = false;
            } else if ($("#phone").val().includes("-")) {
                $("#phoneHyphenMsg").css("display", "block").css("visibility", "visible");
                $("#phone").addClass("is-invalid");
                submitResult = false;
            } else if (!phoneReg.test($("#phone").val())) {
                $("#phoneRegMsg").css("display", "block").css("visibility", "visible");
                $("#phone").addClass("is-invalid");
                submitResult = false;
            }

            if ($("#address").val() == "") {
                $("#addressMsg").css("display", "block").css("visibility", "visible");
                $("#address").addClass("is-invalid");
                submitResult = false;
            }
            if ($("#birthday").val() == "") {
                $("#birthdayMsg").css("display", "block").css("visibility", "visible");
                $("#birthday").addClass("is-invalid");
                submitResult = false;
            }
            if ($("#joindate").val() == "") {
                $("#joindateMsg").css("display", "block").css("visibility", "visible");
                $("#joindate").addClass("is-invalid");
                submitResult = false;
            }
            if ($("#orgId").val() == "") {
                $("#orgIdMsg").css("display", "block").css("visibility", "visible");
                $("#orgId").addClass("is-invalid");
                submitResult = false;
            }
            return submitResult;
        }
    )

    // 아이디 입력 시 is-invalid 클래스 제거
    $("#userid").on("keyup", function () {
        if ($(this).val().trim() !== "") {
            $("#idMsg").css("display", "none").css("visibility", "hidden");
            $("#idCheckMsg").css("display", "none").css("visibility", "hidden");
            $("#idRegMsg").css("display", "none").css("visibility", "hidden");
            $(this).removeClass("is-invalid");
        }
    });


    // 비밀번호 입력 시 is-invalid 클래스 제거
    /*$("#passwd").on("keyup", function () {
        if ($(this).val().trim() !== "") {
            $(this).removeClass("is-invalid");
        }
    });

    if ($("#passwd").val() == "") {
        $(this).removeClass("is-invalid");
    }*/


    // 이름 입력 시 is-invalid 클래스 제거
    $("#name").on("keyup", function () {
        if ($(this).val().trim() !== "") {
            $("#nameMsg").css("display", "none").css("visibility", "hidden");
            $(this).removeClass("is-invalid");
        }
    });

    // 전화번호 입력 시 is-invalid 클래스 제거
    $("#phone").on("keyup", function () {
        if ($(this).val().trim() !== "") {
            $("#phoneMsg").css("display", "none").css("visibility", "hidden");
            $(this).removeClass("is-invalid");
        }
    });

    // 주소 입력 시 is-invalid 클래스 제거
    $("#address").on("keyup", function () {
        if ($(this).val().trim() !== "") {
            $("#addressMsg").css("display", "none").css("visibility", "hidden");
            $(this).removeClass("is-invalid");
        }
    });

    // 이메일 입력 시 is-invalid 클래스 제거
    $("#email").on("keyup", function () {
        if ($(this).val().trim() !== "") {
            $("#emailMsg").css("display", "none").css("visibility", "hidden");
            $(this).removeClass("is-invalid");
        }
    });

    // 생일 입력 시 is-invalid 클래스 제거
    $("#birthday").on("change", function () {
        if ($(this).val().trim() !== "") {
            $("#birthdayMsg").css("display", "none").css("visibility", "hidden");
            $(this).removeClass("is-invalid");
        }
    });

    // 입사일 입력 시 is-invalid 클래스 제거
    $("#joindate").on("change", function () {
        if ($(this).val().trim() !== "") {
            $("#joindateMsg").css("display", "none").css("visibility", "hidden");
            $(this).removeClass("is-invalid");
        }
    });

    // 조직 ID 입력 시 is-invalid 클래스 제거
    $("#orgId").on("keyup", function () {
        if ($(this).val().trim() !== "") {
            $("#orgIdMsg").css("display", "none").css("visibility", "hidden");
            $(this).removeClass("is-invalid");
        }
    });

    /* 중복 검사 */
    $("#idCheck").click(function () {
        $("#idMsg").css("display", "none").css("visibility", "hidden");
        $("#idRegMsg").css("display", "none").css("visibility", "hidden");
        $("#idCheckMsg").css("display", "none").css("visibility", "hidden");

        if ($("#userid").val() == "") {
            $("#idMsg").css("display", "block").css("visibility", "visible");
            $("#userid").addClass("is-invalid");
            return;
        } else if (!idReg.test($("#userid").val())) {
            $("#idRegMsg").css("display", "block").css("visibility", "visible");
            $("#userid").addClass("is-invalid");
            return;
        }
        $("#userid").removeClass("is-invalid");

        // 화면 크기 및 브라우저 창 크기 계산
        var screenWidth = window.screen.width;
        var screenHeight = window.screen.height;

        var popupWidth = 500;
        var popupHeight = 300;

        // 창을 화면 가운데에 위치시키기 위한 좌표 계산
        var left = (screenWidth / 2) - (popupWidth / 2);
        var top = (screenHeight / 2) - (popupHeight / 2);

        // 새 창 열기
        window.open('<c:url value="/admin/idCheck"/>?userid=' + $("#userid").val(), 'idCheck', 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top);

    });

    $("#orgIdCheck").click(function () {
        // 화면 크기 및 브라우저 창 크기 계산
        var screenWidth = window.screen.width;
        var screenHeight = window.screen.height;

        var popupWidth = 700;
        var popupHeight = 500;

        // 창을 화면 가운데에 위치시키기 위한 좌표 계산
        var left = (screenWidth / 2) - (popupWidth / 2);
        var top = (screenHeight / 2) - (popupHeight / 2);

        // 새 창 열기
        var popup = window.open(
            '<c:url value="/admin/searchOrgId"/>?type=all',
            'orgIdCheck',
            'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top
        );
        if (!popup || popup.closed || typeof popup.closed == 'undefined') {
            alert('팝업 차단이 활성화되어 있습니다. 브라우저 설정을 확인해주세요.');
        }

    });

    /* 아이디 바꾸면 다시 중복검사할 수 있게 */
    $("#userid").change(function () {
        $("#idCheckResult").val("0");
        $("#userid").removeClass("is-invalid");
    })

    /* 모달창 열릴 때 값 들어갈 수 있게 */
    document.addEventListener('DOMContentLoaded', function () {
        var editUserModal = document.getElementById('editUserModal');

        editUserModal.addEventListener('show.bs.modal', function (event) {
            // 버튼에서 데이터 가져오기
            var button = event.relatedTarget;
            var userid = button.getAttribute('data-userid');
            var name = button.getAttribute('data-name');
            var phone = button.getAttribute('data-phone');
            var address = button.getAttribute('data-address');
            var email = button.getAttribute('data-email');
            var gender = button.getAttribute('data-gender');
            var birthday = button.getAttribute('data-birthday');
            var joindate = button.getAttribute('data-joindate');
            var enabled = button.getAttribute('data-enabled');
            var orgid = button.getAttribute('data-orgid');
            var isInitialPassword = button.getAttribute('data-isInitialPassword');
            var failedAttempts = button.getAttribute('data-failedAttempts');

            // 모달 내 입력 필드에 값을 설정
            document.getElementById('userid_modal').value = userid;
            document.getElementById('passwd_modal').value = "";
            document.getElementById('name_modal').value = name;
            document.getElementById('phone_modal').value = phone;
            document.getElementById('address_modal').value = address;
            document.getElementById('email_modal').value = email;
            document.getElementById('gender_modal').value = gender;
            document.getElementById('birthday_modal').value = birthday;
            document.getElementById('joindate_modal').value = joindate;
            document.getElementById('enabled_modal').value = enabled;
            document.getElementById('orgId_modal').value = orgid;
            document.getElementById('isInitialPassword_modal').value = isInitialPassword;
            document.getElementById('failedAttempts_modal').value = failedAttempts;
        });
    });

    /* 체크박스 유무에 따라 수정 버튼 클릭 후 비밀번호 재생성 버튼 활성화 비활성화 */
    function togglePasswordButton() {
        const checkbox = document.getElementById("passwd_btn_active");
        const button = document.getElementById("generate_passwd_btn");

        if (checkbox.checked) {
            button.disabled = false;
            button.classList.remove("disabled");
            button.classList.add("active-button");
        } else {
            button.disabled = true;
            button.classList.add("disabled");
            button.classList.remove("active-button");
        }
    }

    function submitEditForm() {
        $("#userid_modal").prop("disabled", false);
        $("#passwd_modal").prop("disabled", false);
        $("#editUserModal").submit();
    }
</script>
</body>
</html>