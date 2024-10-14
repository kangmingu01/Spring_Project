package controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import dto.Settlement;
import dto.Supplier;
import lombok.RequiredArgsConstructor;
import service.SettlementService;

@Controller
@RequestMapping("/purchase/settlement")
@RequiredArgsConstructor
public class SettlementController {

    private final SettlementService settlementService;

    // 구매정산 목록 페이지 - 구매팀 ROLE만 접근 가능
    @PreAuthorize("hasRole('ROLE_PURCHASING_TEAM')")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listSettlement(@RequestParam Map<String, Object> map, Model model, Principal principal) {
        // 로그인한 사용자 아이디 추가
        String userId = principal.getName();
        model.addAttribute("userId", userId);

        // 기본 페이징 및 검색 설정
        if (!map.containsKey("pageNum")) {
            map.put("pageNum", "1");
        }
        if (!map.containsKey("pageSize")) {
            map.put("pageSize", "10");
        }

        // 검색 필드 기본값 설정 (기타 검색 조건들은 유지)
        map.putIfAbsent("settlementId", "");
        map.putIfAbsent("settlementDate", "");
        map.putIfAbsent("receivingId", "");
        map.putIfAbsent("name", "");
        map.putIfAbsent("productId", "");
        map.putIfAbsent("productName", "");
        map.putIfAbsent("supplierId", "");

        // receivingStatus = 4, settlementStatus = 6은 무조건 설정 (기본 필터)
        map.put("receivingStatus", 4); // 입고 완료 상태
        map.put("settlementStatus", 6); // 정산 완료 상태

        // 구매정산 목록 조회 (페이징 처리 및 검색 포함)
        Map<String, Object> resultMap = settlementService.getSettlementList(map);

        // 조회된 구매정산 목록과 페이징 정보를 모델에 추가
        model.addAttribute("pager", resultMap.get("pager"));
        model.addAttribute("settlementList", resultMap.get("settlementList"));
        model.addAttribute("searchMap", map);

        // 공급 업체 목록 추가 (검색 필터에 사용)
        List<Supplier> supplierList = settlementService.getSupplierList();
        model.addAttribute("supplierList", supplierList);
        
        System.out.println(map);
        return "purchase/settlement/settlement_list"; // 구매정산 목록 페이지 뷰로 이동
    }

    @PreAuthorize("hasRole('ROLE_PURCHASING_TEAM')")
    @RequestMapping(value = "/complete", method = RequestMethod.POST)
    public String completeSettlement(@RequestParam("settlementId") int settlementId,
                                     @RequestParam("receivingId") int receivingId, // receivingId를 추가합니다.
                                     @RequestParam Map<String, Object> map, Model model, Principal principal) {
        // 로그인한 사용자 아이디 추가
        String userId = principal.getName();
        model.addAttribute("userId", userId);

        // 구매정산 상태 수정 처리
        Settlement settlement = new Settlement();
        settlement.setSettlementId(settlementId); // 기존의 settlementId 사용
        settlement.setUserid(userId); // 현재 사용자 ID
        settlement.setReceivingId(receivingId); // 매개변수로 전달받은 receivingId 사용
        settlement.setSettlementStatus(6); // 새 정산 상태 (완료)

        // 정산 상태 업데이트
        settlementService.addSettlement(settlement);

        // 페이징 정보를 유지하면서 목록으로 리다이렉트
        String pageNum = map.get("pageNum") != null ? (String) map.get("pageNum") : "1";
        String pageSize = map.get("pageSize") != null ? (String) map.get("pageSize") : "10";

        return "redirect:/purchase/settlement/list?pageNum=" + pageNum + "&pageSize=" + pageSize;
    }


}
