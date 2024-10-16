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

        .error-message {
            color: red;
            font-size: 0.9em;
            min-height: 20px;  /* 고정된 높이 설정 */
        }

        .success-message {
            color: green;
            font-size: 0.9em;
            min-height: 20px;  /* 고정된 높이 설정 */
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

<main class="d-flex justify-content-center align-items-center" style="height: calc(100vh - 140px);">
    <div class="card p-5 shadow-lg" style="max-width: 500px; width: 100%;">
        <h3 class="text-center mb-4">비밀번호 변경</h3>
        <form action="<c:url value='/change_password'/>" method="post" id="changePasswordForm">
            <div class="form-group mb-3">
                <label for="currentPassword" class="form-label">현재 비밀번호</label>
                <input type="password" class="form-control" id="currentPassword"
                       name="currentPassword" placeholder="현재 비밀번호를 입력하세요" required>
                <div id="currentPasswordTempArea" class="error-message"></div> <!-- 고정된 높이의 임시 영역 -->
            </div>
            <div class="form-group mb-3">
                <label for="newPassword" class="form-label">새 비밀번호</label>
                <input type="password" class="form-control" id="newPassword"
                       name="newPassword" placeholder="새 비밀번호를 입력하세요" required>
                <div id="passwordStrengthError" class="error-message"></div>
            </div>
            <div class="form-group mb-4">
                <label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
                <input type="password" class="form-control" id="confirmPassword"
                       name="confirmPassword" placeholder="비밀번호를 다시 입력하세요" required>
                <div id="passwordMatchError" class="error-message"></div>
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

<script src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>
<script>
    $(document).ready(function () {
        var passwdReg = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/;

        function validatePasswordStrength() {
            var newPassword = $('#newPassword').val();
            if (newPassword === "") {
                $('#passwordStrengthError').text('');
            } else if (!passwdReg.test(newPassword)) {
                $('#passwordStrengthError').text('비밀번호는 6-20자의 문자, 숫자, 특수문자를 포함해야 합니다.');
            } else {
                $('#passwordStrengthError').text('');
            }
        }

        function validatePasswordMatch() {
            var newPassword = $('#newPassword').val();
            var confirmPassword = $('#confirmPassword').val();
            if (newPassword === "" || confirmPassword === "") {
                $('#passwordMatchError').text('');
            } else if (newPassword !== confirmPassword) {
                $('#passwordMatchError').text('새 비밀번호와 확인 비밀번호가 일치하지 않습니다.');
            } else {
                $('#passwordMatchError').text('');
            }
        }

        $('#newPassword').on('keyup', function () {
            validatePasswordStrength();
            validatePasswordMatch();
        });

        $('#confirmPassword').on('keyup', function () {
            validatePasswordMatch();
        });
    });
</script>

</body>
</html>
