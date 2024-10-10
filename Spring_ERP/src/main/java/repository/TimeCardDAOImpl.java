package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.TimeCard;
import lombok.RequiredArgsConstructor;
import mapper.TimeCardMapper;

@Repository
@RequiredArgsConstructor
public class TimeCardDAOImpl implements TimeCardDAO{
	private final SqlSession sqlSession;
	
	@Override
	public int insertTimeCard(TimeCard timeCard) {
		return sqlSession.getMapper(TimeCardMapper.class).insertTimeCard(timeCard);
	}

	@Override
	public int updateTimeCard(TimeCard timeCard) {
		return sqlSession.getMapper(TimeCardMapper.class).updateTimeCard(timeCard);
	}

	@Override
	public int deleteTimeCard(int timeCardId) {
		return sqlSession.getMapper(TimeCardMapper.class).deleteTimeCard(timeCardId);
	}
	
	@Override
	public int selectTimeCardCount(Map<String, Object> map) {
		return sqlSession.getMapper(TimeCardMapper.class).selectTimeCardCount(map);
	}
	
	@Override
	public List<TimeCard> selectTimeCardByName(String name) {
		return sqlSession.getMapper(TimeCardMapper.class).selectTimeCardByName(name);
	}


	@Override
	public List<TimeCard> selectAllTimeCard(Map<String, Object> map) {
		return sqlSession.getMapper(TimeCardMapper.class).selectAllTimeCard(null);
	}

	


}
