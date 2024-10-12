package mapper;

import java.util.List;
import java.util.Map;

import dto.Receiving;
import dto.Settlement;
import dto.Supplier;

public interface SettlementMapper {
	int selectSettlementCount(Map<String, Object> map);
	List<Settlement> selectSettlementList(Map<String, Object> map);
	List<Supplier> selectSupplierList();
	Receiving selectReceivingById(int receivingId);
	int insertSettlement(Settlement settlement);
	int updateSettlement(Settlement settlement);	
}
