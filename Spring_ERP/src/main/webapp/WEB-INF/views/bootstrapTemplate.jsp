<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bootstrap</title>
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

    </style>
</head>
<body>
<main class="bg-light">
    <div class="content d-flex justify-content-between pt-2 pb-2 ps-4 pe-4 align-items-center">
        <div class="title fw-bold">
            유저 관리
        </div>
        <div class="d-flex">
            <button class="btn me-2 text-white">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor"
                     class="bi bi-search " viewBox="0 0 16 16">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                </svg>
                <span>조회</span>
            </button>
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
            <form action="/addUser" id="userForm" method="post">
                <%-- 아이디 중복 체크 --%>
                <input type="hidden" id="idCheckResult" value="0">

                <div class="row mb-3">
                    <!-- 사용자 ID -->
                    <div class="col-md-4">
                        <label for="userid" class="form-label">사용자 ID</label>
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
                        <div class="d-flex form-control-position">
                            <input type="password" class="form-control" id="passwd" name="passwd" disabled
                                   readonly>
                            <span class="toggle-password" onclick="togglePassword()">
                            <i class="fa fa-eye-slash" id="toggleIcon"></i>
                            </span>
                            <button type="button" class="btn btn-secondary btn-sm text-nowrap"
                                    onclick="generateRandomPassword()">랜덤생성
                            </button>
                        </div>
                        <div id="passwdMsg" class="error">랜덤생성 버튼을 눌러주세요</div>


                    </div>
                    <!-- 이름 -->
                    <div class="col-md-4">
                        <label for="name" class="form-label">이름</label>
                        <input type="text" class="form-control" id="name" name="name">
                        <div id="nameMsg" class="error">이름을 입력해 주세요.</div>
                        <%-- 이름 입력 오류 메시지 --%>
                    </div>
                </div>

                <div class="row mb-3">
                    <!-- 주소 -->
                    <!-- 전화번호 -->
                    <div class="col-md-4">
                        <label for="phone" class="form-label">전화번호</label>
                        <input type="text" class="form-control" id="phone" name="phone">
                        <div id="mobileMsg" class="error">전화번호를 입력해 주세요.</div>
                        <%-- 전화번호 입력 오류 메시지 --%>
                        <div id="mobileRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해 주세요.</div>
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
                    <!-- 부서 ID -->
                    <div class="col-md-4">
                        <label for="orgId" class="form-label">부서 ID</label>
                        <input type="text" class="form-control" id="orgId" name="orgId">
                        <%-- 여기가 문제임 부서명을 검색해서 나오면 그 값으로 사용할 수 있게 하기 --%>
                        <div id="orgIdMsg" class="error">부서 ID를 입력해주세요. 입력값이 없다면 null로 입력해주세요</div>
                    </div>
                </div>

                <div class="text-end">
                    <button type="submit" class="btn btn-primary">사용자 추가</button>
                </div>
            </form>
        </div>
    </div>

    <div>
        <%-- 값 넘어오는지 테스트 --%>
        <%--<c:out value="${resultMap.erpUserList}"/>--%>
        <%-- 유저 정보를 볼 수 있는 테이블 --%>
        <h2>테이블</h2>
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th scope="col">유저 ID</th>
                <th scope="col">비밀번호</th>
                <th scope="col">이름</th>
                <th scope="col">전화번호</th>
                <th scope="col">주소</th>
                <th scope="col">이메일</th>
                <th scope="col">성별</th>
                <th scope="col">생일</th>
                <th scope="col">가입일</th>
                <th scope="col">유저상태</th>
                <th scope="col">부서 ID</th>
            </tr>
            </thead>
            <c:choose>
                <c:when test="${empty resultMap.erpUserList}">
                    <tr>
                        <td colspan="11" class="text-center">검색된 게시글이 없습니다</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="erpUser" items="${resultMap.erpUserList}">
                        <tr>
                            <td>${erpUser.userid}</td>
                            <td>${erpUser.passwd}</td>
                            <td>${erpUser.name}</td>
                            <td>${erpUser.phone}</td>
                            <td>${erpUser.address}</td>
                            <td>${erpUser.email}</td>
                            <td>${erpUser.gender}</td>
                            <td>${erpUser.birthday}</td>
                            <td>${erpUser.joindate}</td>
                            <td>${erpUser.enabled}</td>
                            <td>${erpUser.orgId}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </table>
    </div>
</main>

<script src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>

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
        document.getElementById("passwd").value = password;
        $("#passwd").removeClass("is-invalid");
        $("#passwdMsg").css("display", "none").css("visibility", "hidden");
    }

    // 페이지 첫 로드시 입력 포커스 잡히게
    $("#userid").focus();

    /* 검증 정규표현식 */
    var idReg = /^[a-zA-Z]\w{5,19}$/;
    var passwdReg = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
    var emailReg = /^([a-zA-Z0-9._]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;

    // 사용자 추가 버튼 누르면 검증
    // => 입력 필드에 있는 값 다 검증하고 문제 있으면 다 잡아다가 에러메세지 띄워줘야됨
    $("#userForm").submit(function () {
        /* 제출 여부 확인 */
        var submitResult = true;

        /* 모든 에러 메세지 숨김 */
        $(".error").css("display", "none").css("visibility", "hidden").removeClass("is-invalid");


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
        }/* else if (!passwdReg.test($("passwd").val())) {
            $("#passwdMsg").css("display", "block").css("visibility", "visible");
            $("#passwd").addClass("is-invalid");
            submitResult = false;
        }*/

        if ($("#name").val() == "") {
            $("#nameMsg").css("display", "block").css("visibility", "visible");
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
    })

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

    // 부서 ID 입력 시 is-invalid 클래스 제거
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

        // 중복 검사할 수 있는 창을 띄움
        window.open('/admin/idCheck?userid=' + $("#userid").val(), 'idCheck', 'width=600,height=400,left=700,top=400');
    });

    /* 아이디 바꾸면 다시 중복검사할 수 있게 */
    $("#userid").change(function () {
        $("#idCheckResult").val("0");
        $("#userid").removeClass("is-invalid");
    })
</script>
</body>
</html>
