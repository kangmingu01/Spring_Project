package repository;

import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Service
@RequiredArgsConstructor
public class EmailService {
    private final JavaMailSender mailSender;
    /* 이메일 작성시 서비스 메서드에 자동으로 값이 들어갈 수 있게 설정 */
    @Async
    public void sendRegistrationEmail(String toEmail, String userId, String password) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(toEmail);
            helper.setSubject("Spring ERP 시스템 초기 로그인 정보 알려드립니다");

            String htmlContent = "<html><body style='font-family: Arial, sans-serif;'>"
                + "<h2 style='color: #007bff;'>Spring ERP 시스템 초기 로그인 정보</h2>"
                + "<p>안녕하세요,</p>"
                + "<p>아래는 귀하의 Spring ERP 시스템 초기 계정 정보입니다:</p>"
                + "<table style='border-collapse: collapse;'>"
                + "<tr>"
                + "<td style='padding: 8px; font-weight: bold;'>사용자 ID:</td>"
                + "<td style='padding: 8px;'>" + userId + "</td>"
                + "</tr>"
                + "<tr>"
                + "<td style='padding: 8px; font-weight: bold;'>초기 비밀번호:</td>"
                + "<td style='padding: 8px;'>" + password + "</td>"
                + "</tr>"
                + "</table>"
                + "<p>아래 링크를 통해 로그인 후 반드시 비밀번호를 변경해 주세요.</p>"
                /* 임시 나중에 EmailService 로그인 바꿔야됨 */
                + "<p><a href='http://localhost:8000/spring/login' style='color: #007bff;'>비밀번호 변경 링크</a></p>"
                + "<br>"
                + "<p>감사합니다.</p>"
                + "</body></html>";
            helper.setText(htmlContent, true);
            mailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
