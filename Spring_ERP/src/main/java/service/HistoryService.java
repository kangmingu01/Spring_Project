package service;

import java.util.Map;

import dto.History;

public interface HistoryService {
	void addHistory(History history);
	void modifyHistory(History history);
	void removeHistory(int historyId);
	History selectHistoryUpdate(int historyId);
	Map<String, Object> getselectHistoryProductWarehouseList(Map<String,Object> map);
}
