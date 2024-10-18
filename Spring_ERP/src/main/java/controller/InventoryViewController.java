package controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import dto.Warehouse;
import lombok.RequiredArgsConstructor;
import service.InventoryService;
import service.ProductService;
import service.WarehouseService;

@Controller
@RequestMapping("/inventory")
@RequiredArgsConstructor
public class InventoryViewController {
	private final InventoryService inventoryService;
	private final ProductService productService;
	private final WarehouseService warehouseService;
	
	//페이지 요청시 모든 전달값을 Map 객체로 제공받아 사용
	@RequestMapping(value = "/list",method = RequestMethod.GET)
	public String view(@RequestParam Map<String, Object> map, Model model) {
		model.addAttribute("warehouseNum",warehouseService.getWarehouseListAll());
		System.out.println("model result"+model);
		return "inventory/inventory";
	}
}
