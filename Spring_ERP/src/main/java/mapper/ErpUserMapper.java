package mapper;

import dto.ErpAuth;
import dto.ErpUser;

public interface ErpUserMapper {
    int insertErpUser(ErpUser erpUser);
    int updateErpUser(ErpUser erpUser);
    ErpUser selectErpUserByUserid(String userid);
    int insertErpAuth(ErpAuth erpAuth);
}
