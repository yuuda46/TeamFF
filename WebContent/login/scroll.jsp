<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>スクロール機能</title>
</head>
<body>
    <script>
        // スクロール動作を制御する関数
        (function() {
            var scrolling = false;  // スクロール中かどうかを判定するフラグ

            // スクロールを少しずつ行う関数
            function smoothScroll() {
                if (scrolling) return;  // スクロール中は処理を中断する

                scrolling = true;

                var targetPosition = document.body.scrollHeight;  // ページの一番下
                var currentPosition = window.scrollY;  // 現在のスクロール位置
                var distance = targetPosition - currentPosition;  // 移動する距離
                var step = distance / 100;  // スクロールのステップ数を設定（数値を小さくすると遅くなります）

                // スクロールをアニメーションで少しずつ行う
                var scrollInterval = setInterval(function() {
                    window.scrollBy(0, step);  // スクロール位置を少しずつ更新

                    // 最下部に近づいたらスクロールを停止
                    if (Math.abs(window.scrollY + window.innerHeight - targetPosition) < Math.abs(step)) {
                        clearInterval(scrollInterval);  // インターバルをクリア
                        scrolling = false;  // スクロール完了
                    }
                }, 20);  // 20ミリ秒ごとにスクロールを更新
            }

            // ページロード時にスクロールを開始
            window.addEventListener('load', function() {
                smoothScroll();  // 初回のスクロールを実行

                // スクロールがページ最下部に到達した場合、再度スクロールを実行
                window.addEventListener('scroll', function() {
                    if (window.innerHeight + window.scrollY >= document.body.offsetHeight) {
                        smoothScroll();  // 最下部に達したらスクロールを繰り返す
                    }
                });
            });
        })();
    </script>
</body>
</html>
