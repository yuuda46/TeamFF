package account;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Account;
import dao.AccountDAO;
import tool.Action;

public class SignUpAction extends Action {
    public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // JSPから受け取る情報
            String name = request.getParameter("name");
            String user_name = request.getParameter("user_name");
            String password = request.getParameter("password");
            String phone_number = request.getParameter("phone_number");
            String email = request.getParameter("email");
            String post_code = request.getParameter("post_code");
            String address = request.getParameter("address");

            // エラーメッセージ
            StringBuilder errorMessage = new StringBuilder();

         // 各エラーメッセージを個別の変数に格納する
            String errorName = null;
            String errorUserName = null;
            String errorPassword = null;
            String errorPhoneNumber = null;
            String errorEmail = null;
            String errorPostCode = null;
            String errorAddress = null;

            // 未入力チェック & 文字数制限チェック
            if (name == null || name.isEmpty()) errorName = "氏名が未入力です。";
            if (user_name == null || user_name.isEmpty()) errorUserName = "ユーザ名が未入力です。";
            if (password == null || password.isEmpty()) errorPassword = "パスワードが未入力です。";
            if (phone_number == null || phone_number.isEmpty()) errorPhoneNumber = "電話番号が未入力です。";
            if (email == null || email.isEmpty()) errorEmail = "メールアドレスが未入力です。";
            if (post_code == null || post_code.isEmpty()) errorPostCode = "郵便番号が未入力です。";
            if (address == null || address.isEmpty()) errorAddress = "住所が未入力です。";

            if (name.length() > 15) errorName = "氏名は15文字以内で入力してください。";
            if (user_name.length() > 20) errorUserName = "ユーザ名は20文字以内で入力してください。";
         // パスワードが6文字以上50文字以内かつ英字と数字の両方を含むかチェック
            if (password.length() < 6 || password.length() > 50) {
                errorPassword = "パスワードは6文字以上50文字以内で入力してください。";
            } else if (!Pattern.matches(".*[a-zA-Z].*", password) || !Pattern.matches(".*\\d.*", password)) {
                errorPassword = "パスワードは英字と数字の両方を含む必要があります。";
            }
            if (email.length() > 50) errorEmail = "メールアドレスは50文字以内で入力してください。";
            if (post_code.length() > 10) errorPostCode = "郵便番号は10文字以内で入力してください。";
            if (address.length() > 30) errorAddress = "住所は30文字以内で入力してください。";

            // フォーマットチェック
            if (!Pattern.matches("^[\\p{IsHan}\\p{IsHiragana}\\p{IsKatakana}a-zA-Zー・\\s\u3000]+$", name)) {
                errorName = "氏名には数字を含めないでください。";
            }
            if (!Pattern.matches("^[a-zA-Z0-9!@#\\$%\\^&*()_+=-]+$", user_name)) {
                errorUserName = "ユーザ名は半角英数字および記号のみを使用してください。";
            }
            if (Pattern.matches(".*[\\p{IsHan}\\p{IsHiragana}].*", password)) {
                errorPassword = "パスワードにはひらがなや漢字を使用できません。";
            }
            if (Pattern.matches(".*[\\p{IsHan}\\p{IsHiragana}\\p{IsKatakana}].*", email)) {
                errorEmail = "メールアドレスには漢字・ひらがな・カタカナを使用できません。";
            }
            if (!Pattern.matches("^\\d{2,4}-\\d{3,4}-\\d{3,4}$", phone_number)) {
                errorPhoneNumber = "電話番号は「-」を2つ含めた形式で入力してください。";
            }
            if (!Pattern.matches("\\d{3}-\\d{4}", post_code)) {
                errorPostCode = "郵便番号は3桁-4桁の形式で入力してください。";
            }

            // 各エラーメッセージをリクエスト属性に設定
            request.setAttribute("errorName", errorName);
            request.setAttribute("errorUserName", errorUserName);
            request.setAttribute("errorPassword", errorPassword);
            request.setAttribute("errorPhoneNumber", errorPhoneNumber);
            request.setAttribute("errorEmail", errorEmail);
            request.setAttribute("errorPostCode", errorPostCode);
            request.setAttribute("errorAddress", errorAddress);


            // 入力情報を保持するためにリクエスト属性に設定
            request.setAttribute("name", name);
            request.setAttribute("user_name", user_name);
            request.setAttribute("password", password);
            request.setAttribute("phone_number", phone_number);
            request.setAttribute("email", email);
            request.setAttribute("post_code", post_code);
            request.setAttribute("address", address);

            // エラーメッセージがある場合はフォームに戻る
            if (errorName != null || errorUserName != null || errorPassword != null ||
                errorPhoneNumber != null || errorEmail != null || errorPostCode != null ||
                errorAddress != null) {
                request.getRequestDispatcher("signUp.jsp").forward(request, response);
                return null;
            }




            // ユーザ名の重複チェック
            AccountDAO dao1 = new AccountDAO();
            if (dao1.checkUser_nameDuplicate(user_name)) {
                errorMessage.append("このユーザ名は既に登録されています。<br>");
                request.setAttribute("error1", errorMessage.toString());
                request.getRequestDispatcher("signUp.jsp").forward(request, response);
                return null;
            }

            // パスワードの重複チェック
            AccountDAO dao2 = new AccountDAO();
            if (dao2.checkPasswordDuplicate(password)) {
                errorMessage.append("このパスワードは既に登録されています。<br>");
                request.setAttribute("error2", errorMessage.toString());
                request.getRequestDispatcher("signUp.jsp").forward(request, response);
                return null;
            }


            // 電話番号の重複チェック
            AccountDAO dao3 = new AccountDAO();
            if (dao3.checkPhone_numberDuplicate(phone_number)) {
                errorMessage.append("この電話番号は既に登録されています。<br>");
                request.setAttribute("error3", errorMessage.toString());
                request.getRequestDispatcher("signUp.jsp").forward(request, response);
                return null;
            }

            // メールアドレスの重複チェック
            AccountDAO dao4 = new AccountDAO();
            if (dao4.checkEmailDuplicate(email)) {
                errorMessage.append("このメールアドレスは既に登録されています。<br>");
                request.setAttribute("error4", errorMessage.toString());
                request.getRequestDispatcher("signUp.jsp").forward(request, response);
                return null;
            }


            // 確認画面からの登録処理
            String confirm = request.getParameter("confirm");
            if ("true".equals(confirm)) {
                // SignUpオブジェクトにデータをセット
                Account signUp = new Account();
                String uuid = UUID.randomUUID().toString();
                signUp.setId(uuid);
                signUp.setName(name);
                signUp.setUser_name(user_name);
                signUp.setPassword(password);
                signUp.setPhone_number(phone_number);
                signUp.setEmail(email);
                signUp.setPost_code(post_code);
                signUp.setAddress(address);

                // DBにデータを登録
                AccountDAO dao = new AccountDAO();
                int result = dao.insert(signUp);

                if (result > 0) {
                    // 登録完了画面へ遷移
                    request.getRequestDispatcher("signUpComplete.jsp").forward(request, response);
                } else {
                    out.println("Data insertion failed.");
                }
                return null;
            }


            // 確認画面へ遷移
            request.setAttribute("name", name);
            request.setAttribute("user_name", user_name);
            request.setAttribute("password", password);
            request.setAttribute("phone_number", phone_number);
            request.setAttribute("email", email);
            request.setAttribute("post_code", post_code);
            request.setAttribute("address", address);
            request.getRequestDispatcher("confirmSignUp.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace(out);  // エラー出力
        }

        return null;
    }
}
