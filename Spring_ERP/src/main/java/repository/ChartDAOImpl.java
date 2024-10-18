package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.History;
import dto.Inventory;
import lombok.RequiredArgsConstructor;
import mapper.ChartMapper;

@Repository
@RequiredArgsConstructor
public class ChartDAOImpl implements ChartDAO {
	private final SqlSession sqlSession;
	
	@Override
	public List<Inventory> selectChartAll() {
		return sqlSession.getMapper(ChartMapper.class).selectChartAll();
	}

	@Override
	public List<History> selectChartInOut() {
		return sqlSession.getMapper(ChartMapper.class).selectChartInOut();
	}

	@Override
	public List<Map<String, Object>> selectSalesChart() {
		return sqlSession.getMapper(ChartMapper.class).selectSalesChart();
	}

	@Override
	public List<Map<String, Object>> selectSalesProduct() {
		return sqlSession.getMapper(ChartMapper.class).selectSalesProduct();
	}

	@Override
	public List<Map<String, Object>> selectWarehouseSpace() {
		return sqlSession.getMapper(ChartMapper.class).selectWarehouseSpace();
	}

}
