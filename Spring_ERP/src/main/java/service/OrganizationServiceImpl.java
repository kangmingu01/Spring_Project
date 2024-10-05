package service;

import dto.Organization;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import repository.OrganizationDAO;
import util.Pager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class OrganizationServiceImpl implements OrganizationService {
    private final OrganizationDAO organizationDAO;

    @Transactional
    @Override
    public void addOrganization(Organization organization) {
        organizationDAO.insertOrganization(organization);
    }

    @Override
    public void updateOrganization(Organization organization) {
        organizationDAO.updateOrganization(organization);
    }

    @Override
    public void deleteOrganization(String orgId) {
        organizationDAO.deleteOrganization(orgId);
    }

    @Override
    public Map<String, Object> getOrganizationList(Map<String, Object> map) {
        int pageNum = 1;
        if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
            pageNum = Integer.parseInt(map.get("pageNum").toString());
        }

        int pageSize = 5;
        if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
            pageSize = Integer.parseInt(map.get("pageSize").toString());
        }

        int totalOrganizationList = organizationDAO.selectOrganizationCount(map);

        int blockSize = 5;

        Pager pager = new Pager(pageNum, pageSize, totalOrganizationList, blockSize);

        map.put("startRow", pager.getStartRow() );
        map.put("endRow", pager.getEndRow());

        List<Organization> organizationList = organizationDAO.selectOrganizationList(map);

        Map<String, Object> result = new HashMap<>();
        result.put("pager", pager);
        result.put("organizationList", organizationList);

        return result;
    }
}
