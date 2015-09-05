package conspro.svlt;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import conspro.storage.InventoryRecord;
import conspro.storage.PMF;
import conspro.util.CodeUtil;

/**
 * 棚卸在庫データEXCEL作成
 * @author yasupong
 */
@SuppressWarnings("serial")
public class LoadExcelForInvCountSvlt extends HttpServlet {
	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		// 在庫データを検索する
		// 条件：仕入支払日が入力ありかつ売上入金日・売上月が空欄
	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
	    String query = "select from " + InventoryRecord.class.getName() + " where ORDER_PAY_DATE != '' && SELL_MONTH == '' && SELL_PAY_DATE == '' && DATA_FLG == '0' order by ORDER_PAY_DATE, TYPE";
	    List<InventoryRecord> listInventoryRecord = (List<InventoryRecord>) pm.newQuery(query).execute();
        
	    // ヘッダー情報構築
	    arg1.setContentType("application/vnd.ms-excel"); 
	    arg1.setHeader("Pragma", "no-cache");  
	    arg1.setHeader("Cache-Control", "no-cache"); 
	    arg1.setHeader("Content-Type","application/vnd.ms-excel"); 
	    arg1.addHeader("Content-Disposition", "inline; filename=\""+ System.currentTimeMillis() + "StockCount.xls\""); 
	    
