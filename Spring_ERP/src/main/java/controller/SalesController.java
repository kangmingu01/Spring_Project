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

import dto.Sales;
import dto.SalesWrapper;
import lombok.RequiredArgsConstructor;
import service.SalesService;


@Controller
@RequestMapping("/sales")
@RequiredArgsConstructor
public class SalesController {
	
	private final SalesService salesService;
	
	// 본사 직원이 실 주문 관리 하는 페이
	 @PreAuthorize("hasRole('ROLE_SUPER_ADMINISTRATOR')")
	@RequestMapping(value = "/saleList", method = RequestMethod.GET)
	public String sales(@RequestParam Map<String, Object> map, Model model,Principal principal) {
		 String userId=principal.getName();
		 model.addAttribute("userId", userId);
		   if (!map.containsKey("pageNum")) {
	            map.put("pageNum", "1");
	        }
	        if (!map.containsKey("pageSize")) {
	            map.put("pageSize", "10");
	        }
		Map<String, Object> resultMap = salesService.getSalesList(map);
		System.out.println("Sales List: " + resultMap.get("salesList"));
		 model.addAttribute("pager", resultMap.get("pager"));// Add this line to debug
		model.addAttribute("resultMap", resultMap);
		model.addAttribute("searchMap", map);
		return "sales/sales/sales";
	}
	@PostMapping("/modifySales")
	public String modifySales(@ModelAttribute SalesWrapper salesList) {
		List<Sales> sales = salesList.getSalesList();
	System.out.println("Received salesList: " + sales);
		salesService.modifySales(sales);
		return "redirect:/sales/saleList";  // 수정 후 리다이렉트
	}
	@PostMapping("/modifySalesStatus")
	public String modifySalesStatus(@ModelAttribute SalesWrapper salesList) {
		List<Sales> sales = salesList.getSalesList();
		System.out.println("Received salesList: " + sales);
		salesService.modifySalesStatus(sales);
		return "redirect:/sales/saleList";  // 수정 후 리다이렉트
	}

}
