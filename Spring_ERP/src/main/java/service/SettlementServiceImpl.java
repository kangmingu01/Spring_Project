package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import dto.Receiving;
import dto.Settlement;
import dto.Supplier;
import lombok.RequiredArgsConstructor;
import repository.SettlementDAO;
import util.Pager;

@Service
@RequiredArgsConstructor
public class SettlementServiceImpl implements SettlementService {
    private final SettlementDAO settlementDAO;

    @Override
    public Map<String, Object> getSettlementList(Map<String, Object> map) {
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

        // 전체 정산 개수 조회
        int totalSettlementCount = settlementDAO.selectSettlementCount(map);

        // 블록 크기 설정
        int blockSize = 5;

        // 페이지 정보 생성
        Pager pager = new Pager(pageNum, pageSize, totalSettlementCount, blockSize);

        // 페이징 정보를 이용하여 데이터 조회
        map.put("startRow", pager.getStartRow());
        map.put("endRow", pager.getEndRow());
        List<Settlement> settlementList = settlementDAO.selectSettlementList(map);
        
        // 결과 맵 생성
        Map<String, Object> result = new HashMap<>();
        result.put("pager", pager);
        result.put("settlementList", settlementList);

        return result;
    }
    
    @Override
    public List<Supplier> getSupplierList() {
        return settlementDAO.selectSupplierList();
    }

    @Override
    public Receiving getReceivingById(int receivingId) {
        Receiving receiving = settlementDAO.selectReceivingById(receivingId);
        if (receiving == null || receiving.getReceivingStatus() != 4) {
            throw new IllegalStateException("입고 상태가 정산 가능하지 않습니다.");
        }
        return receiving;
    }

    @Override
    public void addSettlement(Settlement settlement) {
        // Receiving 상태가 4인지 확인
        Receiving receiving = getReceivingById(settlement.getReceivingId());
        
        settlement.setUserid(receiving.getUserid()); 
        settlement.setSettlementStatus(4);  // 정산 대기 상태로 설정
        
        // 정산 데이터 삽입
        settlementDAO.insertSettlement(settlement);
    }

	@Override
	public int modifySettlement(Settlement settlement) {
	    settlement.setSettlementStatus(6);  // 정산 완료 상태로 변경
	    return settlementDAO.updateSettlement(settlement);
	}

}
