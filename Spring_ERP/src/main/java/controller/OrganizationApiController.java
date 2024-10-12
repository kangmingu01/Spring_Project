package controller;

import dto.Organization;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import service.OrganizationService;
import java.util.Map;



@RestController
@RequestMapping("/api/organization")
@RequiredArgsConstructor
public class OrganizationApiController {
    private final OrganizationService organizationService;

    /* Postman을 통해 요청처리 메소드가 잘 작동하는지 확인 */
    @GetMapping("/list")
    public Map<String, Object> getOrganizationData(@RequestParam Map<String, Object> map) {
        return organizationService.getOrganizationList(map); // JSON 형식으로 Map 객체 반환
    }
}
