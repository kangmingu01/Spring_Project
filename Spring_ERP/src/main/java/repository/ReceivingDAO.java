package repository;

import java.util.List;
import java.util.Map;

import dto.Orders;
import dto.Receiving;
import dto.Warehouse;

public interface ReceivingDAO {
	int insertReceiving(Receiving receiving);
	int selectOrdersCount(Map<String, Object> map);
	List<Orders> selectOrdersList(Map<String, Object> map);
	List<Warehouse> selectWarehouseList();
	Receiving selectReceivingById(int receivingId);
}
