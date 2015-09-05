package conspro.svlt;

import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conspro.storage.Employee;
import conspro.storage.PMF;

/**
 * 従業員登録
 * @author yasupong
 */
@SuppressWarnings("serial")
public class RegistEmployeeSvlt extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// パラメータ取得
		Employee emp = new Employee();
		emp.setACCOUNT(req.getParameter("ACCOUNT"));
		emp.setPASSWORD(req.getParameter("PASSWORD"));
		emp.setNAME(req.getParameter("NAME"));
		emp.setAUTH_CODE(req.getParameter("AUTH_CODE"));
		
        PersistenceManager pm = PMF.getInstance().getPersistenceManager();

        try {
        	// 従業員データを登録する
        	pm.makePersistent( emp );
        }
        catch (Throwable th) {
	    	throw new ServletException(th);
        }
        finally {
        	pm.close();
        }

        resp.sendRedirect("RegResultEmp.jsp");
   }
}
