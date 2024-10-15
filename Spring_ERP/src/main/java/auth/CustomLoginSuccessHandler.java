package auth;

import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import service.ErpUserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
@RequiredArgsConstructor
public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        ErpUser user = (ErpUser) authentication.getPrincipal();

        if (user.getIsInitialPassword() == 1) {
            // 초기 비밀번호인 경우 비밀번호 변경 페이지로 이동
            getRedirectStrategy().sendRedirect(request, response, "/change-password");
        } else {
            // 일반 사용자는 메인 페이지로 이동
            getRedirectStrategy().sendRedirect(request, response, "/main");
        }
    }
}
