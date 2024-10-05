package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.Orders;
import dto.Product;
import dto.ProductCategory;
import dto.Supplier;
import lombok.RequiredArgsConstructor;
import repository.OrdersDAO;
import util.Pager;
import util.ProductCategoryParser;

@Service
@RequiredArgsConstructor
public class OrdersServiceImpl implements OrdersService {
    private final OrdersDAO ordersDAO;

    // 발주 등록
    @Transactional
    @Override
    public void addOrders(Orders orders) {
        ordersDAO.insertOrders(orders);
    }

    // 제품 리스트 조회 (페이징 처리 및 검색)
    @Override
    public Map<String, Object> getProductList(Map<String, Object> map) {
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

        // 전체 제품 개수 조회
        int totalProductCount = ordersDAO.selectProductCount(map);

        // 블록 크기 설정
        int blockSize = 5;

        // 페이지 정보 생성
        Pager pager = new Pager(pageNum, pageSize, totalProductCount, blockSize);

        // 페이징 정보를 이용하여 데이터 조회
        map.put("startRow", pager.getStartRow());
        map.put("endRow", pager.getEndRow());
        List<Product> productList = ordersDAO.selectProductList(map);
        
        // 각 제품의 categoryCode를 파싱하여 ProductCategory를 추가
        for (Product product : productList) {
            ProductCategory category = ProductCategoryParser.parseCategoryCode(product.getProductCategory());
            product.setProductCategoryDetails(category);
        }
        
        // 결과 맵 생성
        Map<String, Object> result = new HashMap<>();
        result.put("pager", pager);
        result.put("productList", productList);

        return result;
    }

    // 공급 업체 목록 조회
    @Override
    public List<Supplier> getSupplierList() {
        return ordersDAO.selectSupplierList();
    }
    
    /*
    @Override
    public List<Supplier> getSupplierListByKeyword(String keyword) {
        return ordersDAO.selectSupplierListByKeyword(keyword);
    }
	*/
}
