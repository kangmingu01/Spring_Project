<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>비밀번호 변경</title>
</head>
<body>
<div class="container mt-5">
  <h2 class="text-center">비밀번호 변경</h2>
  <form action="/change-password" method="post" class="mt-4">
    <div class="form-group">
      <label for="currentPassword">현재 비밀번호</label>
      <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
    </div>
    <div class="form-group">
      <label for="newPassword">새 비밀번호</label>
      <input type="password" class="form-control" id="newPassword" name="newPassword" required>
    </div>
    <div class="form-group">
      <label for="confirmPassword">새 비밀번호 확인</label>
      <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
    </div>
    <button type="submit" class="btn btn-primary btn-block">비밀번호 변경</button>
  </form>
</div>
<script src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>
</body>
</html>