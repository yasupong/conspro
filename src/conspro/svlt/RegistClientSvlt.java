package conspro.svlt;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conspro.storage.Client;
import conspro.storage.PMF;
import conspro.storage.Seq;

/**
 * 顧客登録
 * @author yasupong
 */
@SuppressWarnings("serial")
public class RegistClientSvlt extends HttpServlet {

	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    PersistenceManager pm = PMF.getInstance().getPersistenceManager();
	    
		// 採番するためシーケンスデータを取得する
	    List<Seq> seqList = (List<Seq>)pm.newQuery("select from " + Seq.class.getName() + " where SEQ_ID == '" + Seq.SEQ_ID_CLIENT + "'").execute();
	    Seq seq = new Seq();
	    seq.setSEQ_ID(Seq.SEQ_ID_CLIENT);
	    seq.setSEQ(0);
	    if (seqList != null && !seqList.isEmpty()) {
	    	seq = seqList.get(0);
	    }
	    
	    // カウントアップ
	    seq.setSEQ(seq.getSEQ() + 1);
	    String seqStr = String.format("%04d", seq.getSEQ());
	    
		String clientCode = req.getParameter("CLIENT_TYPE") + req.getParameter("CREDIT") + req.getParameter("COUNTRY") + seqStr;
		
		// チェック処理
	    List<Client> clientRecordList = (List<Client>)pm.newQuery("select from " + Client.class.getName() + " where DATA_FLG == '0' && CLIENT_CODE == '" + clientCode + "'").execute();
	    if (clientRecordList != null && !clientRecordList.isEmpty()) {
	    	req.getSession().setAttribute("MSG", clientCode + " 顧客コードが重複しています。入力をやり直してください");
	        resp.sendRedirect("RegistClient.jsp?ACCOUNT=" + req.getParameter("ACCOUNT"));
	    	return;
	    }
		
		// パラメータ取得
		Client client = new Client();
		client.setCLIENT_CODE(clientCode);
		client.setCLIENT_TYPE(req.getParameter("CLIENT_TYPE"));
		client.setCREDIT(req.getParameter("CREDIT"));
		client.setCOUNTRY(req.getParameter("COUNTRY"));
		client.setSEQ(seqStr);
		client.setADDRESS(req.getParameter("ADDRESS"));
		client.setZIP(req.getParameter("ZIP"));
		client.setTEL(req.getParameter("TEL"));
		client.setFAX(req.getParameter("FAX"));
		client.setMAIL(req.getParameter("MAIL"));
		client.setCOMPANY(req.getParameter("COMPANY"));
		client.setOFFICE(req.getParameter("OFFICE"));
		client.setNAME(req.getParameter("NAME"));
		client.setCOMMENT(req.getParameter("COMMENT"));
		client.setDATA_FLG("0");

        try {
        	pm.makePersistent(client);
        	pm.makePersistent(seq);
        } catch (Throwable th) {
	    	throw new ServletException(th);
        } finally {
        	pm.close();
        }

        resp.sendRedirect("RegResultClient.jsp");
   }
}
