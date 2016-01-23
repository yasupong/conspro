package conspro.svlt;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.Date;
import java.util.List;

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
import conspro.storage.Seq;


/**
 * Proforma Invoice発行
 * @author yasupong
 */
@SuppressWarnings("serial")
public class LoadExcelProformaInvoiceSvlt extends HttpServlet {
	
	private static final int MAX_INV = 6;
	
	@SuppressWarnings("unchecked")
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
			URL url = context.getResource("/doc/ProformaInvoice.xlsx");
			FileInputStream is = new FileInputStream(url.getPath());
	        Workbook workbook = new XSSFWorkbook(is);
	        Sheet sheet = workbook.getSheet("Proforma");
	    
		    
			// 採番するためシーケンスデータを取得する
	        PersistenceManager pm = PMF.getInstance().getPersistenceManager();
		    List<Seq> seqList = (List<Seq>)pm.newQuery("select from " + Seq.class.getName() + " where SEQ_ID == '" + Seq.SEQ_ID_INVOICE_NO + "'").execute();
		    Seq seq = new Seq();
		    seq.setSEQ_ID(Seq.SEQ_ID_INVOICE_NO);
		    seq.setSEQ(0);
		    if (seqList != null && !seqList.isEmpty()) {
		    	seq = seqList.get(0);
		    }
		    
		    // カウントアップ
		    seq.setSEQ(seq.getSEQ() + 1);
		    String seqStr = String.format("%05d", seq.getSEQ());
			    
			String buyerCode = null;
			
			for (int i = 0; i < ids.length; i++) {
				
				if (MAX_INV == i) {
					break;
				}
				
				String id = ids[i];
				
		        // 在庫データ取得
			    Key keyObj = KeyFactory.createKey(InventoryRecord.class.getSimpleName(), id);
			    InventoryRecord inventoryRecord = pm.getObjectById(InventoryRecord.class, keyObj);
		    	
			    // 販売先
			    if (buyerCode == null) {
			    	buyerCode = inventoryRecord.getBUYER_CODE();
			    	
				    // 販売先コードが設定されている場合のみ
				    if (buyerCode != null && buyerCode.length() > 0) {
					    keyObj = KeyFactory.createKey(Client.class.getSimpleName(), inventoryRecord.getBUYER_CODE());
					    Client client = pm.getObjectById(Client.class, keyObj);
					    
					    // 会社名
					    Row row = sheet.getRow(6);
					    Cell cell = row.getCell(3);
				        cell.setCellValue(client.getCOMPANY());
				        
				        // 住所
				        row = sheet.getRow(7);
				        cell = row.getCell(3);
				        cell.setCellValue(client.getADDRESS());
				        
				        // 郵便番号
				        //row = sheet.getRow(8);
				        //cell = row.getCell(3);
				        //cell.setCellValue(client.getZIP());
				       
				        // 電話番号
				        row = sheet.getRow(9);
				        cell = row.getCell(3);
				        cell.setCellValue("TEL:" + client.getTEL());
				        
				        // FAX番号
				        row = sheet.getRow(9);
				        cell = row.getCell(5);
				        cell.setCellValue("FAX：" + client.getFAX());
				        
				    } else if (buyerCode != null && !buyerCode.equals(inventoryRecord.getBUYER_CODE())) {
				    	// 販売先コード一致しないエラー
						arg0.getSession().setAttribute("MSG", "販売先の一致しない在庫が含まれているため出力できません");
						arg1.sendRedirect("FTCGetInventoryList?ACCOUNT=" + arg0.getParameter("ACCOUNT"));
						workbook.close();
						return;
				    }
			    }
			    
			    // 商品名
			    Row row = sheet.getRow(19 + (i*3));
			    Cell cell = row.getCell(1);
		        cell.setCellValue("MODEL:" + inventoryRecord.getNAME());
		        
		        // 号機
		        row = sheet.getRow(20 + (i*3));
		        cell = row.getCell(1);
		        cell.setCellValue("S/N:" + inventoryRecord.getSERIALNO());
		       
		        // 数量
		        row = sheet.getRow(18 + (i*3));
		        cell = row.getCell(5);
		        cell.setCellValue(1);
		        
		        // 単位
		        row = sheet.getRow(18 + (i*3));
		        cell = row.getCell(6);
		        cell.setCellValue("UNIT");
		        
		        // 販売価格
		        row = sheet.getRow(18 + (i*3));
		        cell = row.getCell(7);
		        cell.setCellValue(Double.parseDouble(inventoryRecord.getSELL_PRICE()));
		        
		        // 入力日
		        row = sheet.getRow(4);
		        cell = row.getCell(8);
		        cell.setCellValue(new Date(System.currentTimeMillis()));
		        
		        // INVOICE NO
		        row = sheet.getRow(5);
		        cell = row.getCell(1);
		        cell.setCellValue("INVOICE NO.:" + seqStr);
		        
		        inventoryRecord.setINVOICE_NO(seqStr);
	        	pm.makePersistent(inventoryRecord);
			}
			
	        // 再計算
	        FormulaEvaluator formulaEvaluator = workbook.getCreationHelper().createFormulaEvaluator();
	        formulaEvaluator.evaluateAll();
	        
		    // ヘッダー情報構築
		    arg1.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); 
		    arg1.setHeader("Pragma", "no-cache");  
		    arg1.setHeader("Cache-Control", "no-cache"); 
		    arg1.setHeader("Content-Type","application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); 
		    arg1.addHeader("Content-Disposition", "inline; filename=\""+ System.currentTimeMillis() + "ProformaInvoice.xlsx\""); 
		    
	        // ストリームに書き込み
			ServletOutputStream objSos = arg1.getOutputStream();
	        workbook.write(objSos);
			objSos.close();
			workbook.close();
			
	        try {
	        	pm.makePersistent(seq);
	        } finally {
	        	pm.close();
	        }
	        
	    } catch ( Throwable th ) {
	    	throw new ServletException(th);
		}
	}
 
}
