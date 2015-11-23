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

import conspro.storage.Employee;
import conspro.storage.PMF;

/**
 * アカウント編集
 * @author yasupong
 */
@SuppressWarnings("serial")
public class EditEmployeeSvlt extends HttpServlet {

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
	    Key keyObj = KeyFactory.createKey( Employee.class.getSimpleName(), id );
	    Employee employeeRecord = pm.getObjectById( Employee.class, keyObj );

    	// マスタにない場合エラー
    	if (employeeRecord == null) {
			// エラーページへ
	    	throw new ServletException("処理異常です。データ不正です。");
    	}
		
	    try {
			String type = arg0.getParameter("type");
			// 更新
			if (TYPE_EDIT.equals(type)) {
				// 更新ページへ遷移
			    arg0.setAttribute("EmployeeRecord", employeeRecord);
			    ServletContext sc = getServletContext();
			    RequestDispatcher rd = sc.getRequestDispatcher("/UpdateEmployee.jsp");
			    rd.forward(arg0, arg1);
			} else if (TYPE_EDIT_COMMIT.equals(type)) {
				
				// 更新実行
				employeeRecord.setPASSWORD(arg0.getParameter("PASSWORD"));
				employeeRecord.setNAME(arg0.getParameter("NAME"));
				employeeRecord.setAUTH_CODE(arg0.getParameter("AUTH_CODE"));
				
	        	pm.makePersistent( employeeRecord );
	        	
				// 一覧画面へ
				arg1.sendRedirect("GetEmployeeAllList?ACCOUNT=" + arg0.getParameter("ACCOUNT"));
			} else if (TYPE_DELETE.equals(type)) {
				
				// 在庫削除実行
		    	pm.deletePersistent(employeeRecord);
				// 一覧画面へ
				arg1.sendRedirect("GetEmployeeAllList?ACCOUNT=" + arg0.getParameter("ACCOUNT"));
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
