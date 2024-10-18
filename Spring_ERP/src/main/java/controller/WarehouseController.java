package controller;

import java.util.Map;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import dto.Warehouse;
import lombok.RequiredArgsConstructor;
import service.WarehouseService;

@RestController
@RequestMapping("/inventory")
@RequiredArgsConstructor
public class WarehouseController {
	private final WarehouseService warehouseService;

	@GetMapping("/warehouse_list")
	public Map<String, Object> warehouseList(@RequestParam Map<String, Object> map ) {
		return warehouseService.getselectProductKeyList(map);
		//return warehouseService.getWarehouseListAll();
	}
	
	@PostMapping("/warehouse_add")
	public String addWarehouse(@RequestBody Warehouse warehouse) {
		warehouseService.addWarehouse(warehouse);
		return "success";
	}
	
	@DeleteMapping("/warehouse_remove/{warehouseId}")
	public String removeWarehouse(@PathVariable int warehouseId) {
		warehouseService.removeWarehouse(warehouseId);
		return "success";
	}
	
}
