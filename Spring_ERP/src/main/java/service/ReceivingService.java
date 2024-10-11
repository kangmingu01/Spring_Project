package service;

import java.util.List;
import java.util.Map;

import dto.Receiving;
import dto.Warehouse;

public interface ReceivingService {
	void addReceiving(Receiving receiving);
	Map<String, Object> getOrdersList(Map<String, Object> map);
	List<Warehouse> getWarehouseList();
	Receiving getReceivingById(int receivingId);
	Map<String, Object> getReceivingList(Map<String, Object> map);
	void modifyReceiving(Receiving receiving);
	
}
