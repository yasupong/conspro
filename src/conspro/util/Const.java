package conspro.util;

import java.util.Set;
import java.util.TreeSet;

/**
 * CONSPRO定数クラス
 * @author yasupong
 */
public class Const {
	/** 環境名 */
	public final static String ENV_NAME = "";
	
	/** パスキー：査定受付 */
	public final static String PASS_KEY_SATEI = "a1b2c3";
	
	/** パスキー：Sign Up */
	public final static String PASS_KEY_SIGN_UP = "q9w8e7";
	
	/** 売上月 */
	public final static Set<String> SELL_MONTH_SET = new TreeSet<String>();
	static {
		SELL_MONTH_SET.add("2013/01");
		SELL_MONTH_SET.add("2013/02");
		SELL_MONTH_SET.add("2013/03");
		SELL_MONTH_SET.add("2013/04");
		SELL_MONTH_SET.add("2013/05");
		SELL_MONTH_SET.add("2013/06");
		SELL_MONTH_SET.add("2013/07");
		SELL_MONTH_SET.add("2013/08");
		SELL_MONTH_SET.add("2013/09");
		SELL_MONTH_SET.add("2013/10");
		SELL_MONTH_SET.add("2013/11");
		SELL_MONTH_SET.add("2013/12");
		SELL_MONTH_SET.add("2014/01");
		SELL_MONTH_SET.add("2014/02");
		SELL_MONTH_SET.add("2014/03");
		SELL_MONTH_SET.add("2014/04");
		SELL_MONTH_SET.add("2014/05");
		SELL_MONTH_SET.add("2014/06");
		SELL_MONTH_SET.add("2014/07");
		SELL_MONTH_SET.add("2014/08");
		SELL_MONTH_SET.add("2014/09");
		SELL_MONTH_SET.add("2014/10");
		SELL_MONTH_SET.add("2014/11");
		SELL_MONTH_SET.add("2014/12");
		SELL_MONTH_SET.add("2015/01");
		SELL_MONTH_SET.add("2015/02");
		SELL_MONTH_SET.add("2015/03");
		SELL_MONTH_SET.add("2015/04");
		SELL_MONTH_SET.add("2015/05");
		SELL_MONTH_SET.add("2015/06");
		SELL_MONTH_SET.add("2015/07");
		SELL_MONTH_SET.add("2015/08");
		SELL_MONTH_SET.add("2015/09");
		SELL_MONTH_SET.add("2015/10");
		SELL_MONTH_SET.add("2015/11");
		SELL_MONTH_SET.add("2015/12");
		SELL_MONTH_SET.add("2016/01");
		SELL_MONTH_SET.add("2016/02");
		SELL_MONTH_SET.add("2016/03");
		SELL_MONTH_SET.add("2016/04");
		SELL_MONTH_SET.add("2016/05");
		SELL_MONTH_SET.add("2016/06");
		SELL_MONTH_SET.add("2016/07");
		SELL_MONTH_SET.add("2016/08");
		SELL_MONTH_SET.add("2016/09");
		SELL_MONTH_SET.add("2016/10");
		SELL_MONTH_SET.add("2016/11");
		SELL_MONTH_SET.add("2016/12");
	}
	
	/** 権限：一般*/
	public final static String AUTH_NORMAL = "1";
	/** 権限：経理*/
	public final static String AUTH_ACCT = "2";
	/** 権限：管理*/
	public final static String AUTH_ADMIN = "3";
	/** 権限：事務*/
	public final static String AUTH_OFFICE = "4";
	
