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

import conspro.storage.Client;
import conspro.storage.PMF;
import conspro.util.CodeUtil;

/**
 * 顧客データEXCEL作成
 * @author yasupong
 */
@SuppressWarnings("serial")
public class LoadExcelClientAllSvlt extends HttpServlet {
	
	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		// 顧客データを検索する
	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
		List<Client> listClientRecord = (List<Client>) pm.newQuery("select from " + Client.class.getName()).execute();
        
	    // ヘッダー情報構築
	    arg1.setContentType("application/vnd.ms-excel"); 
	    arg1.setHeader("Pragma", "no-cache");  
	    arg1.setHeader("Cache-Control", "no-cache"); 
	    arg1.setHeader("Content-Type","application/vnd.ms-excel"); 
	    arg1.addHeader("Content-Disposition", "inline; filename=\""+ System.currentTimeMillis() + "Client.xls\""); 
	    
	    try {
	    	HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = workbook.createSheet();
            workbook.setSheetName(0,"顧客一覧");  
            
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
            
            cell01.setCellValue("顧客コード");
            cell02.setCellValue("業種");     
            cell03.setCellValue("与信管理"); 
            cell04.setCellValue("国番号"); 
            cell05.setCellValue("顧客番号"); 
            cell06.setCellValue("住所");
            cell07.setCellValue("郵便番号");
            cell08.setCellValue("電話番号");
            cell09.setCellValue("FAX番号");
            cell10.setCellValue("メール");
            cell11.setCellValue("会社名");
            cell12.setCellValue("担当者"); 
            cell13.setCellValue("備考");
            
            int count = 1;
            
            for (Iterator<Client> iterator = listClientRecord.iterator(); iterator.hasNext();) {
            	Client clientRecord = (Client) iterator.next();
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
	            
	            // セルデータ設定
	            cellData01.setCellValue(clientRecord.getCLIENT_CODE());
	            cellData02.setCellValue(CodeUtil.getClientType(clientRecord.getCLIENT_TYPE()));
	            cellData03.setCellValue(CodeUtil.getCredit(clientRecord.getCREDIT()));
	            cellData04.setCellValue(clientRecord.getCOUNTRY());
	            cellData05.setCellValue(clientRecord.getSEQ());
	            cellData06.setCellValue(clientRecord.getADDRESS());
	            cellData07.setCellValue(clientRecord.getZIP());
	            cellData08.setCellValue(clientRecord.getTEL());
	            cellData09.setCellValue(clientRecord.getFAX());
	            cellData10.setCellValue(clientRecord.getMAIL());
	            cellData11.setCellValue(clientRecord.getCOMPANY());
	            cellData12.setCellValue(clientRecord.getNAME());
	            cellData13.setCellValue(clientRecord.getCOMMENT());
	            
		        count++;
			}
            
			ServletOutputStream objSos = arg1.getOutputStream();
	        workbook.write(objSos);
			objSos.close();
			workbook.close();
	    } catch ( Throwable th ) {
	    	throw new ServletException(th);
		} finally {
        	pm.close();
	    }
	}
}
