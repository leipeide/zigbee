package com.test.dao;

import com.test.domain.ZigbeeStatusRecord;

public interface ZigbeeStatusRecordMapper {
	/*
	 * 插入节点状态更新记录
	 */
	int insert(ZigbeeStatusRecord record);
	/*
	 * 查询节点状态记录的最后一条指令
	 */
	ZigbeeStatusRecord selectLastRecored(); 
}
