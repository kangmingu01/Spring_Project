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

import dto.Product;
import lombok.RequiredArgsConstructor;
import service.ProductService;

@RestController
@RequestMapping("/inventory")
@RequiredArgsConstructor
public class ProductController {
	private final ProductService productService;
	
//	@GetMapping("/product_list")
//	public List<Product> productListAll() {
//		return productService.getProductListAll();
//	}
	/*
	@GetMapping("/product_list")
	public Map<String, Object> getproductKeyList(@RequestParam(defaultValue = "1") int pageNum
			, @RequestParam(defaultValue = "10") int pageSize
			, @RequestParam(defaultValue = "") String search
			, @RequestParam(defaultValue = "") String keyword
			, @RequestParam Map<String, Object> map) {
		
		map.put("pageNum", String.valueOf(pageNum));  
	    map.put("pageSize", String.valueOf(pageSize));
	    map.put("search", search);
	    map.put("keyword", keyword);
		
	    return productService.getselectProductKeyList(map);
	}
	*/
	@GetMapping("/product_list")
	public Map<String, Object> getproductKeyList(@RequestParam Map<String, Object> map) {
		return productService.getselectProductKeyList(map);
	}
	 
	@PostMapping("/product_add")
	public String productAdd(@RequestBody Product product) {
		productService.addProduct(product);
		return "success";
	}
	
	@GetMapping("/product_modify_view/{productId}")
	public Product productModifyView(@PathVariable int productId) {
		return productService.getProductUpdate(productId);
	}
	
	@PutMapping("/product_modify")
	public String productModify(@RequestBody Product product) {
		productService.modifyProduct(product);
		return "success";
	}
	
	@DeleteMapping("/product_remove/{idx}")
	public String productRemvoe(@PathVariable int idx) {
		productService.removeProduct(idx);
		return "success";
	}
	
	
}
