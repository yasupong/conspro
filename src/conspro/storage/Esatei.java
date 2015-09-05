package conspro.storage;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class Esatei
{
    @PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private String DATE;

    @Persistent
    private String POST;
    
    @Persistent
    private String PNAME;
    
    @Persistent
    private String ADDRESS;
    
    @Persistent
    private String TEL;
    
    @Persistent
    private String FAX;
    
    @Persistent
    private String EMAIL;
    
    @Persistent
    private String SOURCE;
    
    @Persistent
    private String SELLER;//仕入先
    
    @Persistent
    private String NAME;//型式

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
    private String MANUFACTURER;//メーカー
    
    @Persistent
    private String MEMO;//在庫メモ

    @Persistent
    private String ORDER_PRICE;//仕入価格
    
	/**
	 * @return the dATE
	 */
	public String getDATE() {
		return DATE;
	}

	/**
	 * @param dATE the dATE to set
	 */
	public void setDATE(String dATE) {
		DATE = dATE;
	}

	/**
	 * @return the pOST
	 */
	public String getPOST() {
		return POST;
	}

	/**
	 * @param pOST the pOST to set
	 */
	public void setPOST(String pOST) {
		POST = pOST;
	}

	/**
	 * @return the pNAME
	 */
	public String getPNAME() {
		return PNAME;
	}

	/**
	 * @param pNAME the pNAME to set
	 */
	public void setPNAME(String pNAME) {
		PNAME = pNAME;
	}

	/**
	 * @return the aDDRESS
	 */
	public String getADDRESS() {
		return ADDRESS;
	}

	/**
	 * @param aDDRESS the aDDRESS to set
	 */
	public void setADDRESS(String aDDRESS) {
		ADDRESS = aDDRESS;
	}

	/**
	 * @return the tEL
	 */
	public String getTEL() {
		return TEL;
	}

	/**
	 * @param tEL the tEL to set
	 */
	public void setTEL(String tEL) {
		TEL = tEL;
	}

	/**
	 * @return the fAX
	 */
	public String getFAX() {
		return FAX;
	}

	/**
	 * @param fAX the fAX to set
	 */
	public void setFAX(String fAX) {
		FAX = fAX;
	}

	/**
	 * @return the eMAIL
	 */
	public String getEMAIL() {
		return EMAIL;
	}

	/**
	 * @param eMAIL the eMAIL to set
	 */
	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}

	/**
	 * @return the sOURCE
	 */
	public String getSOURCE() {
		return SOURCE;
	}

	/**
	 * @param sOURCE the sOURCE to set
	 */
	public void setSOURCE(String sOURCE) {
		SOURCE = sOURCE;
	}

	/**
	 * @return the nAME
	 */
	public String getNAME() {
		return NAME;
	}

	/**
	 * @param nAME the nAME to set
	 */
	public void setNAME(String nAME) {
		NAME = nAME;
	}

	/**
	 * @return the cONDITION
	 */
	public String getCONDITION() {
		return CONDITION;
	}

	/**
	 * @param cONDITION the cONDITION to set
	 */
	public void setCONDITION(String cONDITION) {
		CONDITION = cONDITION;
	}

	/**
	 * @return the tYPE
	 */
	public String getTYPE() {
		return TYPE;
	}

	/**
	 * @param tYPE the tYPE to set
	 */
	public void setTYPE(String tYPE) {
		TYPE = tYPE;
	}

	/**
	 * @return the yEAR
	 */
	public String getYEAR() {
		return YEAR;
	}

	/**
	 * @param yEAR the yEAR to set
	 */
	public void setYEAR(String yEAR) {
		YEAR = yEAR;
	}

	/**
	 * @return the sERIALNO
	 */
	public String getSERIALNO() {
		return SERIALNO;
	}

	/**
	 * @param sERIALNO the sERIALNO to set
	 */
	public void setSERIALNO(String sERIALNO) {
		SERIALNO = sERIALNO;
	}

	/**
	 * @return the hOURS
	 */
	public String getHOURS() {
		return HOURS;
	}

	/**
	 * @param hOURS the hOURS to set
	 */
	public void setHOURS(String hOURS) {
		HOURS = hOURS;
	}

	/**
	 * @return the mANUFACTURER
	 */
	public String getMANUFACTURER() {
		return MANUFACTURER;
	}

	/**
	 * @param mANUFACTURER the mANUFACTURER to set
	 */
	public void setMANUFACTURER(String mANUFACTURER) {
		MANUFACTURER = mANUFACTURER;
	}

	/**
	 * @return the oRDER_PRICE
	 */
	public String getORDER_PRICE() {
		return ORDER_PRICE;
	}

	/**
	 * @param oRDER_PRICE the oRDER_PRICE to set
	 */
	public void setORDER_PRICE(String oRDER_PRICE) {
		ORDER_PRICE = oRDER_PRICE;
	}

	/**
	 * @return the mEMO
	 */
	public String getMEMO() {
		return MEMO;
	}

	/**
	 * @param mEMO the mEMO to set
	 */
	public void setMEMO(String mEMO) {
		MEMO = mEMO;
	}

	/**
	 * @return the sELLER
	 */
	public String getSELLER() {
		return SELLER;
	}

	/**
	 * @param sELLER the sELLER to set
	 */
	public void setSELLER(String sELLER) {
		SELLER = sELLER;
	}
	
	
}
