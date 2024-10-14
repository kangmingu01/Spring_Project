package repository;

import java.util.List;
import java.util.Map;

import dto.History;

public interface HistoryDAO {
	int insertHistory(History history);
	int updateHistory(History history);
	int deleteProduct(int historyId);
	History selectHistoryUpdate(int historyId);
	int selectHistoryProductWarehouseCount(Map<String, Object> map);
	List<History> selectHistoryProductWarehouseList(Map<String,	Object> map);
}
