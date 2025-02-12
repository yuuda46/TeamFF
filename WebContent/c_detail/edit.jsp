<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setCharacterEncoding("UTF-8"); %>
<link rel="stylesheet" href="../css/notice.css">

<c:import url="/common/base.jsp">
    <c:param name="content">
        <section class="mo-4 detail_font container2">
            <h2 class="titlesize h3 mb-3 fw-normal bg-opacity-10 py-2 px-4 user position_center">編集画面</h2>
            <form class="mx-3" action="c_detail_edit_con.jsp" method="post">

                <input type="hidden" name="postid" value="${postid}">

                <div class="form-group">
                    <label class="right_margin">金額:</label>
                    <input class="select-shape form_text2 form_top margin_left_10" type="number" name="monetary" placeholder="例:1000(円)" required="required" min="0" max="999999999" step="10" value="${monetary}">
                </div>

                <div class="form-group">
                    <label class="right_margin">期限:</label>
                    <input class="select-shape form_text3 form_top margin_left_10" type="date" name="deadline" required="required" value="${deadline}">
                </div>



                <button type="submit" class="btn btn-primary  button_style keep_button float_right margin_top_18">確認画面へ</button>
            </form>

            <form action="C_detailList.action" method="get">
                <button class="btn btn-secondary button_style keep_button" type="submit">戻る</button>
            </form>
        </section>
    </c:param>
</c:import>
