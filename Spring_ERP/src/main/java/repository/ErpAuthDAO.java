package repository;

import dto.ErpAuth;

import java.util.List;
import java.util.Map;

public interface ErpAuthDAO {
    int insertErpAuth(ErpAuth erpAuth);
    int deleteAuth(String id);

    /* 리스트 페이징 */
    int selectAuthCount(Map<String, Object> map);
    List<ErpAuth> selectAuthList(Map<String, Object> map);
}
