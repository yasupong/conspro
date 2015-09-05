package conspro.storage;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Blob;

@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class InventoryRecord
{
    @PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private String DATE;//ID

    @Persistent
    private String NAME;//型式

    @Persistent
    private String PRICE;//表示価格

    @Persistent
    private String CONDITION;//程度

    @Persistent
    private String TYPE;//分類
    
    @Persistent
    private String YEAR;//年式

    @Persistent
    private String SERIALNO;//号機

    @Persistent
    private String HOURS;//稼動時間

    @Persistent
    private String OTHER;//詳細英語

    @Persistent
    private String OTHER_JA;//詳細日本語
    
    @Persistent
    private String MANUFACTURER;//メーカー
    
    @Persistent
    private String PIC_URL;//写真アドレス
    
    @Persistent
    private Blob PIC;//表紙写真用データ

    // 以下内部用項目
    
    @Persistent
    private String ACCOUNT;//仕入担当
    
    @Persistent
    private String ORDER_DATE;//発注日
    
    @Persistent
    private String WEB_DISP;//WEB表示
    
    @Persistent
    private String SELLER;//仕入先
    
    @Persistent
    private String ORDER_PRICE;//仕入価格
    
    @Persistent
    private String ORDER_TRANS_COST;//仕入運賃
    
    @Persistent
    private String PARTS_COST;//部品代
    
    @Persistent
    private String MAINTENANCE_COST;//整備費
    
    @Persistent
    private String ORDER_OUT_ORDER_COST;//仕入外注費
    
    @Persistent
    private String ORDER_COST_PRICE;//仕入原価
    
    @Persistent
    private String SELL_TRANCE_COST;//販売運賃
    
    @Persistent
    private String SHIP_COST;//船積費用
    
    @Persistent
    private String SELL_OUT_ORDER_COST;//販売外注費
    
    @Persistent
    private String INS_COST;//保険料
    
    @Persistent
    private String FREIGHT_COST;//フレイト
    
    @Persistent
    private String SELL_COST_PRICE;//販売原価
    
    @Persistent
    private String SELL_PRICE;//販売価格
    
    @Persistent
    private String WHOL_PRICE;//業販価格
    
    @Persistent
    private String PROFIT;//利益
    
    @Persistent
    private String BUYER;//販売先
    
    @Persistent
    private String ORDER_PAY_DATE;//仕入代金支払日
    
    @Persistent
    private String SELL_PAY_DATE;//売上入金日
    
    @Persistent
    private String SELL_MONTH;//売上月

    @Persistent
    private String MEMO;//在庫メモ

    // 制御項目
    
    @Persistent
    private String DATA_FLG;//データフラグ
    
    @Persistent
    private String WEB_DISP_DATE;//WEB表示日時
    
	public String getDATE() {
		return DATE;
	}

	public void setDATE(String dATE) {
		DATE = dATE;
	}

	public String getNAME() {
		return NAME;
	}

	public void setNAME(String nAME) {
		NAME = nAME;
	}

	public String getPRICE() {
		return PRICE;
	}

	public void setPRICE(String pRICE) {
		PRICE = pRICE;
	}

	public String getCONDITION() {
		return CONDITION;
	}

	public void setCONDITION(String cONDITION) {
		CONDITION = cONDITION;
	}

	public String getTYPE() {
		return TYPE;
	}

	public void setTYPE(String tYPE) {
		TYPE = tYPE;
	}

	public String getYEAR() {
		return YEAR;
	}

	public void setYEAR(String yEAR) {
		YEAR = yEAR;
	}

	public String getSERIALNO() {
		return SERIALNO;
	}

	public void setSERIALNO(String sERIALNO) {
		SERIALNO = sERIALNO;
	}

	public String getHOURS() {
		return HOURS;
	}

	public void setHOURS(String hOURS) {
		HOURS = hOURS;
	}

	public String getOTHER() {
		return OTHER;
	}

	public void setOTHER(String oTHER) {
		OTHER = oTHER;
	}

	public String getOTHER_JA() {
		return OTHER_JA;
	}

	public void setOTHER_JA(String oTHER_JA) {
		OTHER_JA = oTHER_JA;
	}

	public String getMANUFACTURER() {
		return MANUFACTURER;
	}

	public void setMANUFACTURER(String mANUFACTURER) {
		MANUFACTURER = mANUFACTURER;
	}

	public String getPIC_URL() {
		return PIC_URL;
	}

	public void setPIC_URL(String pIC_URL) {
		PIC_URL = pIC_URL;
	}

	public Blob getPIC() {
		return PIC;
	}

	public void setPIC(Blob pIC) {
		PIC = pIC;
	}

	public String getACCOUNT() {
		return ACCOUNT;
	}

	public void setACCOUNT(String aCCOUNT) {
		ACCOUNT = aCCOUNT;
	}

	public String getORDER_DATE() {
		return ORDER_DATE;
	}

	public void setORDER_DATE(String oRDER_DATE) {
		ORDER_DATE = oRDER_DATE;
	}

	public String getWEB_DISP() {
		return WEB_DISP;
	}

	public void setWEB_DISP(String wEB_DISP) {
		WEB_DISP = wEB_DISP;
	}

	public String getSELLER() {
		return SELLER;
	}

	public void setSELLER(String sELLER) {
		SELLER = sELLER;
	}

	public String getORDER_PRICE() {
		return ORDER_PRICE;
	}

	public void setORDER_PRICE(String oRDER_PRICE) {
		ORDER_PRICE = oRDER_PRICE;
	}

	public String getORDER_TRANS_COST() {
		return ORDER_TRANS_COST;
	}

	public void setORDER_TRANS_COST(String oRDER_TRANS_COST) {
		ORDER_TRANS_COST = oRDER_TRANS_COST;
	}

	public String getPARTS_COST() {
		return PARTS_COST;
	}

	public void setPARTS_COST(String pARTS_COST) {
		PARTS_COST = pARTS_COST;
	}

	public String getMAINTENANCE_COST() {
		return MAINTENANCE_COST;
	}

	public void setMAINTENANCE_COST(String mAINTENANCE_COST) {
		MAINTENANCE_COST = mAINTENANCE_COST;
	}

	public String getORDER_OUT_ORDER_COST() {
		return ORDER_OUT_ORDER_COST;
	}

	public void setORDER_OUT_ORDER_COST(String oRDER_OUT_ORDER_COST) {
		ORDER_OUT_ORDER_COST = oRDER_OUT_ORDER_COST;
	}

	public String getORDER_COST_PRICE() {
		return ORDER_COST_PRICE;
	}

	public void setORDER_COST_PRICE(String oRDER_COST_PRICE) {
		ORDER_COST_PRICE = oRDER_COST_PRICE;
	}

	public String getSELL_TRANCE_COST() {
		return SELL_TRANCE_COST;
	}

	public void setSELL_TRANCE_COST(String sELL_TRANCE_COST) {
		SELL_TRANCE_COST = sELL_TRANCE_COST;
	}

	public String getSHIP_COST() {
		return SHIP_COST;
	}

	public void setSHIP_COST(String sHIP_COST) {
		SHIP_COST = sHIP_COST;
	}

	public String getSELL_OUT_ORDER_COST() {
		return SELL_OUT_ORDER_COST;
	}

	public void setSELL_OUT_ORDER_COST(String sELL_OUT_ORDER_COST) {
		SELL_OUT_ORDER_COST = sELL_OUT_ORDER_COST;
	}

	public String getINS_COST() {
		return INS_COST;
	}

	public void setINS_COST(String iNS_COST) {
		INS_COST = iNS_COST;
	}

	public String getFREIGHT_COST() {
		return FREIGHT_COST;
	}

	public void setFREIGHT_COST(String fREIGHT_COST) {
		FREIGHT_COST = fREIGHT_COST;
	}

	public String getSELL_COST_PRICE() {
		return SELL_COST_PRICE;
	}

	public void setSELL_COST_PRICE(String sELL_COST_PRICE) {
		SELL_COST_PRICE = sELL_COST_PRICE;
	}

	public String getSELL_PRICE() {
		return SELL_PRICE;
	}

	public void setSELL_PRICE(String sELL_PRICE) {
		SELL_PRICE = sELL_PRICE;
	}

	public String getWHOL_PRICE() {
		return WHOL_PRICE;
	}

	public void setWHOL_PRICE(String wHOL_PRICE) {
		WHOL_PRICE = wHOL_PRICE;
	}

	public String getPROFIT() {
		return PROFIT;
	}

	public void setPROFIT(String pROFIT) {
		PROFIT = pROFIT;
	}

	public String getBUYER() {
		return BUYER;
	}

	public void setBUYER(String bUYER) {
		BUYER = bUYER;
	}

	public String getORDER_PAY_DATE() {
		return ORDER_PAY_DATE;
	}

	public void setORDER_PAY_DATE(String oRDER_PAY_DATE) {
		ORDER_PAY_DATE = oRDER_PAY_DATE;
	}

	public String getSELL_PAY_DATE() {
		return SELL_PAY_DATE;
	}

	public void setSELL_PAY_DATE(String sELL_PAY_DATE) {
		SELL_PAY_DATE = sELL_PAY_DATE;
	}

	public String getSELL_MONTH() {
		return SELL_MONTH;
	}

	public void setSELL_MONTH(String sELL_MONTH) {
		SELL_MONTH = sELL_MONTH;
	}

	public String getMEMO() {
		return MEMO;
	}

	public void setMEMO(String mEMO) {
		MEMO = mEMO;
	}

	public String getDATA_FLG() {
		return DATA_FLG;
	}

	public void setDATA_FLG(String dATA_FLG) {
		DATA_FLG = dATA_FLG;
	}

	/**
	 * @return the wEB_DISP_DATE
	 */
	public String getWEB_DISP_DATE() {
		return WEB_DISP_DATE;
	}

	/**
	 * @param wEB_DISP_DATE the wEB_DISP_DATE to set
	 */
	public void setWEB_DISP_DATE(String wEB_DISP_DATE) {
		WEB_DISP_DATE = wEB_DISP_DATE;
	}
}
