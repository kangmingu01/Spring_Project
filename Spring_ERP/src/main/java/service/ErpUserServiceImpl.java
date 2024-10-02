package service;

import dto.ErpAuth;
import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import repository.ErpUserDAO;

@Service
@RequiredArgsConstructor
public class ErpUserServiceImpl implements ErpUserService {
    private final ErpUserDAO erpUserDAO;
    @Override
    public void addErpUser(ErpUser erpUser) {
        erpUserDAO.insertErpUser(erpUser);
    }

    @Override
    public void updateErpUser(ErpUser erpUser) {
        erpUserDAO.updateErpUser(erpUser);
    }

    @Override
    public ErpUser getErpUserByUserid(String userid) {
        return erpUserDAO.selectErpUserByUserid(userid);
    }

    @Override
    public void addErpAuth(ErpAuth erpAuth) {
        erpUserDAO.insertErpAuth(erpAuth);
    }
}
