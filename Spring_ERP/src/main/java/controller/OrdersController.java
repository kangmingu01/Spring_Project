package controller;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import dto.Orders;
import dto.ProductCategory;
import dto.Supplier;
import lombok.RequiredArgsConstructor;
import service.CommonService;
import service.OrdersService;
import util.ProductCategoryEditor;
import util.ProductCategoryReverse;

@Controller
@RequestMapping("/purchase/orders")
@RequiredArgsConstructor
public class OrdersController {
    private final OrdersService ordersService;
    
    @Autowired
    private CommonService commonService;
    
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(ProductCategory.class, new ProductCategoryEditor());
    }

    // 발주 등록 페이지 - 구매팀 ROLE만 접근 가능
    @PreAuthorize("hasAnyRole('ROLE_PURCHASING_TEAM', 'ROLE_SUPER_ADMINISTRATOR')")
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String register(Model model, Principal principal) {
        // 공급 업체 목록 조회 후 드롭다운에 사용
        List<Supplier> supplierList = ordersService.getSupplierList();
        model.addAttribute("supplierList", supplierList);

        // 제품 목록 조회 (기본적으로 첫 페이지에 10개 조회)
        Map<String, Object> productMap = new HashMap<>();
        productMap.put("pageNum", "1");
        productMap.put("pageSize", "10");

        Map<String, Object> productResult = ordersService.getProductList(productMap);
        model.addAttribute("productList", productResult.get("productList"));
        
        // 로그인한 사용자의 아이디 추가
        String userId = principal.getName(); // 로그인한 사용자의 아이디 가져오기
        model.addAttribute("userId", userId);

        return "purchase/orders/orders_register"; // 발주 등록 페이지로 이동
    }

    // 발주 등록 처리 - 구매팀 ROLE만 접근 가능
    @PreAuthorize("hasAnyRole('ROLE_PURCHASING_TEAM', 'ROLE_SUPER_ADMINISTRATOR')")
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(@ModelAttribute Orders orders, Principal principal, Model model) {
        // 로그인한 사용자의 아이디를 발주 정보에 추가
        String userId = principal.getName(); 
        orders.setUserid(userId); 

        // 발주 등록 서비스 호출
        ordersService.addOrders(orders);

        // 등록된 발주 정보 다시 조회하여 모델에 추가
        Orders newOrder = ordersService.getOrdersById(orders.getOrdersId());
        model.addAttribute("newOrder", newOrder);

        // 화면 초기화를 위해 공급 업체 목록 및 제품 목록 재조회
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
        // 페이지 번호와 페이지 크기 기본 설정
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
        // 공급업체 검색 결과를 리스트로 반환
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
    @PreAuthorize("hasAnyRole('ROLE_PURCHASING_TEAM', 'ROLE_SUPER_ADMINISTRATOR')")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listOrders(@RequestParam Map<String, Object> map, Model model, Principal principal) {
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
        map.putIfAbsent("ordersId", "");
        map.putIfAbsent("ordersDate", "");
        map.putIfAbsent("name", "");      
        map.putIfAbsent("productId", "");
        map.putIfAbsent("productName", "");   
        map.putIfAbsent("brand", "");        
        map.putIfAbsent("supplierId", "");
        map.putIfAbsent("ordersStatus", "");
        map.putIfAbsent("productPrice", "");
        
        // 역변환 로직 적용 (한글을 코드로 변환)
        String brand = ProductCategoryReverse.reverseBrand(map.getOrDefault("brand", "").toString());
        map.put("brand", brand);
        
        String type = ProductCategoryReverse.reverseType(map.getOrDefault("type", "").toString());
        map.put("type", type);

        String color = ProductCategoryReverse.reverseColor(map.getOrDefault("color", "").toString());
        map.put("color", color);
        
        
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
    @PreAuthorize("hasAnyRole('ROLE_PURCHASING_TEAM', 'ROLE_SUPER_ADMINISTRATOR')")
    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String modifyOrder(@RequestBody Map<String, Object> map, Principal principal, Model model)
            throws UnsupportedEncodingException {
        // 로그인한 사용자 아이디 추가
        String userId = principal.getName();
        model.addAttribute("userId", userId);

        // 필요한 필드만 추출하여 수정 처리
        Orders orders = new Orders();

        if (map.containsKey("ordersId")) {
            orders.setOrdersId(Integer.parseInt(map.get("ordersId").toString()));
        }
        if (map.containsKey("ordersQuantity")) {
            orders.setOrdersQuantity(Integer.parseInt(map.get("ordersQuantity").toString()));
        }
        if (map.containsKey("deliveryDate")) {
            orders.setDeliveryDate(map.get("deliveryDate").toString());
        }

        // 발주 정보 수정 처리
        ordersService.modifyOrders(orders);

        // 페이징 정보를 유지하면서 목록으로 리다이렉트
        String pageNum = map.get("pageNum") != null ? (String) map.get("pageNum") : "1";
        String pageSize = map.get("pageSize") != null ? (String) map.get("pageSize") : "10";

        return "redirect:/purchase/orders/list?pageNum=" + pageNum + "&pageSize=" + pageSize;
    }

    // 발주 확정 - 발주 대기 상태에서 발주 완료 상태로 변경
    @PreAuthorize("hasAnyRole('ROLE_PURCHASING_TEAM', 'ROLE_SUPER_ADMINISTRATOR')")
    @RequestMapping(value = "/confirm", method = RequestMethod.POST)
    public String confirmOrders(@RequestParam("ordersId") int ordersId, @RequestParam Map<String, Object> map, Model model, Principal principal) 
            throws UnsupportedEncodingException {
        // 로그인한 사용자 아이디 추가
        String userId = principal.getName(); 
        model.addAttribute("userId", userId);
        
        // 발주 상태 수정 처리 (발주 대기 -> 발주 완료)
        ordersService.modifyOrdersStatus(ordersId);

        // 페이징 정보를 유지하면서 목록으로 리다이렉트, 검색 조건은 초기화
        String pageNum = map.get("pageNum") != null ? (String) map.get("pageNum") : "1";
        String pageSize = map.get("pageSize") != null ? (String) map.get("pageSize") : "10";

        return "redirect:/purchase/orders/list?pageNum=" + pageNum + "&pageSize=" + pageSize;
    }
    
    // 발주에서 카테고리 코드 보기
    @PreAuthorize("hasRole('ROLE_PURCHASING_TEAM')")
    @RequestMapping("/viewCategory")
    public String viewCategory(Model model, @RequestParam("categoryCode") String categoryCode) {
        ProductCategory productCategory = commonService.getProductCategoryDetails(categoryCode);
        model.addAttribute("productCategory", productCategory);
        return "viewCategory";
    }
}
