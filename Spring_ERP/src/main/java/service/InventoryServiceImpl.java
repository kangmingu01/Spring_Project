package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.Inventory;
import lombok.RequiredArgsConstructor;
import repository.InventoryDAO;
import util.Pager;

@Service
@RequiredArgsConstructor
public class InventoryServiceImpl implements  InventoryService{
	private final InventoryDAO inventoryDAO;
	
	@Transactional
	@Override
	public void addInventory(Inventory inventory) {
		inventoryDAO.insertInventory(inventory);
	}
	
	@Transactional
	@Override
	public void modifyInventory(Inventory inventory) {
		inventoryDAO.updateInventory(inventory);
	}
	@Transactional
	@Override
	public void removeInventory(int inventoryId) {
		inventoryDAO.deleteInventory(inventoryId);
	}
	@Transactional
	@Override
	public List<Inventory> getProductInventoryList() {
		return inventoryDAO.selectProductInventoryList();
	}

	@Transactional
	@Override
	public Map<String, Object> getselectProductInventoryPageList(Map<String, Object> map) {
		int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}
		
		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalBoard=inventoryDAO.selectProductInventoryCount(map);
		
		int blockSize=5;
		
		Pager pager=new Pager(pageNum, pageSize, totalBoard, blockSize);
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<Inventory> invenList=inventoryDAO.selectProductInventoryPageList(map);
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("invenList", invenList);
		return result;
	}

	@Override
	public Map<String, Object> getselectProductInventoryDamagePageList(Map<String, Object> map) {
		int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}
		
		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalBoard=inventoryDAO.selectProductInventoryDamageCount(map);
		
		int blockSize=5;
		
		Pager pager=new Pager(pageNum, pageSize, totalBoard, blockSize);
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<Inventory> invenList=inventoryDAO.selectProductInventoryDamagePageList(map);
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("invenList", invenList);
		return result;
	}

	@Override
	public Inventory getselectProductInventoryUpdate(int inventoryId) {
		return inventoryDAO.selectProductInventoryUpdate(inventoryId);
	}

	@Override
	public Map<String, Object> getselectProductInventoryQtyPageList(Map<String, Object> map) {
		int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}
		
		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalBoard=inventoryDAO.selectProductInventoryQtyCount(map);
		
		int blockSize=5;
		
		Pager pager=new Pager(pageNum, pageSize, totalBoard, blockSize);
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<Inventory> invenList=inventoryDAO.selectProductInventoryQtyPageList(map);
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("invenList", invenList);
		return result;
	}

}
