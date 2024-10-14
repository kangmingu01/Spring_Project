package repository;

import dto.ErpAuth;
import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import mapper.ErpUserMapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class ErpUserDAOImpl implements ErpUserDAO {
    private final SqlSession sqlSession;

    @Override
    public int insertErpUser(ErpUser erpUser) {
        return sqlSession.getMapper(ErpUserMapper.class).insertErpUser(erpUser);
    }

    @Override
    public int updateErpUser(ErpUser erpUser) {
        return sqlSession.getMapper(ErpUserMapper.class).updateErpUser(erpUser);
    }

    @Override
    public int deleteErpUser(String userid) {
        return sqlSession.getMapper(ErpUserMapper.class).deleteErpUser(userid);
    }

    @Override
    public ErpUser selectErpUserByUserid(String userid) {
        return sqlSession.getMapper(ErpUserMapper.class).selectErpUserByUserid(userid);
    }

/*    @Override
    public int insertErpAuth(ErpAuth erpAuth) {
        return sqlSession.getMapper(ErpUserMapper.class).insertErpAuth(erpAuth);
    }*/

    @Override
    public int selectUserCount(Map<String, Object> map) {
        return sqlSession.getMapper(ErpUserMapper.class).selectUserCount(map);
    }

    @Override
    public List<ErpUser> selectUserList(Map<String, Object> map) {
        return sqlSession.getMapper(ErpUserMapper.class).selectUserList(map);
    }
}
