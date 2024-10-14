package mapper;

import java.util.List;
import java.util.Map;

import dto.Settlement;
import dto.Supplier;

public interface SettlementMapper {
	int selectSettlementCount(Map<String, Object> map);
	List<Settlement> selectSettlementList(Map<String, Object> map);
	List<Supplier> selectSupplierList();
	int insertSettlement(Settlement settlement);
}
