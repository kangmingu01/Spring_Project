package controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
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
	
	@Autowired
    private ResourceLoader resourceLoader; // ResourceLoader 주입
	
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
	
	
	@GetMapping("/inventoryconvertCategory")
	public Map<String, String> convertCategory(@RequestParam String categoryCode) throws IOException {
	    Properties properties = new Properties();
	    Resource resource = resourceLoader.getResource("classpath:products_category.properties");
	    
	    try (InputStream input = resource.getInputStream()) {
	        properties.load(input);
	    }

	    // categoryCode를 나눠서 변환 작업 수행
	    String brand = properties.getProperty(categoryCode.substring(0, 2), "N/A"); // 'brand'
	    String item = properties.getProperty(categoryCode.substring(2, 4), "N/A");  // 'item'
	    String color = properties.getProperty(categoryCode.substring(4, 6), "N/A");  // 'color'
	    String size = categoryCode.substring(6, 9); // '270' 그대로 사용
	    String gender = properties.getProperty(categoryCode.substring(9), "N/A"); // 기본값으로 "N/A" 설정

	    // 결과를 Map에 담아서 반환
	    Map<String, String> result = new HashMap<>();
	    result.put("brand", brand);
	    result.put("item", item);
	    result.put("color", color);
	    result.put("size", size);
	    result.put("gender", gender);

	    return result;
	}
	 
}
