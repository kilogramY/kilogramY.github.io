package web;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends javax.mail.Authenticator {
    public PasswordAuthentication getPasswordAuthentication() {
        // �꽕�씠踰꾨굹 Gmail �궗�슜�옄 怨꾩젙 �꽕�젙.
        // Gmail�쓽 寃쎌슦 @gmail.com�쓣 �젣�쇅�븳 �븘�씠�뵒留� �엯�젰�븳�떎.
        return new PasswordAuthentication("kmhjn95", "anewlak12");
    }
}

