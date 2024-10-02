package mapper;

import dto.Product;

public interface ProductMapper {
	int insertProduct(Product product);
	int updateProduct(Product product);
	int deleteProduct(int productId);
	//selectProductAll()
	
	
}
