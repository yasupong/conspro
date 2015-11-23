package conspro.svlt;

import conspro.storage.InventoryRecord;

/**
 * 締め在庫データEXCEL作成
 * @author yasupong
 */
@SuppressWarnings("serial")
public class LoadExcelForClosedInvSvlt extends LoadExcelInvCommonAllSvlt {
	@Override
	public String getFileName() {
		return "ClosedInvList";
	}

	@Override
	public String getQuery() {
		// 締め在庫のみを検索
		return "select from " + InventoryRecord.class.getName() + " where DATA_FLG == '1' order by SELL_MONTH desc, SELL_PAY_DATE";
	}

	@Override
	public String getSheetName() {
		return "締め在庫一覧";
	}
}
