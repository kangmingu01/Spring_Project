package controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
	
	@Autowired
    private ResourceLoader resourceLoader; // ResourceLoader 주입
	 
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
	public ResponseEntity<String> productRemove(@PathVariable int idx) {
	    try {
	        // 서비스에서 제품 삭제 로직 호출
	        productService.removeProduct(idx);
	        // 성공 시 성공 메시지 반환
	        return ResponseEntity.ok("success");
	    } catch (DataIntegrityViolationException e) {
	        // 외래 키 제약 조건 위반 발생 시 409 Conflict 상태와 메시지 반환
	        if (e.getMessage().contains("ORA-02292")) {
	            return ResponseEntity.status(HttpStatus.CONFLICT)
	                .body("이 제품은 현재 재고에 등록되어있어 삭제할 수 없습니다.");
	        } else {
	            // 그 외의 서버 오류 처리
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                .body("서버에서 문제가 발생했습니다.");
	        }
	    }
	}
	/*
	 * @DeleteMapping("/product_remove/{idx}") public String
	 * productRemvoe(@PathVariable int idx) { productService.removeProduct(idx);
	 * return "success"; }
	 */
	
	@GetMapping("/ProductconvertCategory")
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
