package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.Product;
import lombok.RequiredArgsConstructor;
import repository.ProductDAO;
import util.Pager;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl  implements ProductService{
	private final ProductDAO productDAO;
	
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
	
	@Transactional
	@Override
	public Product getProductUpdate(int productId) {
		return productDAO.selectProductUpdate(productId);
	}
	
	@Override
	public List<Product> getProductListAll() {
		return productDAO.selectProductAll();
	}

	@Transactional
	@Override
	public Map<String, Object> getselectProductKeyList(Map<String, Object> map) {
		
		int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}
		
		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalBoard=productDAO.selcetProductCount(map);
		
		int blockSize=5;
		
		Pager pager=new Pager(pageNum, pageSize, totalBoard, blockSize);
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<Product> productList=productDAO.selectProductKeyList(map);
		System.out.println("Map Contents: " + map);
		System.out.println("Map Contents: " + productList);
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("productList", productList);
		
		return result;
	}
}
