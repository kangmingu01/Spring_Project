package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.Product;
import lombok.RequiredArgsConstructor;
import mapper.ProductMapper;

@Repository
@RequiredArgsConstructor
public class ProductDAOImpl implements ProductDAO {
	private final SqlSession sqlSession;

	@Override
	public int insertProduct(Product product) {
		return sqlSession.getMapper(ProductMapper.class).insertProduct(product);
	}

	@Override
	public int updateProduct(Product product) {
		return sqlSession.getMapper(ProductMapper.class).updateProduct(product);
	}

	@Override
	public int deleteProduct(int productId) {
		return sqlSession.getMapper(ProductMapper.class).deleteProduct(productId);
	}

	@Override
	public Product selectProductUpdate(int productId) {
		return sqlSession.getMapper(ProductMapper.class).selectProductUpdate(productId);
	}
	
	@Override
	public List<Product> selectProductAll() {
		return sqlSession.getMapper(ProductMapper.class).selectProductAll();	
	}

	@Override
	public List<Product> selectProductKeyList(Map<String, Object> map) {
		return sqlSession.getMapper(ProductMapper.class).selectProductKeyList(map);	
	}

	@Override
	public int selcetProductCount(Map<String, Object> map) {
		return sqlSession.getMapper(ProductMapper.class).selcetProductCount(map);	
	}

}
