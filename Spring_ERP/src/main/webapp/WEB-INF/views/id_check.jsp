<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>User ID Check</title>
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
        <form action="/admin/idCheck" method="post">
            <input type="text" name="userid">
            <button type="submit">확인</button>
        </form>
    </c:otherwise>
</c:choose>

<script>
    function selectId() {
        opener.userForm.userid.value = '${userid}';
        opener.userForm.idCheckResult.value = "1";
        window.close();
    }
</script>
</body>
</html>
