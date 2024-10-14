package repository;

import java.util.List;
import java.util.Map;

import dto.Receiving;
import dto.Settlement;
import dto.Supplier;

public interface SettlementDAO {
	int selectSettlementCount(Map<String, Object> map);
	List<Settlement> selectSettlementList(Map<String, Object> map);
	List<Supplier> selectSupplierList();
	List<Receiving> selectReceivingListByStatus(Receiving receiving);
	int insertSettlement(Settlement settlement);
}