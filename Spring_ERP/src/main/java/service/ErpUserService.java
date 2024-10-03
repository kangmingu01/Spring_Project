package service;

import dto.ErpAuth;
import dto.ErpUser;

import java.util.Map;

public interface ErpUserService {
    void addErpUser(ErpUser erpUser);
    void updateErpUser(ErpUser erpUser);
    ErpUser getErpUserByUserid(String userid);
    void addErpAuth(ErpAuth erpAuth);
    
    Map<String, Object> getErpUserList(Map<String, Object> map);
}
