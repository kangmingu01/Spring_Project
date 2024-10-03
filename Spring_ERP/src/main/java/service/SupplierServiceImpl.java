package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.Supplier;
import lombok.RequiredArgsConstructor;
import repository.SupplierDAO;
import util.Pager;

@Service
@RequiredArgsConstructor
public class SupplierServiceImpl implements SupplierService {
    private final SupplierDAO supplierDAO;

    @Transactional
    @Override
    public void addSupplier(Supplier supplier) {
        int count = supplierDAO.existsByName(supplier.getSupplierName());
        if (count > 0) {
            throw new IllegalArgumentException("이미 존재하는 공급업체 이름입니다.");
        }
        supplierDAO.insertSupplier(supplier);
    }

    @Transactional
    @Override
    public void modifySupplier(Supplier supplier) {
        // 공급업체 정보 수정 전에 존재 여부 확인
        if (supplierDAO.selectSupplierById(supplier.getSupplierId()) == null) {
            throw new RuntimeException("수정하려는 공급업체를 찾을 수 없습니다.");
        }
        supplierDAO.updateSupplier(supplier);
    }

    @Override
    public Supplier getSupplierById(int supplierId) {
        // 공급업체 정보 조회
        Supplier supplier = supplierDAO.selectSupplierById(supplierId);
        if (supplier == null) {
            throw new RuntimeException("해당 공급업체를 찾을 수 없습니다.");
        }
        return supplier;
    }

    @Override
    public Map<String, Object> getSupplierList(Map<String, Object> map) {
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

        // 전체 공급업체 개수 조회
        int totalSupplier = supplierDAO.selectSupplierCount(map);

        // 블록 크기 설정
        int blockSize = 5;

        // 페이지 정보 생성
        Pager pager = new Pager(pageNum, pageSize, totalSupplier, blockSize);

        // 페이징 정보를 이용하여 데이터 조회
        map.put("startRow", pager.getStartRow());
        map.put("endRow", pager.getEndRow());
        List<Supplier> supplierList = supplierDAO.selectSupplierList(map);

        // 결과 맵 생성
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("pager", pager);
        result.put("supplierList", supplierList);

        return result;
    }

    @Override
    public int existsByName(String supplierName) {
        return supplierDAO.existsByName(supplierName);
    }    
}
