package repository;

import java.util.List;
import java.util.Map;

import dto.Employee;

public interface EmployeeDAO {
	Employee selectEmployeeById(int employeeId);
	List<Employee> selectEmployeeList(Map<String, Object> map);
	
}
