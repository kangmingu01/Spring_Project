package repository;

import java.util.List;
import java.util.Map;

import dto.Product;

public interface ProductDAO {
	int insertProduct(Product product);
	int updateProduct(Product product);
	int deleteProduct(int productId);
	Product selectProductUpdate(int productId );
	List<Product> selectProductAll();
	int selcetProductCount(Map<String, Object> map);
	List<Product> selectProductKeyList(Map<String, Object> map);
}
