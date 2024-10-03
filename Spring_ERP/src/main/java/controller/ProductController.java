package controller;

import java.util.List;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import dto.Product;
import lombok.RequiredArgsConstructor;
import service.ProductService;

@RestController
@RequestMapping("/inventory")
@RequiredArgsConstructor
public class ProductController {
	private final ProductService productService;
	
	@PostMapping("/add")
	public String productAdd(@RequestBody Product product) {
		productService.addProduct(product);
		return "success";
	}
	@PutMapping("/modify")
	public String productModify(@RequestBody Product product) {
		productService.modifyProduct(product);
		return "success";
	}
	
	@DeleteMapping("/remove/{idx}")
	public String productRemvoe(@PathVariable int idx) {
		productService.removeProduct(idx);
		return "success";
	}
	
	@GetMapping("/list")
	public List<Product> productView() {
		return productService.getProductListAll();
	}
}
