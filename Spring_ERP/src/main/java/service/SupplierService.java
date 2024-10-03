package service;

import java.util.Map;

import dto.Supplier;

public interface SupplierService {
	void addSupplier(Supplier supplier);
	void modifySupplier(Supplier supplier);
	Supplier getSupplierById(int supplierId);
	Map<String, Object> getSupplierList(Map<String, Object> map);
}
