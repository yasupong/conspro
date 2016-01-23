package conspro.svlt;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.Date;

import javax.jdo.PersistenceManager;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import conspro.storage.Client;
import conspro.storage.InventoryRecord;
import conspro.storage.PMF;


/**
 * 注文書発行
 * @author yasupong
 */
@SuppressWarnings("serial")
public class LoadExcelOrderSheetSvlt extends HttpServlet {
	
	private static final int MAX_INV = 9;
	
	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		String editId = arg0.getParameter("EDITID");
		String ids[ ] = arg0.getParameterValues("REPID");
		
		if (ids == null || ids.length == 0) {
			if (editId == null || editId.length() == 0) {
				// 未選択エラー
				arg0.getSession().setAttribute("MSG", "在庫が選択されていないため出力できません");
				arg1.sendRedirect("FTCGetInventoryList?ACCOUNT=" + arg0.getParameter("ACCOUNT"));
				return;
			}
			
			ids = new String[]{editId};
		}
		
	    try {
		    // テンプレートのロード
			ServletContext context = super.getServletContext();
			URL url = context.getResource("/doc/OrderSheet.xlsx");
			FileInputStream is = new FileInputStream(url.getPath());
			Workbook workbook = new XSSFWorkbook(is);
			Sheet sheet = workbook.getSheet("注文書");
	    
			String sellerCode = null;
			
			for (int i = 0; i < ids.length; i++) {
				
				if (MAX_INV == i) {
					break;
				}
				
				String id = ids[i];
				
		        // 在庫データ取得
			    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
			    Key keyObj = KeyFactory.createKey(InventoryRecord.class.getSimpleName(), id);
			    InventoryRecord inventoryRecord = pm.getObjectById(InventoryRecord.class, keyObj);
			    
			    // 仕入先
			    if (sellerCode == null) {
			    	sellerCode = inventoryRecord.getSELLER_CODE();
			    	
				    // 仕入先コードが設定されている場合のみ
				    if (sellerCode != null && sellerCode.length() > 0) {
					    keyObj = KeyFactory.createKey(Client.class.getSimpleName(), inventoryRecord.getSELLER_CODE());
					    Client client = pm.getObjectById(Client.class, keyObj);
					    
					    // 会社名
					    Row row = sheet.getRow(4);
					    Cell cell = row.getCell(1);
				        cell.setCellValue(client.getCOMPANY() + "　御中");
				        
				        // 営業所・担当者
				        row = sheet.getRow(5);
				        cell = row.getCell(2);
				        cell.setCellValue(client.getOFFICE() + "　" + client.getNAME() + "様");
				        
				        // 郵便番号
				        row = sheet.getRow(6);
				        cell = row.getCell(1);
				        cell.setCellValue("〒" + client.getZIP());
				        
				        // 住所
				        row = sheet.getRow(7);
				        cell = row.getCell(1);
				        cell.setCellValue(client.getADDRESS());
				        
				        // 電話番号
				        row = sheet.getRow(9);
				        cell = row.getCell(1);
				        cell.setCellValue("電話：" + client.getTEL() + "　FAX：" + client.getFAX());
				    }
				    
			    } else if (sellerCode != null && !sellerCode.equals(inventoryRecord.getSELLER_CODE())) {
			    	// 仕入先コード一致しないエラー
					arg0.getSession().setAttribute("MSG", "仕入先の一致しない在庫が含まれているため出力できません");
					arg1.sendRedirect("FTCGetInventoryList?ACCOUNT=" + arg0.getParameter("ACCOUNT"));
					workbook.close();
					return;
			    }

			    // 商品名
			    Row row = sheet.getRow(22 + (i*2));
			    Cell cell = row.getCell(1);
		        cell.setCellValue(inventoryRecord.getNAME());
		        
		        // 号機
		        row = sheet.getRow(23 + (i*2));
		        cell = row.getCell(1);
		        cell.setCellValue(inventoryRecord.getSERIALNO());
		        
		        // 数量
		        row = sheet.getRow(22 + (i*2));
		        cell = row.getCell(5);
		        cell.setCellValue(1);
		        
		        // 単位
		        row = sheet.getRow(22 + (i*2));
		        cell = row.getCell(6);
		        cell.setCellValue("台");
		        
		        // 仕入価格
		        row = sheet.getRow(22+ (i*2));
		        cell = row.getCell(7);
		        cell.setCellValue(Double.parseDouble(inventoryRecord.getORDER_PRICE()));
		        
		        // 引渡場所
		        if (inventoryRecord.getTRAN_PLACE() != null && inventoryRecord.getTRAN_PLACE().length() > 0) {
			        row = sheet.getRow(22+ (i*2));
			        cell = row.getCell(9);
			        cell.setCellValue("引渡場所：" + inventoryRecord.getTRAN_PLACE());
		        }
		        
		        // 入力日
		        row = sheet.getRow(1);
		        cell = row.getCell(9);
		        cell.setCellValue(new Date(System.currentTimeMillis()));
			}

	        // 再計算
	        FormulaEvaluator formulaEvaluator = workbook.getCreationHelper().createFormulaEvaluator();
	        formulaEvaluator.evaluateAll();
	        
		    // ヘッダー情報構築
		    arg1.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); 
		    arg1.setHeader("Pragma", "no-cache");  
		    arg1.setHeader("Cache-Control", "no-cache"); 
		    arg1.setHeader("Content-Type","application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); 
		    arg1.addHeader("Content-Disposition", "inline; filename=\""+ System.currentTimeMillis() + "OrderSheet.xlsx\""); 
		    
	        // ストリームに書き込み
			ServletOutputStream objSos = arg1.getOutputStream();
	        workbook.write(objSos);
			objSos.close();
			workbook.close();
			
	    } catch ( Throwable th ) {
	    	throw new ServletException(th);
		}
	}
 
}
