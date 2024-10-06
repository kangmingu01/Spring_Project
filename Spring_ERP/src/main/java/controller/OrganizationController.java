package controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import service.OrganizationService;

import java.util.Map;

/* HTML만 반환하는 컨트롤러 */
/* Restful 처리하는 컨트롤러는 OrganizationApiController */
/* 유지보수를 위해 컨트롤러를 분리하여 작성 */
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class OrganizationController {
    private final OrganizationService organizationService;

    // 클라이언트가 HTML 요청
    @RequestMapping("/organization")
    public String organization(@RequestParam Map<String, Object> map, Model model) {


        return "/admin/organization_management";
    }


    /* 삭제기능 구현(부서/매장 사라짐 표시) */
    @RequestMapping(value = "/deleteOrg", method = RequestMethod.POST)
    public String deleteOrg(@RequestParam ("orgId") String orgId) {
        organizationService.deleteOrganization(orgId);

        return "redirect:/admin/organization";
    }
}
