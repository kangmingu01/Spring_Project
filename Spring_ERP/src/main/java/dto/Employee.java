package dto;

/*
 * CREATE TABLE employee (
	    employee_id    number PRIMARY KEY,                                      -- 직원 고유 ID (PK)
	    userid         VARCHAR2(100) NOT NULL,                                         -- 사용자 ID (FK, erp_user 테이블 참조)
	    org_id         VARCHAR2(100),                                                  -- 조직 ID (FK, organization 테이블 참조)
	    created_date   DATE ,                                          -- 직원 ID 생성일
	    sicktime       NUMBER(3),                                                     -- 병가 남은 시간
	    vacationhours  NUMBER(3),                                                     -- 휴가 남은 시간
	    overtimes      NUMBER(3),                                                     -- 초과 근무 시간
	    salary         NUMBER(30),                                                    -- 급여
	    bonus          NUMBER(30),                                                    -- 보너스 급여
	    salary_date    DATE,                                                           -- 급여 지급일

	    
	    CONSTRAINT fk_emp_user_id FOREIGN KEY (userid) REFERENCES erp_user(userid),    -- 사용자 ID (FK, erp_user 테이블 참조)
	    CONSTRAINT fk_emp_org_id FOREIGN KEY (org_id) REFERENCES organization(org_id)  -- 조직 ID (FK, organization 테이블 참조)
	);

	CREATE SEQUENCE employee_seq;

*
*/

public class Employee {
	private int employeeId;
	private String userid;
	private String orgId;
	private int sickTime;
	private int vacationHours;
	private int overTimes;
	private int salary;
	private int bonus;
	private String salaryDate;
}
