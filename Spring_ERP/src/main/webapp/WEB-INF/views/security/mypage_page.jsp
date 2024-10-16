<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>마이페이지</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <style>
    /* 읽기 전용 필드 스타일 설정 */
    .readonly-field {
      background-color: #f8f9fa; /* 연한 회색 배경색 */
      border: 1px solid #e0e0e0; /* 연한 테두리 색상 */
      cursor: not-allowed; /* 마우스 커서 변경 */
    }
  </style>
</head>
<body>
${userDetails}
${erpUser}
<div class="container mt-5">
  <h2 class="text-center mb-4">My Page</h2>
  <form action="/updateUserInfo" method="post">
    <!-- 사용자 기본 정보 섹션 -->
    <div class="card mb-4">
      <div class="card-header">
        <h5>기본 정보</h5>
      </div>
      <div class="card-body">
        <div class="mb-3">
          <label for="userid" class="form-label">사용자 ID <span class="badge bg-secondary">조회 전용</span></label>
          <input type="text" class="form-control readonly-field" id="userid" name="userid" value="${loginUser.userid}" readonly>
        </div>
        <div class="mb-3">
          <label for="name" class="form-label">이름 <span class="badge bg-secondary">조회 전용</span></label>
          <input type="text" class="form-control readonly-field" id="name" name="name" value="${loginUser.name}" readonly>
        </div>
        <div class="mb-3">
          <label for="email" class="form-label">이메일 <span class="badge bg-info">수정 가능</span></label>
          <input type="email" class="form-control" id="email" name="email" value="${loginUser.email}">
        </div>
        <div class="mb-3">
          <label for="phone" class="form-label">전화번호 <span class="badge bg-info">수정 가능</span></label>
          <input type="text" class="form-control" id="phone" name="phone" value="${loginUser.phone}">
        </div>
        <div class="mb-3">
          <label for="address" class="form-label">주소 <span class="badge bg-info">수정 가능</span></label>
          <input type="text" class="form-control" id="address" name="address" value="${loginUser.address}">
        </div>
      </div>
    </div>

    <!-- 개인 정보 섹션 -->
    <div class="card mb-4">
      <div class="card-header">
        <h5>개인 정보</h5>
      </div>
      <div class="card-body">
        <div class="mb-3">
          <label for="gender" class="form-label">성별 <span class="badge bg-secondary">조회 전용</span></label>
          <input type="text" class="form-control readonly-field" id="gender" name="gender" value="<c:if test="${erpUser.birthday} == 1">
            남자
          </c:if>
          <c:if test="${erpUser.birthday} == 2">
            여자
          </c:if>" readonly>
        </div>
        <div class="mb-3">
          <label for="birthday" class="form-label">생년월일 <span class="badge bg-secondary">조회 전용</span></label>
          <input type="date" class="form-control readonly-field" id="birthday" name="birthday" value="" readonly>
        </div>
        <div class="mb-3">
          <label for="joindate" class="form-label">입사일 <span class="badge bg-secondary">조회 전용</span></label>
          <input type="date" class="form-control readonly-field" id="joindate" name="joindate" value="${erpUser.joindate}" readonly>
        </div>
      </div>
    </div>

    <!-- 비밀번호 변경 섹션 -->
    <div class="card mb-4">
      <div class="card-header">
        <h5>비밀번호 변경</h5>
      </div>
      <div class="card-body">
        <div class="mb-3">
          <label for="currentPassword" class="form-label">현재 비밀번호 <span class="badge bg-info">필수 입력</span></label>
          <input type="password" class="form-control" id="currentPassword" name="currentPassword" autocomplete="off">
        </div>
        <div class="mb-3">
          <label for="newPassword" class="form-label">새 비밀번호 <span class="badge bg-info">필수 입력</span></label>
          <input type="password" class="form-control" id="newPassword" name="newPassword">
        </div>
        <div class="mb-3">
          <label for="confirmPassword" class="form-label">새 비밀번호 확인 <span class="badge bg-info">필수 입력</span></label>
          <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
        </div>
      </div>
    </div>
<c:out value="${erpUser}"/>
    <!-- 조직 정보 및 권한 섹션 -->
    <div class="card mb-4">
      <div class="card-header">
        <h5>조직 정보 및 권한</h5>
      </div>
      <div class="card-body">
        <div class="mb-3">
          <label for="orgId" class="form-label">조직 ID <span class="badge bg-secondary">조회 전용</span></label>
          <input type="text" class="form-control readonly-field" id="orgId" name="orgId" value="${orgName}" readonly>
        </div>
        <div class="mb-3">
          <label for="roles" class="form-label">권한 <span class="badge bg-secondary">조회 전용</span></label>
          <input type="text" class="form-control readonly-field" id="roles" name="roles" value="${erpUser.erpAuthList}" readonly>
        </div>
      </div>
    </div>

    <!-- 제출 버튼 -->
    <div class="text-center">
      <button type="submit" class="btn btn-primary">정보 수정</button>
    </div>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
