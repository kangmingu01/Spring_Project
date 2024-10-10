package mapper;

import dto.ErpAuth;
import dto.ErpUser;

import java.util.List;
import java.util.Map;

public interface ErpAuthMapper {
    int insertErpAuth(ErpAuth erpAuth);
    int deleteAuth(String id);

    /* 리스트 페이징 */
    int selectAuthCount(Map<String, Object> map);
    List<ErpAuth> selectAuthList(Map<String, Object> map);

    /* 검색 값 */
    List<ErpUser> selectErpAuthById(Map<String, Object> map);
}
