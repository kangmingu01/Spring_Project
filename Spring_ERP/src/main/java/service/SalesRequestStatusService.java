package service;

import java.util.List;
import java.util.Map;

import dto.SalesRequest;

public interface SalesRequestStatusService {
	void addSalesRequestToSales(List<SalesRequest> salesRequests);
//	void addSalesRequestToSales(SalesRequest salesRequest);
	void addSalesRequestStatus(SalesRequest salesRequest);
	void modifySalesRequestStatus(List<SalesRequest> salesRequests);
	void removeSalesRequestStatus(SalesRequest salesRequest);

	
	SalesRequest getSalesRequestStatusById(int requestId);
	
	Map<String,Object> getSalesRequestStatusList(Map<String,Object> map);
}
