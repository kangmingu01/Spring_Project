package dto;

import lombok.Data;

/*
CREATE TABLE supplier (
    supplier_id NUMBER PRIMARY KEY,               -- 공급업체의 고유 식별자 (기본 키)
    supplier_name VARCHAR2(100),                  -- 공급업체 이름
    supplier_phone VARCHAR2(50),                  -- 공급업체 전화번호
    supplier_email VARCHAR2(100)                  -- 공급업체 이메일
);

CREATE SEQUENCE supplier_seq;

 */

@Data
public class Supplier {
	private int supplierId; 	   
    private String supplierName;   
    private String supplierPhone; 
    private String supplierEmail; 

}
