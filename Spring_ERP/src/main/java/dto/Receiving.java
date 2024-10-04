package dto;
/*
CREATE TABLE receiving (
    receiving_id NUMBER PRIMARY KEY,              -- 입고의 고유 식별자 (기본 키)
    receiving_date DATE DEFAULT SYSDATE,          -- 입고 날짜 (기본값: 현재 날짜)
    userid VARCHAR2(100),                         -- 입고를 등록한 사용자 (FK)
    orders_id NUMBER,                             -- 연관된 발주의 ID (FK)
    warehouse_id NUMBER,                          -- 입고된 창고 ID (FK)
    quantity NUMBER,                              -- 입고된 실제 수량
    receiving_status NUMBER(1) DEFAULT 3,         -- 입고 상태 (3: 입고 대기, 4: 입고 완료)
    CONSTRAINT receiving_userid_fk FOREIGN KEY (userid) REFERENCES erp_user(userid),
    CONSTRAINT receiving_orders_fk FOREIGN KEY (orders_id) REFERENCES orders(orders_id),
    CONSTRAINT receiving_warehouse_fk FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id)
);

CREATE SEQUENCE receiving_seq;

 */

import lombok.Data;

@Data
public class Receiving {
	private int receivingId;       
    private String receivingDate;      
    private String userid;         
    private int ordersId;           
    private int warehouseId;      
    private int quantity;        
    private int receivingStatus; 
}
