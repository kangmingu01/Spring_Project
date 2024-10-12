package mapper;

import dto.Organization;

import java.util.List;
import java.util.Map;

public interface OrganizationMapper {
    int insertOrganization(Organization organization);
    int updateOrganization(Organization organization);
    int deleteOrganization(String orgId);

    /* 전체 갯수 가져오는 Mapper */
    int selectOrganizationCount(Map<String, Object> map);
    /* 전체 리스트, 페이징, 검색 Mapper */
    List<Organization> selectOrganizationList(Map<String, Object> map);
    /* 최근에 생성된 조직 ID를 조회 Mapper */
    String selectLastOrgId(String orgPrefix);
}
