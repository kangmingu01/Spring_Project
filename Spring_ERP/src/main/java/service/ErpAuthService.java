package service;

import dto.ErpAuth;

import java.util.Map;

public interface ErpAuthService {
    void addErpAuth(ErpAuth erpAuth);
    void deleteErpAuth(String id);

    Map<String, Object> getErpAuthList(Map<String, Object> map);
}
