package mapper;

import java.util.List;
import java.util.Map;

import dto.Orders;
import dto.Product;
import dto.Supplier;

public interface OrdersMapper {
	int insertOrders(Orders orders);
	int selectProductCount(Map<String, Object> map);
	List<Product> selectProductList(Map<String, Object> map);
	List<Supplier> selectSupplierList();
	//List<Supplier> selectSupplierListByKeyword(String keyword);
}
