package service;

import java.util.List;

import dto.Product;

public interface ProductService {
	void addProduct(Product product);
	void modifyProduct(Product product);
	void removeProduct(int productId);
	List<Product> getProductListAll();
}
