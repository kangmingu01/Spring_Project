package mapper;

import dto.Organization;

import java.util.List;
import java.util.Map;

public interface OrganizationMapper {
    int insertOrganization(Organization organization);
    int updateOrganization(Organization organization);
    int deleteOrganization(String orgId);
    int selectOrganizationCount(Map<String, String> map);
    List<Organization> selectOrganizationList(Map<String, String> map);
}
