package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.ProductCategory;
import dto.SalesRequest;
import lombok.RequiredArgsConstructor;
import repository.SalesRequestStatusDAO;
import util.Pager;
import util.ProductCategoryParser;
@Service
@RequiredArgsConstructor
public class SalesRequestStatusServiceImpl implements SalesRequestStatusService {
	private final SalesRequestStatusDAO salesRequestStatusDAO;
	
	
	@Transactional
	@Override
	public void addSalesRequestToSales(List<SalesRequest> salesRequests) {
		for (SalesRequest salesRequest : salesRequests) {
	        // 각 salesRequest 객체에 대해 처리
	        System.out.println("sales add to sales"+salesRequest);
	        salesRequestStatusDAO.insertSalesRequestToSales(salesRequest);
	    }
		
	}
//	@Transactional
//	@Override
//	public void addSalesRequestToSales(SalesRequest salesRequest) {
//		salesRequestStatusDAO.insertSalesRequestToSales(salesRequest);
//		
//	}
	
	@Transactional
	@Override
	public void addSalesRequestStatus(SalesRequest salesRequest) {
		
		
	}

	@Transactional
	@Override
	public void modifySalesRequestStatus(List<SalesRequest> salesRequests) {
		   for (SalesRequest salesRequest : salesRequests) {
		        // 각 salesRequest 객체에 대해 처리
		        System.out.println(salesRequest);
		        salesRequestStatusDAO.updateSalesRequestStatus(salesRequest);
		    }
		
	}

	@Override
	public void removeSalesRequestStatus(SalesRequest salesRequest) {
		
		
	}

	@Override
	public SalesRequest getSalesRequestStatusById(int requestId) {
		SalesRequest list=salesRequestStatusDAO.selectSalesReqeustStatusById(requestId);
		if(list == null) {
			throw new RuntimeException("게시글을 찾을 수 없습니다.");
		}
		return list;

	}

	@Override
	public Map<String, Object> getSalesRequestStatusList(Map<String, Object> map) {
		int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}
		
		int pageSize=5;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalBoard=salesRequestStatusDAO.selectSalesRequestStatusByCount(map);
		
		int blockSize=5;
		
		Pager pager=new Pager(pageNum, pageSize, totalBoard, blockSize);
		
		System.out.println(pager.toString());
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<SalesRequest> boardList=salesRequestStatusDAO.selectSalesRequestListStatus(map);
		
		for (SalesRequest salesRequest : boardList) {
			  String productCategoryCode = salesRequest.getProductCategory();
			  if (productCategoryCode != null) {
	            ProductCategory category = ProductCategoryParser.parseCategoryCode(salesRequest.getProductCategory());
	            salesRequest.setProductCategoryDetails(category);
	        }
		}
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("salesRequestList", boardList);
		
		return result;
	}

	

	

	
}
