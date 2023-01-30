package mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/* 인터페이스 구성 요소
 * 1. 상수
 * 2. abstract method
 * 3. default method
 * 4. static method
 */
public interface CommandHandler {
	public String process(HttpServletRequest req, HttpServletResponse res)
	throws Exception;
}
