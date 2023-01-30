<%@ page contentType="text/html; charset=utf-8"%>
<%
String name = request.getParameter("name"); 	// "이름"
String value = request.getParameter("value");	// "홍길동"

if (name != null && value != null) {
	application.setAttribute(name, value); //application.setAttribute("이름", "홍길동");
}
%>

<html>
<head>
<title>application 속성 지정</title>
</head>
<body>
	<%
	if (name != null && value != null) { //http://localhost:8080/chap05/setApplicationAttribute.jsp?name=이름&value=홍길동
	%>
	application 기본 객체의 속성 설정:
	<br><%=name%> =	<%=value%>
	<br>이름 = <%= application.getAttribute(name) %> <!-- application.getAttribute("이름") -->
	<%
	} else {
	%>
	application 기본 객체의 속성 설정 안 함
	<%
	}
	%>
</body>
</html>
