package com.test.dao;

import java.util.Date;

import com.test.domain.ZigbeeStatusRecord;

public interface ZigbeeStatusRecordMapper {
	/**
	 * 插入节点状态更新记录
	 */
	int insert(ZigbeeStatusRecord record);
	/**
	 * 查询节点状态记录的最后一条指令
	 */
	ZigbeeStatusRecord selectLastRecored();
	/**
	 *更新节点最新状态记录（update类型）的时间
	 * @param newTime 
	 * @param zbStatusRecord 
	 */
	void updateLastRecordTime(ZigbeeStatusRecord lastRecord);
	/**
	 * 根据集控器地址查询该集控器记录的最后一条节点状态记录
	 * @param devMac
	 * @return
	 */
	ZigbeeStatusRecord selectLastZigbeeStatusRecordByDeviceMac(String devMac);
	/**
	 * 根据节点地址查询该节点的最后一条节点状态记录
	 * @param zigbeeMac
	 * @return
	 */
	ZigbeeStatusRecord selectLastZigbeeStatusRecordByZigbeeMac(String zigbeeMac);

}
