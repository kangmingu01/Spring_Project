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
            margin-bottom: 8px;
        }

        .logo img {
            width: 120px;
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
                align-items: center;
            }

            .logo {
                margin-bottom: 20px;
            }

            .logo-mobile {
                display: block;
            }
        }

        .fade-out {
            opacity: 1;
            transition: opacity 1s ease-out;
        }
        .fade-out {
            opacity: 0;
        }
        .fade-in {
            opacity: 0;
            transition: opacity 1s ease-in;
        }
        .fade-in {
            opacity: 1;
        }
    </style>
</head>

<body>
<!-- 데스크톱 로고 -->
<div class="logo d-none d-md-block mt-5">
    <img src="<c:url value="/images/logo_icon.png"/>"
         alt="logo">
</div>

<!-- 로그인 컨테이너 -->
<div class="login-container">
    <div class="left">
        <img id="animatedGif" src="<c:url value='/images/animation.gif'/>" alt="Animated Background">
    </div>

    <div class="right">
        <!-- 모바일 로고 -->
        <div class="logo logo-mobile d-block d-md-none">
            <img src="<c:url value="/images/logo_icon.png"/>"
                 alt="logo">
        </div>

        <!-- 공통 부모 컨테이너 -->
        <div class="content-wrapper">
            <div class="welcome-text mb-3 text-center">
                <h4>환영합니다!</h4>
                <p>아이디와 비밀번호를 입력해 로그인하세요.</p>
            </div>

            <form method="POST" action="<c:url value='/login'/>" id="loginform">
                <div class="form-floating">
                    <input type="text" class="form-control" id="userid" name="userid" placeholder="아이디"
                           value="${userid}" autocomplete="off">
                    <label for="userid"><i class="fas fa-user"></i> 아이디</label>
                </div>

                <div class="form-floating">
                    <input type="password" class="form-control" id="passwd" name="passwd" placeholder="비밀번호">
                    <label for="passwd"><i class="fas fa-lock"></i> 비밀번호</label>
                </div>

                <button type="submit" class="btn btn-primary">로그인</button>
                <sec:csrfInput />
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
<script>
    // GIF가 끝나면 이미지로 대체하기 위한 스크립트
    document.addEventListener('DOMContentLoaded', function () {
        var gifElement = document.getElementById('animatedGif');
        var gifDuration = 11000; // 애니메이션 GIF 지속 시간 (밀리초)

        setTimeout(function () {
            // 페이드 아웃을 위한 클래스 추가
            gifElement.classList.add('fade-out');

            // 페이드 아웃이 끝난 후 이미지로 교체
            setTimeout(function () {
                gifElement.src = '<c:url value="/images/animation_end.png"/>';
                gifElement.classList.remove('fade-out');
                gifElement.classList.add('fade-in');
            }, 500); // 페이드 아웃 시간 (1초) 후 이미지 교체
        }, gifDuration);
    });
</script>
</body>

</html>