package conspro.storage;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class Signup
{
    @PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private String DATE;

    @Persistent
    private String NAME;

    @Persistent
    private String YOUARE;
    
    @Persistent
    private String COMPANY;
    
    @Persistent
    private String STREET;
    
    @Persistent
    private String CITY;
    
    @Persistent
    private String STATE;
    
    @Persistent
    private String COUNTRY;
    
    @Persistent
    private String ZIP;
    
    @Persistent
    private String TEL;
    
    @Persistent
    private String FAX;
    
    @Persistent
    private String MAIL;
    
    @Persistent
    private String RECEIVE;
    
    @Persistent
    private String COMMENT;

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
	 * @return the yOUARE
	 */
	public String getYOUARE() {
		return YOUARE;
	}

	/**
	 * @param yOUARE the yOUARE to set
	 */
	public void setYOUARE(String yOUARE) {
		YOUARE = yOUARE;
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
	 * @return the sTREET
	 */
	public String getSTREET() {
		return STREET;
	}

	/**
	 * @param sTREET the sTREET to set
	 */
	public void setSTREET(String sTREET) {
		STREET = sTREET;
	}

	/**
	 * @return the cITY
	 */
	public String getCITY() {
		return CITY;
	}

	/**
	 * @param cITY the cITY to set
	 */
	public void setCITY(String cITY) {
		CITY = cITY;
	}

	/**
	 * @return the sTATE
	 */
	public String getSTATE() {
		return STATE;
	}

	/**
	 * @param sTATE the sTATE to set
	 */
	public void setSTATE(String sTATE) {
		STATE = sTATE;
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
	 * @return the rECEIVE
	 */
	public String getRECEIVE() {
		return RECEIVE;
	}

	/**
	 * @param rECEIVE the rECEIVE to set
	 */
	public void setRECEIVE(String rECEIVE) {
		RECEIVE = rECEIVE;
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
}
