package mapper;

import java.util.List;

import dto.Product;

public interface ProductMapper {
	int insertProduct(Product product);
	int updateProduct(Product product);
	int deleteProduct(int productId);
	List<Product> selectProductAll();
}
