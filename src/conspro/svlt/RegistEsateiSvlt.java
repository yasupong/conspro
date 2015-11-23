package conspro.svlt;

import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conspro.storage.Esatei;
import conspro.storage.InventoryRecord;
import conspro.storage.PMF;
import conspro.util.CommonUtil;
import conspro.util.Const;
import conspro.util.MailUtil;

/**
 * 査定受付
 * @author yasupong
 */
@SuppressWarnings("serial")
public class RegistEsateiSvlt extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 遷移元チェック
		if (!Const.PASS_KEY_SATEI.equals(req.getParameter("passkey"))) {
			throw new ServletException("illegal parameters!!");
		}
		
		// 査定データを転記
		Esatei lcEsatei = new Esatei();
		lcEsatei.setDATE(String.valueOf(System.currentTimeMillis()));
		lcEsatei.setPOST(CommonUtil.nullConv(req.getParameter("post")));
		lcEsatei.setPNAME(CommonUtil.nullConv(req.getParameter("pname")));
		lcEsatei.setADDRESS(CommonUtil.nullConv(req.getParameter("address")));
		lcEsatei.setTEL(CommonUtil.nullConv(req.getParameter("tel")));
		lcEsatei.setFAX(CommonUtil.nullConv(req.getParameter("fax")));
		lcEsatei.setEMAIL(CommonUtil.nullConv(req.getParameter("email")));
		lcEsatei.setSOURCE(CommonUtil.nullConv(req.getParameter("source")));
		
		lcEsatei.setSELLER(CommonUtil.nullConv(req.getParameter("name")));
		lcEsatei.setORDER_PRICE(CommonUtil.nullConv(req.getParameter("price")));
		lcEsatei.setTYPE(CommonUtil.nullConv(req.getParameter("type")));
		lcEsatei.setNAME(CommonUtil.nullConv(req.getParameter("model")));
		lcEsatei.setMANUFACTURER(CommonUtil.nullConv(req.getParameter("maker")));
		lcEsatei.setSERIALNO(CommonUtil.nullConv(req.getParameter("serial")));
		lcEsatei.setHOURS(CommonUtil.nullConv(req.getParameter("meter")));
		lcEsatei.setYEAR(CommonUtil.nullConv(req.getParameter("year")));
		lcEsatei.setCONDITION(CommonUtil.nullConv(req.getParameter("cond")));
		lcEsatei.setMEMO(CommonUtil.nullConv(req.getParameter("detail")));
		
        PersistenceManager pmEsatei = PMF.getInstance().getPersistenceManager();

        try {
        	// DB登録
        	pmEsatei.makePersistent(lcEsatei);
        } catch (Throwable th) {
	    	throw new ServletException(th);
        } finally {
        	pmEsatei.close();
        }

        // 金額折り合いの場合は在庫を仮登録する
        if ("3".equals(req.getParameter("source"))) {
    		InventoryRecord lcInventoryRecord = new InventoryRecord();
    		lcInventoryRecord.setDATE(String.valueOf(System.currentTimeMillis()));
    		lcInventoryRecord.setSELLER(CommonUtil.nullConv(req.getParameter("name")));
    		lcInventoryRecord.setORDER_PRICE(CommonUtil.nullConv(req.getParameter("price")));
    		lcInventoryRecord.setTYPE(CommonUtil.nullConv(req.getParameter("type")));
    		lcInventoryRecord.setNAME(CommonUtil.nullConv(req.getParameter("model")));
    		lcInventoryRecord.setMANUFACTURER(CommonUtil.nullConv(req.getParameter("maker")));
    		lcInventoryRecord.setSERIALNO(CommonUtil.nullConv(req.getParameter("serial")));
    		lcInventoryRecord.setHOURS(CommonUtil.nullConv(req.getParameter("meter")));
    		lcInventoryRecord.setYEAR(CommonUtil.nullConv(req.getParameter("year")));
    		lcInventoryRecord.setCONDITION(CommonUtil.nullConv(req.getParameter("cond")));
    		lcInventoryRecord.setMEMO(CommonUtil.nullConv(req.getParameter("detail")));
    		
    		// 仮登録
    		lcInventoryRecord.setACCOUNT("査定受付");
    		// 有効データとして登録
    		lcInventoryRecord.setDATA_FLG("0");
    		// WEB表示なし
    		lcInventoryRecord.setWEB_DISP("0");
    		
    		// 固定値設定
    		lcInventoryRecord.setPRICE("0");
    		lcInventoryRecord.setORDER_TRANS_COST("0");
    		lcInventoryRecord.setPARTS_COST("0");
    		lcInventoryRecord.setMAINTENANCE_COST("0");
    		lcInventoryRecord.setORDER_OUT_ORDER_COST("0");
    		lcInventoryRecord.setORDER_COST_PRICE("0");
    		lcInventoryRecord.setSELL_TRANCE_COST("0");
    		lcInventoryRecord.setSHIP_COST("0");
    		lcInventoryRecord.setSELL_OUT_ORDER_COST("0");
    		lcInventoryRecord.setINS_COST("0");
    		lcInventoryRecord.setFREIGHT_COST("0");
    		lcInventoryRecord.setSELL_COST_PRICE("0");
    		lcInventoryRecord.setSELL_PRICE("0");
    		lcInventoryRecord.setWHOL_PRICE("0");
    		lcInventoryRecord.setPROFIT("0");
    		
    		lcInventoryRecord.setORDER_DATE("");
    		lcInventoryRecord.setORDER_PAY_DATE("");
    		lcInventoryRecord.setSELL_PAY_DATE("");
    		lcInventoryRecord.setSELL_MONTH("");
    		lcInventoryRecord.setBUYER("");
    		lcInventoryRecord.setOTHER("");
    		lcInventoryRecord.setOTHER_JA("");
    		lcInventoryRecord.setPIC_URL("");
    		
            PersistenceManager pmInv = PMF.getInstance().getPersistenceManager();

            try {
            	// DB登録
            	pmInv.makePersistent(lcInventoryRecord);
            } catch (Throwable th) {
    	    	throw new ServletException(th);
            } finally {
            	pmInv.close();
            }
        }
        
        boolean isDev = false;
        
		if ("true".equals(req.getParameter("isdev"))) {
			isDev = true;
		}
		
        // メール送信
        MailUtil.sendMailForEsatei(isDev);
        
        resp.sendRedirect("CPEsateiResult.jsp");
	}
}
