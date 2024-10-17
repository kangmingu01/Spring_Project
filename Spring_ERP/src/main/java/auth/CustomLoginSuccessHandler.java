package auth;

import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import repository.ErpUserDAO;
import service.ErpUserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@Component
@RequiredArgsConstructor
public class CustomLoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
    private final ErpUserDAO erpUserDAO;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();

        ErpUser erpUser = erpUserDAO.selectErpUserByUserid(userDetails.getUserid());
        erpUser.setFailedAttempts(0);
        userDetails.setFailedAttempts(0);
        erpUserDAO.updateErpUser(erpUser);

        if (userDetails.getIsInitialPassword() == 1) {
            getRedirectStrategy().sendRedirect(request, response, "/change_password");
        } else if(userDetails.getJoindate().isAfter(LocalDate.now())){
            getRedirectStrategy().sendRedirect(request, response, "/access_denied");
        } else {
            getRedirectStrategy().sendRedirect(request, response, "/main");
        }
    }
}
