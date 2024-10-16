<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ERP 로그인 페이지</title>

    <!-- FontAwesome 및 Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600&display=swap');

        * {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f5f7fa;
        }

        .login-container {
            display: flex;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 900px;
            max-width: 100%;
        }

        .left {
            position: relative;
            width: 50%;
            overflow: hidden;
        }

        .left img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .right {
            width: 50%;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .content-wrapper {
            width: 100%;
            max-width: 400px;
        }

        .form-floating {
            margin-bottom: 20px;
            width: 100%;
        }

        .logo {
            margin-bottom: 8px; /* 데스크톱일 때 하단 여백 */
        }

        .logo img {
            width: 120px; /* 로고 사이즈 키움 */
        }

        button {
            width: 100%;
            padding: 15px;
            background-color: #4a90e2;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            cursor: pointer;
        }

        button:hover {
            background-color: #357ab8;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 0.8rem;
            color: #999;
        }

        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
                width: 100%;
                max-width: 400px;
                padding: 20px;
            }

            .left {
                display: none;
            }

            .right {
                width: 100%;
                align-items: center; /* 중앙 정렬 */
            }

            .logo {
                margin-bottom: 20px; /* 모바일일 때 하단 여백 */
            }

            .logo-mobile {
                display: block; /* 모바일에서 로고 보이기 */
            }
        }
    </style>
</head>
<body>

<!-- 데스크톱 로고 -->
<div class="logo d-none d-md-block">
    <img src="https://static.wanted.co.kr/community/2022/9/4cac9ce596e8f115290aa44f53f7264ad9a0060ca819fa0868add6bf64380789_resized" alt="logo">
</div>



<!-- 로그인 컨테이너 -->
<div class="login-container">
    <div class="left">
        <img src="<c:url value='/images/animation.gif'/>" alt="Animated Background">
    </div>

    <div class="right">
        <!-- 모바일 로고 -->
        <div class="logo logo-mobile d-block d-md-none">
            <img src="https://static.wanted.co.kr/community/2022/9/4cac9ce596e8f115290aa44f53f7264ad9a0060ca819fa0868add6bf64380789_resized" alt="logo">
        </div>

        <!-- 공통 부모 컨테이너 -->
        <div class="content-wrapper">
            <div class="welcome-text mb-3 text-center">
                <h4>환영합니다!</h4>
                <p>아이디와 비밀번호를 입력해 로그인하세요.</p>
            </div>

            <form method="POST" action="<c:url value='/login'/>" id="loginform">
                <div class="form-floating">
                    <input type="text" class="form-control" id="userid" name="userid" placeholder="아이디" value="${userid}" autocomplete="off">
                    <label for="userid"><i class="fas fa-user"></i> 아이디</label>
                </div>

                <div class="form-floating">
                    <input type="password" class="form-control" id="passwd" name="passwd" placeholder="비밀번호">
                    <label for="passwd"><i class="fas fa-lock"></i> 비밀번호</label>
                </div>

                <button type="submit" class="btn btn-primary">로그인</button>
                <sec:csrfInput/>
            </form>
        </div>
        <!-- 경고 메시지 섹션 -->
        <section class="w-100 mt-3">
            <c:choose>
                <c:when test="${error == 'locked'}">
                    <div class="alert alert-danger text-center">
                        계정이 잠겨 있습니다.<br> 관리자에게 문의하세요.
                    </div>
                </c:when>
                <c:when test="${error == 'notfound'}">
                    <div class="alert alert-danger text-center">
                        입력하신 아이디가 존재하지 않습니다.<br> 다시 확인해 주세요.
                    </div>
                </c:when>
                <c:when test="${error == 'disabled'}">
                    <div class="alert alert-danger text-center">
                        계정이 비활성화되었습니다.<br> 관리자에게 문의하세요.
                    </div>
                </c:when>
                <c:when test="${error == 'failed'}">
                    <div class="alert alert-danger text-center">
                        로그인에 실패했습니다.<br> 아이디와 비밀번호를 확인해 주세요.
                    </div>
                </c:when>
            </c:choose>
        </section>
    </div>
</div>

<div class="footer">
    솔루션 문의는 전문가 컨설턴트가 도와드립니다.<br>
    jkang4531@korea.kr / Tel: 02-501-5858
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
