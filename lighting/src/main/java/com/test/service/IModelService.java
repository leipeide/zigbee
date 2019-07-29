package com.test.service;

import com.test.domain.LayuiTableModel;

public interface IModelService {

	LayuiTableModel getDeviceTableDataByUserid(int userid, int page, int limit);

	LayuiTableModel getZigbeeTableDataByDeviceMac(String devMac, int page, int limit);

	LayuiTableModel getGroupTableDataByUserid(int userid, int page, int limit);

	LayuiTableModel getGroupDetailTableDataByUserid(int groupid, int page, int limit);

	LayuiTableModel getPloyTableDataByUserid(int userid, int page, int limit);

	LayuiTableModel getPloyOperateTableDataByPloyid(int id, int page, int limit);

}
