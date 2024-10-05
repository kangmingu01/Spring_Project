package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class OrganizationController {

    @RequestMapping("/organization")
    public String organization() {
        return "/admin/organization_management";
    }

}
