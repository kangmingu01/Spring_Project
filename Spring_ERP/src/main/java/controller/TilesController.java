package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TilesController {
    @RequestMapping("/")
    public String tiles() {
        // 템플릿 요청 경로 아닌가..?
        return "main";
    }

    @RequestMapping("/main")
    public String main() {
        return "main";
    }

    @RequestMapping("/login")
    public String login() {
        return "login";
    }
}