package repository;

import dto.ErpAuth;
import dto.ErpUser;

public interface ErpUserDAO {
    int insertErpUser(ErpUser erpUser);
    int updateErpUser(ErpUser erpUser);
    ErpUser selectErpUserByUserid(String userid);
    int insertErpAuth(ErpAuth erpAuth);
}
