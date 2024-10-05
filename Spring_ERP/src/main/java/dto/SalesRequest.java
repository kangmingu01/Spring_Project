package dto;

import lombok.Data;

/*
CREATE TABLE salesRequest (
	    requestId NUMBER PRIMARY KEY,                    -- 요청 고유 식별자
	    requestDate DATE DEFAULT SYSDATE,                -- 요청 날짜 (기본값: 현재 날짜)
	    org_id VARCHAR2(30) , CONSTRAINT salesRequest_org_id_fk FOREIGN KEY (org_id) REFERENCES organization(org_id),   -- 점주 ID
	    product_id NUMBER, CONSTRAINT salesRequest_product_fk FOREIGN KEY (product_id) REFERENCES product(product_id),   -- 요청된 신발의 ID (FK)
	    requestQuantity NUMBER ,                 -- 요청된 신발의 수량
	    salesPrice NUMBER(10, 2) ,               -- 요청된 신발의 판매가
	    tax NUMBER(10, 2),                               -- 세금 (자동 계산)
	    totalAmount NUMBER(10, 2),                       -- 총액 (자동 계산)
	    requestStatus NUMBER DEFAULT 1                   -- 요청 상태 (1 = 요청됨, 2 = 처리됨 등)
	);
	CREATE SEQUENCE salesRequest_seq; -- 시퀏스
	*/
@Data
public class SalesRequest {
	private int requestId;
	private String requestDate;
	private String orgId;
	private int productId;
	private int requestQuantity;
	private double salesPrice;
	private double tax;
	private double totalAmount;
	private int requestStatus;
	private String orgName;
	private String productCategory;
	private String productName;

}
