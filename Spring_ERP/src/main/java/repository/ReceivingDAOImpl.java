package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.Orders;
import dto.Receiving;
import dto.Supplier;
import dto.Warehouse;
import lombok.RequiredArgsConstructor;
import mapper.ReceivingMapper;

@Repository
@RequiredArgsConstructor
public class ReceivingDAOImpl implements ReceivingDAO {
	private final SqlSession sqlSession;
	
	@Override
	public int insertReceiving(Receiving receiving) {
		return sqlSession.getMapper(ReceivingMapper.class).insertReceiving(receiving);
	}

	@Override
	public int selectOrdersCount(Map<String, Object> map) {
		return sqlSession.getMapper(ReceivingMapper.class).selectOrdersCount(map);
	}

	@Override
	public List<Orders> selectOrdersList(Map<String, Object> map) {
		return sqlSession.getMapper(ReceivingMapper.class).selectOrdersList(map);
	}

	@Override
	public List<Warehouse> selectWarehouseList() {
		return sqlSession.getMapper(ReceivingMapper.class).selectWarehouseList();
	}

	@Override
	public Receiving selectReceivingById(int receivingId) {
		return sqlSession.getMapper(ReceivingMapper.class).selectReceivingById(receivingId);
	}

	@Override
	public int selectReceivingCount(Map<String, Object> map) {
		return sqlSession.getMapper(ReceivingMapper.class).selectReceivingCount(map);
	}

	@Override
	public List<Receiving> selectReceivingList(Map<String, Object> map) {
		return sqlSession.getMapper(ReceivingMapper.class).selectReceivingList(map);
	}

	@Override
	public int updateReceiving(Receiving receiving) {
		return sqlSession.getMapper(ReceivingMapper.class).updateReceiving(receiving);
	}

	@Override
	public List<Supplier> selectSupplierList() {
		return sqlSession.getMapper(ReceivingMapper.class).selectSupplierList();
	}

	@Override
	public int confirmReceiving(int receivingId) {
		return sqlSession.getMapper(ReceivingMapper.class).confirmReceiving(receivingId);
	}

}
