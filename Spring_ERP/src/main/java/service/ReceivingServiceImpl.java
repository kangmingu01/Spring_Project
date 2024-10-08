package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.Orders;
import dto.Receiving;
import dto.Warehouse;
import lombok.RequiredArgsConstructor;
import repository.ReceivingDAO;
import util.Pager;

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
        return receivingDAO.selectReceivingById(receivingId);
    }
}
