package controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dto.SalesRequest;
import lombok.RequiredArgsConstructor;
import service.SalesRequestService;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor
public class SalesRequestController {
	private final SalesRequestService requestService;
	
	@RequestMapping("/requestList")
	public String request(@RequestParam Map<String,Object> map, Model model) {
		model.addAttribute("resultMap",requestService.getSalesRequestList(map));
		model.addAttribute("searchMap",map);
		return "request/request";
	
	}
    @PostMapping("/modifySalesRequests")
    public String modifySalesRequests(@RequestBody List<SalesRequest> salesRequests) {
    	requestService.modifySalesRequest(salesRequests);
    	 return "redirect:/requestList";
    }
	
	
}
