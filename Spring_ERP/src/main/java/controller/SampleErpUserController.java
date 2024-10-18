package controller;

import dto.ErpAuth;
import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import service.ErpUserService;

import java.time.LocalDate;

@Controller
@RequiredArgsConstructor
public class SampleErpUserController {
    private final ErpUserService erpUserService;
    private final PasswordEncoder passwordEncoder;

    @RequestMapping(value = "/member/add", method = RequestMethod.GET)
    @ResponseBody
    public String add() {
/*

        // 첫 번째 임시 사용자
        LocalDate birthday1 = LocalDate.of(1990, 5, 20);
        LocalDate joindate1 = LocalDate.of(2020, 3, 1);
        ErpUser erpUser1 = new ErpUser("userid1", passwordEncoder.encode("123456"), "홍길동", "010-1111-1111", "서울시 강남구", "abc@naver.com", 1, birthday1, joindate1, 1, null, null);

        // 두 번째 임시 사용자
        LocalDate birthday2 = LocalDate.of(1985, 7, 15);
        LocalDate joindate2 = LocalDate.of(2019, 6, 10);
        ErpUser erpUser2 = new ErpUser("userid2",  passwordEncoder.encode("123456"), "임꺽정", "010-2345-6789", "부산광역시", "example@naver.com", 2, birthday2, joindate2, 1, null, null);

        // 세 번째 임시 사용자
        LocalDate birthday3 = LocalDate.of(1995, 10, 30);
        LocalDate joindate3 = LocalDate.of(2021, 1, 15);
        ErpUser erpUser3 = new ErpUser("userid3",  passwordEncoder.encode("123456"), "김철수", "010-3456-7890", "인천광역시", "user3@example.com", 1, birthday3, joindate3, 1, null, null);

        ErpUser erpUser4 = new ErpUser("userid4",  passwordEncoder.encode("123456"), "안성재", "010-3456-7890", "모수", "user4@example.com", 1, birthday3, joindate3, 1, null, null);


        erpUserService.addErpUser(erpUser1);
        erpUserService.addErpUser(erpUser2);
        erpUserService.addErpUser(erpUser3);
        erpUserService.addErpUser(erpUser4);

        ErpAuth auth1 = new ErpAuth("userid1", "ROLE_SUPER_ADMINISTRATOR");
        ErpAuth auth2 = new ErpAuth("userid2", "ROLE_PURCHASING_TEAM");
        ErpAuth auth3 = new ErpAuth("userid2", "ROLE_INVENTORY_TEAM ");
        ErpAuth auth4 = new ErpAuth("userid3", "ROLE_SALES_TEAM");


        erpUserService.addErpAuth(auth1);
        erpUserService.addErpAuth(auth2);
        erpUserService.addErpAuth(auth3);
        erpUserService.addErpAuth(auth4);
*/
        return "success";
    }
}
