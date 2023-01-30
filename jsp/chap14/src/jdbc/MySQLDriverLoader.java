package jdbc;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;

// servlet 클래스 : HttpServelet를 상속받은 자식클래스로 작성
public class MySQLDriverLoader extends HttpServlet {
	
	// init(config) 자동으로 실행되는 메소드
    public void init(ServletConfig config) throws ServletException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch(Exception ex) {
            throw new ServletException(ex);
        }
    }
}
