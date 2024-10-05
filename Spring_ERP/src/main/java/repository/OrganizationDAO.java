package repository;

import dto.Organization;

import java.util.List;
import java.util.Map;

public interface OrganizationDAO {
    int insertOrganization(Organization organization);
    int updateOrganization(Organization organization);
    int deleteOrganization(String orgId);
    int selectOrganizationCount(Map<String, Object> map);
    List<Organization> selectOrganizationList(Map<String, Object> map);
}
