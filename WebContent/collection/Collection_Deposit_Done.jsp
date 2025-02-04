<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>


<c:import url="/common/base.jsp">

    <c:param name="scripts"></c:param>

    <c:param name="content">
    <div class="function">
<%--<c:import url="/common/sidemenu.jsp">
    </c:import> --%>

        <link rel="stylesheet" href="../css/collection.css">

        <section class="mo-4">
            <h2 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test large-bold">入金管理</h2>
			<label class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test small-bold">
			入金が完了しました。<br>
			ご協力ありがとうございました。
			</label>


		<form action="../collection/CollectionDeposit.action" method="get">
          <button type="submit" class="CollectionDeposit.action">
          未入金確認画面に戻る
          </button>
        </form>

        <form action="../common/index.jsp" method="get">
          <button type="submit" class="home">
          ホームに戻る
          </button>
        </form>


        </section>
        </div>
    </c:param>
</c:import>
