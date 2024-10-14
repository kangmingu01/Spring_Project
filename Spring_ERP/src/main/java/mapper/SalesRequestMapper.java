package mapper;

import java.util.List;
import java.util.Map;

import dto.Sales;
import dto.SalesRequest;

public interface SalesRequestMapper {
	int insertSalesRequest(SalesRequest salesRequest);
//	int updateSalesRequest(List<SalesRequest> salesRequests);
	int updateSalesRequest(SalesRequest salesRequests);
	
	int updateSalesRequestStatus(SalesRequest salesRequests);
	
	
	int deleteSalesRequest(SalesRequest salesRequest);
    int insertSalesList(List<Sales> salesList);
	
	SalesRequest selectSalesReqeustById(int requestId);
	int selectSalesRequestByCount(Map<String,Object> map);
	
	List<SalesRequest> selectSalesRequestList(Map<String,Object> map);
	

}
