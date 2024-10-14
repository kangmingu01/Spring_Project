package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.Sales;
import dto.SalesRequest;
import lombok.RequiredArgsConstructor;
import mapper.SalesRequestMapper;

@Repository
@RequiredArgsConstructor

public class SalesRequestDAOImpl  implements SalesRequestDAO{
	private final SqlSession sqlSession;
	
	@Override
	public int insertSalesRequest(SalesRequest salesRequest) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesRequestMapper.class).insertSalesRequest(salesRequest);
	}

	@Override
//	public int updateSalesRequest(List<SalesRequest> salesRequests) {
		public int updateSalesRequest(SalesRequest salesRequests) {
		System.out.println("DAO"+salesRequests);
	
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesRequestMapper.class).updateSalesRequest(salesRequests);
	}

	@Override
	public int deleteSalesRequest(SalesRequest salesRequest) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesRequestMapper.class).deleteSalesRequest(salesRequest);
	}



	@Override
	public int insertSalesList(List<Sales> salesList) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesRequestMapper.class).insertSalesList(salesList);
	}

	@Override
	public SalesRequest selectSalesReqeustById(int requestId) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesRequestMapper.class).selectSalesReqeustById(requestId);
	}

	@Override
	public int selectSalesRequestByCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesRequestMapper.class).selectSalesRequestByCount(map);
	}

	@Override
	public List<SalesRequest> selectSalesRequestList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesRequestMapper.class).selectSalesRequestList(map);
	}



}
