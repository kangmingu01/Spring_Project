package service;

import java.util.List;
import java.util.Map;

import dto.Receiving;
import dto.Settlement;
import dto.Supplier;

public interface SettlementService {
	Map<String, Object> getSettlementList(Map<String, Object> map);
	List<Supplier> getSupplierList();
	List<Receiving> getReceivingList(Receiving receiving);
	void addSettlement(Settlement settlement);
}
