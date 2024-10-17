package service;

import java.util.List;
import java.util.Map;

import dto.History;
import dto.Inventory;

public interface ChartService {
	List<Inventory> getselectChartAll();
	List<History> getselectChartInOutAll();
	List<Map<String, Object>> getselectSalesChart();
	List<Map<String, Object>> getselectSalesProduct();
	List<Map<String, Object>> getselectWarehouseSpace();
}
