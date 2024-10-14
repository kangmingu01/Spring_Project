package repository;

import dto.ErpAuth;
import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import mapper.ErpAuthMapper;
import mapper.ErpUserMapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class ErpAuthDAOImpl implements ErpAuthDAO {
    private final SqlSession sqlSession;

    @Override
    public int checkAuthExists(ErpAuth erpAuth) {
        return sqlSession.getMapper(ErpAuthMapper.class).checkAuthExists(erpAuth);
    }

    @Override
    public int insertErpAuth(ErpAuth erpAuth) {
        return sqlSession.getMapper(ErpAuthMapper.class).insertErpAuth(erpAuth);
    }

    @Override
    public int deleteAuth(ErpAuth erpAuth) {
        return sqlSession.getMapper(ErpAuthMapper.class).deleteAuth(erpAuth);
    }

    @Override
    public int selectAuthCount(Map<String, Object> map) {
        return sqlSession.getMapper(ErpAuthMapper.class).selectAuthCount(map);
    }

    @Override
    public List<ErpAuth> selectAuthList(Map<String, Object> map) {
        return sqlSession.getMapper(ErpAuthMapper.class).selectAuthList(map);
    }

    @Override
    public List<ErpUser> selectErpAuthById(Map<String, Object> map) {
        return sqlSession.getMapper(ErpAuthMapper.class).selectErpAuthById(map);
    }
}
