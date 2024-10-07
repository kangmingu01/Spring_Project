package controller;

import dto.Organization;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
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

    @PostMapping("/addOrganization")
    public String addOrganization(@ModelAttribute Organization organization, @RequestParam("orgPrefix") String orgPrefix) {
        // orgPrefix = 부서, 매장인지 값 넘어오는 건 DEP, STORE로 넘어옴
        String orgId = organizationService.generateNextOrgId(orgPrefix);
        organization.setOrgId(orgId);
        organizationService.addOrganization(organization);

        return "redirect:/admin/organization";
    }

    /* 삭제기능 구현(부서/매장 사라짐 표시) */
    @RequestMapping(value = "/deleteOrg", method = RequestMethod.POST)
    public String deleteOrg(@RequestParam ("orgId") String orgId) {
        organizationService.deleteOrganization(orgId);

        return "redirect:/admin/organization";
    }
}
