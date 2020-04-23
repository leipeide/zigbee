package com.test.dao;

import com.test.domain.DeviceConnectRecord;

public interface DeviceConnectRecordMapper {
	/**
	 * 新增集控器与服务器链接/断开连接记录
	 * @param devConnectRecord
	 */
	void insert(DeviceConnectRecord devConnectRecord);
	/**
	 * 根据集控器mac查找集控器与服务器连接的最后一条记录
	 * @param deviceMac
	 * @return
	 */
	DeviceConnectRecord selectLastConnectRecordByDeviceMac(String deviceMac);
	
}
