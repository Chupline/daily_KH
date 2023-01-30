<%@ page contentType="text/html; charset=utf-8"%>
<% // scriptlet: 자바 실행문을 기술
String id = request.getParameter("memberId");
if (id != null && id.equals("madvirus")) {
	response.sendRedirect("/chap03/index.jsp");
	// http://localhost:8080/chap03/login.jsp?memberId=madvirus
	// => http://localhost:8080/chap03/index.jsp 로 넘어간다.
} else {
%>
<html>
<head>
<title>로그인에 실패</title>
</head>
<body>
	잘못된 아이디입니다.
</body>
</html>
<%
}
%>
