package conspro.storage;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

/**
 * 顧客エンティティ
 * @author yishizu
 */
@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class Client {
    @PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private String CLIENT_CODE;

    @Persistent
    private String CLIENT_TYPE;
    
    @Persistent
    private String CREDIT;
    
    @Persistent
    private String COUNTRY;
    
    @Persistent
    private String SEQ;
    
    @Persistent
    private String NAME;
    
    @Persistent
    private String COMPANY;
    
    @Persistent
    private String OFFICE;
    
    @Persistent
    private String ADDRESS;
    
    @Persistent
    private String ZIP;
    
    @Persistent
    private String TEL;
    
    @Persistent
    private String FAX;
    
    @Persistent
    private String MAIL;
    
    @Persistent
    private String COMMENT;

    @Persistent
    private String DATA_FLG;//データフラグ

	/**
	 * @return the cLIENT_CODE
	 */
	public String getCLIENT_CODE() {
		return CLIENT_CODE;
	}

	/**
	 * @param cLIENT_CODE the cLIENT_CODE to set
	 */
	public void setCLIENT_CODE(String cLIENT_CODE) {
		CLIENT_CODE = cLIENT_CODE;
	}

	/**
	 * @return the cLIENT_TYPE
	 */
	public String getCLIENT_TYPE() {
		return CLIENT_TYPE;
	}

	/**
	 * @param cLIENT_TYPE the cLIENT_TYPE to set
	 */
	public void setCLIENT_TYPE(String cLIENT_TYPE) {
		CLIENT_TYPE = cLIENT_TYPE;
	}

	/**
	 * @return the cREDIT
	 */
	public String getCREDIT() {
		return CREDIT;
	}

	/**
	 * @param cREDIT the cREDIT to set
	 */
	public void setCREDIT(String cREDIT) {
		CREDIT = cREDIT;
	}

	/**
	 * @return the cOUNTRY
	 */
	public String getCOUNTRY() {
		return COUNTRY;
	}

	/**
	 * @param cOUNTRY the cOUNTRY to set
	 */
	public void setCOUNTRY(String cOUNTRY) {
		COUNTRY = cOUNTRY;
	}

	/**
	 * @return the sEQ
	 */
	public String getSEQ() {
		return SEQ;
	}

	/**
	 * @param sEQ the sEQ to set
	 */
	public void setSEQ(String sEQ) {
		SEQ = sEQ;
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
	 * @return the cOMPANY
	 */
	public String getCOMPANY() {
		return COMPANY;
	}

	/**
	 * @param cOMPANY the cOMPANY to set
	 */
	public void setCOMPANY(String cOMPANY) {
		COMPANY = cOMPANY;
	}

	/**
	 * @return the oFFICE
	 */
	public String getOFFICE() {
		return OFFICE;
	}

	/**
	 * @param oFFICE the oFFICE to set
	 */
	public void setOFFICE(String oFFICE) {
		OFFICE = oFFICE;
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
	 * @return the zIP
	 */
	public String getZIP() {
		return ZIP;
	}

	/**
	 * @param zIP the zIP to set
	 */
	public void setZIP(String zIP) {
		ZIP = zIP;
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
	 * @return the mAIL
	 */
	public String getMAIL() {
		return MAIL;
	}

	/**
	 * @param mAIL the mAIL to set
	 */
	public void setMAIL(String mAIL) {
		MAIL = mAIL;
	}

	/**
	 * @return the cOMMENT
	 */
	public String getCOMMENT() {
		return COMMENT;
	}

	/**
	 * @param cOMMENT the cOMMENT to set
	 */
	public void setCOMMENT(String cOMMENT) {
		COMMENT = cOMMENT;
	}

	/**
	 * @return the dATA_FLG
	 */
	public String getDATA_FLG() {
		return DATA_FLG;
	}

	/**
	 * @param dATA_FLG the dATA_FLG to set
	 */
	public void setDATA_FLG(String dATA_FLG) {
		DATA_FLG = dATA_FLG;
	}
    
}
