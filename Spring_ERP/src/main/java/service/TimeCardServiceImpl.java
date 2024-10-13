package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.TimeCard;
import lombok.RequiredArgsConstructor;
import repository.TimeCardDAO;
import util.Pager;

@Service
@RequiredArgsConstructor
public class TimeCardServiceImpl implements TimeCardService{
	private final TimeCardDAO timeCardDAO;
	
	@Transactional
	@Override
	public void insertTimeCard(TimeCard timeCard) {
		timeCardDAO.insertTimeCard(timeCard);
		
	}
	
	@Transactional
	@Override 
	public void updateTimeCard(TimeCard timeCard) {
		timeCardDAO.updateTimeCard(timeCard);
	}
	
	@Transactional
	@Override
	public void deleteTimeCard(int timeCardId) {
		timeCardDAO.deleteTimeCard(timeCardId);
	}

	@Override
	public List<TimeCard> selectTimeCardByName(String name) {
		return timeCardDAO.selectTimeCardByName(name);
	}

	@Override
	public Map<String, Object> selectAllTimeCard(Map<String, Object> map) {
		int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}
		
		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalBoard=timeCardDAO.selectTimeCardCount(map);
		
		int blockSize=5;
		
		Pager pager=new Pager(pageNum, pageSize, totalBoard, blockSize);
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<TimeCard> timecardList=timeCardDAO.selectAllTimeCard(map);
		System.out.println("Map Contents: " + map);
		System.out.println("Map Contents: " + timecardList);
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("timecardList", timecardList);
		
		return result;
	}

	
	
	
}
