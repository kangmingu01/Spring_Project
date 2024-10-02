package auth;

import org.springframework.security.crypto.password.PasswordEncoder;

public class CustomPasswordEncoder implements PasswordEncoder {
    // 매개변수로 전달받은 문자열을 암호화 처리해 반환하는 메소드
    @Override
    public String encode(CharSequence rawPassword) {
        return rawPassword.toString();
    }

    // 매개변수로 전달받은 암호화된 문자열과 일반 문자열을 비교하여 비교결과를 논리값으로 반환하는 메소드
    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        // 비교
        return rawPassword.toString().equals(encodedPassword);
    }
}
