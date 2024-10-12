package mapper;

import dto.ErpAuth;
import dto.ErpUser;

import java.util.List;
import java.util.Map;

public interface ErpUserMapper {
    int insertErpUser(ErpUser erpUser);
    int updateErpUser(ErpUser erpUser);
    int deleteErpUser(String userid);
    ErpUser selectErpUserByUserid(String userid);
    /*int insertErpAuth(ErpAuth erpAuth);*/

    /* 리스트 페이징 */
    int selectUserCount(Map<String, Object> map);
    List<ErpUser> selectUserList(Map<String, Object> map);
}
