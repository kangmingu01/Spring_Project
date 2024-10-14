package controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import dto.SalesRequest;
import dto.SalesRequestWrapper;
import lombok.RequiredArgsConstructor;
import service.SalesRequestService;
import service.SalesRequestStatusService;

@Controller
@RequestMapping("/request")
@RequiredArgsConstructor
public class SalesRequestController {
	private final SalesRequestService requestService;
	private final SalesRequestStatusService requestStatusService;

	// 점주들의 요청 페이
	 @PreAuthorize("hasRole('ROLE_SUPER_ADMINISTRATOR')")
	@RequestMapping(value = "/requestList", method = RequestMethod.GET)
	public String request(@RequestParam Map<String, Object> map, Model model,Principal principal) {
		String userId=principal.getName();
		 model.addAttribute("userId", userId);
		   if (!map.containsKey("pageNum")) {
	            map.put("pageNum", "1");
	        }
	        if (!map.containsKey("pageSize")) {
	            map.put("pageSize", "10");
	        }
	        // 검색 필드 기본값 설정
//	        map.putIfAbsent("ordersId", "");
//	        map.putIfAbsent("ordersDate", "");
//	        map.putIfAbsent("name", "");      
//	        map.putIfAbsent("productId", "");
//	        map.putIfAbsent("productName", "");   
//	        map.putIfAbsent("brand", "");        
//	        map.putIfAbsent("supplierId", "");
//	        map.putIfAbsent("ordersStatus", "");
	    Map<String, Object> resultMap = requestService.getSalesRequestList(map);
	    System.out.println("SalesRequest List: " + resultMap.get("salesRequestList"));
	    model.addAttribute("pager", resultMap.get("pager"));// Add this line to debug
	    model.addAttribute("resultMap", resultMap);
	    model.addAttribute("searchMap", map);
	    return "sales/request/request";
	}
	
	// 본사의 판매 관리 직원 페이지 
	 @PreAuthorize("hasRole('ROLE_SUPER_ADMINISTRATOR')")
	@RequestMapping(value = "/saleRequestList", method = RequestMethod.GET)
	public String salesRequest(@RequestParam Map<String, Object> map, Model model,Principal principal) {
		String userId=principal.getName();
		 model.addAttribute("userId", userId);
		   if (!map.containsKey("pageNum")) {
	            map.put("pageNum", "1");
	        }
	        if (!map.containsKey("pageSize")) {
	            map.put("pageSize", "10");
	        }
		Map<String, Object> resultMap = requestStatusService.getSalesRequestStatusList(map);
		System.out.println("SalesRequest List: " + resultMap.get("salesRequestList")); 
		 model.addAttribute("pager", resultMap.get("pager"));// Add this line to debug
		model.addAttribute("resultMap", resultMap);
		model.addAttribute("searchMap", map);
		return "sales/request/requestSales";
	}
	
	
	
	// 판매자가 수량 수문 할때post 방식 불러오는 
	@PostMapping("/modifySalesRequests")
	public String modifySalesRequests(@ModelAttribute SalesRequestWrapper salesRequestWrapper) {
	    List<SalesRequest> salesRequests = salesRequestWrapper.getSalesRequests();
	    System.out.println("Received salesRequests: " + salesRequests);
	    requestService.modifySalesRequest(salesRequests);
	    return "redirect:/request/requestList";  // 수정 후 리다이렉트
	}
	// 본사가 수정 할때 가져오는 
	@PostMapping("/modifySalesRequestsStatus")
	public String modifySalesRequestsStatus(@ModelAttribute SalesRequestWrapper salesRequestWrapper) {
		List<SalesRequest> salesRequests = salesRequestWrapper.getSalesRequests();
//		System.out.println("Received salesRequests: " + salesRequests);
		requestStatusService.modifySalesRequestStatus(salesRequests);
		return "redirect:/request/saleRequestList";  // 수정 후 리다이렉트
	}
	@PostMapping("/addSalesRequestToSales")
	public String addSalesRequestToSales(@ModelAttribute SalesRequestWrapper salesRequestWrapper) {
		List<SalesRequest> salesRequests = salesRequestWrapper.getSalesRequests();
		System.out.println("add Sales: " + salesRequests);
		requestStatusService.addSalesRequestToSales(salesRequests);
		return "redirect:/sales/saleList";  
	}
	 

}
