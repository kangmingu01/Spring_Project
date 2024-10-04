package dto;

/*
CREATE TABLE erp_auth
(
    userid VARCHAR2(100),                                                    -- 사용자 ID (FK)
    auth   VARCHAR2(50),                                                     -- 권한 (예: ROLE_USER, ROLE_ADMIN 등)
    CONSTRAINT fk_user_id FOREIGN KEY (userid) REFERENCES erp_user (userid), -- 외래 키 (erp_user 테이블 참조)
    CONSTRAINT uq_user_auth UNIQUE (userid, auth)                            -- UNIQUE 제약 조건 추가
);
*/

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ErpAuth {
    private String userid;
    private String auth;
}
