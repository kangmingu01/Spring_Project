package service;

import dto.Organization;

import java.util.Map;

public interface OrganizationService {
    void addOrganization(Organization organization);
    void updateOrganization(Organization organization);
    void deleteOrganization(String orgId);

    Map<String, Object> getOrganizationList(Map<String, Object> map);
}
