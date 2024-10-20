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

    /* 기본값을 상수로 선언하여 가독성을 높임, 또한 유지보수 효율성을 높임 */
    private static final int DEFAULT_PAGE_NUM = 1;
    private static final int DEFAULT_PAGE_SIZE = 5;
    private static final int DEFAULT_BLOCK_SIZE = 5;

    @Transactional
    @Override
    public void addOrganization(Organization organization) {
        organizationDAO.insertOrganization(organization);
    }

    @Transactional
    @Override
    public void updateOrganization(Organization organization) {
        organizationDAO.updateOrganization(organization);
    }

    @Transactional
    @Override
    public void deleteOrganization(String orgId) {
        organizationDAO.deleteOrganization(orgId);
    }

    @Override
    public Map<String, Object> getOrganizationList(Map<String, Object> map) {
        int pageNum = DEFAULT_PAGE_NUM;
        if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
            pageNum = Integer.parseInt(map.get("pageNum").toString());
        }

        int pageSize = DEFAULT_PAGE_SIZE;
        if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
            pageSize = Integer.parseInt(map.get("pageSize").toString());
        }

        int totalOrganizationList = organizationDAO.selectOrganizationCount(map);

        int blockSize = DEFAULT_BLOCK_SIZE;

        Pager pager = new Pager(pageNum, pageSize, totalOrganizationList, blockSize);

        map.put("startRow", pager.getStartRow() );
        map.put("endRow", pager.getEndRow());

        List<Organization> organizationList = organizationDAO.selectOrganizationList(map);

        Map<String, Object> result = new HashMap<>();
        result.put("pager", pager);
        result.put("organizationList", organizationList);

        return result;
    }

    @Override
    public String generateNextOrgId(String orgPrefix) {
        String lastOrgId = organizationDAO.selectLastOrgId(orgPrefix);
        if (lastOrgId == null) {
            // 만약 해당 prefix로 조직이 없다면 첫 번째 ID를 "001"로 설정합니다.
            return orgPrefix + "001";
        }
        // 마지막으로 생성된 조직 ID의 숫자 부분을 추출하고, 1을 더해 다음 순번을 생성합니다.
        int nextNum = Integer.parseInt(lastOrgId.substring(orgPrefix.length())) + 1;
        // 새로운 조직 ID를 생성하고, 숫자는 항상 3자리로 포맷합니다 (예: 001, 002, ...).
        return orgPrefix + String.format("%03d", nextNum);
    }
}
