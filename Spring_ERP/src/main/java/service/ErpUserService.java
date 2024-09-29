package service;

import dto.ErpAuth;
import dto.ErpUser;

public interface ErpUserService {
    void addErpUser(ErpUser erpUser);
    void updateErpUser(ErpUser erpUser);
    ErpUser getErpUserByUserid(String userid);
    void addErpAuth(ErpAuth erpAuth);
}