	/** コンボボックス：分類*/
	public final static String COMBO_TYPE = 
			"<option value=\"1\">1:Excavator (under 8 ton) - 油圧ショベル 8t未満</option>\n" + 
			"<option value=\"2\">2:Excavator (10 ton up) - 油圧ショベル 10t以上</option>\n" + 
			"<option value=\"3\">3:Crawler Dozer (Bulldozer) - ブルドーザー</option>\n" + 
			"<option value=\"4\">4:Crawler Loader (Dozer shovel) - ショベルローダー</option>\n" +
			"<option value=\"5\">5:Wheel Loader (Rubber Tired Loader) - タイヤショベル</option>\n" + 
			"<option value=\"6\">6:Road Equipment - 舗装機械</option>\n" + 
			"<option value=\"7\">7:Crane - クレーン</option>\n" + 
			"<option value=\"8\">8:Crawler Carrier - キャリアダンプ</option>\n" + 
			"<option value=\"9\">9:Attachment - アタッチメント</option>\n" + 
			"<option value=\"10\">10:Parts - 部品</option>\n" + 
			"<option value=\"11\">11:Generator - 発電機</option>\n" + 
			"<option value=\"12\">12:Air Compressor - エアーコンプレッサー</option>\n" + 
			"<option value=\"13\">13:Welder - 溶接機</option>\n" + 
			"<option value=\"14\">14:Truck - トラック</option>\n" + 
			"<option value=\"99\">99:Other - その他</option>\n";
	
	/** コンボボックス：メーカー*/
	public final static String COMBO_MANUFACTURER = 
			"<option value=\"AIRMAN\">AIRMAN</option>\n" +
			"<option value=\"BOMAG\">BOMAG</option>\n" +
			"<option value=\"CAT\">CAT</option>\n" +
			"<option value=\"DENYO\">DENYO</option>\n" +
			"<option value=\"DYNAPAC\">DYNAPAC</option>\n" +
			"<option value=\"FURUKAWA\">FURUKAWA</option>\n" +
			"<option value=\"HANTA\">HANTA</option>\n" +
			"<option value=\"HITACHI\">HITACHI</option>\n" +
			"<option value=\"IHI\">IHI</option>\n" +
			"<option value=\"KATO\">KATO</option>\n" +
			"<option value=\"KAWASAKI\">KAWASAKI</option>\n" +
			"<option value=\"KOBELCO\">KOBELCO</option>\n" +
			"<option value=\"KOMATSU\">KOMATSU</option>\n" +
			"<option value=\"KUBOTA\">KUBOTA</option>\n" +
			"<option value=\"MEIWA\">MEIWA</option>\n" +
			"<option value=\"MIKASA\">MIKASA</option>\n" +
			"<option value=\"MITSUBISHI\">MITSUBISHI</option>\n" +
			"<option value=\"MOROOKA\">MOROOKA</option>\n" +
			"<option value=\"NISSHA\">NISSHA</option>\n" +
			"<option value=\"OTHER\">OTHER</option>\n" +
			"<option value=\"SAKAI\">SAKAI</option>\n" +
			"<option value=\"SHINDAIWA\">SHINDAIWA</option>\n" +
			"<option value=\"SUMITOMO\">SUMITOMO</option>\n" +
			"<option value=\"TACOM\">TACOM</option>\n" +
			"<option value=\"TADANO\">TADANO</option>\n" +
			"<option value=\"TCM\">TCM</option>\n" +
			"<option value=\"YANMAR\">YANMAR</option>\n";

	/** コンボボックス：程度*/
	public final static String COMBO_CONDITION = 
			"<option value=\"5\">5：新車もしくは、新車に近い状態</option>\n" +
			"<option value=\"4\">4：高年式・メーターの少ない極上品</option>\n" +
			"<option value=\"3.5\">3.5：整備済み</option>\n" +
			"<option value=\"3\">3：現状で使用可能な状態</option>\n" +
			"<option value=\"2\">2：故障はしてないが、使用するには軽微な修理や整備が必要なもの</option>\n" +
			"<option value=\"1\">1：故障はしていないが、摩耗が激しく、使用するには相当の修理や整備が必要なもの</option>\n" +
			"<option value=\"B\">B：エンジンや油圧系統など重要部品が故障しているもの</option>\n";
	
	/** コンボボックス：WEB表示*/
	public final static String COMBO_WEB_DISP = 
			"<option value=\"0\">0:WEBに表示しない</option>\n" +
			"<option value=\"1\">1:WEBに表示する</option>\n";
	
	/** コンボボックス：権限*/
	public final static String COMBO_AUTH_CODE = 
			"<option value=\"1\">1：一般</option>\n" + 
			"<option value=\"2\">2：経理</option>\n" + 
			"<option value=\"3\">3：管理</option>\n" + 
			"<option value=\"4\">4：事務</option>\n";
}
