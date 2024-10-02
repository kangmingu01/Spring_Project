package dto;

import lombok.Data;

/*
CREATE TABLE warehouse (
  warehouse_id NUMBER PRIMARY KEY, -- 고유한 창고 식별자
  warehouse_name VARCHAR2(100) , -- 창고 이름
  warehouse_location VARCHAR2(255), -- 창고 위치
  warehouse_capacity NUMBER -- 창고 최대 수용 용량
);
CREATE SEQUENCE warehouse_seq;
*/

@Data
public class Warehouse {
	private int warehouseId;
	private String warehouseName;
	private String warehouseLocation;
	private int warehouseCapacity;
}
