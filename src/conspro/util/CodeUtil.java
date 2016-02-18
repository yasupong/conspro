package conspro.util;

/**
 * CONSPROコード値部品
 * @author yasupong
 */
public class CodeUtil {

	/**
	 * 英語の型名を返す
	 * @param type
	 * @return
	 */
	public static String getTypeEng(String type) {
		if ("01".equals(type)) {
			return "Mini Excavator";
		} else if ("02".equals(type)) {
			return "Excavator";
		} else if ("03".equals(type)) {
			return "Crawler Dozer";
		} else if ("04".equals(type)) {
			return "Crawler Loader";
		} else if ("05".equals(type)) {
			return "Wheel Loader";
		} else if ("06".equals(type)) {
			return "Road Equipment";
		} else if ("07".equals(type)) {
			return "Crane";
		} else if ("08".equals(type)) {
			return "Crawler Carrier";
		} else if ("09".equals(type)) {
			return "Attachment";
		} else if ("10".equals(type)) {
			return "Parts";
		} else if ("11".equals(type)) {
			return "Generator";
		} else if ("12".equals(type)) {
			return "Air Compressor";
		} else if ("13".equals(type)) {
			return "Welder";
		} else if ("14".equals(type)) {
			return "Truck";
		} else if ("99".equals(type)) {
			return "Other";
		} else {
			return "";
		}
	}
	
	/**
	 * 日本語の型名を返す
	 * @param type
	 * @return
	 */
	public static String getTypeJa(String type) {
		if ("01".equals(type)) {
			return "油圧ショベル 8t未満";
		} else if ("02".equals(type)) {
			return "油圧ショベル 10t以上";
		} else if ("03".equals(type)) {
			return "ブルドーザー";
		} else if ("04".equals(type)) {
			return "ショベルローダー";
		} else if ("05".equals(type)) {
			return "タイヤショベル";
		} else if ("06".equals(type)) {
			return "舗装機械";
		} else if ("07".equals(type)) {
			return "クレーン";
		} else if ("08".equals(type)) {
			return "キャリアダンプ";
		} else if ("09".equals(type)) {
			return "アタッチメント";
		} else if ("10".equals(type)) {
			return "部品";
		} else if ("11".equals(type)) {
			return "発電機";
		} else if ("12".equals(type)) {
			return "エアーコンプレッサー";
		} else if ("13".equals(type)) {
			return "溶接機";
		} else if ("14".equals(type)) {
			return "トラック";
		} else if ("99".equals(type)) {
			return "その他";
		} else {
			return "";
		}
	}
	
	/**
	 * 権限名を返す
	 * @param type
	 * @return
	 */
	public static String getAuthName(String aCode) {
		if ("1".equals(aCode)) {
			return "1:一般";
		} else if ("2".equals(aCode)) {
			return "2:経理";
		} else if ("3".equals(aCode)) {
			return "3:管理";
		} else if ("4".equals(aCode)) {
			return "4:事務";
		} else {
			return "";
		}
	}
	
	/**
	 * 表示／非表示を返す
	 * @param flg
	 * @return
	 */
	public static String getIsDisp(String flg) {
		if ("0".equals(flg)) {
			return "無";
		} else if ("1".equals(flg)) {
			return "有";
		} else {
			return "";
		}
	}
	
	/**
	 * 写真URL代替文字表示英語
	 * @param url
	 * @return
	 */
	public static String isExistURLEn(String url) {
		if (url != null && url.length() > 0) {
			return "SHOW PHOTOS";
		}
		return "";
	}
	
	/**
	 * 写真URL代替文字表示日本語
	 * @param url
	 * @return
	 */
	public static String isExistURLJa(String url) {
		if (url != null && url.length() > 0) {
			return "写真参照";
		}
		return "";
	}
	
	/**
	 * 査定種類を返す
	 * @param type
	 * @return
	 */
	public static String getSateiType(String type) {
		if ("1".equals(type)) {
			return "相場確認";
		} else if ("2".equals(type)) {
			return "売却希望";
		} else if ("3".equals(type)) {
			return "在庫仮登録";
		} else {
			return "";
		}
	}
	
	/**
	 * 業種を返す
	 * @param type
	 * @return
	 */
	public static String getClientType(String type) {
		if ("1".equals(type)) {
			return "貿易";
		} else if ("2".equals(type)) {
			return "オークション";
		} else if ("3".equals(type)) {
			return "個人ブローカー";
		} else if ("4".equals(type)) {
			return "新車ディーラー";
		} else if ("5".equals(type)) {
			return "中古車ディーラー";
		} else if ("6".equals(type)) {
			return "レンタル";
		} else if ("7".equals(type)) {
			return "修理";
		} else if ("8".equals(type)) {
			return "エンドユーザー";
		} else if ("9".equals(type)) {
			return "その他";
		} else {
			return "";
		}
	}
	
	/**
	 * 与信管理を返す
	 * @param type
	 * @return
	 */
	public static String getCredit(String credit) {
		if ("A".equals(credit)) {
			return "入金前引渡OK";
		} else if ("B".equals(credit)) {
			return "入金後引渡";
		} else if ("C".equals(credit)) {
			return "問題あり";
		} else {
			return "";
		}
	}
}
