package service;

import java.util.List;
import java.util.Map;

import dto.Sales;

public interface SalesService {
	void addSalesHistory(List<Sales> salesHistory);
	void addSalesList(Sales sales);

	void modifySales(List<Sales> salesList);
	
	void modifySalesStatus(List<Sales> salesList);
	
	
	void removeSales(Sales sales);
    void addSalesList(List<Sales> salesList);
	
    Sales getSalesById(int salesId);
	int getSalesByCount(Map<String,Object> map);
	
	Map<String,Object>  getSalesList(Map<String,Object> map);

}
