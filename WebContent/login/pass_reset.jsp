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
<h3 class="titlesize">Login</h3>



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
    bottom: 80px; /* 画像を下から80pxに配置 */
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
    bottom: 90px; /* 画像を下から90pxに配置 */
    margin: 0;
}
body {
	margin: 0;
    min-height: 100vh; /* ビューポートの高さに合わせて最小高さを設定 */
    display: flex;
    flex-direction: column; /* コンテンツを縦に並べる */
}


        .form-group {
            margin: 10px 0;
        }

/* フォーム内の入力欄とボタンの中央揃え */
.container {
    display: flex;
    flex-direction: column;
    align-items: center; /* 水平方向の中央揃え */
    justify-content: center; /* 垂直方向の中央揃え（フォーム内のスペース調整） */
    text-align: center; /* フォーム内のテキストも中央揃え */
    margin-top: 50px; /* 必要に応じて上部に余白を追加 */
}

/* 入力欄とボタンのスタイルを調整 */
input[type="text"], input[type="password"], button, .reset-button, .back-button {
    width: 300px; /* 入力欄とボタンを同じ幅にする */
    height: 40px; /* 入力欄とボタンを同じ高さにする */
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    margin-bottom: 10px; /* 入力欄とボタンの間にスペース */
}

/* ボタンのスタイル */
button {
    background-color: #00bfff; /* 薄い青色 */
    color: white;
    cursor: pointer;
    border: none;
    font-size: 16px;
}

button:hover {
    background-color: #0056b3;
}

/* パスワードを忘れたボタンと戻るボタンのスタイル */
.reset-button, .back-button {
    display: inline-block; /* インラインブロック要素にして、横並びを防ぐ */
}

.reset-button:hover, .back-button:hover {
    background-color: #ff0000; /* ホバー時の色 */
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


    footer {
    color: #000000; /* 文字色 */
    text-align: center;
    font-size: 85%; /* 文字サイズ */
    padding: 10px 0; /* 上下の余白を追加 */
    background-color: #f8f8f8; /* 背景色を薄いグレーに設定 */
    margin-top: 60px; /* 青い枠線の下に表示されるように余白を追加 */
}
h2 {

    text-align: center;  /* 中央揃え */
    color: #333;
    font-size: 2em;
    font-weight: bold;
    margin-bottom: 10px; /* 下部のマージンを縮める */
}

.container {
    margin-top: 10px; /* ログインフォームの上部の余白を縮める */
}


/* ボタンの間隔を縮める */
button {
    margin-bottom: 5px; /* ログインボタンの下の余白を縮める */
}

/* 「パスワードを忘れた」ボタンとログインボタンの間隔を縮める */
p {
    margin-top: 5px;
    margin-bottom: 5px; /* 「パスワードを忘れた」ボタンとログインボタンの間隔を縮める */
}

/* 戻るボタンの間隔を縮める */
p a {
    margin-top: 5px;
    margin-bottom: 5px; /* 戻るボタンと「パスワードを忘れた」ボタンの間隔を縮める */
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

<h2>Login</h2>

<div class="container" id="loginFormContainer">
    <%
        String url = "jdbc:postgresql://localhost:5432/team_f";  // データベースURL
        String dbUser = "postgres";  // ユーザー名
        String dbPassword = "Team_F";  // パスワード
        String loginMessage = "";  // エラーメッセージを格納する変数
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        // パスワードの正規表現（半角英数字5文字以上、英字と数字を両方含む）
        String passwordRegex = "^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{5,}$";
        // ユーザー名は1文字以上の任意の文字列
        String usernameRegex = ".{1,}"; // 1文字以上

        try {
            // 入力されたユーザー名とパスワードを取得
            String inputUsername = request.getParameter("username");
            String inputPassword = request.getParameter("password");

            // パスワードやユーザー名のチェック
            if (inputUsername != null && inputPassword != null) {

                // ユーザー名が正規表現に一致しない場合、エラーメッセージを設定
                if (!inputUsername.matches(usernameRegex)) {
                    loginMessage = "ユーザー名は1文字以上で入力してください。";
                }
                // パスワードが正規表現に一致しない場合、エラーメッセージを設定
                else if (!inputPassword.matches(passwordRegex)) {
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
                        session.setAttribute("admin", "true".equalsIgnoreCase(adminFlag)); // 管理者権限の有
                        // ログイン成功後、トップページへリダイレクト
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

    <!-- エラーメッセージを表示 -->
    <div class="login-message">
        <%= loginMessage %>
    </div>

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
        <button type="submit" class="login-btn">ログイン</button>
    </form>

    <!-- 戻るボタン -->
    <p style="text-align: center;">
        <a href="../common/index.jsp" class="back-button">戻る</a>
    </p>

    <!-- パスワードを忘れたリンク -->
    <p style="text-align: center;">
        <a href="pass_reset.jsp" class="reset-link">パスワードを忘れた方は<span class="highlight">こちら</span></a>
    </p>
</div>

<!-- CSSスタイル -->
<style>
    .login-message {
        text-align: center;
        font-size: 16px;
        color: red;
        font-weight: bold;
        margin-bottom: 20px; /* フォームとの間にスペースを追加 */
    }

    /* その他のスタイル */
    .login-btn {
        width: 300px;
        height: 40px;
        background-color: black;
        color: white;
        font-size: 16px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .login-btn:hover {
        background-color: #ff4d4d;
    }

    .back-button {
        display: inline-block;
        padding: 10px 20px;
        background-color: #808080;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        font-size: 16px;
    }

    .back-button:hover {
        background-color: #e53935;
    }

    .reset-link {
        font-size: 16px;
        color: black;
        text-decoration: none;
    }

    .reset-link:hover {
        color: black;
    }

    .highlight {
        color: #ff0000;
        text-decoration: underline;
    }

    .highlight:hover {
        color: #cc0000;
    }
</style>

<%@ include file="scroll.jsp" %>


</body>
</html>
