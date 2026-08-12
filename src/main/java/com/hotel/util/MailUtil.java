package com.hotel.model;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class MailUtil {

    // Dùng Gmail App Password, KHÔNG dùng mật khẩu Gmail thật
    private static final String FROM_EMAIL = "your-app@gmail.com";
    private static final String APP_PASSWORD = "xxxx xxxx xxxx xxxx";

    public static void sendOtpEmail(String toEmail, String otpCode) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã xác minh đăng ký - Luxury Hotel");
            message.setText("Mã OTP của bạn là: " + otpCode + "\nMã có hiệu lực trong 5 phút.");

            Transport.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
            throw new RuntimeException("Gửi email thất bại", e);
        }
    }

    public static String generateOtp() {
        int otp = (int) (Math.random() * 900000) + 100000; // 6 chữ số
        return String.valueOf(otp);
    }
}
