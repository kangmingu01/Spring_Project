package repository;

import java.util.List;

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
	public List<Product> selectProductListAll() {
		return sqlSession.getMapper(ProductMapper.class).selectProductAll();	
	}

}
