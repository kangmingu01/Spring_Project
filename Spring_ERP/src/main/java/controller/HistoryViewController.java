package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.RequiredArgsConstructor;
import service.WarehouseService;

@Controller
@RequestMapping("/inventory")
@RequiredArgsConstructor
public class HistoryViewController {
	private final WarehouseService warehouseService;
	
	@RequestMapping(value = "/history", method = RequestMethod.GET)
	public String view( Model model) { 
		model.addAttribute("warehouseNum",warehouseService.getWarehouseListAll());
		System.out.println("model result"+model);
		return "inventory/history";
	}
}
