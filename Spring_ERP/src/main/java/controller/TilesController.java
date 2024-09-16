package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TilesController {
    @RequestMapping("/")
    public String tiles() {
        return "main";
    }

    @RequestMapping("/admin")
    public String admin() {
        return "admin";
    }
}
