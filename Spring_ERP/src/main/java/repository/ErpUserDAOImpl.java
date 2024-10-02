package repository;

import dto.ErpAuth;
import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import mapper.ErpUserMapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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
    public ErpUser selectErpUserByUserid(String userid) {
        return sqlSession.getMapper(ErpUserMapper.class).selectErpUserByUserid(userid);
    }

    @Override
    public int insertErpAuth(ErpAuth erpAuth) {
        return sqlSession.getMapper(ErpUserMapper.class).insertErpAuth(erpAuth);
    }
}
