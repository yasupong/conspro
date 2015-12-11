package conspro.svlt;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

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

/**
 * 在庫編集
 * @author yasupong
 */
@SuppressWarnings("serial")
public class EditInventorySvlt extends HttpServlet {

	/** 種別：0 更新画面起動 */
	private static final String TYPE_EDIT = "0";
	/** 種別：1  更新確定 */
	private static final String TYPE_EDIT_COMMIT = "1";
	/** 種別：2  削除 */
	private static final String TYPE_DELETE = "2";
	/** 種別：3  写真更新 */
	private static final String TYPE_PICUPDATE = "3";
	/** 種別：4 詳細画面起動 */
	private static final String TYPE_DETAIL = "4";
	/** 種別：5 在庫締め */
	private static final String TYPE_CLOSE = "5";
	/** 種別：6 締め戻し */
	private static final String TYPE_CLOSE_BACK = "6";
	
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
	    Key keyObj = KeyFactory.createKey( InventoryRecord.class.getSimpleName(), id );
	    InventoryRecord inventoryRecord = pm.getObjectById( InventoryRecord.class, keyObj );

    	// マスタにない場合エラー
    	if (inventoryRecord == null) {
			// エラーページへ
	    	throw new ServletException("処理異常です。データ不正です。");
    	}

