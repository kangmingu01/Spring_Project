package service;

import java.util.List;
import java.util.Map;

import dto.Warehouse;


public interface WarehouseService {
	void addWarehouse(Warehouse warehouse);
	void modifyWarehouse(Warehouse warehouse);
	void removeWarehouse(int warehouseId);
	List<Warehouse> getWarehouseListAll();
	Map<String, Object> getselectProductKeyList(Map<String, Object> map);
}
