<%-- 学生一覧JSP --%>
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
        <section class="mo-4">
            <h2 class="h3 mb-3 fw-norma student bg-opacity-10 py-2 px-4">入金管理</h2>
			<label class="btn-position">入金確認</label>


		<form action="../collection/CollectionList.action" method="get">
          <button type="submit" class="CollectionList.action">
          未入金確認画面に戻る
          </button>
        </form>

		<c:choose>
                <c:when test="${Post.size()>0}">
                    <table class="test-table table-hover mx-3">
                        <tr>
                            <th class="subject-boder test-table-wide">集金番号</th>
                            <th class="subject-boder test-table-wide">目的</th>
                            <th class="subject-boder test-table-wide">投稿日</th>
                            <th class="subject-boder test-table-wide">説明</th>
                            <th class="subject-boder test-table-width"></th>
                        </tr>
                        <c:forEach var="Collection" items="${Post}">
                            <tr>
                                <td class="subject-table-wide test-boder">${Collection.id}</td>
                                <td class="subject-table-wide test-boder">${Collection.title}</td>
                                <td class="subject-table-wide test-boder">${Collection.post_day}</td>
                                <td class="subject-table-wide test-boder">${Collection.content}</td>

                             </tr>

                        <%--ここでsignidとcollectionidをCompleteActionに渡して登録 --%>
                        <td class="text-center test-boder student-table-wide">
					    <a href="../collection/CollectionDepositComplete.action?postId=${Collection.id}">
					        <button type="submit" class="CollectionDepositComplete.action">
					            入金を完了する
					        </button>
					    </a>
						</td>

                        </c:forEach>
                    </table>
                </c:when>
            </c:choose>

        </section>
        </div>
    </c:param>
</c:import>
