package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.Product;
import dto.RequestProdut;
import lombok.RequiredArgsConstructor;
import mapper.OrdersMapper;
import mapper.RequestProdutMapper;

@Repository
@RequiredArgsConstructor
public class RequestProdutDAOImpl implements RequestProdutDAO {
	private final SqlSession sqlSession;

	@Override
	public int insertSalesRequest(RequestProdut requestProduct) {
		return sqlSession.getMapper(RequestProdutMapper.class).insertSalesRequest(requestProduct);
		
	}

	@Override
	public List<Product> selectProductList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(RequestProdutMapper.class).selectProductList(map);
	}

	@Override
	public int selectProductCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(OrdersMapper.class).selectProductCount(map);
	}

}
