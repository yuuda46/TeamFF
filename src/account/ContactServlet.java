package account;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ContactServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // フォームから送信されたデータを取得
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        // メール送信
        String to = "recipient@example.com";  // 送信先のメールアドレスを設定
        String subject = "新しいお問い合わせ";
        String body = "名前: " + name + "\nメール: " + email + "\nメッセージ: " + message;

        try {
            sendEmail(to, subject, body);
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<html><body><h3>送信ありがとうございました！</h3></body></html>");
        } catch (MessagingException e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<html><body><h3>エラーが発生しました。もう一度お試しください。</h3></body></html>");
        }
    }

    // メール送信のためのヘルパーメソッド
    private void sendEmail(String to, String subject, String body) throws MessagingException {
    	String from = "ngn2349597@stu.o-hara.ac.jp";
    	String host = "smtp.gmail.com";
    	final String username = "narugakuruka@gmail.com";
    	final String password = "ewah cgxa yycs hbot";  // アプリパスワードを使用


        // プロパティの設定
        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.starttls.enable", "true");

        // セッションの作成
        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        // メールメッセージの作成
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject(subject);
        message.setText(body);

        // メールの送信
        Transport.send(message);
        System.out.println("メールが送信されました。");
    }
}
