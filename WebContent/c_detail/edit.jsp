<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setCharacterEncoding("UTF-8"); %>

<c:import url="/common/base.jsp">
    <c:param name="content">
        <section class="mo-4">
            <h2 class="titlesize h3 mb-3 fw-normal bg-opacity-10 py-2 px-4 user">編集画面</h2>
            <form class="mx-3" action="c_detail_edit_con.jsp" method="post">

                <input type="hidden" name="postid" value="${postid}">

                <div class="form-group">
                    <label>金額</label><br>
                    <input class="select-shape" type="number" name="monetary" placeholder="例:1000(円)" required="required" min="0" max="999999999" step="10" value="${monetary}">
                </div>

                <div class="form-group">
                    <label>期限</label><br>
                    <input class="select-shape" type="date" name="deadline" required="required" value="${deadline}">
                </div>



                <button type="submit" class="btn btn-primary">確認画面へ</button>
            </form>

            <form action="C_detailList.action" method="get">
                <button class="btn btn-secondary" type="submit">戻る</button>
            </form>
        </section>
    </c:param>
</c:import>
