package controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import service.ErpUserService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class UserController {
    private final ErpUserService erpUserService;

    @RequestMapping("/user")
    public String user(Model model) {
        return "htmlTemplate";
    }
}
