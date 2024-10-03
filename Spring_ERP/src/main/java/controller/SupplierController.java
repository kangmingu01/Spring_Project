package controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import dto.Supplier;
import service.SupplierService;

@Controller
@RequestMapping("/purchase/supplier")
@RequiredArgsConstructor
public class SupplierController {
    private final SupplierService supplierService;

    // 공급업체 관리 페이지 - 기본 전체 목록 조회
    @RequestMapping("/manage")
    public String manage(@RequestParam Map<String, Object> map, Model model) {
        if (map.isEmpty()) {
            map.put("pageNum", "1");
            map.put("pageSize", "10");
        }

        model.addAttribute("resultMap", supplierService.getSupplierList(map));
        model.addAttribute("searchMap", map);
        return "purchase/supplier/supplier_manage";
    }

    // 공급업체 등록 - 모든 로그인 사용자 가능
    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public ResponseEntity<Void> register(@RequestBody Supplier supplier) {
        try {
            supplierService.addSupplier(supplier);
            return ResponseEntity.ok().build();
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
    }

    // 공급업체 이름 중복 여부 확인 API
    @RequestMapping(value = "/checkName", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Boolean>> checkName(@RequestParam("supplierName") String supplierName) {
        int count = supplierService.existsByName(supplierName);
        boolean exists = count > 0;
        Map<String, Boolean> response = Map.of("exists", exists);
        return ResponseEntity.ok(response);
    }

    // 공급업체 정보 수정
    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String modify(@ModelAttribute Supplier supplier, @RequestParam Map<String, Object> map) throws UnsupportedEncodingException {
        supplierService.modifySupplier(supplier);
        
        String pageNum = (String) map.get("pageNum");
        String pageSize = (String) map.get("pageSize");
        String column = (String) map.get("column");
        String keyword = URLEncoder.encode((String) map.get("keyword"), "utf-8");

        return "redirect:/purchase/supplier/manage?pageNum=" + pageNum + "&pageSize=" + pageSize
                + "&column=" + column + "&keyword=" + keyword;
    }

    // 공급업체 검색 및 초기화 - 전체 목록을 기본으로 조회
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String search(@RequestParam Map<String, Object> map, Model model) {
        // 검색 조건이 있는 경우 해당 조건으로 조회, 없는 경우 전체 목록 조회
        if (map.isEmpty()) {
            map.put("pageNum", "1");
            map.put("pageSize", "10");
        }

        model.addAttribute("resultMap", supplierService.getSupplierList(map));
        model.addAttribute("searchMap", map);
        return "purchase/supplier/supplier_manage";
    }
}
