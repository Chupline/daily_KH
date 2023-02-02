package mvc.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;

public class LoginHandler implements CommandHandler {

	private static final String FORM_VIEW = "/WEB-INF/view/member/loginForm.jsp";

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if (req.getMethod().equalsIgnoreCase("GET")) {
			return processForm(req, res);
		} else if (req.getMethod().equalsIgnoreCase("POST")) {
			return processSubmit(req, res);
		} else {
			return null;
		}
	}

	private String processForm(HttpServletRequest req, HttpServletResponse res) {
		return FORM_VIEW;
	}

	private String processSubmit(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String id = trim(req.getParameter("email"));
		String password = trim(req.getParameter("password"));

		if (id.equals(password)) {
			try {
				req.getSession().setAttribute("MEMBERID", id);
				res.sendRedirect(req.getContextPath() + "/main/index.do");
				return null;
			} catch (Exception e) {
				return FORM_VIEW;
			}
		}
		return FORM_VIEW;

	}

	private String trim(String str) {
		return str == null ? null : str.trim();
	}

}
