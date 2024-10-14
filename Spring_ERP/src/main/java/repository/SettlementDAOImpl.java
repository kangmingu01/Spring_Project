package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.Receiving;
import dto.Settlement;
import dto.Supplier;
import lombok.RequiredArgsConstructor;
import mapper.SettlementMapper;

@Repository
@RequiredArgsConstructor
public class SettlementDAOImpl implements SettlementDAO {
	private final SqlSession sqlSession;

	@Override
	public int selectSettlementCount(Map<String, Object> map) {
		return sqlSession.getMapper(SettlementMapper.class).selectSettlementCount(map);
	}

	@Override
	public List<Settlement> selectSettlementList(Map<String, Object> map) {
		return sqlSession.getMapper(SettlementMapper.class).selectSettlementList(map);
	}

	@Override
	public List<Supplier> selectSupplierList() {
		return sqlSession.getMapper(SettlementMapper.class).selectSupplierList();
	}

	@Override
	public List<Receiving> selectReceivingListByStatus(Receiving receiving) {
		return sqlSession.getMapper(SettlementMapper.class).selectReceivingListByStatus(receiving);
	}

	@Override
	public int insertSettlement(Settlement settlement) {
		return sqlSession.getMapper(SettlementMapper.class).insertSettlement(settlement);
	}

}