package service;

import java.util.List;
import java.util.Map;

import dto.Inventory;

public interface InventoryService {
	void addInventory(Inventory inventory);
	void modifyInventory(Inventory inventory);
	void removeInventory(int inventoryId);
	List<Inventory>	getProductInventoryList();
	Map<String, Object>  getselectProductInventoryPageList(Map<String, Object> map);
	//Map<String, Object> getselectProductInventoryPageList(int pageNum, int pageSize);
	//수정 선택
	Inventory getselectProductInventoryUpdate(int inventoryId);
	//파손수량
	Map<String, Object> getselectProductInventoryDamagePageList(Map<String, Object> map);
	//수량 부족
	Map<String, Object> getselectProductInventoryQtyPageList(Map<String, Object> map);
}
