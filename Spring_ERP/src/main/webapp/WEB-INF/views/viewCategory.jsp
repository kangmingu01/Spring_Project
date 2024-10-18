<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>카테고리 정보</title>
</head>
<body>
    <h1>카테고리 정보</h1>
    <table>
        <tr>
            <th>브랜드</th>
            <td>${productCategory.brand}</td>
        </tr>
        <tr>
            <th>종류</th>
            <td>${productCategory.type}</td>
        </tr>
        <tr>
            <th>색상</th>
            <td>${productCategory.color}</td>
        </tr>
        <tr>
            <th>사이즈</th>
            <td>${productCategory.size}</td>
        </tr>
        <tr>
            <th>성별</th>
            <td>${productCategory.gender}</td>
        </tr>
    </table>
</body>
</html>
