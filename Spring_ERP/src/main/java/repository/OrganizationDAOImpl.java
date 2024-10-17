package repository;

import dto.Organization;
import lombok.RequiredArgsConstructor;
import mapper.OrganizationMapper;
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
        return sqlSession.getMapper(OrganizationMapper.class).insertOrganization(organization);
    }

    @Override
    public int updateOrganization(Organization organization) {
        return sqlSession.getMapper(OrganizationMapper.class).updateOrganization(organization);
    }

    @Override
    public int deleteOrganization(String orgId) {
        return sqlSession.getMapper(OrganizationMapper.class).deleteOrganization(orgId);
    }

    @Override
    public int selectOrganizationCount(Map<String, Object> map) {
        return sqlSession.getMapper(OrganizationMapper.class).selectOrganizationCount(map);
    }

    @Override
    public List<Organization> selectOrganizationList(Map<String, Object> map) {
        return sqlSession.getMapper(OrganizationMapper.class).selectOrganizationList(map);
    }

    @Override
    public String selectLastOrgId(String orgPrefix) {
        return sqlSession.getMapper(OrganizationMapper.class).selectLastOrgId(orgPrefix);
    }

    @Override
    public String selectOrgName(String orgId) {
        return sqlSession.getMapper(OrganizationMapper.class).selectOrgName(orgId);
    }
}
