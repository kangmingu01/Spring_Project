package service;

import java.util.List;
import java.util.Map;

import dto.Product;

public interface ProductService {
	void addProduct(Product product);
	void modifyProduct(Product product);
	void removeProduct(int productId);
	Product getProductUpdate(int productId);
	List<Product> getProductListAll();
	Map<String, Object> getselectProductKeyList(Map<String, Object> map);
}
