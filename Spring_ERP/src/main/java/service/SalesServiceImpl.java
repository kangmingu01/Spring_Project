package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.Sales;
import lombok.RequiredArgsConstructor;
import repository.SalesDAO;
import util.Pager;

@Service
@RequiredArgsConstructor
public class SalesServiceImpl implements SalesService {
	private final SalesDAO salesDAO;
	
	
	@Transactional
	@Override
	public void addSalesList(Sales sales) {
		// TODO Auto-generated method stub
		
	}
	@Transactional
	@Override
	public void modifySales(List<Sales> salesList) {
		for (Sales sales : salesList) {
			 System.out.println("Sales= "+sales);
			salesDAO.updateSales(sales);
		}
		
	}
	@Transactional
	@Override
	public void modifySalesStatus(List<Sales> salesList) {
		for (Sales sales : salesList) {
			 System.out.println("Sales= "+sales);
			salesDAO.updateSalesStatus(sales);
		}
		
	}
	@Transactional
	@Override
	public void removeSales(Sales sales) {
		
		
	}
	@Transactional
	@Override
	public void addSalesList(List<Sales> salesList) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Sales getSalesById(int salesId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getSalesByCount(Map<String, Object> map) {
		
		return salesDAO.selectSalesByCount(map);
	}

	@Override
	public Map<String,Object>  getSalesList(Map<String, Object> map) {
		int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}
		
		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalBoard=salesDAO.selectSalesByCount(map);
		
		int blockSize=10;
		
		Pager pager=new Pager(pageNum, pageSize, totalBoard, blockSize);
		
		System.out.println(pager.toString());
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<Sales> boardList=salesDAO.selectSalesList(map);
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("salesList", boardList);
		
		return result;
	}

}
