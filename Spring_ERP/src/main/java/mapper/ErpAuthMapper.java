package mapper;

import dto.ErpAuth;
import dto.ErpUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ErpAuthMapper {
    int checkAuthExists(ErpAuth erpAuth);
    int insertErpAuth(ErpAuth erpAuth);
    int deleteAuth(ErpAuth erpAuth);

    /* 리스트 페이징 */
    int selectAuthCount(Map<String, Object> map);
    List<ErpAuth> selectAuthList(Map<String, Object> map);

    /* 검색 값 */
    List<ErpUser> selectErpAuthById(Map<String, Object> map);

    List<ErpAuth> findAuthByOrgId(String orgId);
}
