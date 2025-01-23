<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@page import="bean.Post2, java.util.List" %>


<c:import url="/common/base.jsp">
<c:param name="content">


	<title>投稿確認</title>
	<p>この内容で投稿してもよろしいでしょうか？</p>
	<form action="your-url-here" method="get">
    <input name="yesproposal" id="yes-button" type="button" onclick="location.href='../notice/ToukouNotice.action?items=${items}'" value="はい">
    </form>
	</c:param>
</c:import>

<!--  %@include file="../footer.html" %-->


