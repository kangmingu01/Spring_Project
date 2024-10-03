package controller;

import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import service.ErpUserService;

import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class UserController {
    private final ErpUserService erpUserService;

    @RequestMapping("/user")
    public String user(Model model) {
        return "htmlTemplate";
    }

    @RequestMapping("/boot")
    public String boot(@RequestParam Map<String, Object> map, @ModelAttribute ErpUser erpUser, Model model) {
        model.addAttribute("resultMap", erpUserService.getErpUserList(map));
        model.addAttribute("searchMap", map);
        return "bootstrapTemplate";
    }

    @RequestMapping("/idCheck")
    public String idCheck(@RequestParam("userid") String userid, Model model) {
        // User ID를 받아서 중복 체크 처리
        if (userid == null || userid.isEmpty()) {
            return "redirect:/admin/boot";
        }

        /* 로직 구현 */
        /*
        1. userid 값을 가져와서 DB에 해당 값이 있는지 검증
        2. 값의 존재 여부에 따라 view는 다른화면이 보여지게 구현
        3. 값이 없다면 view에서는 사용 가능합니다 버튼을 누르면 그 값을 그대로 사용가능하게 하고 /boot 경로의 view에서 idCheckResult값을 1로 바꿔줘야됨
        4. 값이 있다면 새로운 userid를 입력할 수 있게 해줘야하고 그 값도 중복 검사해줘야됨. 그리고 값이 없으니 사용 가능합니다 버튼이 뜰 수 있어야됨
        */
        ErpUser erpUser = erpUserService.getErpUserByUserid(userid);
        model.addAttribute("check", (erpUser == null ? 0 : 1));
        model.addAttribute("userid", userid);


        // View Resolver 우회
        return "forward:/WEB-INF/views/id_check.jsp";
    }
}
