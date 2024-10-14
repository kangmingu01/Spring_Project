package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.Product;
import dto.ProductCategory;
import dto.RequestProdut;
import lombok.RequiredArgsConstructor;
import repository.RequestProdutDAO;
import util.Pager;
import util.ProductCategoryParser;

@Service
@RequiredArgsConstructor
public class RequestProdutServiceImpl implements RequestProdutService {
	  private final RequestProdutDAO requestProductDAO;
	@Transactional
	@Override
	public void addSalesRequest(RequestProdut requestProduct) {
		requestProductDAO.insertSalesRequest(requestProduct);
		
	}

	@Override
	public Map<String, Object>  getSalesRequest(Map<String, Object> map) {
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
        int totalProductCount = requestProductDAO.selectProductCount(map);
        // 블록 크기 설정
        int blockSize = 5;

        // 페이지 정보 생성
        Pager pager = new Pager(pageNum, pageSize, totalProductCount, blockSize);

        // 페이징 정보를 이용하여 데이터 조회
        map.put("startRow", pager.getStartRow());
        map.put("endRow", pager.getEndRow());
        List<Product> productList = requestProductDAO.selectProductList(map);
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


}
