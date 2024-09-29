package auth;

import dto.ErpAuth;
import dto.ErpUser;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

// 인증된 사용자 정보와 권한 정보를 저장하기 위한 클래스
// => 인증 성공 후 인증 정보 및 권한 정보가 저장된 UserDetails 객체를 Spring Security로부터 제공


@Data
public class CustomUserDetails implements UserDetails {
    private static final long serialVersionUID = 1L;

    // 인증된 사용자 정보가 저장될 필드 작성
    private String userid;      // 사용자 ID
    private String passwd;      // 비밀번호
    private String name;        // 사용자 이름
    private String phone;       // 전화번호
    private String address;     // 주소
    private String email;       // 이메일
    private int gender;     // 성별 (1: 남성, 2: 여성 등)
    private LocalDate birthday;      // 생년월일
    private LocalDate joindate;      // 입사일
    private int enabled;    // 계정 활성 상태 (1: 활성, 0: 비활성)
    private String orgId;      // 조직 ID (부서 또는 지점)

    // 인증된 사용자의 모든 권한 정보가 저장될 필드 작성
    private List<GrantedAuthority> erpAuthList;

    public CustomUserDetails(ErpUser user) {
        this.userid = user.getUserid();
        this.passwd = user.getPasswd();
        this.name = user.getName();
        this.phone = user.getPhone();
        this.address = user.getAddress();
        this.email = user.getEmail();
        this.gender = user.getGender();
        this.birthday = user.getBirthday();
        this.joindate = user.getJoindate();
        this.enabled = user.getEnabled();
        this.orgId = user.getOrgId();

        this.erpAuthList = new ArrayList<GrantedAuthority>();

        for(ErpAuth auth : user.getErpAuthList()) {
            this.erpAuthList.add(new SimpleGrantedAuthority(auth.getAuth()));
        }
    }

    // 인증된 사용자의 권한정보를 반환하는 메소드
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return erpAuthList;
    }

    // 인증된 사용자의 비밀번호를 반환하는 메소드
    @Override
    public String getPassword() {
        return passwd;
    }

    // 인증된 사용자의 식별자(아이디)를 반환하는 메소드
    @Override
    public String getUsername() {
        return userid;
    }

    // 인증된 사용자의 유효기간 상태를 반환하는 메소드
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    // 인증된 사용자의 잠금 상태를 반환하는 메소드
    @Override
    public boolean isAccountNonLocked() {
        return false;
    }

    // 인증된 사용자 비밀번호의 유효기간 상태를 반환하는 메소드
    @Override
    public boolean isCredentialsNonExpired() {
        return false;
    }

    // 인증된 사용자의 활성화 상태를 반환하는 메소드
    @Override
    public boolean isEnabled() {
        if(enabled == 0) {
            return false;
        } else {
            return true;
        }
    }
}
