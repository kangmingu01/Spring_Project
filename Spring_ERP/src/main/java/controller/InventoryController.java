package controller;

import java.util.Map;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import dto.Inventory;
import dto.Product;
import lombok.RequiredArgsConstructor;
import service.InventoryService;

@RestController
@RequestMapping("/inventory")
@RequiredArgsConstructor
public class InventoryController {
	private final InventoryService inventoryService;
	
	@GetMapping("/inventory_list")
	public Map<String, Object> inventoryProductList(@RequestParam Map<String, Object> map){
		return inventoryService.getselectProductInventoryPageList(map);
	}
	
	@GetMapping("/inventory_damage_list")
	public Map<String, Object> inventoryProductDamageList(@RequestParam Map<String, Object> map){
		return inventoryService.getselectProductInventoryDamagePageList(map);
	}
	
	@GetMapping("/inventory_qty_list")
	public Map<String, Object> inventoryProductQtyList(@RequestParam Map<String, Object> map){
		return inventoryService.getselectProductInventoryQtyPageList(map);
	}
	
	
	@GetMapping("/inventory_modify_view/{inventoryId}")
	public Inventory inventoryModifyView(@PathVariable int inventoryId) {
		return inventoryService.getselectProductInventoryUpdate(inventoryId);
	}
	
	@PostMapping("/inventory_add")
	public String inventoryadd(@RequestBody Inventory inventory) {
		inventoryService.addInventory(inventory);
		return "success";
	}
	
	@PutMapping("/inventory_modify")
	public String inventoryModify(@RequestBody Inventory inventory) {
		inventoryService.modifyInventory(inventory);
		return "success";
	}
	
	@DeleteMapping("/inventory_remove/{idx}")
	public String productRemvoe(@PathVariable int idx) {
		inventoryService.removeInventory(idx);
		return "success";
	}
	
}
