package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.SalesRequest;
import lombok.RequiredArgsConstructor;
import mapper.SalesRequestStatusMapper;


@Repository
@RequiredArgsConstructor
public class SalesRequestStatusDAOImpl implements SalesRequestStatusDAO{
	private final SqlSession sqlSession;
	@Override
	public int insertSalesRequestToSales(SalesRequest salesRequests) {
		return sqlSession.getMapper(SalesRequestStatusMapper.class).insertSalesRequestToSales(salesRequests);
	}
	@Override
	public int updateSalesRequestStatus(SalesRequest salesRequests) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesRequestStatusMapper.class).updateSalesRequestStatus(salesRequests);
	}
	@Override
	public List<SalesRequest> selectSalesRequestListStatus(Map<String, Object> map) {
		return sqlSession.getMapper(SalesRequestStatusMapper.class).selectSalesRequestListStatus(map);
	}
	@Override
	public SalesRequest selectSalesReqeustStatusById(int requestId) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesRequestStatusMapper.class).selectSalesReqeustStatusById(requestId);
	}	
	@Override
	public int selectSalesRequestStatusByCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesRequestStatusMapper.class).selectSalesRequestStatusByCount(map);
	}


}
