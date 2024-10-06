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
	Orders getOrdersById(int ordersId);
	Map<String, Object> getOrdersList(Map<String, Object> map);
	void modifyOrders(Orders orders);
    int modifyOrdersStatus(int ordersId);
	
}
