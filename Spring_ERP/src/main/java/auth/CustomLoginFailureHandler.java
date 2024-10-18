package auth;

// 인증 실패 후 실행될 기능을 제공하기 위한 클래스
// => 로그인 실패 횟수 누적, 계정 비활성화 처리 등의 기능 구현
// => AuthenticationFailureHandler 인터페이스를 상속받아 작성하거나 AuthenticationFailureHandler
// 인터페이스를 상속받은 자식클래스를 상속받아 작성

import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;
import repository.ErpUserDAO;
import service.ErpUserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// 인증 실패시 Session Scope 속성값으로 아이디를 저장하고 로그인 페이지로 이동하는 기능을 제공
// => SimpleUrlAuthenticationFailureHandler 클래스를 상속받아 작성
@Component
@RequiredArgsConstructor
public class CustomLoginFailureHandler extends SimpleUrlAuthenticationFailureHandler {
    private final ErpUserDAO erpUserDAO;

    // 인증 실패시 자동 호출되는 메소드
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        String userid = request.getParameter("userid");
        String failureUrl = "/login?error=notfound";

        if (userid != null) {
            ErpUser user = erpUserDAO.selectErpUserByUserid(userid);

            if (user != null) {
                int newFailedAttempts = user.getFailedAttempts() + 1;
                user.setFailedAttempts(newFailedAttempts);

                if (newFailedAttempts >= 5) {
                    user.setEnabled(0);
                    failureUrl = "/login?error=disabled";
                } else {
                    failureUrl = "/login?error=failed";
                }
                erpUserDAO.updateErpUser(user);
            }
        }

        // 실패한 아이디 세션에 저장
        request.getSession().setAttribute("userid", userid);
        // 실패 URL 설정
        setDefaultFailureUrl(failureUrl);

        super.onAuthenticationFailure(request, response, exception);
    }
}