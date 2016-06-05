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

import conspro.storage.Esatei;
import conspro.storage.PMF;

/**
 * e-査定全一覧
 * @author yasupong
 */
@SuppressWarnings("serial")
public class GetEsateiAllListSvlt extends HttpServlet {

	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
	    // クエリー発行
	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
	    String query = "select from " + Esatei.class.getName() + " order by DATE desc";
	    List<Esatei> listEsatei = (List<Esatei>) pm.newQuery(query).execute();

	    arg0.setAttribute("listEsateiList", listEsatei);
	    
	    ServletContext sc = getServletContext();
	    RequestDispatcher rd = sc.getRequestDispatcher("/EsateiListAll.jsp");
	    rd.forward(arg0, arg1);
	}
}