	    try {
			String type = arg0.getParameter("type");

			if (TYPE_EDIT.equals(type)) {
				// 更新ページへ遷移
			    arg0.setAttribute("InventoryRecord", inventoryRecord);
			    ServletContext sc = getServletContext();
			    RequestDispatcher rd = sc.getRequestDispatcher("/UpdateInventory.jsp");
			    rd.forward(arg0, arg1);
			} else if (TYPE_EDIT_COMMIT.equals(type)) {
				// 更新実行
				inventoryRecord.setNAME(arg0.getParameter("NAME"));
				inventoryRecord.setPRICE(arg0.getParameter("PRICE"));
				inventoryRecord.setCONDITION(arg0.getParameter("CONDITION"));
				inventoryRecord.setTYPE(arg0.getParameter("TYPE"));
				inventoryRecord.setMANUFACTURER(arg0.getParameter("MANUFACTURER"));
				inventoryRecord.setYEAR(arg0.getParameter("YEAR"));
				inventoryRecord.setSERIALNO(arg0.getParameter("SERIALNO"));
				inventoryRecord.setHOURS(arg0.getParameter("HOURS"));
				inventoryRecord.setOTHER(arg0.getParameter("OTHER"));
				inventoryRecord.setOTHER_JA(arg0.getParameter("OTHER_JA"));
				inventoryRecord.setPIC_URL(arg0.getParameter("PIC_URL"));
				
				// 内部業務項目
				inventoryRecord.setACCOUNT(arg0.getParameter("INACCOUNT"));
				inventoryRecord.setORDER_DATE(arg0.getParameter("ORDER_DATE"));
				inventoryRecord.setWEB_DISP(arg0.getParameter("WEB_DISP"));
				inventoryRecord.setSELLER_CODE(arg0.getParameter("SELLER_CODE"));
				inventoryRecord.setSELLER(arg0.getParameter("SELLER"));
				inventoryRecord.setORDER_PRICE(arg0.getParameter("ORDER_PRICE"));
				inventoryRecord.setORDER_TRANS_COST(arg0.getParameter("ORDER_TRANS_COST"));
				inventoryRecord.setPARTS_COST(arg0.getParameter("PARTS_COST"));
				inventoryRecord.setMAINTENANCE_COST(arg0.getParameter("MAINTENANCE_COST"));
				inventoryRecord.setORDER_OUT_ORDER_COST(arg0.getParameter("ORDER_OUT_ORDER_COST"));
				inventoryRecord.setORDER_COST_PRICE(arg0.getParameter("ORDER_COST_PRICE"));
				inventoryRecord.setSELL_TRANCE_COST(arg0.getParameter("SELL_TRANCE_COST"));
				inventoryRecord.setSHIP_COST(arg0.getParameter("SHIP_COST"));
				inventoryRecord.setSELL_OUT_ORDER_COST(arg0.getParameter("SELL_OUT_ORDER_COST"));
				inventoryRecord.setINS_COST(arg0.getParameter("INS_COST"));
				inventoryRecord.setFREIGHT_COST(arg0.getParameter("FREIGHT_COST"));
				inventoryRecord.setSELL_COST_PRICE(arg0.getParameter("SELL_COST_PRICE"));
				inventoryRecord.setSELL_PRICE(arg0.getParameter("SELL_PRICE"));
				inventoryRecord.setWHOL_PRICE(arg0.getParameter("WHOL_PRICE"));
				inventoryRecord.setPROFIT(arg0.getParameter("PROFIT"));
				inventoryRecord.setBUYER_CODE(arg0.getParameter("BUYER_CODE"));
				inventoryRecord.setBUYER(arg0.getParameter("BUYER"));
				inventoryRecord.setORDER_PAY_DATE(arg0.getParameter("ORDER_PAY_DATE"));
				inventoryRecord.setSELL_PAY_DATE(arg0.getParameter("SELL_PAY_DATE"));
				inventoryRecord.setSELL_MONTH(arg0.getParameter("SELL_MONTH"));
				inventoryRecord.setMEMO(arg0.getParameter("MEMO"));
				
				if ("0".equals(inventoryRecord.getWEB_DISP())) {
					inventoryRecord.setWEB_DISP_DATE("");
				} else if ("0".equals(arg0.getParameter("LOADWEB_DISP")) && !"0".equals(inventoryRecord.getWEB_DISP())) {
					// 非表示から変更された場合のみ書き換える
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					Date date = new Date(System.currentTimeMillis());
					inventoryRecord.setWEB_DISP_DATE(sdf.format(date));
				}
				
	        	pm.makePersistent( inventoryRecord );
	        	
				// 一覧画面へ
				arg1.sendRedirect("GetInventoryList?ACCOUNT=" + arg0.getParameter("ACCOUNT"));
			} else if (TYPE_DELETE.equals(type)) {
	        	
				// 削除フラグを立てるだけ
				inventoryRecord.setDATA_FLG("9");
	        	pm.makePersistent( inventoryRecord );
				arg0.getSession().setAttribute("MSG", "選択した在庫を削除ました");
				
				// 一覧画面へ
				arg1.sendRedirect("GetInventoryList?ACCOUNT=" + arg0.getParameter("ACCOUNT"));
			} else if (TYPE_PICUPDATE.equals(type)) {
				// 写真更新
			    // セッションにつっこむ
			    arg0.getSession().setAttribute("InventoryRecord", inventoryRecord.getDATE());
			    arg0.getSession().setAttribute("AuthACCOUNT", arg0.getParameter("ACCOUNT"));
			    ServletContext sc = getServletContext();
			    RequestDispatcher rd = sc.getRequestDispatcher("/UpdatePicture.jsp?NAME=" + inventoryRecord.getNAME() + "&MANUFACTURER=" + inventoryRecord.getMANUFACTURER());
			    rd.forward(arg0, arg1);
			} else if (TYPE_DETAIL.equals(type)) {
				// 詳細ページへ遷移
			    arg0.setAttribute("InventoryRecord", inventoryRecord);
			    ServletContext sc = getServletContext();
			    RequestDispatcher rd = sc.getRequestDispatcher("/InventoryDetail.jsp");
			    rd.forward(arg0, arg1);
			} else if (TYPE_CLOSE.equals(type)) {
	        	
				String sellMonth = inventoryRecord.getSELL_MONTH();
				if (sellMonth == null || sellMonth.length() == 0) {
					arg0.getSession().setAttribute("MSG", "エラー：売上月が入力されていないため締めることができません");
				} else {
					// データフラグを締めに更新
					inventoryRecord.setDATA_FLG("1");
		        	pm.makePersistent( inventoryRecord );
					arg0.getSession().setAttribute("MSG", "選択した在庫を締めました");
				}
	        	
				// 一覧画面へ
				arg1.sendRedirect("GetInventoryList?ACCOUNT=" + arg0.getParameter("ACCOUNT"));
			} else if (TYPE_CLOSE_BACK.equals(type)) {
	        	
				// データフラグを通常に戻す
				inventoryRecord.setDATA_FLG("0");
	        	pm.makePersistent( inventoryRecord );
				arg0.getSession().setAttribute("MSG", "選択した在庫を締め戻しました");
				
				// 一覧画面へ
				arg1.sendRedirect("GetOldInventoryList?ACCOUNT=" + arg0.getParameter("ACCOUNT"));
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
