<%@ page contentType = "text/html; charset=utf-8" %>

<%
	request.setCharacterEncoding("utf-8");
%>

<script>
	alert("성공적으로 등록되었습니다.");
	location.href="fileView.do?bno=${tblAttachList.bno}";
</script>
