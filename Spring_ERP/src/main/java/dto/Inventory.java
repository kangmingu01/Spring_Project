package dto;

import lombok.Data;

/*
CREATE TABLE inventory (
    inv_id NUMBER PRIMARY KEY, -- ��� �ĺ���(������)
    inv_product_id NUMBER,   -- product_id �ܷ�Ű
    inv_current_qty NUMBER, -- ���� ����
    inv_warehouse_id NUMBER, -- warehouse_id �ܷ�Ű
    inv_damaged_qty NUMBER DEFAULT 0, -- �ջ�� ������ �����ϴ� �÷�
    inv_last_date DATE, --�ֱ� ����� ��¥
    CONSTRAINT fk_product FOREIGN KEY (inv_product_id) REFERENCES product (product_id),
    CONSTRAINT fk_warehouse FOREIGN KEY (inv_warehouse_id) REFERENCES warehouse (warehouse_id),
    CONSTRAINT unique_product_warehouse UNIQUE (inv_product_id, inv_warehouse_id)
);

CREATE SEQUENCE inventory_seq;
*/
@Data
public class Inventory {
	private int inventoryId;
	private int inventoryProductId;	
	private int inventoryQty;
	private int inventoryWarehouseId;
	private int inventoryDamagedQty;
	private String lastDate;

	private Product product;
	private Warehouse warehouse;
}
