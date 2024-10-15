package controller;

import auth.CustomUserDetails;
import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import repository.ErpUserDAO;

import java.util.Map;

@Controller
@RequiredArgsConstructor
public class SecurityController {
    private final PasswordEncoder passwordEncoder;
    private final ErpUserDAO erpUserDAO;

    @GetMapping(value = "/change_password")
    public String changePassword(@RequestParam(value = "error", required = false) String error, Model model) {
        if (error != null) {
            model.addAttribute("error", error);
        }
        return "changePassword";
    }

    @PostMapping("/change_password")
    public String changePassword(@RequestParam Map<String, Object> map, Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        ErpUser erpUser = erpUserDAO.selectErpUserByUserid(userDetails.getUsername());

        String currentPassword = (String) map.get("currentPassword");
        String newPassword = (String) map.get("newPassword");
        String confirmPassword = (String) map.get("confirmPassword");

        if (currentPassword != null && passwordEncoder.matches(currentPassword, erpUser.getPasswd())) {
            if (currentPassword.equals(newPassword)) {
                model.addAttribute("error", "현재 비밀번호와 입력한 새 비밀번호랑 같습니다. 다시 입력해주세요");
                return "redirect:/change_password";
            }
            if (newPassword.equals(confirmPassword)) {
                erpUser.setPasswd(passwordEncoder.encode(newPassword));
                erpUser.setIsInitialPassword(0);
                erpUserDAO.updateErpUser(erpUser);

                /* 변경이 완료되면 안내 페이지로 이동(비밀번호가 수정되었습니다. 입사일에 맞춰 출근해주세요 등) */
                return "redirect:/password_changed";
            } else {
                model.addAttribute("error", "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
                return "redirect:/change_password";
            }
        } else {
            model.addAttribute("error", "현재 비밀번호가 올바르지 않습니다.");
            return "redirect:/change_password";
        }
    }

    @GetMapping(value = "/password_changed")
    public String passwordChanged(Model model) {
        model.addAttribute("info", "비밀번호가 수정되었습니다. 입사일에 맞춰 출근해주세요");
        return "passwordChanged";
    }

    @GetMapping("/access_denied")
    public String accessDenied(Model model) {
        model.addAttribute("info", "입사일 당일부터 로그인 가능합니다.");

        return "accessDenied";
    }
}
