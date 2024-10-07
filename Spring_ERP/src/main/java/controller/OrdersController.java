package controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import dto.Orders;
import dto.Supplier;
import lombok.RequiredArgsConstructor;
import service.OrdersService;

@Controller
@RequestMapping("/purchase/orders")
@RequiredArgsConstructor
public class OrdersController {
    private final OrdersService ordersService;
    
    // 발주 등록 페이지 - 구매팀 ROLE만 접근 가능
    @PreAuthorize("hasRole('ROLE_PURCHASING_TEAM')")
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String register(Model model, Principal principal) {
        // 공급 업체 목록 조회 후 모델에 추가하여 드롭다운에 사용
        List<Supplier> supplierList = ordersService.getSupplierList();
        model.addAttribute("supplierList", supplierList);

        // 제품 목록 조회 및 추가 (기본적으로 첫 페이지에 10개 조회)
        Map<String, Object> productMap = new HashMap<>();
        productMap.put("pageNum", "1");
        productMap.put("pageSize", "10");

        Map<String, Object> productResult = ordersService.getProductList(productMap);
        model.addAttribute("productList", productResult.get("productList"));
        
        // 로그인한 사용자 아이디를 모델에 추가
        String userId = principal.getName(); // 로그인한 사용자의 아이디 가져오기
        model.addAttribute("userId", userId);

        return "purchase/orders/orders_register"; // 발주 등록 페이지로 이동
    }

    // 발주 등록 처리 - 구매팀 ROLE만 접근 가능
    @PreAuthorize("hasRole('ROLE_PURCHASING_TEAM')")
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(@ModelAttribute Orders orders, Principal principal, Model model) {
        // 로그인한 사용자의 아이디를 발주 정보에 추가
        String userId = principal.getName(); // 로그인한 사용자의 아이디 가져오기
        orders.setUserid(userId); // 발주 객체에 사용자 아이디 설정

        // 발주 등록 서비스 호출
        ordersService.addOrders(orders);

        // 등록된 발주 ID로 발주 정보 다시 조회
        Orders newOrder = ordersService.getOrdersById(orders.getOrdersId());
        
        // 새로 등록된 발주 정보를 모델에 추가
        model.addAttribute("newOrder", newOrder);

        // 공급 업체 목록 및 제품 목록 다시 추가 (등록 후 화면 초기화 위해 재조회)
        List<Supplier> supplierList = ordersService.getSupplierList();
        model.addAttribute("supplierList", supplierList);

        Map<String, Object> productMap = new HashMap<>();
        productMap.put("pageNum", "1");
        productMap.put("pageSize", "10");

        Map<String, Object> productResult = ordersService.getProductList(productMap);
        model.addAttribute("productList", productResult.get("productList"));

        return "purchase/orders/orders_register"; // 발주 등록 페이지로 다시 이동
    }


    // 제품 리스트 조회 - 모달 창에서 페이징 및 검색 처리
    @RequestMapping(value = "/productList", method = RequestMethod.GET)
    public String getProductList(@RequestParam Map<String, Object> map, Model model) {
        if (!map.containsKey("pageNum")) {
            map.put("pageNum", "1");
        }
        if (!map.containsKey("pageSize")) {
            map.put("pageSize", "10");
        }

        // 제품 리스트와 페이징 정보 조회
        Map<String, Object> resultMap = ordersService.getProductList(map);

        // 페이징 정보와 제품 리스트를 모델에 추가
        model.addAttribute("pager", resultMap.get("pager")); 
        model.addAttribute("productList", resultMap.get("productList")); 
        model.addAttribute("searchMap", map); 

        return "purchase/orders/product_list";  // 제품 리스트 페이지 뷰 (모달에서 사용)
    }

    /*
    // 공급업체 검색 - Ajax 요청 처리 
    @GetMapping("/supplier/search")
    @ResponseBody
    public List<Map<String, Object>> searchSuppliers(@RequestParam String keyword) {
        List<Supplier> suppliers = ordersService.getSupplierListByKeyword(keyword);
        return suppliers.stream()
                .map(supplier -> {
                    Map<String, Object> supplierMap = new HashMap<>();
                    supplierMap.put("supplierId", supplier.getSupplierId());
                    supplierMap.put("supplierName", supplier.getSupplierName());
                    return supplierMap;
                })
                .collect(Collectors.toList());
    }
    */
    
