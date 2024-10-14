package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.Orders;
import dto.ProductCategory;
import dto.Receiving;
import dto.Supplier;
import dto.Warehouse;
import lombok.RequiredArgsConstructor;
import repository.ReceivingDAO;
import util.Pager;
import util.ProductCategoryParser;

@Service
@RequiredArgsConstructor
public class ReceivingServiceImpl implements ReceivingService {
    private final ReceivingDAO receivingDAO;

    // 입고 등록
    @Transactional
    @Override
    public void addReceiving(Receiving receiving) {
        receivingDAO.insertReceiving(receiving);
    }

    // 발주 리스트 조회 (페이징 처리 및 검색 기능)
    @Override
    public Map<String, Object> getOrdersList(Map<String, Object> map) {
        // 페이지 번호 설정 (기본값: 1)
        int pageNum = 1;
        if (map.get("pageNum") != null && !map.get("pageNum").equals("")) {
            pageNum = Integer.parseInt((String) map.get("pageNum"));
        }

        // 페이지 크기 설정 (기본값: 10)
        int pageSize = 10;
        if (map.get("pageSize") != null && !map.get("pageSize").equals("")) {
            pageSize = Integer.parseInt((String) map.get("pageSize"));
        }

        // 전체 발주 개수 조회
        int totalOrdersCount = receivingDAO.selectOrdersCount(map);

        // 블록 크기 설정
        int blockSize = 5;

        // 페이지 정보 생성
        Pager pager = new Pager(pageNum, pageSize, totalOrdersCount, blockSize);

        // 페이징 정보를 이용하여 데이터 조회
        map.put("startRow", pager.getStartRow());
        map.put("endRow", pager.getEndRow());
        List<Orders> ordersList = receivingDAO.selectOrdersList(map);
        
        // 각 발주의 제품 카테고리 정보를 파싱하여 ProductCategory를 설정
        for (Orders order : ordersList) {
            String productCategoryCode = order.getProductCategory();
            if (productCategoryCode != null) {
                ProductCategory category = ProductCategoryParser.parseCategoryCode(productCategoryCode);
                order.setProductCategoryDetails(category);  // 파싱한 결과를 설정
            }
        }

        // 결과 맵 생성
        Map<String, Object> result = new HashMap<>();
        result.put("pager", pager);
        result.put("ordersList", ordersList);

        return result;
    }

    // 창고 목록 조회
    @Override
    public List<Warehouse> getWarehouseList() {
        return receivingDAO.selectWarehouseList();
    }

    // 특정 입고 정보 조회
    @Override
    public Receiving getReceivingById(int receivingId) {
        Receiving receiving = receivingDAO.selectReceivingById(receivingId);

        // 해당 입고 정보에 제품 카테고리 정보 설정
        if (receiving != null) {
            String productCategoryCode = receiving.getProductCategory(); // productCategory 필드를 가져옴
            if (productCategoryCode != null) {
                ProductCategory productCategoryDetails = ProductCategoryParser.parseCategoryCode(productCategoryCode);
                receiving.setProductCategoryDetails(productCategoryDetails);  // 파싱한 결과를 설정
            }
        }
        
        return receiving;
    }
    // 전체 입고 목록 조회 (페이징 처리 및 검색 기능 포함)
	@Override
	public Map<String, Object> getReceivingList(Map<String, Object> map) {
		// 페이지 번호 설정 (기본값: 1)
        int pageNum = 1;
        if (map.get("pageNum") != null && !map.get("pageNum").equals("")) {
            pageNum = Integer.parseInt((String) map.get("pageNum"));
        }

        // 페이지 크기 설정 (기본값: 10)
        int pageSize = 10;
        if (map.get("pageSize") != null && !map.get("pageSize").equals("")) {
            pageSize = Integer.parseInt((String) map.get("pageSize"));
        }

        // 전체 발주 개수 조회
        int totalReceivingCount = receivingDAO.selectReceivingCount(map);

        // 블록 크기 설정
        int blockSize = 5;

        // 페이지 정보 생성
        Pager pager = new Pager(pageNum, pageSize, totalReceivingCount, blockSize);

        // 페이징 정보를 이용하여 데이터 조회
        map.put("startRow", pager.getStartRow());
        map.put("endRow", pager.getEndRow());
        List<Receiving> receivingList = receivingDAO.selectReceivingList(map);

        // 각 입고의 제품 카테고리 정보를 설정
        for (Receiving receiving : receivingList) {
            String productCategoryCode = receiving.getProductCategory();
            if (productCategoryCode != null) {
                ProductCategory productCategoryDetails = ProductCategoryParser.parseCategoryCode(productCategoryCode);
                receiving.setProductCategoryDetails(productCategoryDetails);
            }
        }

        // 결과 맵 생성
        Map<String, Object> result = new HashMap<>();
        result.put("pager", pager);
        result.put("receivingList", receivingList);

        return result;
    }
	
	@Transactional
	@Override
	public void modifyReceiving(Receiving receiving) {
		
		receiving.setReceivingStatus(4); 
	    receivingDAO.updateReceiving(receiving); 
	}

	@Override
	public List<Supplier> getSupplierList() {
		return receivingDAO.selectSupplierList();
	}
}