	    try {
	    	HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = workbook.createSheet();
            workbook.setSheetName(0,"棚卸在庫一覧");  
            
            // ヘッダーデータ構築
	        HSSFRow row1 = sheet.createRow(0);
	        
            HSSFCell cell01 = row1.createCell(0);
            HSSFCell cell02 = row1.createCell(1);
            HSSFCell cell03 = row1.createCell(2);
            HSSFCell cell04 = row1.createCell(3);
            HSSFCell cell05 = row1.createCell(4);
            HSSFCell cell06 = row1.createCell(5);
            HSSFCell cell07 = row1.createCell(6);
            HSSFCell cell08 = row1.createCell(7);
            HSSFCell cell09 = row1.createCell(8);
            HSSFCell cell10 = row1.createCell(9);
            HSSFCell cell11 = row1.createCell(10);
            HSSFCell cell12 = row1.createCell(11);
            HSSFCell cell13 = row1.createCell(12);
            HSSFCell cell14 = row1.createCell(13);
            HSSFCell cell15 = row1.createCell(14);
            HSSFCell cell16 = row1.createCell(15);
            HSSFCell cell17 = row1.createCell(16);
            HSSFCell cell18 = row1.createCell(17);
            HSSFCell cell19 = row1.createCell(18);
            HSSFCell cell20 = row1.createCell(19);
            HSSFCell cell21 = row1.createCell(19);
            HSSFCell cell22 = row1.createCell(20);
            HSSFCell cell23 = row1.createCell(21);
            HSSFCell cell24 = row1.createCell(22);
            HSSFCell cell25 = row1.createCell(23);
            
            cell01.setCellValue("仕入担当");
            cell02.setCellValue("発注日");
            cell03.setCellValue("型式"); 
            cell04.setCellValue("号機"); 
            cell05.setCellValue("WEB表示");
            cell06.setCellValue("仕入先");
            cell07.setCellValue("仕入価格");
            cell08.setCellValue("仕入運賃");
            cell09.setCellValue("部品代");
            cell10.setCellValue("整備費");
            cell11.setCellValue("仕入外注費");
            cell12.setCellValue("仕入原価");
            cell13.setCellValue("販売運賃");
            cell14.setCellValue("船積費用");
            cell15.setCellValue("販売外注費");
            cell16.setCellValue("保険料");
            cell17.setCellValue("フレイト");
            cell18.setCellValue("販売原価");
            cell19.setCellValue("販売価格");
            cell20.setCellValue("利益");
            cell21.setCellValue("販売先");
            cell22.setCellValue("業販価格");
            cell23.setCellValue("仕入代金支払日");
            cell24.setCellValue("売上入金日");
            cell25.setCellValue("売上月");
            
            int count = 1;

            for (Iterator<InventoryRecord> iterator = listInventoryRecord.iterator(); iterator.hasNext();) {
            	InventoryRecord inventoryRecord = (InventoryRecord) iterator.next();
		        HSSFRow row = sheet.createRow(count);
		        
		        // セルデータ構築
	            HSSFCell cellData01 = row.createCell(0);
	            HSSFCell cellData02 = row.createCell(1);
	            HSSFCell cellData03 = row.createCell(2);
	            HSSFCell cellData04 = row.createCell(3);
	            HSSFCell cellData05 = row.createCell(4);
	            HSSFCell cellData06 = row.createCell(5);
	            HSSFCell cellData07 = row.createCell(6);
	            HSSFCell cellData08 = row.createCell(7);
	            HSSFCell cellData09 = row.createCell(8);
	            HSSFCell cellData10 = row.createCell(9);
	            HSSFCell cellData11 = row.createCell(10);
	            HSSFCell cellData12 = row.createCell(11);
	            HSSFCell cellData13 = row.createCell(12);
	            HSSFCell cellData14 = row.createCell(13);
	            HSSFCell cellData15 = row.createCell(14);
	            HSSFCell cellData16 = row.createCell(15);
	            HSSFCell cellData17 = row.createCell(16);
	            HSSFCell cellData18 = row.createCell(17);
	            HSSFCell cellData19 = row.createCell(18);
	            HSSFCell cellData20 = row.createCell(19);
	            HSSFCell cellData21 = row.createCell(19);
	            HSSFCell cellData22 = row.createCell(20);
	            HSSFCell cellData23 = row.createCell(21);
	            HSSFCell cellData24 = row.createCell(22);
	            HSSFCell cellData25 = row.createCell(23);
	            
	            // セルデータ設定            
	            cellData01.setCellValue(inventoryRecord.getACCOUNT()); //仕入担当
	            cellData02.setCellValue(inventoryRecord.getORDER_DATE()); //発注日
	            cellData03.setCellValue(inventoryRecord.getNAME()); //型式  
	            cellData04.setCellValue(inventoryRecord.getSERIALNO()); //号機
	            cellData05.setCellValue(CodeUtil.getIsDisp(inventoryRecord.getWEB_DISP())); //WEB表示
	            cellData06.setCellValue(inventoryRecord.getSELLER()); //仕入先
	            cellData07.setCellValue(inventoryRecord.getORDER_PRICE()); //仕入価格
	            cellData08.setCellValue(inventoryRecord.getORDER_TRANS_COST()); //仕入運賃
	            cellData09.setCellValue(inventoryRecord.getPARTS_COST()); //部品代
	            cellData10.setCellValue(inventoryRecord.getMAINTENANCE_COST()); //整備費
	            cellData11.setCellValue(inventoryRecord.getORDER_OUT_ORDER_COST()); //仕入外注費
	            cellData12.setCellValue(inventoryRecord.getORDER_COST_PRICE()); //仕入原価
	            
	            cellData13.setCellValue(inventoryRecord.getSELL_TRANCE_COST()); //販売運賃
	            cellData14.setCellValue(inventoryRecord.getSHIP_COST()); //船積費用
	            cellData15.setCellValue(inventoryRecord.getSELL_OUT_ORDER_COST()); //販売外注費
	            cellData16.setCellValue(inventoryRecord.getINS_COST()); //保険料
	            cellData17.setCellValue(inventoryRecord.getFREIGHT_COST()); //フレイト
	            cellData18.setCellValue(inventoryRecord.getSELL_COST_PRICE()); //販売原価
	            cellData19.setCellValue(inventoryRecord.getSELL_PRICE()); //販売価格
	            cellData20.setCellValue(inventoryRecord.getPROFIT()); //利益
	            cellData21.setCellValue(inventoryRecord.getBUYER()); //販売先
	            cellData22.setCellValue(inventoryRecord.getWHOL_PRICE()); //業販価格
	            
	            cellData23.setCellValue(inventoryRecord.getORDER_PAY_DATE()); //仕入代金支払日
	            cellData24.setCellValue(inventoryRecord.getSELL_PAY_DATE()); //売上入金日
	            cellData25.setCellValue(inventoryRecord.getSELL_MONTH()); //売上月
	            
		        count++;
			}
            
			ServletOutputStream objSos = arg1.getOutputStream();
	        workbook.write(objSos);
			objSos.close();
	    }
	    catch ( Throwable th ) {
	    	throw new ServletException(th);
		}
	    finally {
        	pm.close();
	    }
	}
}
