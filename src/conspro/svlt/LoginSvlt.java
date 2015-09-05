package conspro.svlt;

import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import conspro.storage.Employee;
import conspro.storage.PMF;

/**
 * ログイン認証
 * @author yasupong
 */
@SuppressWarnings("serial")
public class LoginSvlt extends HttpServlet {

	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		String ACCOUNT = arg0.getParameter("ACCOUNT");
		String PASSWORD = arg0.getParameter("PASSWORD");
		if (ACCOUNT == null || ACCOUNT.length() == 0 || PASSWORD == null || PASSWORD.length() == 0) {
			arg1.sendRedirect("LoginErr.jsp");
			return;
		}

	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
	    Key keyObj = KeyFactory.createKey( Employee.class.getSimpleName(), ACCOUNT );
	    Employee emp = pm.getObjectById( Employee.class, keyObj );

		if (emp == null) {
			arg1.sendRedirect("LoginErr.jsp");
			return;
		}

		if (!PASSWORD.equals(emp.getPASSWORD())) {
			arg1.sendRedirect("LoginErr.jsp");
			return;
		}

		arg0.getSession().setAttribute("ACCOUNT", ACCOUNT);
		arg0.getSession().setAttribute("AUTH_CODE", emp.getAUTH_CODE());
		arg0.getSession().setAttribute("NAME", emp.getNAME());
		
	    ServletContext sc = getServletContext();
	    RequestDispatcher rd = sc.getRequestDispatcher("/menu.jsp");
	    rd.forward(arg0, arg1);
	}
}
