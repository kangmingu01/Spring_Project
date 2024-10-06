package service;

import java.util.List;
import java.util.Map;

import dto.Orders;
import dto.Supplier;

public interface OrdersService {
	void addOrders(Orders orders);
	Map<String, Object> getProductList(Map<String, Object> map);
	List<Supplier> getSupplierList();
	//List<Supplier> getSupplierListByKeyword(String keyword);
	List<Orders> getAllOrders();
	Orders getOrdersById(int ordersId);
	
}
