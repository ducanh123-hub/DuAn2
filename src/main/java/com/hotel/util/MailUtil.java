package com.hotel.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class MailUtil {

    // Gmail dùng để gửi OTP
    private static final String FROM_EMAIL =
            "manhlion060@gmail.com";

    // Google App Password - KHÔNG phải mật khẩu Gmail
    private static final String APP_PASSWORD =
            "rxwjewgkilpiaign";

    public static void sendOtpEmail(
            String toEmail,
            String otpCode) {

        Properties props = new Properties();

        props.put(
                "mail.smtp.auth",
                "true"
        );

        props.put(
                "mail.smtp.starttls.enable",
                "true"
        );

        props.put(
                "mail.smtp.host",
                "smtp.gmail.com"
        );

        props.put(
                "mail.smtp.port",
                "587"
        );

        Session session =
                Session.getInstance(
                        props,
                        new Authenticator() {

                            @Override
                            protected PasswordAuthentication
                            getPasswordAuthentication() {

                                return new PasswordAuthentication(
                                        FROM_EMAIL,
                                        APP_PASSWORD
                                );
                            }
                        }
                );

        try {

            Message message =
                    new MimeMessage(session);

            message.setFrom(
                    new InternetAddress(FROM_EMAIL)
            );

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );

            message.setSubject(
                    "Mã xác minh đăng ký - Luxury Hotel"
            );

            message.setText(
                    "Xin chào,\n\n" +
                            "Mã OTP đăng ký tài khoản của bạn là:\n\n" +
                            otpCode + "\n\n" +
                            "Mã OTP có hiệu lực trong 5 phút.\n\n" +
                            "Nếu bạn không thực hiện đăng ký, " +
                            "vui lòng bỏ qua email này.\n\n" +
                            "Luxury Hotel"
            );

            Transport.send(message);

        } catch (MessagingException e) {

            e.printStackTrace();

            throw new RuntimeException(
                    "Gửi email thất bại",
                    e
            );
        }
    }

    public static String generateOtp() {

        int otp =
                (int) (Math.random() * 900000) + 100000;

        return String.valueOf(otp);
    }
}