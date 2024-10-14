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

import dto.Receiving;
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

        // 검색 필드 기본값 설정
        map.putIfAbsent("settlementId", "");
        map.putIfAbsent("settlementDate", "");
        map.putIfAbsent("receivingId", "");
        map.putIfAbsent("name", "");
        map.putIfAbsent("productId", "");
        map.putIfAbsent("productName", "");
        map.putIfAbsent("supplierId", "");

        // 기본값 설정: 입고 완료 상태(4)와 정산 완료 상태(6)를 모두 조회
        map.put("receivingStatus", "4");
        map.putIfAbsent("settlementStatus", "6");

        // 구매정산 목록 조회 (페이징 처리 및 검색 포함)
        Map<String, Object> resultMap = settlementService.getSettlementList(map);

        // 조회된 구매정산 목록과 페이징 정보를 모델에 추가
        model.addAttribute("pager", resultMap.get("pager"));
        model.addAttribute("settlementList", resultMap.get("settlementList"));
        model.addAttribute("searchMap", map);

        // Receiving 객체 생성 후 receiving_status = 4로 설정
        Receiving receiving = new Receiving();
        receiving.setReceivingStatus(4); // receiving_status = 4인 항목만 조회
        
        List<Receiving> receivingList = settlementService.getReceivingList(receiving);
        model.addAttribute("receivingList", receivingList);
        
        // 공급 업체 목록 추가 (검색 필터에 사용)
        List<Supplier> supplierList = settlementService.getSupplierList();
        model.addAttribute("supplierList", supplierList);

        return "purchase/settlement/settlement_list"; // 구매정산 목록 페이지 뷰로 이동
    }

    // 구매정산 확정 - 구매정산 대기 상태에서 구매정산 완료 상태로 변경
    @PreAuthorize("hasRole('ROLE_PURCHASING_TEAM')")
    @RequestMapping(value = "/complete", method = RequestMethod.POST)
    public String completeSettlement(@RequestParam("settlementId") int settlementId, @RequestParam Map<String, Object> map, Model model, Principal principal) {
        // 로그인한 사용자 아이디 추가
        String userId = principal.getName();
        model.addAttribute("userId", userId);

        // 구매정산 상태 수정 처리 (구매정산 대기 -> 구매정산 완료)
        Settlement settlement = new Settlement();
        settlement.setSettlementId(settlementId);
        settlement.setSettlementStatus(6); // 상태를 완료(6)로 변경
        
        // 정산 상태 업데이트
        settlementService.addSettlement(settlement);

        // 페이징 정보를 유지하면서 목록으로 리다이렉트
        String pageNum = map.get("pageNum") != null ? (String) map.get("pageNum") : "1";
        String pageSize = map.get("pageSize") != null ? (String) map.get("pageSize") : "10";

        return "redirect:/purchase/settlement/list?pageNum=" + pageNum + "&pageSize=" + pageSize;
    }
}
