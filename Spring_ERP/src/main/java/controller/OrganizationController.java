package controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import service.OrganizationService;

import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class OrganizationController {
    private final OrganizationService organizationService;

    @RequestMapping("/organization")
    public String organization(@RequestParam Map<String, Object> map, Model model) {
        model.addAttribute("resultMap", organizationService.getOrganizationList(map));
        model.addAttribute("searchMap", map);

        return "/admin/organization_management";
    }

    
    /* 삭제기능 구현(부서/매장 사라짐 표시) */
    @RequestMapping(value = "/deleteOrg", method = RequestMethod.POST)
    public String deleteOrg(@RequestParam ("orgId") String orgId) {
        organizationService.deleteOrganization(orgId);

        return "redirect:/admin/organization";
    }
}
