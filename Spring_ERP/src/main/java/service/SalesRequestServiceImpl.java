package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.SalesRequest;
import lombok.RequiredArgsConstructor;
import repository.SalesRequestDAO;
import util.Pager;


@Service
@RequiredArgsConstructor
public class SalesRequestServiceImpl implements SalesRequestService {
	private final SalesRequestDAO salesRequestDAO;
	
	
	@Transactional
	@Override
	public void addSalesRequest(SalesRequest salesRequest) {
//		if(securityUserDAO.selectSecurityUserByUserid(board.getWriter()) == null) {
//			throw new RuntimeException("게시글 작성자를 찾을 수 없습니다.");
//		}
		salesRequestDAO.insertSalesRequest(salesRequest);
		
	}

	@Override
	public SalesRequest getSalesRequestById(int requestId) {
		SalesRequest list=salesRequestDAO.selectSalesReqeustById(requestId);
		if(list == null) {
			throw new RuntimeException("게시글을 찾을 수 없습니다.");
		}
		return list;
	}

	@Override
	public Map<String, Object> getSalesRequestList(Map<String, Object> map) {
		int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNUm").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}
		
		int pageSize=5;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalBoard=salesRequestDAO.selectSalesReqeustByCount(map);
		
		int blockSize=5;
		
		Pager pager=new Pager(pageNum, pageSize, totalBoard, blockSize);
		
		System.out.println(pager.toString());
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<SalesRequest> boardList=salesRequestDAO.selectSalesRequestList(map);
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("securityBoardList", boardList);
		
		return result;
	}

	

}


	


	
