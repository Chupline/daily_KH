<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*"%>
<html>
<head>
<title>application 기본 객체 사용하여 자원 읽기</title>
</head>
<body>

	<%
	String resourcePath = "/message/notice.txt"; 
	%>
	자원의 실제 경로:
	<br>
	<%=application.getRealPath(resourcePath)%> <!-- getRealPath(path) : string 객체 반환, 상대경로를 절대경로로 반환 -->
	<br> ----------
	<br>
	<%=resourcePath%>의 내용
	<br> ----------
	<br>
	<%
	char[] buff = new char[128];
	int len = -1;

	try (InputStreamReader br = new InputStreamReader(application.getResourceAsStream(resourcePath), "UTF-8")) { //getResourceAsStream(getRealPath(str)) : InputStream으로 반환
		while ((len = br.read(buff)) != -1) {
			out.print(new String(buff, 0, len));
		}
	} catch (IOException ex) {
		out.println("익셉션 발생: " + ex.getMessage());
	}
	%>

</body>
</html>
