<%@ page contentType="text/html; charset=utf-8"%>
<%-- <%@ page import="util.Cookies"%>
<%
	response.addCookie(Cookies.createCookie("AUTH", "", "/", 0));
	response.sendRedirect("../member/loginForm.jsp");
%> --%>
<%
	session.invalidate();
	response.sendRedirect("../member/loginForm.jsp");
%>