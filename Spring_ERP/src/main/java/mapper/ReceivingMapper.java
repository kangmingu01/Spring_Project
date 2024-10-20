package mapper;

import java.util.List;
import java.util.Map;

import dto.Orders;
import dto.Receiving;
import dto.Supplier;
import dto.Warehouse;

public interface ReceivingMapper {
	int insertReceiving(Receiving receiving);
	int selectOrdersCount(Map<String, Object> map);
	List<Orders> selectOrdersList(Map<String, Object> map);
	List<Warehouse> selectWarehouseList();
	Receiving selectReceivingById(int receivingId);
	int selectReceivingCount(Map<String, Object> map);
	List<Receiving> selectReceivingList(Map<String, Object> map);
	int updateReceiving(Receiving receiving);
	List<Supplier> selectSupplierList();
}
