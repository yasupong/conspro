package conspro.svlt;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;

import javax.jdo.PersistenceManager;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.Blob;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.memcache.ErrorHandlers;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;

import conspro.storage.InventoryRecord;
import conspro.storage.PMF;

/**
 * 写真データ取得
 * @author yasupong
 */
@SuppressWarnings("serial")
public class GetPictureSvlt extends HttpServlet {
	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		String id = arg0.getParameter("EDITID");
		
		// idが取れない場合エラー
		if (id == null || id.length() == 0) {
			// エラーページへ
			arg1.sendRedirect("Error.jsp");
			return;
		}
		
		InputStream in = null;
		
		try {
			// キャッシュより写真データを取得
			MemcacheService syncCache = MemcacheServiceFactory.getMemcacheService();
			syncCache.setErrorHandler(ErrorHandlers.getConsistentLogAndContinue(Level.INFO));
			
			byte[] picData = (byte[])syncCache.get(id);
			// キャッシュにない場合
			if (picData == null) {
				// ＤＢから取得する
			    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
			    Key keyObj = KeyFactory.createKey( InventoryRecord.class.getSimpleName(), id );
			    InventoryRecord inventoryRecord = null;
		    	inventoryRecord = pm.getObjectById( InventoryRecord.class, keyObj );
	
		    	// マスタにない場合エラー
		    	if (inventoryRecord == null) {
					// エラーページへ
			    	throw new ServletException("処理異常です。データ不正です。");
		    	}
		    	
		    	// 写真データをBLOBから取得
				Blob picBlobData = inventoryRecord.getPIC();
				
				if (picBlobData != null) {
					picData = picBlobData.getBytes();
					syncCache.put(id, picData);
		    	}
	        	pm.close();
			}

			ServletOutputStream objSos = arg1.getOutputStream();

			if (picData != null) {
				// 写真データをバイナリーとしてストリームへ書き込む
				objSos.write(picData);
	    	} else {
				// 写真データが取れなかった場合は代替画像を出力
		        in = new FileInputStream("img/nopic.gif");
		        byte[] buff = new byte[1024];
		        int len = 0;
		        while ((len = in.read(buff, 0, buff.length)) != -1) {
		        	objSos.write(buff, 0, len);
		        }
			}

			objSos.close();
	    } catch ( Throwable th ) {
	    	throw new ServletException(th);
		} finally {
	    	if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
        	    	throw new ServletException(e);
                }
            }
	    }
	}
}
