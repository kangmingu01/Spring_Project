package dto;

import lombok.Data;

/*
CREATE TABLE history(
    history_id NUMBER PRIMARY KEY,
    history_product_id NUMBER,
    history_type NUMBER CHECK (history_type IN (1, 2, 3)), -- 1: �԰�, 2: ���, 3:��ǰ
    history_date DATE,
    history_warehouse_id NUMBER,
    history_quantity NUMBER,
    CONSTRAINT fk_history_warehouse FOREIGN KEY (history_warehouse_id) REFERENCES warehouse(warehouse_id),
    CONSTRAINT fk_inventory FOREIGN KEY (history_product_id) REFERENCES product(product_id)
);

CREATE SEQUENCE history_seq;
*/

@Data
public class History {
	private int historyId;
	private int historyProductId; 
	private int historyType;	// �԰�, ��� , ��ǰ
	private String historyDate; //���糯¥
	private int historyWarehouseId; // â�� ��ȣ
	private int historyQty;	// ����
	
	private Product product;
	private Warehouse warehouse;
}
