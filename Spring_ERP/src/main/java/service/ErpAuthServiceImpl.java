package service;

import dto.ErpAuth;
import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import repository.ErpAuthDAO;
import repository.ErpUserDAO;
import util.Pager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ErpAuthServiceImpl implements ErpAuthService {
    private final ErpAuthDAO erpAuthDAO;

    @Override
    public void addErpAuth(ErpAuth erpAuth) {
        erpAuthDAO.insertErpAuth(erpAuth);
    }

    @Override
    public void deleteErpAuth(String id) {
        erpAuthDAO.deleteAuth(id);
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
