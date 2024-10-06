package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.Orders;
import dto.Product;
import dto.Supplier;
import lombok.RequiredArgsConstructor;
import mapper.OrdersMapper;

@Repository
@RequiredArgsConstructor
public class OrdersDAOImpl implements OrdersDAO{
	private final SqlSession sqlSession;
	
	@Override
	public int insertOrders(Orders orders) {
		return sqlSession.getMapper(OrdersMapper.class).insertOrders(orders);
	}

	@Override
	public int selectProductCount(Map<String, Object> map) {
		return sqlSession.getMapper(OrdersMapper.class).selectProductCount(map);
	}

	@Override
	public List<Product> selectProductList(Map<String, Object> map) {
		return sqlSession.getMapper(OrdersMapper.class).selectProductList(map);
	}

	@Override
	public List<Supplier> selectSupplierList() {
		return sqlSession.getMapper(OrdersMapper.class).selectSupplierList();
	}

	/*
	@Override
	public List<Supplier> selectSupplierListByKeyword(String keyword) {
		return sqlSession.getMapper(OrdersMapper.class).selectSupplierListByKeyword(keyword);
	}
	 */

	@Override
	public List<Orders> selectOrdersList() {
		return sqlSession.getMapper(OrdersMapper.class).selectOrdersList();
	}

	@Override
    public Orders selectOrdersById(int ordersId) {
        return sqlSession.getMapper(OrdersMapper.class).selectOrdersById(ordersId);
    }
	

}
