package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.History;
import lombok.RequiredArgsConstructor;
import mapper.HistoryMapper;

@Repository
@RequiredArgsConstructor
public class HistoryDAOImpl implements HistoryDAO{
	private final SqlSession sqlSession;
	
	@Override
	public int insertHistory(History history) {
		return sqlSession.getMapper(HistoryMapper.class).insertHistory(history);
	}

	@Override
	public int updateHistory(History history) {
		return sqlSession.getMapper(HistoryMapper.class).updateHistory(history);
	}

	@Override
	public int deleteProduct(int historyId) {
		return sqlSession.getMapper(HistoryMapper.class).deleteProduct(historyId);
	}

	@Override
	public int selectHistoryProductWarehouseCount(Map<String, Object> map) {
		return sqlSession.getMapper(HistoryMapper.class).selectHistoryProductWarehouseCount(map);
	}

	@Override
	public List<History> selectHistoryProductWarehouseList(Map<String, Object> map) {
		return sqlSession.getMapper(HistoryMapper.class).selectHistoryProductWarehouseList(map);
	}

	@Override
	public History selectHistoryUpdate(int historyId) {
		return sqlSession.getMapper(HistoryMapper.class).selectHistoryUpdate(historyId);
	} 
}
