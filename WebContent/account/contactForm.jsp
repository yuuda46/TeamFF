<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ja">
<header>
    <h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
</header>

<head>
    <!-- Link to the same stylesheet as the first JSP -->
    <link rel="stylesheet" href="../css/form.css">
</head>


<body>
    <h2>お問い合わせフォーム</h2>
    <form action="contactForm.jsp" method="post">
        <label for="name">お名前:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="email">メールアドレス:</label>
        <input type="email" id="email" name="email" required><br><br>

        <label for="message">お問い合わせ内容:</label><br>
        <textarea id="message" name="message" rows="4" required></textarea><br><br>

        <button type="submit">送信</button>

        <a href="../notice/Tokou.action">戻る</a>
    </form>

    <%-- メール送信処理 --%>
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String message = request.getParameter("message");

            // メール送信処理
            String to = "ngn2349597@stu.o-hara.ac.jp";  // 送信先/
            String from = "narugakuruka@gmail.com";     // 送信元

            String host = "smtp.gmail.com";
            java.util.Properties properties = System.getProperties();
            properties.setProperty("mail.smtp.host", host);
            properties.setProperty("mail.smtp.port", "587");
            properties.setProperty("mail.smtp.auth", "true");
            properties.setProperty("mail.smtp.starttls.enable", "true");

            final String username = "narugakuruka@gmail.com";
            final String password = "ewah cgxa yycs hbot"; // App Passwordを使用

            javax.mail.Session mailSession = javax.mail.Session.getInstance(properties, new javax.mail.Authenticator() {
                protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                    return new javax.mail.PasswordAuthentication(username, password);
                }
            });

            try {
                javax.mail.Message mimeMessage = new javax.mail.internet.MimeMessage(mailSession);
                mimeMessage.setFrom(new javax.mail.internet.InternetAddress(from));
                mimeMessage.addRecipient(javax.mail.Message.RecipientType.TO, new javax.mail.internet.InternetAddress(to));
                mimeMessage.setSubject("お問い合わせフォームからのメッセージ");
                mimeMessage.setText("お名前: " + name + "\n" +
                                    "メールアドレス: " + email + "\n" +
                                    "お問い合わせ内容: \n" + message);
                javax.mail.Transport.send(mimeMessage);

                out.println("<h2>お問い合わせが送信されました</h2>");
                out.println("<p>お問い合わせありがとうございます。確認後、担当者よりご連絡いたします。</p>");
            } catch (javax.mail.MessagingException mex) {
                out.println("<h2>メール送信に失敗しました。</h2>");
                mex.printStackTrace();
            }
        }
    %>
</body>
</html>
