package controller;

import dto.ErpAuth;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.ErpAuthService;

import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AuthController {
    private final ErpAuthService erpAuthService;

    /* 탭으로 조절 가능하게 */
    /* 일단 auth 페이지에서 만들고 쪼개기 */
    @GetMapping("/auth")
    public String authGet(@RequestParam Map<String, Object> map, Model model) {
        model.addAttribute("resultMap", erpAuthService.getErpAuthList(map));
        model.addAttribute("searchMap", map);
        return "/admin/auth_management";
    }

    /* Post 방식으로 ErpAuth 받을 수 있게 */
    @PostMapping("/auth")
    public String authPost(@ModelAttribute ErpAuth erpauth, Model model) {
        return "/admin/auth_management";
    }

    /* 탭 기능으로 user랑 org 따로 구분할 수 있도록 함 */
    @GetMapping("/auth/user")
    public String user() {
        return "/admin/user";
    }

    @GetMapping("/auth/org")
    public String org() {
        return "/admin/org";
    }


}
