package dto;

import lombok.Data;

/*
CREATE TABLE settlement (
    settlement_id NUMBER PRIMARY KEY,             -- 구매정산의 고유 식별자 (기본 키)
    settlement_date DATE DEFAULT SYSDATE,         -- 구매정산 날짜 (기본값: 현재 날짜)
    userid VARCHAR2(100),                         -- 구매정산을 처리한 사용자 (FK)
    receiving_id NUMBER,                          -- 연관된 입고의 ID (FK)
    settlement_status NUMBER(1) DEFAULT 5,        -- 구매정산 상태 (5: 대기, 6: 완료)
    auth NUMBER,                                  -- Authorization level (used for bank transaction link)
    CONSTRAINT settlement_userid_fk FOREIGN KEY (userid) REFERENCES erp_user(userid),
    CONSTRAINT settlement_receiving_fk FOREIGN KEY (receiving_id) REFERENCES receiving(receiving_id),
    CONSTRAINT settlement_auth_fk FOREIGN KEY (auth) REFERENCES bank_kind(bank_id) -- 외래 키 제약 조건 추가
);

CREATE SEQUENCE settlement_seq;

 */


@Data
public class Settlement {
	private int settlementId;       
    private String settlementDate;
    private String userid;           
    private int receivingId;     
    private int settlementStatus;
    private int auth;            
}
