package conspro.util;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * CONSPRO権限Util
 * @author yasupong
 */
public class AuthUtil {

	/**
	 * ログインチェック
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public static void isLogin(HttpServletRequest request, HttpServletResponse response)throws IOException {
		String account = request.getParameter("ACCOUNT");
		if (account == null || account.length() == 0) {
			response.sendRedirect("LoginErr.jsp");
		}

		if (!account.equals(request.getSession().getAttribute("ACCOUNT"))) {
			response.sendRedirect("LoginErr.jsp");
		}
	}
}
