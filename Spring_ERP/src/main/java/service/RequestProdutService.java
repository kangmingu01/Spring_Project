package service;

import java.util.List;
import java.util.Map;

import dto.Product;
import dto.RequestProdut;

public interface RequestProdutService {
	 void addSalesRequest(RequestProdut requestProduct);
	
	 Map<String, Object>  getSalesRequest(Map<String, Object> map);
}
