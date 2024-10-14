package service;

import java.util.List;
import java.util.Map;

import dto.Sales;
import dto.SalesRequest;

public interface SalesRequestService {

	void addSalesRequest(SalesRequest salesRequest);
	void modifySalesRequest(List<SalesRequest> salesRequests);

	void removeSalesRequest(SalesRequest salesRequest);
	void addSalesList(List<Sales> salesList);
	
	 
	
	
	
	SalesRequest getSalesRequestById(int requestId);
	
	
	
	Map<String,Object> getSalesRequestList(Map<String,Object> map);
	
}

