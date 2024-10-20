package mapper;

import java.util.List;
import java.util.Map;

import dto.Sales;


public interface SalesMapper {
	
	int insertSalesHistory(Sales sales);
	int insertSalesList(Sales sales);
	int updateSales(Sales sales);
	int updateSalesStatus(Sales sales);
	int deleteSales(Sales sales);
    int insertSalesList(List<Sales> salesList);
	Sales selectSalesById(int salesId);
	int selectSalesByCount(Map<String,Object> map);
	List<Sales> selectSalesList(Map<String,Object> map);

}