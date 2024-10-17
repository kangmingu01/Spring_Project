<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<main class="mt-6">
    <sec:authorize access="isAnonymous()">
        <h3><a href="<c:url value="/login"/>">로그인</a></h3>
    </sec:authorize>

    <%-- 로그인 사용자 정보(Authentication 객체의 Principal 필드값)를 Scope 속성값으로
    저장하여 사용 가능 --%>
    <sec:authentication property="principal" var="loginUser"/>

    <%-- 로그인 사용자인 경우 태그가 포함되도록 설정  --%>
    <sec:authorize access="isAuthenticated()">
        <div>
            <h3>${loginUser.name}님, 환영합니다.</h3>
            <ul>
                <li>${loginUser.name}</li>
                <li>${loginUser.passwd}</li>
                <li>${loginUser.name}</li>
                <li>${loginUser.phone}</li>
                <li>${loginUser.address}</li>
                <li>${loginUser.email}</li>
                <li>${loginUser.gender}</li>
                <li>${loginUser.birthday}</li>
                <li>${loginUser.joindate}</li>
                <li>${loginUser.enabled}</li>
                <li>
                    <c:choose>
                        <c:when test="${loginUser.enabled == null}">
                            ${loginUser.enabled}
                        </c:when>
                        <c:otherwise>
                            부서/매장이 없습니다
                        </c:otherwise>
                    </c:choose>
                </li>
                <li>${loginUser.erpAuthList}</li>
            </ul>

                <%-- 로그아웃 처리 기능을 제공하는 페이지는 반드시 form 태그를 사용해 요청 --%>
                <%-- => CSRF 토큰을 전달하기 위한 form 태그 사용 --%>
            <form action="<c:url value="/logout"/>" method="post">
                    <%-- <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> --%>
                    <%-- csrfInput 태그 : CSRF 토큰을 전달하기 위한 태그 --%>
                <sec:csrfInput/>
                <button type="submit">로그아웃</button>
            </form>
        </div>

    </sec:authorize>
</main>