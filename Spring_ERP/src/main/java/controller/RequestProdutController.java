package controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import dto.ErpUser;
import dto.RequestProdut;
import lombok.RequiredArgsConstructor;
import service.ErpUserService;
import service.RequestProdutService;

@Controller
@RequestMapping("/request")
@RequiredArgsConstructor

public class RequestProdutController {
	
	private final RequestProdutService requestProductService;
	private final ErpUserService erpUserService;
	
	
	
	 @PreAuthorize("hasRole('ROLE_STORE_TEAM')")
	@RequestMapping(value = "/requestproduct", method = RequestMethod.GET)
	public String list( @RequestParam Map<String, Object> map, Model model,Principal principal ) {
		 String userId=principal.getName();
		 model.addAttribute("userId", userId);
		 String orgId=erpUserService.getOrgIdByUserId(userId);
		    map.put("orgId", orgId);
		if (!map.containsKey("pageNum")) {
	            map.put("pageNum", "1");
	        }
	        if (!map.containsKey("pageSize")) {
	            map.put("pageSize", "10");
	        }
 
		Map<String,Object> resultMap=requestProductService.getSalesRequest(map);
		model.addAttribute("pager", resultMap.get("pager"));
		model.addAttribute("productList", resultMap.get("productList"));
	  
	    model.addAttribute("searchMap", map); 
		return "sales/request/requestproduct";
		
	}
  

    @PostMapping("/insertSalesRequest")
    public String insertSalesRequest(@RequestParam("productIds") List<Integer> productIds) {
        // Retrieve the logged-in user's orgId
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        
      
       String userId = authentication.getName(); // Assuming the orgId is mapped to the user's username
      String orgId=erpUserService.getOrgIdByUserId(userId);
        // Loop through the selected productIds and create salesRequest entries
        for (Integer productId : productIds) {
            RequestProdut salesRequestDTO = new RequestProdut();
            
            salesRequestDTO.setOrgId(orgId);
            salesRequestDTO.setProductId(productId);
           

            requestProductService.addSalesRequest(salesRequestDTO);
        }

        return "redirect:/request/requestList";  // Redirect to a sales request list page after insert
    }
	
}
