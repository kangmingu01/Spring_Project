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
	Orders selectOrdersById(int ordersId);
	int selectOrdersCount(Map<String, Object> map);
	List<Orders> selectOrdersList(Map<String, Object> map);
	int updateOrders(Orders orders);
	int updateOrdersStatus(int ordersId);  	
}
