package conspro.svlt;

import conspro.storage.InventoryRecord;

/**
 * 在庫データEXCEL作成
 * @author yasupong
 */
@SuppressWarnings("serial")
public class LoadExcelInvSvlt extends LoadExcelInvCommonAllSvlt {

	@Override
	public String getFileName() {
		return "InvList";
	}

	@Override
	public String getQuery() {
		// 締められていない在庫をすべて取得
		return "select from " + InventoryRecord.class.getName() + " where DATA_FLG == '0' order by TYPE, DATE desc";
	}

	@Override
	public String getSheetName() {
		return "在庫一覧";
	}
}
