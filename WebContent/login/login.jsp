<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %> <!-- セッションを有効にする -->
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ログインページ</title>
<header>


<h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>



</header>

<style>
/* 共通 */
/* 背景画像の設定 */
header {
    height: 300px; /* 高さを画面の一部に設定 */
    position: relative;
    background: url(../images/mainimg.jpg) no-repeat center center / cover; /* 背景画像の読み込み */
}

/* ロゴ画像のスタイル */
header #logo img {
    display: block;
    width: 200px; /* ロゴ画像の幅 */
    position: absolute;
    left: 50%;
    transform: translateX(-50%); /* 画像を中央に配置 */
    bottom: 80px; /* 画像を下から20pxに配置 */
}

/* タイトル */
h3 {
	font-size: 105px;
    color: #ffffff;
    width: 60px; /* ロゴ画像の幅 */
    height:140px;
    position: absolute;
    left: 55%;
    transform: translateX(-50%); /* 画像を中央に配置 */
    bottom: 90px; /* 画像を下から20pxに配置 */

    margin: 0;
}
body {
	margin: 0;
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
    background-color: #00bfff; /* 薄い青色 */
    color: white;
    cursor: pointer;
    border: none;
    padding: 12px;
    border-radius: 5px;
    font-size: 16px;
}

        button:hover {
            background-color: #0056b3;
        }
        h1{
			margin: 0;
		}



        .logout-btn {
            text-align: center;
        }

        .logout-btn a {
            padding: 10px 20px;
            background-color: #000000;
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

    footer {
    color: #000000; /* 文字色 */
    text-align: center;
    font-size: 85%; /* 文字サイズ */
    padding: 10px 0; /* 上下の余白を追加 */
    background-color: #f8f8f8; /* 背景色を薄いグレーに設定 */
    margin-top: 20px; /* 青い枠線の下に表示されるように余白を追加 */
}
h2 {
    text-align: center;  /* 中央揃え */
    color: #333;
    font-size: 2em;
    font-weight: bold;
    margin-bottom: 30px;

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

<h2>ログインページ</h2>

<div class="container">

<%
    String url = "jdbc:postgresql://localhost:5432/team_f";  // データベースURL
    String dbUser = "postgres";  // ユーザー名
    String dbPassword = "Team_F";  // パスワード
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
                Class.forName("org.postgresql.Driver");
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
                    String idFrag = rs.getString("ID");
                    session.setAttribute("sessionId", idFrag);
                    System.out.println("Session ID set: " + idFrag);
                    response.sendRedirect("../notice/Tokou.action"); // ログイン成功後、トップページへリダイレクト
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
<input type="text" name="username" placeholder="😆‍ユーザー名を入力" value="" required autocomplete="off">
</div>
<div class="form-group">
<label for="password">パスワード:</label>
<input type="password" name="password" placeholder="🔒パスワードを入力" value="" required autocomplete="off">
</div>
<button type="submit">ログイン</button>
</form>

    <!-- エラーメッセージ表示 -->
<p class="login-message"><%= loginMessage %></p>

    <p style="text-align: center;"><a href="pass_reset.jsp">パスワードを忘れた</a></p>
</div>
    <footer>
	<small>Copyright&copy; <a href="index.html">SAMPLE COMPANY</a> All Rights Reserved.</small>
	</footer>
</body>
</html>
