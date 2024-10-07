<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>User ID Check</title>

    <style>
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

<c:choose>
<c:when test="${check == 0}">
<p>입력된 [${userid}]는 사용 가능한 아이디입니다.</p>
<button type="button" onclick="selectId()">아이디 사용</button>
</c:when>
<c:otherwise>
<p>입력된 [${userid}]는 사용중인 아이디입니다.</p>
<p>새로운 아이디를 입력하고 [확인] 버튼을 눌러주세요.</p>
    <%-- /idCheck를 다시 요청해서 같은 값이 있으면 다시 검증할 수 있게 해줘야하고, 같은 값이 없으면 사용자 ID 입력 필드에 입력한 값이 들어갈 수 있게--%>
<form action="<c:url value="/admin/idCheck"/>" method="post" id="id_check_form">
    <input type="text" name="userid" id="userid">
    <div id="idMsg" class="error">아이디를 입력해주세요</div>
    <div id="idRegMsg" class="error">아이디는 영문자로 시작되는 영문자, 숫자의 범위 6~15범위의 문자로만 작성 가능합니다</div>
    <button type="submit">확인</button>
    <sec:csrfInput/>
</form>
</c:otherwise>
</c:choose>
<script src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>
<script>
    function selectId() {
        opener.userForm.userid.value = '${userid}';
        opener.userForm.idCheckResult.value = "1";
        window.close();
    }

    var idReg = /^[a-zA-Z]\w{5,19}$/;
    $("id_check_form").submit(function () {
        e.preventDefault();
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
    </body>
    </html>
