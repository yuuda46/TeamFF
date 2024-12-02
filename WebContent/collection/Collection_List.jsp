<%-- 一覧JSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>


<c:import url="/common/base.jsp">

    <c:param name="scripts"></c:param>

    <c:param name="content">

   <%-- <c:import url="/common/sidemenu.jsp"></c:import> --%>

    <div class="function">
        <section class="mo-4">
        <h2 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C subject">入金ページ</h2>
        <h3 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C subject">このページには、まだ入金していない項目のみ表示しています</h3>
        <%--    <div class="my-2 text-end px-4">
                <a href="../subject/SubjectCreate.action">新規登録</a>
            </div> --%>

            <c:choose>
                <c:when test="${Post.size()>0}">
                    <table class="test-table table-hover mx-3">
                        <tr>
                            <th class="subject-boder test-table-wide">集金番号</th>
                            <th class="subject-boder test-table-wide">目的</th>
                            <th class="subject-boder test-table-wide">投稿日</th>
                            <th class="subject-boder test-table-width"></th>
                        </tr>
                        <c:forEach var="Collection" items="${Post}">
                            <tr>
                                <td class="subject-table-wide test-boder">${Collection.id}</td>
                                <td class="subject-table-wide test-boder">${Collection.title}</td>
                                <td class="subject-table-wide test-boder">${Collection.post_day}</td>

								<%-- 入金ボタン↓現状張りぼて。
								こちらをのボタンを押したらpostのidを持っていってdeposit.jspで表示する --%>
                        		<td class="text-center test-boder student-table-wide"><a href="CollectionDeposit.jsp?no=${Collection.id}">
								<button>入金する</button></a>
                                </td>

								<%-- 二次目標：一つ一つそれぞれのお知らせに飛ぶようにする。
								もしくは、入金ボタンを押した先で詳細な説明が読めるようにするかのどちらか。
								前者の場合、入金ボタンを押した後のワンクッションが空っぽになる。 --%>

                             </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <div>現在入金待ちの項目はありません</div>
                </c:otherwise>
            </c:choose>
        </section>
        <p>
        ${forward_test}
        ${forward_test2}
        ${name}
        </p>
        </div>
    </c:param>
</c:import>