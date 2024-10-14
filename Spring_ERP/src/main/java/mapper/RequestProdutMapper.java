package mapper;

import java.util.List;
import java.util.Map;

import dto.Product;
import dto.RequestProdut;

public interface RequestProdutMapper {
	int insertSalesRequest(RequestProdut requestProduct);
	int selectProductCount(Map<String, Object> map);
	List<Product> selectProductList(Map<String, Object> map);
}
