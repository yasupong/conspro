package conspro.util;

import java.text.DecimalFormat;
import java.util.Set;

/**
 * CONSPRO共通Util
 * @author yasupong
 */
public class CommonUtil {
	
	/** 金額編集 */
	private static DecimalFormat formatter = new DecimalFormat("#,###");
	
	/**
	 * NULL置換
	 * @param str
	 * @return
	 */
	public static String nullConv(String str) {
		if (str==null) return "";
		return str;
	}
	
	/**
	 * 金額編集
	 * @param amount
	 * @return
	 */
	public static String moneyFormat(String amount) {
		if (amount == null || amount.length() == 0) {
			return "";
		}
		
		Long value = null;
		try {
			value = Long.parseLong(amount);
		}
		catch (Throwable th) {
			return amount;
		}
		return moneyFormat(value);
	}
	
	/**
	 * 金額編集
	 * @param value
	 * @return
	 */
	public static String moneyFormat(Long value) {
		return formatter.format(value);
	}
	
	/**
	 * 金額がNULLか0かチェックし代替文字を返却する
	 * @param num
	 * @return
	 */
	public static String checkEmptyOrZero(String num) {
		
		if (num == null || num.length() == 0 || "0".equals(num)) {
			return "ASK";
		}
		else if ("9,999".equals(num)) {
			return "SOLD";
		}
		
		return num;
	}
	
	/**
	 * コンボの中身を構築します
	 * @param optionSet
	 * @return
	 */
	public static String buildOptions(Set<String> optionSet) {
		if (optionSet == null || optionSet.size() == 0) {
			return "";
		}
		
		StringBuffer retBuf = new StringBuffer();
		
		for (String value : optionSet) {
			retBuf.append("<option value=\"" + value + "\">" + value + "</option>\n");
		}
		
		return retBuf.toString();
	}
	
	/**
	 * 数値変換する
	 * @param num
	 * @return
	 */
	public static long getLong(String num) {
		if (num == null || num.length() == 0) {
			return 0;
		}
		
		try
		{
			return Long.parseLong(num);
		}
		catch (NumberFormatException nfe){
			return 0;
		}
	}
}
