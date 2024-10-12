package service;

import dto.ErpAuth;
import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import repository.ErpAuthDAO;
import util.Pager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ErpAuthServiceImpl implements ErpAuthService {
    private final ErpAuthDAO erpAuthDAO;

    @Transactional
    @Override
    public boolean addErpAuth(ErpAuth erpAuth) {
        int authExists = erpAuthDAO.checkAuthExists(erpAuth);
        if (authExists == 0) {
            erpAuthDAO.insertErpAuth(erpAuth);
            return true; // 성공
        } else {
            return false; // 실패
        }
    }

    @Transactional
    @Override
    public void deleteErpAuth(ErpAuth erpAuth) {
        erpAuthDAO.deleteAuth(erpAuth);
    }

    @Override
    public Map<String, Object> getErpAuthList(Map<String, Object> map) {
        int pageNum = 1;
        if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
            pageNum = Integer.parseInt(map.get("pageNum").toString());
        }

        int pageSize = 5;
        if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
            pageSize = Integer.parseInt(map.get("pageSize").toString());
        }

        int totalAuthList = erpAuthDAO.selectAuthCount(map);


        int blockSize = 5;

        Pager pager = new Pager(pageNum, pageSize, totalAuthList, blockSize);

        map.put("startRow", pager.getStartRow() );
        map.put("endRow", pager.getEndRow());
        List<ErpAuth> erpAuthList = erpAuthDAO.selectAuthList(map);

        Map<String, Object> result = new HashMap<>();
        result.put("pager", pager);
        result.put("erpAuthList", erpAuthList);

        return result;
    }

    @Override
    public List<ErpUser> getErpAuthById(Map<String, Object> map) {
        return erpAuthDAO.selectErpAuthById(map);
    }
}
