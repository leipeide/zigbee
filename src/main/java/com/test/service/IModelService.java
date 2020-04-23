package com.test.service;

import com.test.domain.LayuiTableModel;

public interface IModelService {

	LayuiTableModel getDeviceTableDataByUserid(int userid, int page, int limit);

	LayuiTableModel getZigbeeTableDataByDeviceMac(String devMac, int page, int limit);

	LayuiTableModel getGroupTableDataByUserid(int userid, int page, int limit);

	LayuiTableModel getGroupDetailTableDataByUserid(int groupid, int page, int limit);

	LayuiTableModel getPloyTableDataByUserid(int userid, int page, int limit);

	LayuiTableModel getPloyOperateTableDataByPloyid(int id, int page, int limit);
	/**
	 * 根据用户id获取该用户所有的报警信息
	 * @param userid
	 * @param page
	 * @param limit
	 * @return
	 */
	LayuiTableModel getAlarmMessageTableDataByUserid(int userid, int page, int limit);
	/**
	 * 
	 * @param userid
	 * @param deviceMac
	 * @param page
	 * @param limit
	 * @return
	 */
	LayuiTableModel getAlarmMessageTableDataByUseridAndDevmac(int userid, String deviceMac, int page,
			int limit);

}
