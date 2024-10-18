package service;

import dto.ErpAuth;
import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import repository.ErpUserDAO;
import util.Pager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ErpUserServiceImpl implements ErpUserService {
    private final ErpUserDAO erpUserDAO;
    /* 유저 추가 */
    @Transactional
    @Override
    public void addErpUser(ErpUser erpUser) {
        erpUserDAO.insertErpUser(erpUser);
    }

    /* 유저 정보 업데이트 */
    @Transactional
    @Override
    public void updateErpUser(ErpUser erpUser) {
        erpUserDAO.updateErpUser(erpUser);
    }

    @Transactional
    @Override
    public void deleteErpUser(String userid) {
        erpUserDAO.deleteErpUser(userid);
    }

    /* 유저 아이디로 유저 찾기 */
    @Override
    public ErpUser getErpUserByUserid(String userid) {
        return erpUserDAO.selectErpUserByUserid(userid);
    }

    /* 리스트 페이징 */
    @Override
    public Map<String, Object> getErpUserList(Map<String, Object> map) {
        int pageNum = 1;
        if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
            pageNum = Integer.parseInt(map.get("pageNum").toString());
        }

        int pageSize = 5;
        if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
            pageSize = Integer.parseInt(map.get("pageSize").toString());
        }

        int totalUserList = erpUserDAO.selectUserCount(map);

        int blockSize = 5;

        Pager pager = new Pager(pageNum, pageSize, totalUserList, blockSize);

        map.put("startRow", pager.getStartRow() );
        map.put("endRow", pager.getEndRow());
        List<ErpUser> erpUserList = erpUserDAO.selectUserList(map);

        Map<String, Object> result = new HashMap<>();
        result.put("pager", pager);
        result.put("erpUserList", erpUserList);

        return result;
    }
}
