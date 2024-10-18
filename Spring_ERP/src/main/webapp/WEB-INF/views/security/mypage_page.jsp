<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>마이페이지</title>
    <style>
        /* 읽기 전용 필드 스타일 설정 */
        .readonly-field {
            background-color: #f8f9fa; /* 연한 회색 배경색 */
            border: 1px solid #e0e0e0; /* 연한 테두리 색상 */
            cursor: not-allowed; /* 마우스 커서 변경 */
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
<body>
<sec:authentication property="principal" var="loginUser"/>
<div class="container mt-5">
    <h2 class="text-center mb-4">My Page</h2>
    <c:if test="${not empty success}">
        <div class="alert alert-success text-center" role="alert">
                ${success}
        </div>
    </c:if>
    <form action="<c:url value="/updateUserInfo"/>" method="post">
        <!-- 사용자 기본 정보 섹션 -->
        <div class="card mb-4">
            <div class="card-header">
                <h5>기본 정보</h5>
            </div>
            <div class="card-body">
                <div class="mb-3">
                    <label for="userid" class="form-label">사용자 ID <span class="badge bg-secondary">조회 전용</span></label>
                    <input type="text" class="form-control readonly-field" id="userid" name="userid"
                           value="${loginUser.userid}" readonly>
                </div>
                <div class="mb-3">
                    <label for="name" class="form-label">이름 <span class="badge bg-secondary">조회 전용</span></label>
                    <input type="text" class="form-control readonly-field" id="name" name="name"
                           value="${loginUser.name}" readonly>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">이메일 <span class="badge bg-info">수정 가능</span></label>
                    <input type="email" class="form-control" id="email" name="email" value="${loginUser.email}">
                    <div id="emailError" class="error-message"></div>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">전화번호 <span class="badge bg-info">수정 가능</span></label>
                    <input type="text" class="form-control" id="phone" name="phone" value="${loginUser.phone}">
                    <div id="phoneError" class="error-message"></div>
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">주소 <span class="badge bg-info">수정 가능</span></label>
                    <input type="text" class="form-control" id="address" name="address" value="${loginUser.address}">
                </div>
            </div>
        </div>

        <!-- 조직 정보 및 권한 섹션 -->
        <div class="card mb-4">
            <div class="card-header">
                <h5>조직 정보 및 권한</h5>
            </div>
            <div class="card-body">
                <div class="mb-3">
                    <label for="orgId" class="form-label">조직 ID <span class="badge bg-secondary">조회 전용</span></label>
                    <input type="text" class="form-control readonly-field" id="orgId" name="orgId" value="${orgName}"
                           readonly>
                </div>
                <div class="mb-3">
                    <label for="roles" class="form-label">권한 <span class="badge bg-secondary">조회 전용</span></label>
                    <input type="text" class="form-control readonly-field" id="roles" name="roles"
                           value="${loginUser.erpAuthList}" readonly>
                </div>
            </div>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center" role="alert">
                    ${error}
            </div>
        </c:if>
        <div class="card mb-4" id="passwordChangeSection" style="display: none;">
            <div class="card-header">
                <h5>비밀번호 변경</h5>
            </div>
            <div class="card-body">
                <div class="mb-3">
                    <label for="currentPassword" class="form-label">현재 비밀번호 <span
                            class="badge bg-info">필수 입력</span></label>
                    <input type="password" class="form-control" id="currentPassword" name="currentPassword"
                           autocomplete="off">
                    <div id="currentPasswordTempArea" class="error-message"></div>
                </div>
                <div class="mb-3">
                    <label for="newPassword" class="form-label">새 비밀번호 <span class="badge bg-info">필수 입력</span></label>
                    <input type="password" class="form-control" id="newPassword" name="newPassword">
                    <div id="passwordStrengthError" class="error-message"></div>
                </div>
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">새 비밀번호 확인 <span
                            class="badge bg-info">필수 입력</span></label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                    <div id="passwordMatchError" class="error-message"></div>
                </div>
            </div>
        </div>

        <!-- 제출 버튼 -->
        <div class="text-center mb-3">
            <button type="button" class="btn btn-outline-secondary" id="togglePasswordChange">비밀번호 변경</button>
            <button type="submit" class="btn btn-primary" id="updateButton">정보 수정</button>
        </div>
        <sec:csrfInput/>
    </form>
</div>

<script>
    $(document).ready(function () {
        var passwdReg = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/;
        var emailReg = /^([a-zA-Z0-9._]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/;
        var phoneReg = /^010\d{8}$/;

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
                $('#updateButton').prop('disabled', true);
            } else if (newPassword !== confirmPassword) {
                $('#passwordMatchError').text('새 비밀번호와 확인 비밀번호가 일치하지 않습니다.').css('color', 'red');
                $('#updateButton').prop('disabled', true);
            } else {
                $('#passwordMatchError').text('새 비밀번호와 일치합니다.').css('color', 'green');
                checkAllFieldsFilled();
            }
        }

        function validateEmail() {
            var email = $('#email').val();
            if (email !== "${loginUser.email}" && !emailReg.test(email)) {
                $('#emailError').text('유효한 이메일 주소를 입력해주세요.').css('color', 'red');
                $('#updateButton').prop('disabled', true);
            } else {
                $('#emailError').text('');
                checkAllFieldsFilled();
            }
        }

        function validatePhone() {
            var phone = $('#phone').val();
            if (phone !== "${loginUser.phone}" && !phoneReg.test(phone)) {
                $('#phoneError').text('유효한 전화번호를 입력해주세요. 형식: 010XXXXXXXX').css('color', 'red');
                $('#updateButton').prop('disabled', true);
            } else {
                $('#phoneError').text('');
                checkAllFieldsFilled();
            }
        }

        function checkAllFieldsFilled() {
            var currentPassword = $('#currentPassword').val();
            var newPassword = $('#newPassword').val();
            var confirmPassword = $('#confirmPassword').val();
            var emailError = $('#emailError').text();
            var phoneError = $('#phoneError').text();

            // 모든 필드에 값이 올바르게 입력되었을 경우에만 버튼 활성화
            if ((newPassword !== "" && confirmPassword !== "" && newPassword === confirmPassword && emailError === "" && phoneError === "") || (currentPassword === "" && newPassword === "" && confirmPassword === "" && emailError === "" && phoneError === "")) {
                $('#updateButton').prop('disabled', false);
            } else {
                $('#updateButton').prop('disabled', true);
            }
        }

        $('#newPassword, #confirmPassword, #currentPassword').on('keyup', function () {
            validatePasswordStrength();
            validatePasswordMatch();
            checkAllFieldsFilled();
        });

        $('#email').on('keyup', function () {
            validateEmail();
        });

        $('#phone').on('keyup', function () {
            validatePhone();
        });

        // 슬라이드 토글 효과를 사용하여 비밀번호 변경 섹션을 열고 닫기
        $("#togglePasswordChange").on("click", function () {
            $("#passwordChangeSection").slideToggle("slow", function() {
                if ($("#passwordChangeSection").is(":visible")) {
                    // 비밀번호 변경 섹션이 열리면 정보 수정 버튼 비활성화
                    $('#updateButton').prop('disabled', true);
                } else {
                    // 비밀번호 변경 섹션이 닫히면 정보 수정 버튼 활성화
                    $('#updateButton').prop('disabled', false);
                }
            });
        });

        // 페이지가 로드될 때 기본적으로 버튼 비활성화
        $('#updateButton').prop('disabled', true);
    });

</script>
</body>
</html>