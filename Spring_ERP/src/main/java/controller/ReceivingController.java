package controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dto.ProductCategory;
import dto.Receiving;
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

    // 발주 목록 조회 (페이징 및 검색 처리)
    @RequestMapping(value = "/ordersList", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getOrdersList(@RequestParam Map<String, Object> map) {
    	// 페이지 번호와 페이지 크기를 기본값으로 설정 (1페이지, 10개 항목)
        if (!map.containsKey("pageNum")) {
            map.put("pageNum", "1");
        }
        if (!map.containsKey("pageSize")) {
            map.put("pageSize", "10");
        }

        // 발주 목록과 페이징 정보를 조회
        Map<String, Object> resultMap = receivingService.getOrdersList(map);
        
        return resultMap;  // JSON 형식으로 데이터 반환
    }
}
