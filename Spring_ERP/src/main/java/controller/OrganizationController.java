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


        Organization org = (Organization) map.get("Organization");

        if (org != null && org.getOrgId() != null) {
            String orgIdPrefix = org.getOrgId().substring(0, 3);
            model.addAttribute("isDepartment", "DEP".equals(orgIdPrefix));
        } else {
            model.addAttribute("isDepartment", false);
        }

        return "/admin/organization_management";
    }

    @PostMapping("/addOrganization")
    public String addOrganization(@RequestParam Map<String, Object> map, Model model) {

        // 다음에 생성될 orgId 값 구하는 파람
        String orgPrefix  = map.get("orgPrefix").toString();

        String startNum = map.get("startNum").toString();
        String middleNum = map.get("middleNum").toString();
        String endNum = map.get("endNum").toString();

        String phoneNumber = startNum + '-' + middleNum + '-' + endNum;

        // orgId 생성
        String orgId = organizationService.generateNextOrgId(orgPrefix);

        // Organization 객체 생성 후 추가
        Organization organization = new Organization();
        organization.setOrgId(orgId);
        organization.setOrgName(map.get("orgName").toString());
        organization.setOrgType(Integer.parseInt(map.get("orgType").toString()));
        organization.setAddress(map.get("address").toString());
        organization.setPhoneNumber(phoneNumber);

        // 서비스 호출하여 조직 추가
        organizationService.addOrganization(organization);


        System.out.println(orgPrefix);
        System.out.println(orgId);
        System.out.println(map.get("orgName").toString());
        System.out.println(map.get("address").toString());
        System.out.println(phoneNumber);


        return "redirect:/admin/organization";
    }

    /* 삭제기능 구현(부서/매장 사라짐 표시) */
    @RequestMapping(value = "/deleteOrg", method = RequestMethod.POST)
    public String deleteOrg(@RequestParam ("orgId") String orgId) {
        organizationService.deleteOrganization(orgId);

        return "redirect:/admin/organization";
    }

    /* 조직 정보 수정 */
    @RequestMapping(value = "/updateOrg", method = RequestMethod.POST)
    public String updateOrg(@ModelAttribute Organization organization) {
        organization.setOrgName(organization.getOrgName());
        organization.setAddress(organization.getAddress());

        organizationService.updateOrganization(organization);
        return "redirect:/admin/organization";
    }
}
