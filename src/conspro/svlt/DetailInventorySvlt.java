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

import conspro.storage.InventoryRecord;
import conspro.storage.PMF;
import conspro.util.Const;

/**
 * 在庫詳細
 * @author yasupong
 */
@SuppressWarnings("serial")
public class DetailInventorySvlt extends HttpServlet {

	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {

		String id = arg0.getParameter("EDITID");
		
		// idが取れない場合エラー
		if (id == null || id.length() == 0) {
			// エラーページへ
			arg1.sendRedirect("Error.jsp");
			return;
		}
		
		// マスターチェック実行
	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
	    Key keyObj = KeyFactory.createKey( InventoryRecord.class.getSimpleName(), id);
	    InventoryRecord inventoryRecord = pm.getObjectById( InventoryRecord.class, keyObj);
        pm.close();
        
    	// マスタにない場合エラー
    	if (inventoryRecord == null) {
			// エラーページへ
	    	throw new ServletException("処理異常です。データ不正です。");
    	}

	    ServletContext sc = getServletContext();
	    RequestDispatcher rd = null;
	    
		String page = arg0.getParameter("page");
		
	    // ページ制御
	    if (Const.PAGE_TYPE_EN.equals(page)) {
	    	rd = sc.getRequestDispatcher("/CPInventoryDetail.jsp");
	    } else if (Const.PAGE_TYPE_JA.equals(page)) {
	    	rd = sc.getRequestDispatcher("/CPInventoryDetailJa.jsp");
	    }
	    
	    arg0.setAttribute("InventoryRecord", inventoryRecord);
	    arg0.setAttribute("TYPE", arg0.getParameter("TYPE"));
	    rd.forward(arg0, arg1);
	}
}
