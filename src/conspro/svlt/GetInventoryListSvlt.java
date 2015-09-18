package conspro.svlt;

import java.io.IOException;
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
import conspro.util.Const;

/**
 * 在庫一覧
 * @author yasupong
 */
@SuppressWarnings("serial")
public class GetInventoryListSvlt extends HttpServlet {

	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String page = request.getParameter("page");
		
	    ServletContext sc = getServletContext();
	    RequestDispatcher rd = null;
	    // 遷移先制御
	    if (Const.PAGE_TYPE_EN.equals(page)) {
	    	rd = sc.getRequestDispatcher("/GetInventoryListByType?TYPE=1&page=" + Const.PAGE_TYPE_EN);
	    }
	    else if (Const.PAGE_TYPE_JA.equals(page)) {
	    	rd = sc.getRequestDispatcher("/GetInventoryListByType?TYPE=1&page=" + Const.PAGE_TYPE_JA);
	    }
	    else {
			String sortType = request.getParameter("sort");
			String sortOrder = " order by TYPE,　MANUFACTURER, DATE desc";
			
			// 種類
		    if ("1".equals(sortType)) {
		    	sortOrder = " order by TYPE, MANUFACTURER, DATE desc";
		    }
			// 日付
		    else if ("2".equals(sortType)) {
		    	sortOrder = " order by DATE desc";
		    }
		    // 値段
		    else if ("3".equals(sortType)) {
		    	sortOrder = " order by PRICE asc";
		    }
		    // 状態
		    else if ("4".equals(sortType)) {
		    	sortOrder = " order by CONDITION desc";
		    }
		    // 稼動時間
		    else if ("5".equals(sortType)) {
		    	sortOrder = " order by HOURS desc";
		    }
		    // メーカー
		    else if ("6".equals(sortType)) {
		    	sortOrder = " order by MANUFACTURER, TYPE, DATE desc";
		    }
		    // WEB表示
		    else if ("7".equals(sortType)) {
		    	sortOrder = " order by WEB_DISP, WEB_DISP_DATE desc, TYPE";
		    }
		    
	    	// データ検索
		    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
		    String query = "select from " + InventoryRecord.class.getName() + " where DATA_FLG == '0'" + sortOrder;
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
	        if("1".equals(request.getParameter("MENU"))) {
	            request.getSession().setAttribute("NameSet", nameSet);
	            request.getSession().setAttribute("SellerSet", sellerSet);
	            request.getSession().setAttribute("TantoSet", tantoSet);
	        }
		    request.setAttribute("orderCostPrice", orderCostPrice);
		    request.setAttribute("sellCostPrice", sellCostPrice);
		    request.setAttribute("sellPrice", sellPrice);
		    request.setAttribute("profit", profit);
	    	rd = sc.getRequestDispatcher("/InventoryList.jsp");
	    }
	    rd.forward(request, response);
	}
}
