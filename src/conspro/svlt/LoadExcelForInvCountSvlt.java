package conspro.svlt;

import conspro.storage.InventoryRecord;

/**
 * 棚卸在庫データEXCEL作成
 * @author yasupong
 */
@SuppressWarnings("serial")
public class LoadExcelForInvCountSvlt extends LoadExcelForBusinessCommonSvlt {
	
	@Override
	public String getFileName() {
		return "StockCount";
	}

	@Override
	public String getQuery() {
		// 条件：仕入支払日が入力ありかつ売上入金日・売上月が空欄
		return "select from " + InventoryRecord.class.getName() + " where ORDER_PAY_DATE != '' && SELL_MONTH == '' && SELL_PAY_DATE == '' && DATA_FLG == '0' order by ORDER_PAY_DATE, TYPE";
	}

	@Override
	public String getSheetName() {
		return "棚卸在庫一覧";
	}
}
