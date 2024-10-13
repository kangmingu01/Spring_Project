package dto;

import lombok.Data;

/*CREATE TABLE timecard (
    timeCard_id      NUMBER PRIMARY KEY,                                               -- 타임카드 고유 ID (PK)
    employee_id      NUMBER CONSTRAINT fk_timecard_employee_id REFERENCES employee(employee_id),  -- 직원 고유 ID (FK)
    org_id VARCHAR2(100) CONSTRAINT fk_timecard_org_id REFERENCES organization(org_id),       --  부서/매장 테이블 고유 ID                                         
    daily_work       VARCHAR2(500),                                                    -- 오늘 한 일
    worked_hours     NUMBER(5),                                                         -- 일한 시간
    timecard_date    DATE                                                                -- 타임 카드 작성일
);

	CREATE SEQUENCE TIMECARD_SEQ;*/

@Data
public class TimeCard {
	private int timeCardId;
	private int employeeId;
	private String orgId;
	private String dailyWork;
	private int workedHours;
	private String timeCardDate;
}
