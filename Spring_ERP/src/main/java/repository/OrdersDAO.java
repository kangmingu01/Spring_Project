package repository;

import java.util.List;
import java.util.Map;

import dto.Orders;
import dto.Product;
import dto.Supplier;

public interface OrdersDAO {
	int insertOrders(Orders orders);
	int selectProductCount(Map<String, Object> map);
	List<Product> selectProductList(Map<String, Object> map);
	List<Supplier> selectSupplierList();
	//List<Supplier> selectSupplierListByKeyword(String keyword);
	List<Orders> selectOrdersList();
	Orders selectOrdersById(int ordersId);	
}
