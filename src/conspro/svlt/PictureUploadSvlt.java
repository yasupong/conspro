package conspro.svlt;

import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;

import javax.jdo.PersistenceManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

import com.google.appengine.api.datastore.Blob;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.memcache.ErrorHandlers;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;

import conspro.storage.InventoryRecord;
import conspro.storage.PMF;

/**
 * 写真アップロード
 * @author yasupong
 */
@SuppressWarnings("serial")
public class PictureUploadSvlt extends HttpServlet {
	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {

	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
	    // セッションからとる
		String id =(String)arg0.getSession().getAttribute("InventoryRecord");
		
		// idが取れない場合エラー
		if (id == null || id.length() == 0) {
			// エラーページへ
			arg1.sendRedirect("Error.jsp");
			return;
		}
		
	    Key keyObj = KeyFactory.createKey(InventoryRecord.class.getSimpleName(), id);
	    InventoryRecord inventoryRecord = pm.getObjectById(InventoryRecord.class, keyObj);

        try {
    		ServletFileUpload fileUpload = new ServletFileUpload();

            FileItemIterator itemIterator = fileUpload.getItemIterator(arg0);

            // 写真データをBLOBへ展開
            if (itemIterator.hasNext()) {
                FileItemStream itemStream = itemIterator.next();
                InputStream inputStream = itemStream.openStream();
                byte[] picByte = IOUtils.toByteArray(inputStream);
                if (picByte!= null && picByte.length > 0) {
                	
                	// キャッシュに保存する
        			MemcacheService syncCache = MemcacheServiceFactory.getMemcacheService();
        			syncCache.setErrorHandler(ErrorHandlers.getConsistentLogAndContinue(Level.INFO));
					syncCache.put(id, picByte);
        			
	                Blob imageBlob = new Blob(picByte);
	                inventoryRecord.setPIC(imageBlob);
                }
            }

            // データ保存
        	pm.makePersistent(inventoryRecord);
			// 一覧画面へ
			arg1.sendRedirect("GetInventoryList?ACCOUNT=" + (String)arg0.getSession().getAttribute("AuthACCOUNT"));
        } catch (Throwable th) {
	    	throw new ServletException(th);
        } finally {
        	pm.close();
        }
   }
}
