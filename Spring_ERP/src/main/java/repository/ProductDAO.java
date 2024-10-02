package repository;

import java.util.List;

import dto.Product;

public interface ProductDAO {
	int insertProduct(Product product);
	int updateProduct(Product product);
	int deleteProduct(int productId);
	List<Product> selectProductListAll();
}
