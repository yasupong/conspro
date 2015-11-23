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
import conspro.util.Const;

/**
 * 在庫一覧をTYPEで絞り込む
 * @author yasupong
 */
@SuppressWarnings("serial")
public class GetInventoryListByTypeSvlt extends HttpServlet {

	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		// パラメータチェック
		String TYPE = arg0.getParameter("TYPE");
		if (TYPE == null || TYPE.length() == 0) {
	    	throw new ServletException("処理異常です。パラメータ不正です。");
		}

		String page = arg0.getParameter("page");
		
	    ServletContext sc = getServletContext();
	    RequestDispatcher rd = null;
	    String cond = null;
	    
	    // 絞り込み条件作成。ページ制御
	    if (Const.PAGE_TYPE_EN.equals(page)) {
	    	rd = sc.getRequestDispatcher("/CPInventoryList.jsp");
	    	cond = "　&& (WEB_DISP == '1' || WEB_DISP == '3')";
	    } else if (Const.PAGE_TYPE_JA.equals(page)) {
	    	rd = sc.getRequestDispatcher("/CPInventoryListJa.jsp");
	    	cond = " && (WEB_DISP == '1' ||  WEB_DISP == '3')";
	    }
	    
	    // クエリー発行
	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
	    
	    String query = null;
	    if ("maker".equals(TYPE)) {
	    	query = "select from " + InventoryRecord.class.getName() + " where MANUFACTURER == '" + arg0.getParameter("MANUFACTURER") + "' && DATA_FLG == '0'" + cond + " order by DATE desc";
	    } else {
	    	query = "select from " + InventoryRecord.class.getName() + " where TYPE == '" + TYPE +"' && DATA_FLG == '0'" + cond + " order by DATE desc";
	    }
	    
	    List<InventoryRecord> listInventoryRecord = (List<InventoryRecord>)pm.newQuery(query).execute();

	    arg0.setAttribute("InventoryRecordList", listInventoryRecord);
	    
	    rd.forward(arg0, arg1);
	}
}
