package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import dto.History;
import lombok.RequiredArgsConstructor;
import repository.HistoryDAO;
import util.Pager;

@Service
@RequiredArgsConstructor
public class HistoryServiceImpl implements HistoryService{
	private final HistoryDAO historyDAO;
	
	@Override
	public void addHistory(History history) {
		historyDAO.insertHistory(history);
	}

	@Override
	public void modifyHistory(History history) {
		historyDAO.updateHistory(history);
		
	}

	@Override
	public void removeHistory(int historyId) {
		historyDAO.deleteProduct(historyId);
	}

	@Override
	public Map<String, Object> getselectHistoryProductWarehouseList(Map<String, Object> map) {
		int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}
		
		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalBoard=historyDAO.selectHistoryProductWarehouseCount(map);
		
		int blockSize=5;
		
		Pager pager=new Pager(pageNum, pageSize, totalBoard, blockSize);
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<History> historyList=historyDAO.selectHistoryProductWarehouseList(map);
	
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("historyList", historyList);
		return result;
	}

	@Override
	public History selectHistoryUpdate(int historyId) {
		return historyDAO.selectHistoryUpdate(historyId);
	}

}