 // 발주 목록 페이지 - 구매팀 ROLE만 접근 가능
    @PreAuthorize("hasRole('ROLE_PURCHASING_TEAM')")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listOrders(@RequestParam Map<String, Object> map, Model model, Principal principal) {
        // 로그인한 사용자 아이디를 모델에 추가
        String userId = principal.getName(); 
        model.addAttribute("userId", userId);

        // 기본 페이징 및 검색 설정
        if (!map.containsKey("pageNum")) {
            map.put("pageNum", "1");
        }
        if (!map.containsKey("pageSize")) {
            map.put("pageSize", "10");
        }

        // 검색 필드가 없는 경우 처리 (기본 값 세팅)
        map.putIfAbsent("ordersId", "");
        map.putIfAbsent("ordersDate", "");
        map.putIfAbsent("userid", "");
        map.putIfAbsent("productId", "");
        map.putIfAbsent("productName", "");
        map.putIfAbsent("brand", "");
        map.putIfAbsent("supplierId", "");
        map.putIfAbsent("ordersStatus", "");

        // 발주 목록 조회 (페이징 처리 및 검색 포함)
        Map<String, Object> resultMap = ordersService.getOrdersList(map);

        // 조회된 발주 목록과 페이징 정보를 모델에 추가
        model.addAttribute("pager", resultMap.get("pager"));
        model.addAttribute("ordersList", resultMap.get("ordersList"));
        model.addAttribute("searchMap", map);

        // 공급 업체 목록 추가 (검색 필터에 사용)
        List<Supplier> supplierList = ordersService.getSupplierList();
        model.addAttribute("supplierList", supplierList);

        return "purchase/orders/orders_list"; // 발주 목록 페이지 뷰로 이동
    }

    // 발주 수정 후 목록으로 이동 - 페이징 및 검색 조건 유지
    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String modifyOrder(@ModelAttribute Orders orders, @RequestParam Map<String, Object> map, Model model, Principal principal)
    		throws UnsupportedEncodingException {
    	// 로그인한 사용자 아이디를 모델에 추가
        String userId = principal.getName(); 
        model.addAttribute("userId", userId);
        
        // 발주 정보 수정 처리
        ordersService.modifyOrders(orders);

     // 페이징 및 검색 정보를 유지하면서 목록으로 리다이렉트
        String pageNum = (String) map.get("pageNum");
        String pageSize = (String) map.get("pageSize");
        String ordersId = (String) map.get("ordersId");
        String ordersDate = URLEncoder.encode((String) map.get("ordersDate"), "utf-8");
        String userid = URLEncoder.encode((String) map.get("userid"), "utf-8");
        String productName = URLEncoder.encode((String) map.get("productName"), "utf-8");
        String supplierId = (String) map.get("supplierId");
        String ordersStatus = (String) map.get("ordersStatus");

        return "redirect:/purchase/orders/list?pageNum=" + pageNum
                + "&pageSize=" + pageSize
                + "&ordersId=" + ordersId
                + "&ordersDate=" + ordersDate
                + "&userid=" + userid
                + "&productName=" + productName
                + "&supplierId=" + supplierId
                + "&ordersStatus=" + ordersStatus;
    }


    // 발주 확정 - 발주 대기 상태에서 발주 완료 상태로 변경
    @PreAuthorize("hasRole('ROLE_PURCHASING_TEAM')")
    @RequestMapping(value = "/confirm", method = RequestMethod.POST)
    public String confirmOrders(@RequestParam("ordersId") int ordersId, @RequestParam Map<String, Object> map, Model model, Principal principal) 
            throws UnsupportedEncodingException {
        // 로그인한 사용자 아이디를 모델에 추가
        String userId = principal.getName(); 
        model.addAttribute("userId", userId);
        
        // 발주 상태 수정 처리
        ordersService.modifyOrdersStatus(ordersId);

        // 페이징 정보를 유지하면서 목록으로 리다이렉트, 검색 조건은 초기화
        String pageNum = map.get("pageNum") != null ? (String) map.get("pageNum") : "1";
        String pageSize = map.get("pageSize") != null ? (String) map.get("pageSize") : "10";

        return "redirect:/purchase/orders/list?pageNum=" + pageNum
                + "&pageSize=" + pageSize;
    }


}
