package controller;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import dto.History;
import dto.Inventory;
import lombok.RequiredArgsConstructor;
import service.ChartService;

@RestController
@RequestMapping("/inventory")
@RequiredArgsConstructor
public class ChartController {
	private final ChartService chartService;
	
	@GetMapping("/inventory_chart")
	public List<Inventory> chartList(){
		return chartService.getselectChartAll();
	}
	@GetMapping("/inventory_chartInOut")
	public List<History> chartListInOut(){
		return chartService.getselectChartInOutAll();
	}
	
	@GetMapping("/inventory_sales")
	public List<Map<String, Object>> salesChart(){
		return chartService.getselectSalesChart();
	}
	
	@GetMapping("/inventory_sales_product")
	public List<Map<String, Object>> salesProduct(){
		return chartService.getselectSalesProduct();		
	}
	
	@GetMapping("/inventory_warehouse_space")
	public List<Map<String, Object>> WarehouseSpace(){
		return chartService.getselectWarehouseSpace();				
	}
	
}
