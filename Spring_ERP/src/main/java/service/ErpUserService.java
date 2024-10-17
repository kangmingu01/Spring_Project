package service;

import dto.ErpAuth;
import dto.ErpUser;

import java.util.Map;

public interface ErpUserService {
    void addErpUser(ErpUser erpUser);
    void updateErpUser(ErpUser erpUser);
    void deleteErpUser(String userid);
    ErpUser getErpUserByUserid(String userid);
    
    Map<String, Object> getErpUserList(Map<String, Object> map);
}
