package mapper;

import java.util.List;
import java.util.Map;

import dto.Inventory;

public interface InventoryMapper {
	int insertInventory(Inventory inventory);
	int updateInventory(Inventory inventory);
	int deleteInventory(int inventoryId);
	List<Inventory>	selectProductInventoryList();
	int selectProductInventoryCount(Map<String, Object> map);
	List<Inventory> selectProductInventoryPageList(Map<String, Object> map);
	// 수정 선택
	Inventory selectProductInventoryUpdate(int inventoryId);
	//파손 수량
	int selectProductInventoryDamageCount(Map<String, Object> map);
	List<Inventory> selectProductInventoryDamagePageList(Map<String, Object> map);
	//수량 부족
	int selectProductInventoryQtyCount(Map<String, Object> map);
	List<Inventory> selectProductInventoryQtyPageList(Map<String, Object> map);
}
