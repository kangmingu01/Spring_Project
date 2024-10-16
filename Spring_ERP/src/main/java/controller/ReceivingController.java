package controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.http.ResponseEntity;
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
import org.springframework.web.bind.annotation.ResponseBody;

import dto.ProductCategory;
import dto.Receiving;
import dto.Supplier;
import dto.Warehouse;
import lombok.RequiredArgsConstructor;
import service.ReceivingService;
import util.ProductCategoryEditor;
import util.ProductCategoryParser;

@Controller
@RequestMapping("/purchase/receiving")
@RequiredArgsConstructor
@PropertySource("classpath:colors.properties")
public class ReceivingController {
    private final ReceivingService receivingService;
    
    private final Environment env; // Environment 객체 주입

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(ProductCategory.class, new ProductCategoryEditor());
    }

    // 입고 등록 페이지 - 구매팀 ROLE만 접근 가능
    @PreAuthorize("hasRole('ROLE_PURCHASING_TEAM')")
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String register(Model model, Principal principal) {
    	// 창고 목록 조회
    	List<Warehouse> warehouseList = receivingService.getWarehouseList();
    	model.addAttribute("warehouseList", warehouseList);
       
        // 발주 목록을 조회하여 모델에 추가
        Map<String, Object> ordersMap = new HashMap<>();
        //ordersMap.put("pageNum", "1");
        //ordersMap.put("pageSize", "10");
        Map<String, Object> ordersResult = receivingService.getOrdersList(ordersMap);
        System.out.println(ordersResult);
        model.addAttribute("ordersResult", ordersResult.get("ordersList"));
        System.out.println(ordersResult.get("ordersList"));

        // 로그인한 사용자의 아이디 추가
        String userId = principal.getName();
        model.addAttribute("userId", userId);

        return "purchase/receiving/receiving_register"; // 입고 등록 페이지로 이동
    }

    // 입고 등록 처리 - 구매팀 ROLE만 접근 가능
    @PreAuthorize("hasRole('ROLE_PURCHASING_TEAM')")
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(@ModelAttribute ProductCategory productCategory, @ModelAttribute Receiving receiving, Principal principal, Model model) {
    	// 로그로 productCategoryDetails 확인
        System.out.println("Received Product Category Details: " + receiving.getProductCategoryDetails());
        
    	// 로그인한 사용자의 아이디를 입고 정보에 추가
        String userId = principal.getName();
        receiving.setUserid(userId);
        
        // 입고 등록 처리
        receivingService.addReceiving(receiving);

        // ProductCategory에서 색상 코드를 조회하고 색상 이름으로 변환하여 모델에 추가
        String colorCode = productCategory.getColor();
        System.out.println("colorCode = "+colorCode);
        String propertyKey = "color." + productCategory.getColor();
        System.out.println("propertyKey = "+propertyKey);
        String propertyValue = env.getProperty(propertyKey);
        System.out.println("propertyValue = "+propertyValue);
        
        productCategory.setColor(propertyValue);

        // 등록된 입고 정보 다시 조회하여 모델에 추가
        Receiving newReceiving = receivingService.getReceivingById(receiving.getReceivingId());
        model.addAttribute("newReceiving", newReceiving);
        model.addAttribute("productCategory", productCategory);
        String productCode = "" + productCategory.getBrand() + " " + colorCode + " " + productCategory.getColor() + " " + productCategory.getSize() + " " + productCategory.getGender();
        System.out.println(productCode);
        model.addAttribute("productCode", productCode);

        // ProductCategory 코드를 파싱하여 상세 정보를 설정
        if (newReceiving != null) {
            String productCategoryCode = newReceiving.getProductCategory();
            System.out.println("Product Category Code: " + productCategoryCode); // 로그 추가

            if (productCategoryCode != null) {
                ProductCategory productCategoryDetails = ProductCategoryParser.parseCategoryCode(productCategoryCode);
                newReceiving.setProductCategoryDetails(productCategoryDetails);
            }
        }

        // 창고 목록도 다시 조회
        List<Warehouse> warehouseList = receivingService.getWarehouseList();
        model.addAttribute("warehouseList", warehouseList);

        // 발주 목록도 다시 조회하여 모델에 추가
        Map<String, Object> ordersMap = new HashMap<>();
        //ordersMap.put("pageNum", "1");
        //ordersMap.put("pageSize", "10");
        
        Map<String, Object> ordersResult = receivingService.getOrdersList(ordersMap);
        model.addAttribute("ordersResult", ordersResult.get("ordersList"));

        return "purchase/receiving/receiving_register"; // 입고 등록 페이지로 다시 이동
    }

    // 발주 목록 조회 - 모달 창에서 페이징 및 검색 처리
    @PreAuthorize("hasRole('ROLE_PURCHASING_TEAM')")
    @RequestMapping(value = "/ordersList", method = RequestMethod.GET)
    public Map<String, Object> getOrdersList(@RequestParam Map<String, Object> map, Model model, Principal principal) {
    	// 로그인한 사용자 아이디 추가
        String userId = principal.getName(); 
        model.addAttribute("userId", userId);
    	// 페이지 번호와 페이지 크기를 기본값으로 설정 (1페이지, 10개 항목)
        if (!map.containsKey("pageNum")) {
            map.put("pageNum", "1");
        }
        if (!map.containsKey("pageSize")) {
            map.put("pageSize", "10");
        }
        map.put("userId", userId);
        
        map.putIfAbsent("productId", "");
        map.putIfAbsent("productName", "");
        map.putIfAbsent("supplierId", "");
        map.putIfAbsent("supplierName", "");

        // 발주 목록과 페이징 정보를 조회
        Map<String, Object> resultMap = receivingService.getOrdersList(map);
        
        // 조회된 발주 목록과 페이징 정보를 모델에 추가
        model.addAttribute("pager", resultMap.get("pager"));
        model.addAttribute("ordersList", resultMap.get("ordersList"));
        model.addAttribute("searchMap", map);
        
        return resultMap;  
    }
    
    // 입고 목록 페이지 - 구매팀 ROLE만 접근 가능
    @PreAuthorize("hasRole('ROLE_PURCHASING_TEAM')")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listReceiving( @RequestParam(required = false) String receivingStatus,@RequestParam Map<String, Object> map
    		, Model model, Principal principal) {
    	
    	 // receivingStatus 값 확인 로그
        //System.out.println("receivingStatus: " + receivingStatus);
        
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
        map.putIfAbsent("receivingId", "");
        map.putIfAbsent("receivingDate", "");
        map.putIfAbsent("ordersId", "");
        map.putIfAbsent("name", "");      
        map.putIfAbsent("productId", "");
        map.putIfAbsent("productName", "");   
        map.putIfAbsent("brand", "");        
        map.putIfAbsent("supplierId", "");
        map.putIfAbsent("deliveryDate", "");
        map.putIfAbsent("warehouseId", "");
        map.putIfAbsent("warehouseName", "");
        
        map.put("receivingStatus", receivingStatus != null ? receivingStatus : "");
 
        // 입고 목록 조회 (페이징 처리 및 검색 포함)
        Map<String, Object> resultMap = receivingService.getReceivingList(map);

        // 조회된 입고 목록과 페이징 정보를 모델에 추가
        model.addAttribute("pager", resultMap.get("pager"));
        model.addAttribute("receivingList", resultMap.get("receivingList"));
        model.addAttribute("searchMap", map);
        
        // 공급 업체 목록 추가 (검색 필터에 사용)
        List<Supplier> supplierList = receivingService.getSupplierList();
        model.addAttribute("supplierList", supplierList);
        
        // 창고 목록 추가 (검색 필터에 사용)
        List<Warehouse> warehouseList = receivingService.getWarehouseList();
        model.addAttribute("warehouseList", warehouseList);
        
        return "purchase/receiving/receiving_list"; // 입고 목록 페이지 뷰로 이동
    }
    
    @PreAuthorize("hasRole('ROLE_PURCHASING_TEAM')")
    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String modifyReceiving(@RequestBody Map<String, Object> params, Principal principal, Model model) 
            throws UnsupportedEncodingException {

        // 로그인한 사용자 아이디 추가
        String userId = principal.getName();
        model.addAttribute("userId", userId);

        // 요청에서 receivingId 추출
        int receivingId = Integer.parseInt(params.get("receivingId").toString());

        // 요청에서 quantity 추출
        int quantity = Integer.parseInt(params.get("quantity").toString());

        // Receiving 객체 생성 후 receivingId, quantity, receivingStatus 설정
        Receiving receiving = new Receiving();
        receiving.setReceivingId(receivingId);
        receiving.setQuantity(quantity);  // 수량 설정
        receiving.setReceivingStatus(4);  // 입고 완료 상태로 설정

        // 입고 정보 수정 서비스 호출
        receivingService.modifyReceiving(receiving);

        // 페이징 정보와 검색 조건 유지
        String pageNum = params.get("pageNum") != null ? params.get("pageNum").toString() : "1";
        String pageSize = params.get("pageSize") != null ? params.get("pageSize").toString() : "10";

        // 개별 검색 조건 추출
        String receivingIdParam = params.containsKey("receivingId") ? URLEncoder.encode(params.get("receivingId").toString(), "UTF-8") : "";
        String receivingDate = params.containsKey("receivingDate") ? URLEncoder.encode(params.get("receivingDate").toString(), "UTF-8") : "";
        String ordersId = params.containsKey("ordersId") ? URLEncoder.encode(params.get("ordersId").toString(), "UTF-8") : "";
        String name = params.containsKey("name") ? URLEncoder.encode(params.get("name").toString(), "UTF-8") : "";
        String productId = params.containsKey("productId") ? URLEncoder.encode(params.get("productId").toString(), "UTF-8") : "";
        String productName = params.containsKey("productName") ? URLEncoder.encode(params.get("productName").toString(), "UTF-8") : "";
        String brand = params.containsKey("brand") ? URLEncoder.encode(params.get("brand").toString(), "UTF-8") : "";
        String supplierId = params.containsKey("supplierId") ? URLEncoder.encode(params.get("supplierId").toString(), "UTF-8") : "";
        String deliveryDate = params.containsKey("deliveryDate") ? URLEncoder.encode(params.get("deliveryDate").toString(), "UTF-8") : "";
        String warehouseId = params.containsKey("warehouseId") ? URLEncoder.encode(params.get("warehouseId").toString(), "UTF-8") : "";
        String warehouseName = params.containsKey("warehouseName") ? URLEncoder.encode(params.get("warehouseName").toString(), "UTF-8") : "";
        String receivingStatus = params.containsKey("receivingStatus") ? URLEncoder.encode(params.get("receivingStatus").toString(), "UTF-8") : "";

        // 리다이렉트할 URL을 구성
        String redirectUrl = "/purchase/receiving/list?pageNum=" + pageNum + "&pageSize=" + pageSize
                + "&receivingId=" + receivingIdParam
                + "&receivingDate=" + receivingDate
                + "&ordersId=" + ordersId
                + "&name=" + name
                + "&productId=" + productId
                + "&productName=" + productName
                + "&brand=" + brand
                + "&supplierId=" + supplierId
                + "&deliveryDate=" + deliveryDate
                + "&warehouseId=" + warehouseId
                + "&warehouseName=" + warehouseName
                + "&receivingStatus=" + receivingStatus;

        // 리다이렉트 처리
        return "redirect:" + redirectUrl;
    }
   
    @PreAuthorize("hasRole('ROLE_PURCHASING_TEAM')")
    @RequestMapping(value = "/confirm", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> confirmReceiving(@RequestParam("receivingId") int receivingId) {
        
        // 입고 상태를 5로 변경하는 서비스 호출
        receivingService.modifyReceivingStatus(receivingId);

        // 상태 변경이 성공하면 OK 응답을 반환
        return ResponseEntity.ok("상태가 5로 변경되었습니다.");
    }

}