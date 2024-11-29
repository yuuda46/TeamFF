<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %> <!-- セッションを有効にする -->
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ログインページ</title>
<style>

        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 20px;
        }

        .container {
            width: 300px;
            margin: 0 auto;
            padding: 30px;
            border: 2px solid #007bff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: left;
        }

        .form-group {
            margin: 10px 0;
        }

        input[type="text"], input[type="password"], button {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 10px;
            box-sizing: border-box;
            height: 40px;
        }

        button {
            background-color: #007bff;
            color: white;
            cursor: pointer;
            border: none;
        }

        button:hover {
            background-color: #0056b3;
        }

        h2 {
            text-align: center;
        }

        .logout-btn {
            text-align: center;
        }

        .logout-btn a {
            padding: 10px 20px;
            background-color: #dc3545;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 16px;
        }

        .logout-btn a:hover {
            background-color: #c82333;
        }

        .login-message {
            text-align: center;
            font-size: 18px;
            color: red;
            font-weight: bold;
        }

        /* ラベルのスタイル */
        label {
        display: block;
        text-align: left;
        margin-bottom: 5px;
        }

        input:focus {
        border: 2px solid red;  /* 赤色の枠線 */
        outline: none; /* 追加のアウトラインを削除 */
    }
</style>
</head>

<%
    if (session.getAttribute("username") != null) {
        response.sendRedirect("../common/index.jsp");
        return;
    }
%>
<body>

<h1>ログインページ</h1>

<div class="container">

<%
    String url = "jdbc:h2:tcp://localhost:9092/~/Team_F";  // データベースURL
    String dbUser = "sa";  // ユーザー名
    String dbPassword = "";  // パスワード
    String loginMessage = "";  // エラーメッセージを格納する変数
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    try {
        // 入力されたユーザー名とパスワードを取得
        String inputUsername = request.getParameter("username");
        String inputPassword = request.getParameter("password");
        // パスワードの正規表現（半角英数字5文字以上、英字と数字を両方含む）
        String regex = "^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{5,}$"; // 半角英数字5文字以上、英字と数字を両方含む
        // ユーザー名は1文字以上の任意の文字列
        String usernameRegex = ".{1,}"; // 1文字以上
        // ユーザー名とパスワードのチェック

        if (inputUsername != null && inputPassword != null) {

            // ユーザー名が正規表現に一致しない場合、エラーメッセージを設定

            if (!inputUsername.matches(usernameRegex)) {

                loginMessage = "ユーザー名は1文字以上で入力してください。";

            }

            // パスワードが正規表現に一致しない場合、エラーメッセージを設定

            else if (!inputPassword.matches(regex)) {

                loginMessage = "パスワードは半角英数字5文字以上で、英字と数字を両方含む必要があります。";

            }

            // パスワードに同じ文字が連続して使われていないかチェック

            else if (inputPassword.matches("(.)\\1")) {

                loginMessage = "パスワードには同じ文字を連続して使用できません。";

            } else {
                // データベース接続
                Class.forName("org.h2.Driver");
                conn = DriverManager.getConnection(url, dbUser, dbPassword);
                // ユーザー名とパスワードの組み合わせを確認するクエリ
                String query = "SELECT * FROM SIGNUP WHERE USER_NAME = ? AND PASSWORD = ?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, inputUsername.trim()); // 入力値をトリム
                stmt.setString(2, inputPassword.trim());
                // クエリ実行
                rs = stmt.executeQuery();
                if (rs.next()) {
                    // ログイン成功時
                    loginMessage = "ログイン成功";
                    // セッションを設定
                    session.setAttribute("username", inputUsername);
                    session.setAttribute("password", inputPassword);
                 // 管理者フラグの取得とセッション保存
                    String adminFlag = rs.getString("ADMINI");
                    session.setAttribute("admin", "true".equalsIgnoreCase(adminFlag)); // 管理者権限の有                    // ログイン成功後、トップページへリダイレクト
                    response.sendRedirect("../common/index.jsp"); // ログイン成功後、トップページへリダイレクト
                    return; // 処理終了
                } else {

                    // ログイン失敗時

                    loginMessage = "ユーザー名またはパスワードが間違っています。";
                }
            }
        }
    } catch (Exception e) {
        loginMessage = "データベースエラー: " + e.getMessage();
    } finally {
        // リソースのクローズ
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

    <!-- ログインフォーム -->
<form method="POST" action="login.jsp" autocomplete="off">
<div class="form-group">
<label for="username">ユーザー名:</label>
<input type="text" name="username" placeholder="ユーザー名を入力" value="" required autocomplete="off">
</div>
<div class="form-group">
<label for="password">パスワード:</label>
<input type="password" name="password" placeholder="パスワードを入力" value="" required autocomplete="off">
</div>
<button type="submit">ログイン</button>
</form>

    <!-- エラーメッセージ表示 -->
<p class="login-message"><%= loginMessage %></p>

    <p style="text-align: center;"><a href="pass_reset.jsp">パスワードを忘れた</a></p>
</div>

</body>
</html>
