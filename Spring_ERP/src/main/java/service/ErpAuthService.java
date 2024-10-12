package service;

import dto.ErpAuth;
import dto.ErpUser;

import java.util.List;
import java.util.Map;

public interface ErpAuthService {
    boolean addErpAuth(ErpAuth erpAuth);
    void deleteErpAuth(ErpAuth erpAuth);

    Map<String, Object> getErpAuthList(Map<String, Object> map);

    List<ErpUser> getErpAuthById(Map<String, Object> map);
}
