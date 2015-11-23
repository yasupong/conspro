package conspro.svlt;

import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conspro.storage.InventoryRecord;
import conspro.storage.PMF;
import conspro.util.CommonUtil;

/**
 * 在庫一覧検索
 * @author yasupong
 */
@SuppressWarnings("serial")
public class SeachInventoryListSvlt extends HttpServlet {

	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		// データ検索
	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
	    StringBuffer queryBuf = new StringBuffer("select from " + InventoryRecord.class.getName());
	    
	    String searchType = arg0.getParameter("SEARCH_TYPE");
	    
	    if ("1".equals(searchType)) {
	    	// 販売用在庫検索
			// 条件：販売先が空欄
	    	queryBuf.append(" where DATA_FLG == '0' && BUYER == '' order by TYPE");
	    } else if ("2".equals(searchType)) {
	    	// 棚卸在庫検索
			// 条件：仕入支払日が入力ありかつ売上入金日・売上月が空欄
	    	queryBuf.append(" where DATA_FLG == '0' && ORDER_PAY_DATE != '' && SELL_MONTH == '' && SELL_PAY_DATE == '' order by ORDER_PAY_DATE, TYPE");
	    } else {
	    	
	    	queryBuf.append(" where DATA_FLG == '0'");
	    	
	    	// 通常検索
		    if (arg0.getParameter("NAME") != null && arg0.getParameter("NAME").length() > 0) {	    	
		    	queryBuf.append(" && NAME == '" + arg0.getParameter("NAME") + "'");
		    }
		    if (arg0.getParameter("SELLER") != null && arg0.getParameter("SELLER").length() > 0) {
		    	queryBuf.append(" && SELLER == '" + arg0.getParameter("SELLER") + "'");
		    }
		    if (arg0.getParameter("TANTO") != null && arg0.getParameter("TANTO").length() > 0) {
		    	queryBuf.append(" && ACCOUNT == '" + arg0.getParameter("TANTO") + "'");
		    }
		    if (arg0.getParameter("WEB_DISP") != null && arg0.getParameter("WEB_DISP").length() > 0) {
		    	queryBuf.append(" && WEB_DISP == '" + arg0.getParameter("WEB_DISP") + "'");
		    }
	    }

	    List<InventoryRecord> listInventoryRecord = (List<InventoryRecord>) pm.newQuery(queryBuf.toString()).execute();
	    
	    Set<String> nameSet = new TreeSet<String>();
	    Set<String> sellerSet = new TreeSet<String>();
	    Set<String> tantoSet = new TreeSet<String>();
	    Long orderCostPrice = 0L;
	    Long sellCostPrice = 0L;
	    Long sellPrice = 0L;
	    Long profit = 0L;
	    for (InventoryRecord inventoryRecord : listInventoryRecord) {
	    	nameSet.add(inventoryRecord.getNAME());
	    	sellerSet.add(inventoryRecord.getSELLER());
	    	tantoSet.add(inventoryRecord.getACCOUNT());
	    	orderCostPrice = orderCostPrice + CommonUtil.getLong(inventoryRecord.getORDER_COST_PRICE());
	    	sellCostPrice = sellCostPrice + CommonUtil.getLong(inventoryRecord.getSELL_COST_PRICE());
	    	sellPrice = sellPrice + CommonUtil.getLong(inventoryRecord.getSELL_PRICE());
	    	profit = profit + CommonUtil.getLong(inventoryRecord.getPROFIT());
		}
	    
	    // 画面返却
	    arg0.setAttribute("InventoryRecordList", listInventoryRecord);
	    arg0.setAttribute("NameSet", nameSet);
	    arg0.setAttribute("SellerSet", sellerSet);
	    arg0.setAttribute("TantoSet", tantoSet);
	    arg0.setAttribute("orderCostPrice", orderCostPrice);
	    arg0.setAttribute("sellCostPrice", sellCostPrice);
	    arg0.setAttribute("sellPrice", sellPrice);
	    arg0.setAttribute("profit", profit);
	    RequestDispatcher rd = getServletContext().getRequestDispatcher("/InventoryList.jsp");
		rd.forward(arg0, arg1);
	}
}
