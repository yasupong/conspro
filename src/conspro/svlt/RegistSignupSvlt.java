package conspro.svlt;

import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conspro.storage.PMF;
import conspro.storage.Signup;
import conspro.util.CommonUtil;
import conspro.util.Const;
import conspro.util.MailUtil;

/**
 * Signup登録
 * @author yasupong
 */
@SuppressWarnings("serial")
public class RegistSignupSvlt extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 遷移元チェック
		if (!Const.PASS_KEY_SIGN_UP.equals(req.getParameter("passkey"))) {
			throw new ServletException("illegal parameters!!");
		}
		
		// E査定データを転記
		Signup lcSignup = new Signup();
		lcSignup.setDATE(String.valueOf(System.currentTimeMillis()));
		lcSignup.setNAME(CommonUtil.nullConv(req.getParameter("name")));
		lcSignup.setYOUARE(CommonUtil.nullConv(req.getParameter("usertype")));
		lcSignup.setCOMPANY(CommonUtil.nullConv(req.getParameter("company")));
		lcSignup.setSTREET(CommonUtil.nullConv(req.getParameter("street")));
		lcSignup.setCITY(CommonUtil.nullConv(req.getParameter("city")));
		lcSignup.setSTATE(CommonUtil.nullConv(req.getParameter("state")));
		lcSignup.setCOUNTRY(CommonUtil.nullConv(req.getParameter("country")));
		lcSignup.setZIP(CommonUtil.nullConv(req.getParameter("zipcode")));
		lcSignup.setTEL(CommonUtil.nullConv(req.getParameter("tel")));
		lcSignup.setFAX(CommonUtil.nullConv(req.getParameter("fax")));
		lcSignup.setMAIL(CommonUtil.nullConv(req.getParameter("email")));
		lcSignup.setRECEIVE(CommonUtil.nullConv(req.getParameter("stocklist")));
		lcSignup.setCOMMENT(CommonUtil.nullConv(req.getParameter("comment")));
		
        PersistenceManager pm = PMF.getInstance().getPersistenceManager();

        try {
        	// DB登録
        	pm.makePersistent( lcSignup );
        }
        catch (Throwable th) {
	    	throw new ServletException(th);
        }
        finally {
        	pm.close();
        }

        boolean isDev = false;
        
		if ("true".equals(req.getParameter("isdev"))) {
			isDev = true;
		}
		
        // メール送信
        MailUtil.sendMailForSignup(isDev);
        
        resp.sendRedirect("CPSignupResult.jsp");
	}
}
