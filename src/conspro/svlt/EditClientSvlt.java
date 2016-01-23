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

import conspro.storage.Client;
import conspro.storage.PMF;

/**
 * 顧客編集
 * @author yasupong
 */
@SuppressWarnings("serial")
public class EditClientSvlt extends HttpServlet {

	/** 種別：0 更新画面起動 */
	private static final String TYPE_EDIT = "0";
	/** 種別：1  更新確定 */
	private static final String TYPE_EDIT_COMMIT = "1";
	/** 種別：2  削除 */
	private static final String TYPE_DELETE = "2";

	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		
		String id = arg0.getParameter("EDITID");
		
		// ACCOUNTが取れない場合エラー
		if (id == null || id.length() == 0) {
			// エラーページへ
			arg1.sendRedirect("Error.jsp");
			return;
		}
		
		// マスターチェック実行
	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
	    Key keyObj = KeyFactory.createKey( Client.class.getSimpleName(), id );
	    Client clientRecord = pm.getObjectById( Client.class, keyObj );

    	// マスタにない場合エラー
    	if (clientRecord == null) {
			// エラーページへ
	    	throw new ServletException("処理異常です。データ不正です。");
    	}
		
	    try {
			String type = arg0.getParameter("type");
			
			// 更新
			if (TYPE_EDIT.equals(type)) {
				// 更新ページへ遷移
			    arg0.setAttribute("ClientRecord", clientRecord);
			    ServletContext sc = getServletContext();
			    RequestDispatcher rd = sc.getRequestDispatcher("/UpdateClient.jsp");
			    rd.forward(arg0, arg1);
			} else if (TYPE_EDIT_COMMIT.equals(type)) {
				// 更新実行
				clientRecord.setADDRESS(arg0.getParameter("ADDRESS"));
				clientRecord.setZIP(arg0.getParameter("ZIP"));
				clientRecord.setTEL(arg0.getParameter("TEL"));
				clientRecord.setFAX(arg0.getParameter("FAX"));
				clientRecord.setMAIL(arg0.getParameter("MAIL"));
				clientRecord.setCOMPANY(arg0.getParameter("COMPANY"));
				clientRecord.setOFFICE(arg0.getParameter("OFFICE"));
				clientRecord.setNAME(arg0.getParameter("NAME"));
				clientRecord.setCOMMENT(arg0.getParameter("COMMENT"));
				arg0.getSession().setAttribute("MSG", "選択した顧客を更新しました");
	        	pm.makePersistent( clientRecord );
	        	// 再検索してもとに戻る
				arg1.sendRedirect("EditClient?ACCOUNT=" + arg0.getParameter("ACCOUNT") + "&EDITID=" + id + "&type=" + TYPE_EDIT);
			} else if (TYPE_DELETE.equals(type)) {			
				// 顧客削除実行
		    	pm.deletePersistent(clientRecord);
				arg0.getSession().setAttribute("MSG", "選択した顧客を削除しました");
				// 一覧画面へ
				arg1.sendRedirect("ClientList.jsp?ACCOUNT=" + arg0.getParameter("ACCOUNT"));
			} else {
				// エラーページへ
				arg1.sendRedirect("Error.jsp");
			}
	    } catch ( Throwable th ) {
	    	throw new ServletException(th);
		} finally {
        	pm.close();
	    }
	}
}
