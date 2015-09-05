package conspro.svlt;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conspro.storage.PMF;
import conspro.storage.Signup;

/**
 * Signup全一覧
 * @author yasupong
 */
@SuppressWarnings("serial")
public class GetSignupAllListSvlt extends HttpServlet {

	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
	    // クエリー発行
	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
	    String query = "select from " + Signup.class.getName() + " order by DATE desc";
	    List<Signup> listSignup = (List<Signup>) pm.newQuery(query).execute();

	    arg0.setAttribute("listSignupList", listSignup);
	    
	    ServletContext sc = getServletContext();
	    RequestDispatcher rd = sc.getRequestDispatcher("/SignupListAll.jsp");
	    rd.forward(arg0, arg1);
	}
}
