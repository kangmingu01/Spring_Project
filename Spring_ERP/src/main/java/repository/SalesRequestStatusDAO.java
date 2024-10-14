package repository;

import java.util.List;
import java.util.Map;

import dto.SalesRequest;

public interface SalesRequestStatusDAO {
	int insertSalesRequestToSales(SalesRequest salesRequests);
	int updateSalesRequestStatus(SalesRequest salesRequests);
	
	SalesRequest selectSalesReqeustStatusById(int requestId);
	int selectSalesRequestStatusByCount(Map<String,Object> map);

	List<SalesRequest> selectSalesRequestListStatus(Map<String,Object> map);

}
