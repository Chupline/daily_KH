<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ include file="../include/header.jspf"%>





<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			Member 테이블 <small>it all starts here</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#">Examples</a></li>
			<li class="active">Blank page</li>
		</ol>
	</section>

	<!-- Main content -->
	<section class="content">

		<!-- Default box -->
		<div class="box">
			<div class="box-header with-border">
				<h3 class="box-title">Title</h3>

				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool"
						data-widget="collapse" data-toggle="tooltip" title="Collapse">
						<i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"
						data-toggle="tooltip" title="Remove">
						<i class="fa fa-times"></i>
					</button>
				</div>
			</div>
			<div class="box-body">



				<%@ page import="java.sql.DriverManager"%>
				<%@ page import="java.sql.Connection"%>
				<%@ page import="java.sql.Statement"%>
				<%@ page import="java.sql.ResultSet"%>
				<%@ page import="java.sql.SQLException"%>


				MEMBER 테이블의 내용
				<table width="100%" border="1">
					<tr>
						<td>이름</td>
						<td>아이디</td>
						<td>이메일</td>
					</tr>
					<%
					Connection conn = null;
					Statement stmt = null;
					ResultSet rs = null;

					try {
						String jdbcDriver = "jdbc:apache:commons:dbcp:chap14";
						String query = "select * from MEMBER order by MEMBERID";
						conn = DriverManager.getConnection(jdbcDriver);
						stmt = conn.createStatement();
						rs = stmt.executeQuery(query);
						while (rs.next()) {
					%>
					<tr>
						<td><%=rs.getString("NAME")%></td>
						<td><%=rs.getString("MEMBERID")%></td>
						<td><%=rs.getString("EMAIL")%></td>
					</tr>
					<%
					}
					} finally {
					if (rs != null)
					try {
						rs.close();
					} catch (SQLException ex) {
					}
					if (stmt != null)
					try {
						stmt.close();
					} catch (SQLException ex) {
					}
					if (conn != null)
					try {
						conn.close();
					} catch (SQLException ex) {
					}
					}
					%>
				</table>











			</div>
			<!-- /.box-body -->
			<div class="box-footer">Footer</div>
			<!-- /.box-footer-->
		</div>
		<!-- /.box -->

	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->



<%@ include file="../include/footer.jspf"%>

