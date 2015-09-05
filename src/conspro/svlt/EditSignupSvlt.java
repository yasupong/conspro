package conspro.svlt;

import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import conspro.storage.PMF;
import conspro.storage.Signup;

/**
 * Signup編集
 * @author yasupong
 */
@SuppressWarnings("serial")
public class EditSignupSvlt extends HttpServlet {

	/** 種別：2  削除 */
	private static final String TYPE_DELETE = "2";

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
	    Key keyObj = KeyFactory.createKey( Signup.class.getSimpleName(), id );
	    Signup signup = pm.getObjectById( Signup.class, keyObj );

    	// マスタにない場合エラー
    	if (signup == null) {
			// エラーページへ
	    	throw new ServletException("処理異常です。データ不正です。");
    	}

	    try {
			String type = arg0.getParameter("type");
			// 削除
			if (TYPE_DELETE.equals(type)) {	        	
				// 在庫削除実行
		    	pm.deletePersistent(signup);
				// 一覧画面へ
				arg1.sendRedirect("GetSignupAllList?ACCOUNT=" + arg0.getParameter("ACCOUNT"));
			}
			else {
				// エラーページへ
				arg1.sendRedirect("Error.jsp");
			}
	    }
	    catch ( Throwable th ) {
	    	throw new ServletException(th);
		}
	    finally {
        	pm.close();
	    }
	}
}
