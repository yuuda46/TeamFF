
//pagetopのボタンを出したり消したりするスクリプト
$(function(){
    var scroll = $('.scroll');
    var scrollShow = $('.scroll-show');
        $(scroll).hide();
        $(window).scroll(function(){
            if($(this).scrollTop() >= 300) {
                $(scroll).fadeIn(500).addClass(scrollShow);
            } else {
                $(scroll).fadeOut(500).removeClass(scrollShow);
            }
        });
});

//スムーススクロールのスクリプト
$(function(){
    $('a[href^="#"]').click(function(){
        var href = $(this).attr('href');
        var target = href == '#' ? 0 : $(href).offset().top;
            $('body,html').animate({scrollTop:target},500);
            return false;
    });
});
//ドロップダウンメニューのスクリプト
document.addEventListener("DOMContentLoaded", function() {
    const dropdown = document.querySelector('.dropdown');
    const toggleButton = document.querySelector('.dropdown-toggle');

    // メニューボタンがクリックされたら、メニューの表示/非表示を切り替え
    toggleButton.addEventListener('click', function() {
        dropdown.classList.toggle('show');
    });

    // 画面の他の部分がクリックされたらメニューを閉じる
    window.addEventListener('click', function(event) {
        if (!dropdown.contains(event.target)) {
            dropdown.classList.remove('show');
        }
    });
});

//パスワード表示/非表示

document.addEventListener('DOMContentLoaded', function() {
    const togglePassword = document.getElementById('togglePassword');
    const passwordInput = document.getElementById('password');

    togglePassword.addEventListener('click', function() {
        // パスワードの表示/非表示を切り替え
        const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordInput.setAttribute('type', type);
        // ボタンのテキストを切り替え
        this.textContent = type === 'password' ? '表示' : '非表示';
    });
});


