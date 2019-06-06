package com.test.service;

import com.test.domain.LayuiTableModel;

public interface IModelService {

	LayuiTableModel getDeviceTableDataByUserid(int userid, int page, int limit);

}
