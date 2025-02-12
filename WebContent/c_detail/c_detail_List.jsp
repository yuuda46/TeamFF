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

<link rel="stylesheet" href="../css/collection.css">
<link rel="stylesheet" href="../css/notice.css">

    <div class="function">
        <section class="mo-4">
        <div class="container">
        <h2 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test large-bold">集金物登録</h2>
		<h3 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test small-bold"></h3>


	            <c:choose>
	                <c:when test="${Post.size()>0}">
	                    <table class="test-table table-hover mx-3">
	                        <tr>
	                            <th class="test-boder test-table-wide">集金番号</th>
	                            <th class="test-boder test-table-wide">目的</th>
	                            <th class="test-boder test-table-wide">投稿日</th>
	                            <th class="test-boder test-table-wide"></th>
	                        </tr>
	                       <c:forEach var="Collection" items="${Post}" varStatus="loop">
							    <tr>
							        <td class="test-table-wide test-boder">${Collection.id}</td>
							        <td class="test-table-wide test-boder">${Collection.title}</td>
							        <td class="test-table-wide test-boder">${post_day[loop.index]}</td>

							        <td class="text-center test-boder padding_none admin_button border-none position_notice">
							            <c:choose>
							                <c:when test="${Collection.judgement eq 'true'}">
							                    <!-- 編集ボタン -->
							                    <form class="padding_bottom_0 form_height admin_button_width" action="../c_detail/C_detailEdit.action" method="get">
							                        <input type="hidden" name="postid" value="${Collection.id}">
							                        <button class="button_back_ground button_style hit_judgment_mechanics" type="submit">編集</button>
							                    </form>
							                </c:when>
							                <c:otherwise>
							                    <!-- 投稿ボタン -->
							                    <form class="padding_bottom_0 form_height admin_button_width" action="../c_detail/C_detailReceive.action" method="post">
							                        <input type="hidden" name="postid" value="${Collection.id}">
							                        <button class="button_back_ground button_style hit_judgment_mechanics" type="submit">投稿</button>
							                    </form>
							                </c:otherwise>
							            </c:choose>
							        </td>
							    </tr>
							</c:forEach>

	                    </table>
	                    <div class="pagination">
						    <c:if test="${currentPage > 1}">
						        <a href="C_detailList.action?page=${currentPage - 1}">前へ</a>
						    </c:if>

						    <c:forEach var="i" begin="1" end="${totalPages}">
						        <c:choose>
						            <c:when test="${i == currentPage}">
						                <strong>${i}</strong>
						            </c:when>
						            <c:otherwise>
						                <a href="C_detailList.action?page=${i}">${i}</a>
						            </c:otherwise>
						        </c:choose>
						    </c:forEach>

						    <c:if test="${currentPage < totalPages}">
						        <a href="C_detailList.action?page=${currentPage + 1}">次へ</a>
						    </c:if>
						</div>
	                </c:when>
	                <c:otherwise>
	                    <div>現在入金待ちの項目はありません</div>
	                </c:otherwise>
	            </c:choose>
	            	<form class="container2 position_form" action="../notice/Tokou.action">
						<button class="button_style detail_button" type="submit">戻る	</button>
					</form>

			</div>
        </section>
        <p>
        ${forward_test}
        ${forward_test2}
        ${name}
        </p>
        </div>
    </c:param>
</c:import>