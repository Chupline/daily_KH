package mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CommandHandler {
	// 인터페이스 구성요소
	// 1. 상수
	// 2. abstract method
	// 3. default method
	// 4. static method
	// 추상 클래스(통일) vs 인터페이스 (다형성)
	public String process(HttpServletRequest req, HttpServletResponse res)
	throws Exception;
}
