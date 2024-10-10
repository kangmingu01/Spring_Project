
package service;

import java.util.List;
import java.util.Map;

import dto.TimeCard;

public interface TimeCardService {
	void insertTimeCard(TimeCard timeCard);
	void updateTimeCard(TimeCard timeCard);
	void deleteTimeCard(int timeCardId);
	List<TimeCard> selectTimeCardByName(String name);
	Map<String, Object> selectAllTimeCard(Map<String, Object> map);
}
