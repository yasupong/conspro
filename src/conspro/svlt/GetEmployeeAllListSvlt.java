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

import conspro.storage.Employee;
import conspro.storage.PMF;

/**
 * アカウント全一覧
 * @author yasupong
 */
@SuppressWarnings("serial")
public class GetEmployeeAllListSvlt extends HttpServlet {

	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
	      
	    // クエリー発行
	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
	    String query = "select from " + Employee.class.getName();
	    List<Employee> listEmployeeRecord = (List<Employee>) pm.newQuery(query).execute();

	    arg0.setAttribute("EmployeeRecordList", listEmployeeRecord);
	    
	    ServletContext sc = getServletContext();
	    RequestDispatcher rd = sc.getRequestDispatcher("/EmployeeList.jsp");
	    rd.forward(arg0, arg1);
	}
}
