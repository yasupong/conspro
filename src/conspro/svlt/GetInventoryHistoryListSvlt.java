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
 * 在庫削除履歴一覧
 * @author yasupong
 */
@SuppressWarnings("serial")
public class GetInventoryHistoryListSvlt extends HttpServlet {

	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		// 履歴データを検索する
	    ServletContext sc = getServletContext();
	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
	    String query = "select from " + InventoryRecord.class.getName() + " where DATA_FLG == '9'";
	    List<InventoryRecord> listInventoryRecord = (List<InventoryRecord>) pm.newQuery(query).execute();
	    // 画面返却
	    arg0.setAttribute("InventoryRecordList", listInventoryRecord);
	    RequestDispatcher rd = sc.getRequestDispatcher("/InventoryHistoryList.jsp");
	    	
	    rd.forward(arg0, arg1);
	}
}
