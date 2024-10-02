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
            right: 85px;
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
                            <input type="text" class="form-control" id="userid" name="userid" required>
                            <button type="button" class="btn btn-secondary btn-sm text-nowrap">중복검사</button>
                        </div>

                        <div id="idMsg" class="error">아이디를 입력해주세요</div>
                        <div id="idReg" class="error">아이디는 영문자로 시작되는 영문자, 숫자의 범위 6~15범위의 문자로만 작성 가능합니다</div>
                        <div id="idCheckMsg" class="error">아이디 중복 검사를 반드시 실행해주세요</div>

                    </div>

                    <!-- 비밀번호 -->
                    <div class="col-md-4">
                        <label for="passwd" class="form-label">비밀번호</label>
                        <div class="d-flex form-control-position">
                            <input type="password"  class="form-control" id="passwd" name="passwd" required disabled readonly>
                            <span class="toggle-password" onclick="togglePassword()">
                            <i class="fa fa-eye-slash" id="toggleIcon"></i>
                            </span>
                            <button type="button" class="btn btn-secondary btn-sm text-nowrap"
                                    onclick="generateRandomPassword()">랜덤생성
                            </button>
                        </div>
                        <div id="passwdMsg" class="error">비밀번호를 입력해 주세요.</div> <%-- 비밀번호 입력 오류 메시지 --%>
                        <div id="passwdRegMsg" class="error">비밀번호는 영문자,숫자,특수문자가 반드시 하나이상 포함된 6~20 범위의 문자로만 작성 가능합니다.</div> <%-- 비밀번호 형식 오류 메시지 --%>
                    </div>
                    <%--                    <!-- Random Password Button -->
                                        <div class="col-md-3 d-flex align-items-end">
                                            <button type="button" class="btn btn-secondary" onclick="generateRandomPassword()">랜덤</button>
                                        </div>--%>
                    <!-- 이름 -->
                    <div class="col-md-4">
                        <label for="name" class="form-label">이름</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                        <div id="nameMsg" class="error">이름을 입력해 주세요.</div> <%-- 이름 입력 오류 메시지 --%>
                    </div>
                </div>

                <div class="row mb-3">
                    <!-- 주소 -->
                    <!-- 전화번호 -->
                    <div class="col-md-4">
                        <label for="phone" class="form-label">전화번호</label>
                        <input type="text" class="form-control" id="phone" name="phone" required>
                        <div id="mobileMsg" class="error">전화번호를 입력해 주세요.</div> <%-- 전화번호 입력 오류 메시지 --%>
                        <div id="mobileRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해 주세요.</div> <%-- 전화번호 형식 오류 메시지 --%>
                    </div>
                    <div class="col-md-4">
                        <label for="address" class="form-label">주소</label>
                        <input type="text" class="form-control" id="address" name="address" required>
                        <div id="addressMsg" class="error">주소를 입력해 주세요.</div> <%-- 주소 입력 오류 메시지 --%>
                    </div>
                    <!-- 이메일 -->
                    <div class="col-md-4">
                        <label for="email" class="form-label">이메일</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                        <div id="emailMsg" class="error">이메일을 입력해 주세요.</div> <%-- 이메일 입력 오류 메시지 --%>
                        <div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div> <%-- 이메일 형식 오류 메시지 --%>
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
                        <input type="date" class="form-control" id="birthday" name="birthday" required>
                        <div id="birthdayMsg" class="error">생년월일을 선택해주세요</div>
                    </div>
                    <!-- 입사일 -->
                    <div class="col-md-4">
                        <label for="joindate" class="form-label">입사일</label>
                        <input type="date" class="form-control" id="joindate" name="joindate" required>
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
                    </div>
                </div>

                <div class="text-end">
                    <button type="submit" class="btn btn-primary">사용자 추가</button>
                </div>
            </form>
        </div>
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
    }

    // 페이지 첫 로드시 입력 포커스 잡히게
    $("#userid").focus();

    // 사용자 추가 버튼 누르면 검증
    // => 입력 필드에 있는 값 다 검증하고 문제 있으면 다 잡아다가 에러메세지 띄워줘야됨
</script>
</body>
</html>
