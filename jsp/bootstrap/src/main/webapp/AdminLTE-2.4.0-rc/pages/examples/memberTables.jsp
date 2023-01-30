<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ include file="../include/header.jspf"%>

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>




<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			DataTables PlugIn <small>it all starts here</small>
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
				Member table 내용
				<table width="100%">
					<tr>
						<td>이름</td>
						<td>아이디</td>
						<td>이메일</td>
					</tr>
					<%
					// 1. JDBC 드라이버 로딩
					Class.forName("com.mysql.jdbc.Driver");
					
					Connection conn = null;
					Statement stmt = null;
					ResultSet rs = null;

					try {
						String jdbcDriver = "jdbc:mysql://localhost:3306/chap14?" +
											"useUnicode=true&characterEncoding=utf8";
						String dbUser = "jspexam";
						String dbPass = "jsppw";
						
						String query = "select * from MEMBER order by MEMBERID";
						
						// 2. 데이터베이스 커넥션 생성
						conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
						
						// 3. Statement 생성 : Connection으로 연결한 객체에게, Query 작업을 실행하기 위한 객체.
						stmt = conn.createStatement();
						
						// 4. 쿼리 실행
						rs = stmt.executeQuery(query);
						
						// 5. 쿼리 실행 결과 출력
						while(rs.next()) {
				%>
				<tr>
					<td><%= rs.getString("NAME") %></td>
					<td><%= rs.getString("MEMBERID") %></td>
					<td><%= rs.getString("EMAIL") %></td>
				</tr>
				<%
						}
					} catch(SQLException ex) {
						out.println(ex.getMessage());
						ex.printStackTrace();
					} finally {
						// 6. 사용한 Statement 종료
						if (rs != null) try { rs.close(); } catch(SQLException ex) {}
						if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
						
						// 7. 커넥션 종료
						if (conn != null) try { conn.close(); } catch(SQLException ex) {}
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

