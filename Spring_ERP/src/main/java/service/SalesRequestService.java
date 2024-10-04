package service;

import java.util.List;
import java.util.Map;

import dto.SalesRequest;

public interface SalesRequestService {

	void addSalesRequest(SalesRequest salesRequest);
	SalesRequest getSalesRequestById(int requestId);
	Map<String,Object> getSalesRequestList(Map<String,Object> map);
}

