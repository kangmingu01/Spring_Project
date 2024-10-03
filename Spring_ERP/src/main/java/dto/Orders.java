package dto;

import lombok.Data;

/*
CREATE TABLE orders (
    orders_id NUMBER PRIMARY KEY,                 -- 발주의 고유 식별자 (기본 키)
    orders_date DATE DEFAULT SYSDATE,             -- 발주 날짜 (기본값: 현재 날짜)
    userid VARCHAR2(100),                         -- 발주를 등록한 사용자 (FK)
    supplier_id NUMBER,                           -- 공급업체 ID (FK)
    product_id NUMBER,                            -- 발주된 상품의 ID (FK)
    orders_quantity NUMBER,                       -- 발주된 상품의 수량
    product_price NUMBER,                         -- 발주 시 상품의 단가
    delivery_date DATE,                           -- 발주된 상품의 납품 예정일
    orders_status NUMBER(1) DEFAULT 1,            -- 발주 상태 (1: 발주 대기, 2: 발주 완료)
    CONSTRAINT orders_userid_fk FOREIGN KEY (userid) REFERENCES erp_user(userid),
    CONSTRAINT orders_supplier_fk FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id),
    CONSTRAINT orders_product_fk FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE SEQUENCE orders_seq;

 */

@Data
public class Orders {
	private int ordersId;           
    private String ordersDate;          
    private String userid;           
    private int supplierId;          
    private int productId;         
    private int ordersQuantity;   
    private int productPrice;    
    private String deliveryDate;        
    private int ordersStatus;     
}
