package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.Supplier;
import lombok.RequiredArgsConstructor;
import mapper.SupplierMapper;

@Repository
@RequiredArgsConstructor
public class SupplierDAOImpl implements SupplierDAO {
	private final SqlSession sqlSession;

	@Override
	public int insertSupplier(Supplier supplier) {
		return sqlSession.getMapper(SupplierMapper.class).insertSupplier(supplier);
	}

	@Override
	public Supplier selectSupplierById(int supplierId) {
		return sqlSession.getMapper(SupplierMapper.class).selectSupplierById(supplierId);
	}

	@Override
	public int updateSupplier(Supplier supplier) {
		return sqlSession.getMapper(SupplierMapper.class).updateSupplier(supplier);
	}

	@Override
	public int selectSupplierCount(Map<String, Object> map) {
		return sqlSession.getMapper(SupplierMapper.class).selectSupplierCount(map);
	}

	@Override
	public List<Supplier> selectSupplierList(Map<String, Object> map) {
		return sqlSession.getMapper(SupplierMapper.class).selectSupplierList(map);
	}

	@Override
	public boolean existsByName(String supplierName) {
		return sqlSession.getMapper(SupplierMapper.class).equals(supplierName);
	}
}
