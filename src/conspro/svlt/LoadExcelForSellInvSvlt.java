package conspro.svlt;

import conspro.storage.InventoryRecord;

/**
 * 販売用在庫データEXCEL作成
 * @author yasupong
 */
@SuppressWarnings("serial")
public class LoadExcelForSellInvSvlt extends LoadExcelForBusinessCommonSvlt {
	
	@Override
	public String getFileName() {
		return "InvListForSell";
	}

	@Override
	public String getQuery() {
		// 条件：販売先が空欄
		return "select from " + InventoryRecord.class.getName() + " where BUYER == '' && DATA_FLG == '0' order by TYPE";
	}

	@Override
	public String getSheetName() {
		return "販売用在庫一覧";
	}
}
