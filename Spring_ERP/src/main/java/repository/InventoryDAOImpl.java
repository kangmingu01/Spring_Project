package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.Inventory;
import lombok.RequiredArgsConstructor;
import mapper.InventoryMapper;

@Repository
@RequiredArgsConstructor
public class InventoryDAOImpl implements InventoryDAO{
	private final SqlSession sqlSession;
	
	@Override
	public int insertInventory(Inventory inventory) {
		return sqlSession.getMapper(InventoryMapper.class).insertInventory(inventory);
	}

	@Override
	public int updateInventory(Inventory inventory) {
		return sqlSession.getMapper(InventoryMapper.class).updateInventory(inventory);
	}

	@Override
	public int deleteInventory(int inventoryId) {
		return sqlSession.getMapper(InventoryMapper.class).deleteInventory(inventoryId);
	}

	@Override
	public List<Inventory> selectProductInventoryList() {
		return sqlSession.getMapper(InventoryMapper.class).selectProductInventoryList();
	}

	@Override
	public int selectProductInventoryCount(Map<String, Object> map) {
		return sqlSession.getMapper(InventoryMapper.class).selectProductInventoryCount(map);		
	}

	@Override
	public List<Inventory> selectProductInventoryPageList(Map<String, Object> map) {	
		return sqlSession.getMapper(InventoryMapper.class).selectProductInventoryPageList(map);
	}

	@Override
	public int selectProductInventoryDamageCount(Map<String, Object> map) {
		return sqlSession.getMapper(InventoryMapper.class).selectProductInventoryDamageCount(map);
	}
	
	@Override
	public List<Inventory> selectProductInventoryDamagePageList(Map<String, Object> map) {
		return sqlSession.getMapper(InventoryMapper.class).selectProductInventoryDamagePageList(map);
	}

	@Override
	public Inventory selectProductInventoryUpdate(int inventoryId) {
		return sqlSession.getMapper(InventoryMapper.class).selectProductInventoryUpdate(inventoryId);
	}

	@Override
	public int selectProductInventoryQtyCount(Map<String, Object> map) {
		return sqlSession.getMapper(InventoryMapper.class).selectProductInventoryQtyCount(map);		
	}

	@Override
	public List<Inventory> selectProductInventoryQtyPageList(Map<String, Object> map) {
		return sqlSession.getMapper(InventoryMapper.class).selectProductInventoryQtyPageList(map);		
	}

}
