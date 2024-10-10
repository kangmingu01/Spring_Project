package repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import dto.Employee;
import lombok.RequiredArgsConstructor;
import mapper.EmployeeMapper;

@Repository
@RequiredArgsConstructor
public class EmployeeDAOImpl implements EmployeeDAO{
	private final SqlSession sqlSession;
	
	@Override
	public Employee selectEmployeeById(int employeeId) {
		return sqlSession.getMapper(EmployeeMapper.class).selectEmployeeById(employeeId);
	}

	@Override
	public List<Employee> selectEmployeeList(Map<String, Object> map) {
		return sqlSession.getMapper(EmployeeMapper.class).selectEmployeeList(map);
	}

}
