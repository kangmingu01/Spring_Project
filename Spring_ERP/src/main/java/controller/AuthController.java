package controller;

import dto.ErpAuth;
import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import service.ErpAuthService;
import service.ErpUserService;
import service.OrganizationService;

import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AuthController {
    private final ErpAuthService erpAuthService;
    private final ErpUserService erpUserService;
    private final OrganizationService organizationService;

    /* 탭으로 조절 가능하게 */
    /* 일단 auth 페이지에서 만들고 쪼개기 */
    @RequestMapping("/auth")
    public String authGet(@RequestParam Map<String, Object> map, @ModelAttribute("errorMessage") String errorMessage, Model model) {

        if(errorMessage != null){
            model.addAttribute("errorMessage", errorMessage);
        }

        model.addAttribute("resultMap", erpAuthService.getErpAuthList(map));
        model.addAttribute("searchMap", map);

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

    /* 검색시 권한 대상의 ID를 반환할 수 있게 */
    @RequestMapping("/searchId")
    public String searchIdGet(@RequestParam Map<String, Object> map, @RequestParam("searchType") String searchType, Model model) {
        if(searchType.equals("userid")) {
            model.addAttribute("searchType", searchType);
            model.addAttribute("resultMap", erpUserService.getErpUserList(map));
            model.addAttribute("searchMap", map);
        }

        if(searchType.equals("orgId")) {
            model.addAttribute("searchType", searchType);
            model.addAttribute("resultMap", organizationService.getOrganizationList(map));
            model.addAttribute("searchMap", map);
        }

        /* 로직 구현 */
        /*
        1. 처음 검색 버튼을 누르면 검색 입력 필드 나옴.(url에는 searchType이 파라미터로 존재)
        2. 권한 대상의 명을 입력하고 검색 버튼을 누르면 검색한 권한 대상의 명을 가진 ID가 나옴.(검색했는데 값이 없으면 검색된 결과가 없습니다.)
        3. 검색 대상의 명이 여러 개 일수도 있으니 페이징 처리
        4. 그 권한명 중 원하는 행 중에서 [사용] 버튼 클릭시 그 권한 대상의 명을 가진 ID가 input 필드에 나타남 문제는 ErpUser에서 가져와야됨
        */
        return "searchId";
    }

    @RequestMapping(value = "/addAuth", method = RequestMethod.POST)
    public String addAuth(@ModelAttribute ErpAuth erpAuth, RedirectAttributes redirectAttributes) {
        boolean isAdded = erpAuthService.addErpAuth(erpAuth);

        if(!isAdded) {
            redirectAttributes.addFlashAttribute("errorMessage", "이미 해당 권한이 존재합니다.");
        }
        return "redirect:/admin/auth";
    }

    @RequestMapping(value = "/deleteAuth", method = RequestMethod.POST)
    public String deleteAuth(@ModelAttribute ErpAuth erpAuth) {
        erpAuthService.deleteErpAuth(erpAuth);

        return "redirect:/admin/auth";
    }
}
