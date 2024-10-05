package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.SalesRequest;
import lombok.RequiredArgsConstructor;
import mapper.SalesRequestMapper;

@Repository
@RequiredArgsConstructor
public class SalesRequestDAOImpl implements SalesRequestDAO {
	private final SqlSession sqlSession;
	@Override
	public int insertSalesRequest(SalesRequest salesRequest) {
		
		return sqlSession.getMapper(SalesRequestMapper.class).insertSalesRequest(salesRequest);
	}



	@Override
	public SalesRequest selectSalesReqeustById(int requestId) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesRequestMapper.class).selectSalesReqeustById(requestId);
	}

	@Override
	public int selectSalesReqeustByCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesRequestMapper.class).selectSalesReqeustByCount(map);
	}

	@Override
	public List<SalesRequest> selectSalesRequestList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesRequestMapper.class).selectSalesRequestList(map);
	}



	@Override
	 public int updateSalesRequest(List<SalesRequest> salesRequests) {
        return sqlSession.getMapper(SalesRequestMapper.class).updateSalesRequest(salesRequests);
    }



	@Override
	public int deleteSalesRequest(SalesRequest salesRequest) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SalesRequestMapper.class).deleteSalesRequest(salesRequest);
	}
	
}
