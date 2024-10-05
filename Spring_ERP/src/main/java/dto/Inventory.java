package dto;

import lombok.Data;

/*
CREATE TABLE inventory (
    inv_id NUMBER PRIMARY KEY, -- 재고 식별자(시퀀스)
    inv_product_id NUMBER,   -- product_id 외래키
    inv_current_qty NUMBER, -- 현재 수량
    inv_warehouse_id NUMBER, -- warehouse_id 외래키
    inv_damaged_qty NUMBER DEFAULT 0, -- 손상된 수량을 관리하는 컬럼
    inv_last_date DATE, --최근 입출고 날짜
    CONSTRAINT fk_product FOREIGN KEY (inv_product_id) REFERENCES product (product_id),
    CONSTRAINT fk_warehouse FOREIGN KEY (inv_warehouse_id) REFERENCES warehouse (warehouse_id),
    CONSTRAINT unique_product_warehouse UNIQUE (inv_product_id, inv_warehouse_id)
);

CREATE SEQUENCE inventory_seq;
*/
@Data
public class Inventory {
	private int inventoryId;	// 재고 식별자
	private int inventoryProductId;	
	private int inventoryQty;	// 현재 수량
	private int inventoryWarehouseId;	// 창고아이디
	private int inventoryDamagedQty;	// 파손된 수량
	private String lastDate;
	
}