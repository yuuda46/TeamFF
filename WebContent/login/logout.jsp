<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // セッションを破棄
    session.invalidate();
%>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>ログアウト</title>
    <script>
        // カウントダウン用の秒数を設定
        var countdown = 5;

        // カウントダウンを表示する関数
        function updateCountdown() {
            if (countdown <= 0) {
                window.location.href = "../common/index.jsp"; // 5秒後に自動で遷移
            } else {
                document.getElementById("countdown").textContent = countdown + "秒後にホーム画面へ戻ります";
                countdown--; // 秒数を1減らす
            }
        }

        // 1秒ごとにカウントダウンを更新
        setInterval(updateCountdown, 1000);
    </script>
</head>
<body>
    <h1>ログアウトしました</h1>
    <p id="countdown">5秒後にホーム画面へ戻ります</p> <!-- カウントダウン表示 -->

    <p><a href="../common/index.jsp">今すぐ戻る</a></p> <!-- 手動で戻るリンク -->
</body>
</html>
