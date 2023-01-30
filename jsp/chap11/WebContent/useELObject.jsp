<%@ page contentType = "text/html; charset=utf-8" %>
<%
	request.setAttribute("name", "최범균");
%>
<html>
<head><title>EL Object</title></head>
<body>


<%--EL태그 사용시 
<%= pageContext.getRequest().getRequestURI() %> --%>
요청 URI: ${pageContext.request.requestURI}<br>

request의 name 속성: ${requestScope.name}<br> 
<%--EL태그 사용시 
<%= request.getAttribute("name") %> --%>

code 파라미터: ${param.code}
<%--EL태그 사용시 
<%= request.getParameter("code") %> --%>

</body>
</html>
