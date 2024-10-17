package service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import dto.History;
import dto.Inventory;
import lombok.RequiredArgsConstructor;
import repository.ChartDAO;

@Service
@RequiredArgsConstructor
public class ChartServiceImpl implements ChartService{
	private final ChartDAO chartDAO;

	//현재 재고 상태
	@Override
	public List<Inventory> getselectChartAll() {
		return chartDAO.selectChartAll();
	}

	//월별 입출고 수량
	@Override
	public List<History> getselectChartInOutAll() {
		return chartDAO.selectChartInOut();
	}

	//월별 금액
	@Override
	public List<Map<String, Object>> getselectSalesChart() {
		return chartDAO.selectSalesChart();
	}

	@Override
	public List<Map<String, Object>> getselectSalesProduct() {
		return chartDAO.selectSalesProduct();
	}

	@Override
	public List<Map<String, Object>> getselectWarehouseSpace() {
		return chartDAO.selectWarehouseSpace();
	}
}
