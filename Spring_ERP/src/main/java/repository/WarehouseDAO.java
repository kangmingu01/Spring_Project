package repository;

import java.util.List;
import java.util.Map;

import dto.Warehouse;

public interface WarehouseDAO {
	int insertWarehouse(Warehouse warehouse);
	int updateWarehouse(Warehouse warehouse);
	int deleteWarehouse(int warehouseId);
	Warehouse selectWarehouseUpdate(int warehouseId);
	int selcetWarehouseCount(Map<String, Object> map);
	List<Warehouse>selectWarehouseKeyList(Map<String, Object> map);
	List<Warehouse> selectWarehouseAll();
}
