package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.Sales;
import lombok.RequiredArgsConstructor;
import mapper.SalesMapper;

@Repository
@RequiredArgsConstructor
public class SalesDAOImpl  implements SalesDAO{
	private final SqlSession sqlSession;
	
	
	
	
	@Override
	public int insertSalesList(Sales sales) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesMapper.class).insertSalesList(sales);
	}

	@Override
	public int updateSales(Sales sales) {
		System.out.println("DAO = "+sales);
		return sqlSession.getMapper(SalesMapper.class).updateSales(sales);
	}

	@Override
	public int updateSalesStatus(Sales sales) {
		
		return sqlSession.getMapper(SalesMapper.class).updateSalesStatus(sales);
	}

	@Override
	public int deleteSales(Sales sales) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesMapper.class).deleteSales(sales);
	}

	@Override
	public int insertSalesList(List<Sales> salesList) {
		
		return sqlSession.getMapper(SalesMapper.class).insertSalesList(salesList);
	}

	@Override
	public Sales selectSalesById(int salesId) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesMapper.class).selectSalesById(salesId);
	}

	@Override
	public int selectSalesByCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesMapper.class).selectSalesByCount(map);
	}

	@Override
	public List<Sales> selectSalesList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesMapper.class).selectSalesList(map);
	}

}
