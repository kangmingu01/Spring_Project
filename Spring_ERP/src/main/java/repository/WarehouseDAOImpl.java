package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.Warehouse;
import lombok.RequiredArgsConstructor;
import mapper.WarehouseMapper;

@Repository
@RequiredArgsConstructor
public class WarehouseDAOImpl implements WarehouseDAO {
	private final SqlSession sqlSession;
	
	@Override
	public int insertWarehouse(Warehouse warehouse) {
		return sqlSession.getMapper(WarehouseMapper.class).insertWarehouse(warehouse);
	}

	@Override
	public int updateWarehouse(Warehouse warehouse) {
		return sqlSession.getMapper(WarehouseMapper.class).updateWarehouse(warehouse);
	}

	@Override
	public int deleteWarehouse(int warehouseId) {
		return sqlSession.getMapper(WarehouseMapper.class).deleteWarehouse(warehouseId);
	}

	@Override
	public Warehouse selectWarehouseUpdate(int warehouseId) {
		return sqlSession.getMapper(WarehouseMapper.class).selectWarehouseUpdate(warehouseId);
	}
	
	@Override
	public List<Warehouse> selectWarehouseAll() {
		return sqlSession.getMapper(WarehouseMapper.class).selectWarehouseAll();
	}

	@Override
	public int selcetWarehouseCount(Map<String, Object> map) {
		return sqlSession.getMapper(WarehouseMapper.class).selcetWarehouseCount(map);
	}

	@Override
	public List<Warehouse> selectWarehouseKeyList(Map<String, Object> map) {
		return sqlSession.getMapper(WarehouseMapper.class).selectWarehouseKeyList(map);
	}	

}
