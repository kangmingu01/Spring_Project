package repository;

import java.util.List;
import java.util.Map;

import dto.TimeCard;

public interface TimeCardDAO {
	int insertTimeCard(TimeCard timeCard);
	int updateTimeCard(TimeCard timeCard);
	int deleteTimeCard(int timeCardId);
	int selectTimeCardCount(Map<String, Object> map);
	List<TimeCard> selectTimeCardByName(String name);
	List<TimeCard> selectAllTimeCard(Map<String, Object> map);
}
 