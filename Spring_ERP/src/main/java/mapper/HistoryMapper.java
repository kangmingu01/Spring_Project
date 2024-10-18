package mapper;

import java.util.List;
import java.util.Map;

import dto.History;

public interface HistoryMapper {
	int insertHistory(History history);
	int updateHistory(History history);
	int deleteProduct(int historyId);
	History selectHistoryUpdate(int historyId);
	int selectHistoryProductWarehouseCount(Map<String, Object> map);
	List<History> selectHistoryProductWarehouseList(Map<String,	Object> map);
}
