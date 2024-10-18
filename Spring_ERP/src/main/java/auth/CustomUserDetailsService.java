package auth;

import dto.ErpAuth;
import dto.ErpUser;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import repository.ErpAuthDAO;
import repository.ErpUserDAO;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
    private final ErpUserDAO erpUserDAO;
    private final ErpAuthDAO erpAuthDAO;

    // 사용자 ID를 기준으로 사용자 정보를 조회하는 메서드
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        ErpUser user = erpUserDAO.selectErpUserByUserid(username);

        if(user == null) {
            throw new UsernameNotFoundException(username);
        }

        // 부서 권한 조회
        List<ErpAuth> departmentAuthList = erpAuthDAO.findAuthByOrgId(user.getOrgId());

        return new CustomUserDetails(user, departmentAuthList);
    }
}
