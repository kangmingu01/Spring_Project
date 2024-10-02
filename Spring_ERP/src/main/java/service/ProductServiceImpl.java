package service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.Product;
import lombok.RequiredArgsConstructor;
import repository.ProductDAO;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl  implements ProductService{
	private ProductDAO productDAO;
	
	@Transactional
	@Override
	public void addProduct(Product product) {
		productDAO.insertProduct(product);
	}
	
	@Transactional
	@Override
	public void modifyProduct(Product product) {
		productDAO.updateProduct(product);
	}
	
	@Transactional
	@Override
	public void removeProduct(int productId) {
		productDAO.deleteProduct(productId);
	}
	
	
	@Override
	public List<Product> getProductListAll() {
		return productDAO.selectProductListAll();
	}
}
