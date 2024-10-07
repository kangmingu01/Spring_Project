package dto;

/*
CREATE TABLE erp_user
(
    userid   VARCHAR2(100) PRIMARY KEY,                                        -- 사용자 ID (PK)
    passwd   VARCHAR2(100) NOT NULL,                                           -- 비밀번호
    name     VARCHAR2(50)  NOT NULL,                                           -- 사용자 이름
    phone    VARCHAR2(30),                                                     -- 전화번호
    address  VARCHAR2(255),                                                    -- 주소 추가
    email    VARCHAR2(50),                                                     -- 이메일
    gender   NUMBER,                                                           -- 성별 (1: 남성, 2: 여성 등)
    birthday DATE,                                                             -- 생년월일
    joindate DATE,                                                             -- 입사일
    enabled  NUMBER(1) DEFAULT 1,                                              -- 계정 활성 상태 (1: 활성, 0: 비활성)
    org_id   VARCHAR2(100),                                                    -- 조직 ID (부서 또는 지점)
    CONSTRAINT fk_org_id FOREIGN KEY (org_id) REFERENCES organization (org_id) -- 외래 키 (organization 테이블 참조)
);
*/

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ErpUser {
    private String userid;      // 사용자 ID
    private String passwd;      // 비밀번호
    private String name;        // 사용자 이름
    private String phone;       // 전화번호
    private String address;     // 주소
    private String email;       // 이메일
    private int gender;     // 성별 (1: 남성, 2: 여성 등)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate birthday;      // 생년월일
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate joindate;      // 입사일
    private int enabled;    // 계정 활성 상태 (1: 활성, 0: 비활성)
    private String orgId;      // 조직 ID (부서 또는 지점)
    private List<ErpAuth> erpAuthList;  // 동일 사용자가 여러 권한을 가질 수 있음
}
