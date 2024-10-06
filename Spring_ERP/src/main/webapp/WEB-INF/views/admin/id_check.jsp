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
        아이디 중복체크
    </div>
</header>
<section class="container mt-3">
    <c:choose>
        <c:when test="${check == 0}">
            <p>입력된 [${userid}]는 사용 가능한 아이디입니다.</p>
            <button type="button" onclick="selectId()">아이디 사용</button>
        </c:when>
        <c:otherwise>
            <p>입력하신 아이디 [${userid}] 는 이미 사용 중입니다.</p>
            <p>새로운 아이디를 입력한 후 [확인] 버튼을 눌러 주세요.</p>

            <form action="<c:url value='/admin/idCheck'/>" method="post" id="id_check_form">
                <div class="input-group mb-3">
                    <!-- 아이디 입력 필드 -->
                    <div class="form-floating flex-grow-1">
                        <input type="text" class="form-control" name="userid" id="userid" placeholder="아이디를 입력하세요"autocomplete="off">
                        <label for="userid">아이디 입력</label>
                    </div>
                    <!-- 확인 버튼 -->
                    <button type="submit" class="btn btn-primary ms-2">확인</button>
                </div>

                <!-- 오류 메시지 -->
                <div class="mt-2">
                    <div id="idMsg" class="text-danger" style="display: none;">아이디를 입력해주세요</div>
                    <div id="idRegMsg" class="text-danger" style="display: none;">
                        아이디는 영문자로 시작되는 영문자, 숫자의 범위 6~15 범위의 문자로만 작성 가능합니다
                    </div>
                </div>

                <sec:csrfInput/>
            </form>
        </c:otherwise>
    </c:choose>
</section>
<script src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>
<script>
    function selectId() {
        opener.userForm.userid.value = '${userid}';
        opener.userForm.idCheckResult.value = "1";
        window.close();
    }

    var idReg = /^[a-zA-Z]\w{5,19}$/;
    $("#id_check_form").submit(function () {
        var submitResult = true;

        $(".error").css("display", "none").css("visibility", "hidden").removeClass("is-invalid");
        if ($("#userid").val() == "") {
            $("#idMsg").css("display", "block").css("visibility", "visible");
            $("#userid").addClass("is-invalid");
            submitResult = false;
        } else if (!idReg.test($("#userid").val())) {
            $("#idRegMsg").css("display", "block").css("visibility", "visible");
            $("#userid").addClass("is-invalid");
            submitResult = false;
        }
        return submitResult;
    })
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
