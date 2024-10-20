package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.Product;
import dto.Warehouse;
import lombok.RequiredArgsConstructor;
import repository.WarehouseDAO;
import util.Pager;

@Service
@RequiredArgsConstructor
public class WarehouseServiceImpl implements WarehouseService{
	private final WarehouseDAO warehouseDAO;
	
	@Transactional
	@Override
	public void addWarehouse(Warehouse warehouse) {
		warehouseDAO.insertWarehouse(warehouse);
	}
	
	@Transactional
	@Override
	public void modifyWarehouse(Warehouse warehouse) {
		warehouseDAO.updateWarehouse(warehouse);
	}
	
	@Transactional
	@Override
	public void removeWarehouse(int warehouseId) {
		warehouseDAO.deleteWarehouse(warehouseId);
	}
	
	@Transactional
	@Override
	public List<Warehouse> getWarehouseListAll() {
		return warehouseDAO.selectWarehouseAll();
	}
	
	@Transactional
	@Override
	public Map<String, Object> getselectProductKeyList(Map<String, Object> map) {
		int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}
		
		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalBoard=warehouseDAO.selcetWarehouseCount(map);
		
		int blockSize=5;
		
		Pager pager=new Pager(pageNum, pageSize, totalBoard, blockSize);
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<Warehouse> warehouseList=warehouseDAO.selectWarehouseKeyList(map);
		System.out.println("Map Contents: " + map);
		System.out.println("Map Contents: " + warehouseList);
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("warehouseList", warehouseList);
		
		return result;
	}
	
}
