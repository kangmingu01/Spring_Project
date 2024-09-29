package dto;

/*
CREATE TABLE organization
(
    org_id       VARCHAR2(100) PRIMARY KEY,          -- 조직 ID (PK, 부서 또는 지점)
    org_name     VARCHAR2(100) NOT NULL,             -- 조직 이름 (부서명 또는 지점명)
    org_type     VARCHAR2(10),                       -- 조직 유형 (예: '본사', '지점')
    address      VARCHAR2(255),                      -- 주소
    phone_number VARCHAR2(20),                       -- 전화번호
    created      TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- 생성 일시
);
*/

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Organization {
    private String orgId;
    private String orgName;
    private String orgType;
    private String address;
    private String phoneNumber;
    private Timestamp created;
}
