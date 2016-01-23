package conspro.svlt;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.jdo.PersistenceManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conspro.storage.InventoryRecord;
import conspro.storage.PMF;

/**
 * 在庫登録
 * @author yasupong
 */
@SuppressWarnings("serial")
public class RegistInventorySvlt extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 在庫データを転記
		InventoryRecord lcInventoryRecord = new InventoryRecord();

		lcInventoryRecord.setDATE(String.valueOf(System.currentTimeMillis()));
		
		// WEB表示項目
		lcInventoryRecord.setNAME(req.getParameter("NAME"));
		lcInventoryRecord.setPRICE(req.getParameter("PRICE"));
		lcInventoryRecord.setCONDITION(req.getParameter("CONDITION"));
		lcInventoryRecord.setTYPE(req.getParameter("TYPE"));
		lcInventoryRecord.setMANUFACTURER(req.getParameter("MANUFACTURER"));
		lcInventoryRecord.setYEAR(req.getParameter("YEAR"));
		lcInventoryRecord.setSERIALNO(req.getParameter("SERIALNO"));
		lcInventoryRecord.setHOURS(req.getParameter("HOURS"));
		lcInventoryRecord.setOTHER(req.getParameter("OTHER"));
		lcInventoryRecord.setOTHER_JA(req.getParameter("OTHER_JA"));
		lcInventoryRecord.setPIC_URL(req.getParameter("PIC_URL"));
		
		// 内部業務項目
		lcInventoryRecord.setACCOUNT(req.getParameter("INACCOUNT"));
		lcInventoryRecord.setORDER_DATE(req.getParameter("ORDER_DATE"));
		lcInventoryRecord.setWEB_DISP(req.getParameter("WEB_DISP"));
		lcInventoryRecord.setSELLER_CODE(req.getParameter("SELLER_CODE"));
		lcInventoryRecord.setSELLER(req.getParameter("SELLER"));
		lcInventoryRecord.setORDER_PRICE(req.getParameter("ORDER_PRICE"));
		lcInventoryRecord.setORDER_TRANS_COST(req.getParameter("ORDER_TRANS_COST"));
		lcInventoryRecord.setPARTS_COST(req.getParameter("PARTS_COST"));
		lcInventoryRecord.setMAINTENANCE_COST(req.getParameter("MAINTENANCE_COST"));
		lcInventoryRecord.setORDER_OUT_ORDER_COST(req.getParameter("ORDER_OUT_ORDER_COST"));
		lcInventoryRecord.setORDER_COST_PRICE(req.getParameter("ORDER_COST_PRICE"));
		lcInventoryRecord.setTRAN_PLACE(req.getParameter("TRAN_PLACE"));
		lcInventoryRecord.setSELL_TRANCE_COST(req.getParameter("SELL_TRANCE_COST"));
		lcInventoryRecord.setSHIP_COST(req.getParameter("SHIP_COST"));
		lcInventoryRecord.setSELL_OUT_ORDER_COST(req.getParameter("SELL_OUT_ORDER_COST"));
		lcInventoryRecord.setINS_COST(req.getParameter("INS_COST"));
		lcInventoryRecord.setFREIGHT_COST(req.getParameter("FREIGHT_COST"));
		lcInventoryRecord.setSELL_COST_PRICE(req.getParameter("SELL_COST_PRICE"));
		lcInventoryRecord.setSELL_PRICE(req.getParameter("SELL_PRICE"));
		lcInventoryRecord.setWHOL_PRICE(req.getParameter("WHOL_PRICE"));
		lcInventoryRecord.setPROFIT(req.getParameter("PROFIT"));
		lcInventoryRecord.setBUYER_CODE(req.getParameter("BUYER_CODE"));
		lcInventoryRecord.setBUYER(req.getParameter("BUYER"));
		lcInventoryRecord.setORDER_PAY_DATE(req.getParameter("ORDER_PAY_DATE"));
		lcInventoryRecord.setSELL_PAY_DATE(req.getParameter("SELL_PAY_DATE"));
		lcInventoryRecord.setSELL_MONTH(req.getParameter("SELL_MONTH"));
		lcInventoryRecord.setMEMO(req.getParameter("MEMO"));
		
		lcInventoryRecord.setDATA_FLG("0");
		
		if ("0".equals(lcInventoryRecord.getWEB_DISP())) {
			lcInventoryRecord.setWEB_DISP_DATE("");
		} else {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date date = new Date(System.currentTimeMillis());
			lcInventoryRecord.setWEB_DISP_DATE(sdf.format(date));
		}
		
        PersistenceManager pm = PMF.getInstance().getPersistenceManager();

        try {
        	// DB登録
        	pm.makePersistent( lcInventoryRecord );
        } catch (Throwable th) {
	    	throw new ServletException(th);
        } finally {
        	pm.close();
        }

        resp.sendRedirect("RegResult.jsp?ACCOUNT=" + req.getParameter("ACCOUNT"));
   }
}
