package conspro.svlt;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conspro.storage.Client;
import conspro.storage.PMF;

/**
 * 顧客一覧検索
 * @author yasupong
 */
@SuppressWarnings("serial")
public class SeachClientListSvlt extends HttpServlet {

	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		
		// データ検索
	    StringBuffer queryBuf = new StringBuffer("select from " + Client.class.getName());
	   
	    queryBuf.append(" where DATA_FLG == '0'");
    	
    	// 通常検索
	    if (arg0.getParameter("CLIENT_CODE") != null && arg0.getParameter("CLIENT_CODE").length() > 0) {	    	
	    	queryBuf.append(" && CLIENT_CODE == '" + arg0.getParameter("CLIENT_CODE") + "'");
	    }
	    if (arg0.getParameter("CLIENT_TYPE") != null && arg0.getParameter("CLIENT_TYPE").length() > 0) {
	    	queryBuf.append(" && CLIENT_TYPE == '" + arg0.getParameter("CLIENT_TYPE") + "'");
	    }
	    if (arg0.getParameter("CREDIT") != null && arg0.getParameter("CREDIT").length() > 0) {
	    	queryBuf.append(" && CREDIT == '" + arg0.getParameter("CREDIT") + "'");
	    }
	    if (arg0.getParameter("COUNTRY") != null && arg0.getParameter("COUNTRY").length() > 0) {
	    	queryBuf.append(" && COUNTRY == '" + arg0.getParameter("COUNTRY") + "'");
	    }
	    if (arg0.getParameter("SEQ") != null && arg0.getParameter("SEQ").length() > 0) {
	    	queryBuf.append(" && SEQ == '" + arg0.getParameter("SEQ") + "'");
	    }
	    if (arg0.getParameter("COMPANY") != null && arg0.getParameter("COMPANY").length() > 0) {
	    	queryBuf.append(" && COMPANY == '" + arg0.getParameter("COMPANY") + "'");
	    }
	    if (arg0.getParameter("NAME") != null && arg0.getParameter("NAME").length() > 0) {
	    	queryBuf.append(" && NAME == '" + arg0.getParameter("NAME") + "'");
	    }
	    if (arg0.getParameter("TEL") != null && arg0.getParameter("TEL").length() > 0) {
	    	queryBuf.append(" && TEL == '" + arg0.getParameter("TEL") + "'");
	    }
	    if (arg0.getParameter("ZIP") != null && arg0.getParameter("ZIP").length() > 0) {
	    	queryBuf.append(" && ZIP == '" + arg0.getParameter("ZIP") + "'");
	    }
	    if (arg0.getParameter("OFFICE") != null && arg0.getParameter("OFFICE").length() > 0) {
	    	queryBuf.append(" && OFFICE == '" + arg0.getParameter("OFFICE") + "'");
	    }
	    
	    arg0.setAttribute("ClientRecordList", PMF.getInstance().getPersistenceManager().newQuery(queryBuf.toString()).execute());

	    // 遷移先判定
	    String jsp = "/ClientList.jsp";
	    if ("0".equals(arg0.getParameter("type"))) {
	    	jsp = "/ClientListPopUp.jsp";
	    }
	    
	    // JSPへフォワードする
	    getServletContext().getRequestDispatcher(jsp).forward(arg0, arg1);
	}
}
