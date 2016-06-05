package conspro.svlt;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conspro.storage.InventoryRecord;
import conspro.storage.PMF;
import conspro.util.CommonUtil;

/**
 * 締め在庫一覧
 * @author yasupong
 */
@SuppressWarnings("serial")
public class GetOldInventoryListSvlt extends HttpServlet {

	protected static SimpleDateFormat SDF = new SimpleDateFormat("yyyy/MM");
	
	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    ServletContext sc = getServletContext();
	    RequestDispatcher rd = null;
	    
	    // 当月で絞り込む
	    Date now = new Date(System.currentTimeMillis());
	    
    	// データ検索
	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
	    String query = "select from " + InventoryRecord.class.getName() + " where DATA_FLG == '1' && SELL_MONTH == '" + SDF.format(now) + "' order by SELL_MONTH desc, SELL_PAY_DATE";
	    List<InventoryRecord> listInventoryRecord = (List<InventoryRecord>) pm.newQuery(query).execute();
	    
	    Set<String> nameSet = new TreeSet<String>();
	    Set<String> sellerSet = new TreeSet<String>();
	    Set<String> tantoSet = new TreeSet<String>();
	    Long orderCostPrice = 0L;
	    Long sellCostPrice = 0L;
	    Long sellPrice = 0L;
	    Long profit = 0L;
	    for (InventoryRecord inventoryRecord : listInventoryRecord) {
	    	if("1".equals(request.getParameter("MENU"))) {
		    	nameSet.add(inventoryRecord.getNAME());
		    	sellerSet.add(inventoryRecord.getSELLER());
		    	tantoSet.add(inventoryRecord.getACCOUNT());
	    	}
	    	orderCostPrice = orderCostPrice + CommonUtil.getLong(inventoryRecord.getORDER_COST_PRICE());
	    	sellCostPrice = sellCostPrice + CommonUtil.getLong(inventoryRecord.getSELL_COST_PRICE());
	    	sellPrice = sellPrice + CommonUtil.getLong(inventoryRecord.getSELL_PRICE());
	    	profit = profit + CommonUtil.getLong(inventoryRecord.getPROFIT());
		}
	    
	    // 画面返却
	    request.setAttribute("InventoryRecordList", listInventoryRecord);
	    request.setAttribute("NameSet", nameSet);
	    request.setAttribute("SellerSet", sellerSet);
	    request.setAttribute("TantoSet", tantoSet);
	    
        if("1".equals(request.getParameter("MENU"))) {
            request.getSession().setAttribute("NameSet", nameSet);
            request.getSession().setAttribute("SellerSet", sellerSet);
            request.getSession().setAttribute("TantoSet", tantoSet);
        }
        
	    request.setAttribute("orderCostPrice", orderCostPrice);
	    request.setAttribute("sellCostPrice", sellCostPrice);
	    request.setAttribute("sellPrice", sellPrice);
	    request.setAttribute("profit", profit);
    	rd = sc.getRequestDispatcher("/InventoryOldList.jsp");
    	
	    rd.forward(request, response);
	}
}
