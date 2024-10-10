package mapper;

import java.util.List;
import java.util.Map;

import dto.Employee;

public interface EmployeeMapper {
	Employee selectEmployeeById(int employeeId);
	List<Employee> selectEmployeeList(Map<String, Object> map);
}
