package dto;

import lombok.Data;

/*
CREATE TABLE warehouse (
  warehouse_id NUMBER PRIMARY KEY, -- ������ â�� �ĺ���
  warehouse_name VARCHAR2(100) , -- â�� �̸�
  warehouse_location VARCHAR2(255), -- â�� ��ġ
  warehouse_capacity NUMBER -- â�� �ִ� ���� �뷮
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
