package repository;

import dto.Organization;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class OrganizationDAOImpl implements OrganizationDAO {
    private final SqlSession sqlSession;
    @Override
    public int insertOrganization(Organization organization) {
        return sqlSession.insert("Organization.insertOrganization", organization);
    }

    @Override
    public int updateOrganization(Organization organization) {
        return sqlSession.update("Organization.updateOrganization", organization);
    }

    @Override
    public int deleteOrganization(String orgId) {
        return sqlSession.delete("Organization.deleteOrganization", orgId);
    }


    @Override
    public int selectOrganizationCount(Map<String, Object> map) {
        return sqlSession.selectOne("Organization.selectOrganizationCount", map);
    }

    @Override
    public List<Organization> selectOrganizationList(Map<String, Object> map) {
        return sqlSession.selectList("Organization.selectOrganizationList", map);
    }
}
