package service;

import java.util.List;
import java.util.Map;

import dto.Supplier;

public interface SettlementService {
	Map<String, Object> getSettlementList(Map<String, Object> map);
	List<Supplier> getSupplierList();
	int modifySettlement(int settlementId);
}
