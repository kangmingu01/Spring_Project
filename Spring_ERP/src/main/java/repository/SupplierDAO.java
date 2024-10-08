package repository;

import java.util.List;
import java.util.Map;

import dto.Supplier;

public interface SupplierDAO {
	int insertSupplier(Supplier supplier);
	Supplier selectSupplierById(int supplierId);	
	int updateSupplier(Supplier supplier);
	int selectSupplierCount(Map<String, Object> map);
	List<Supplier> selectSupplierList(Map<String, Object> map);
	int existsByName(String supplierName);
}
