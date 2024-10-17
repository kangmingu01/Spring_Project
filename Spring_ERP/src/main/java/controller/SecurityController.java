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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import repository.ErpUserDAO;
import repository.OrganizationDAO;

import java.util.Map;

@Controller
@RequiredArgsConstructor
public class SecurityController {
    private final PasswordEncoder passwordEncoder;
    private final ErpUserDAO erpUserDAO;
    private final OrganizationDAO organizationDAO;

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

        /* 현재 비밀번호 검증 */
        String currentPassword = (String) map.get("currentPassword");
        /* 새 비밀번호 */
        String newPassword = (String) map.get("newPassword");
        /* 새 비밀번호랑 같은지 확인하는 거 */
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
    public String accessDenied() {
        return "accessDenied";
    }

    @GetMapping("/lnaccessible")
    public String lnaccessible() {
        return "/security/lnaccessible_page";
    }

    /* 비상 */
    @GetMapping("/mypage")
    public String mypage(Model model) {
        /*@AuthenticationPrincipal CustomUserDetails userDetails*/
        /*@RequestParam(value = "error",required = false) String error, @RequestParam(value = "success",required = false) String success,*/
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        String orgName = organizationDAO.selectOrgName(userDetails.getOrgId());

        model.addAttribute("orgName", orgName);
        /*
        if(error != null) {
            model.addAttribute("error", error);
        }
        if(success != null) {
            model.addAttribute("success", success);
        }
*/
        return "/security/mypage_page";
    }

    @PostMapping("/updateUserInfo")
    public String updateUserInfo(@RequestParam Map<String, Object> map, Model model, RedirectAttributes redirectAttributes) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        ErpUser erpUser = erpUserDAO.selectErpUserByUserid(userDetails.getUsername());

        String currentPassword = (String) map.get("currentPassword");
        String newPassword = (String) map.get("newPassword");
        String confirmPassword = (String) map.get("confirmPassword");

        if (!erpUser.getEmail().equals(map.get("email"))) {
            erpUser.setEmail((String) map.get("email"));
        }
        if (!erpUser.getPhone().equals(map.get("phone"))) {
            erpUser.setPhone((String) map.get("phone"));
        }
        if (!erpUser.getAddress().equals(map.get("address"))) {
            erpUser.setAddress((String) map.get("address"));
        }

        if (currentPassword != null && !currentPassword.isEmpty() &&
            newPassword != null && !newPassword.isEmpty() &&
            confirmPassword != null && !confirmPassword.isEmpty()) {

            if (passwordEncoder.matches(currentPassword, erpUser.getPasswd())) {
                if (currentPassword.equals(newPassword)) {
                    redirectAttributes.addFlashAttribute("error", "현재 비밀번호와 입력한 새 비밀번호가 같습니다. 다시 입력해주세요.");
                    return "redirect:/mypage";
                }
                if (newPassword.equals(confirmPassword)) {
                    erpUser.setPasswd(passwordEncoder.encode(newPassword));
                    erpUser.setEnabled(1);
                } else {
                    redirectAttributes.addFlashAttribute("error", "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
                    return "redirect:/mypage";
                }
            } else {
                redirectAttributes.addFlashAttribute("error", "현재 비밀번호가 올바르지 않습니다.");
                return "redirect:/mypage";
            }
        }

        erpUserDAO.updateErpUser(erpUser);
        redirectAttributes.addFlashAttribute("success", "정보가 성공적으로 수정되었습니다.");
        return "redirect:/mypage";
    }
}