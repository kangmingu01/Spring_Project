package mapper;

import java.util.List;
import java.util.Map;

import dto.TimeCard;

public interface TimeCardMapper {
	int insertTimeCard(TimeCard timeCard);
	int updateTimeCard(TimeCard timeCard);
	int deleteTimeCard(int timeCardId);
	List<TimeCard> selectTimeCardByName(String name);
	List<TimeCard> selectAllTimeCard(Map<String, Object> map);
	int selectTimeCardCount(Map<String, Object> map);
}
