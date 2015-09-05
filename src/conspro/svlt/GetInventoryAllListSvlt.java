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

import conspro.storage.InventoryRecord;
import conspro.storage.PMF;

/**
 * 在庫全一覧
 * @author yasupong
 */
@SuppressWarnings("serial")
public class GetInventoryAllListSvlt extends HttpServlet {

	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {

		String page = arg0.getParameter("page");
		
	    ServletContext sc = getServletContext();
	    RequestDispatcher rd = null;
	    String cond = null;
	    
	    // 絞り込み条件作成。ページ制御
	    if ("1".equals(page)) {
	    	rd = sc.getRequestDispatcher("/CPInventoryListAll.jsp");
	    	cond = "(WEB_DISP == '1' || WEB_DISP == '3') && DATA_FLG == '0'";
	    }
	    else if ("2".equals(page)) {
	    	rd = sc.getRequestDispatcher("/CPInventoryListJaAll.jsp");	
	    	cond = "(WEB_DISP == '1' ||  WEB_DISP == '3') && DATA_FLG == '0'";
	    }
	    else if ("3".equals(page)) {
	    	rd = sc.getRequestDispatcher("/CPInventoryListHzjAll.jsp");		
	    	cond = "(WEB_DISP == '2' || WEB_DISP == '3') && DATA_FLG == '0'";
	    }
	      
	    // クエリー発行
	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
	    String query = "select from " + InventoryRecord.class.getName() + " where " + cond + " order by TYPE";
	    List<InventoryRecord> listInventoryRecord = (List<InventoryRecord>) pm.newQuery(query).execute();

	    arg0.setAttribute("InventoryRecordList", listInventoryRecord);
	    
	    rd.forward(arg0, arg1);
	}
}
