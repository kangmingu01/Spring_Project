package repository;

import java.util.List;
import java.util.Map;

import dto.SalesRequest;

public interface SalesRequestDAO {
	int insertSalesRequest(SalesRequest salesRequest);
	SalesRequest selectSalesReqeustById(int requestId);
	int selectSalesReqeustByCount(Map<String,Object> map);
	
	List<SalesRequest> selectSalesRequestList(Map<String,Object> map);

}
