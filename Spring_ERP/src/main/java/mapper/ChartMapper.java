package mapper;

import java.util.List;
import java.util.Map;

import dto.History;
import dto.Inventory;

public interface ChartMapper {
	List<Inventory> selectChartAll();
	List<History> selectChartInOut();
	List<Map<String, Object>> selectSalesChart();
	List<Map<String, Object>> selectSalesProduct();
	List<Map<String, Object>> selectWarehouseSpace();
}