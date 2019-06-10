package com.test.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.test.domain.Zigbee;

public interface ZigbeeMapper {
    int deleteByPrimaryKey(String zigbeeMac);

    int insert(Zigbee record);

    int insertSelective(Zigbee record);

    Zigbee selectByPrimaryKey(String zigbeeMac);
    
    Zigbee selectBySAddrAndDevMac(String sAddr, String devMac);
    
    ArrayList<Zigbee> selectBydevMac(String devMac);

    int updateByPrimaryKeySelective(Zigbee record);

    int updateByPrimaryKey(Zigbee record);
    
    int updateBydevMacSelectiveWhereOnline(Zigbee record);
    
    int selectZigbeeNumberByDeviceMac(@Param("devMac")String devMac);
    
	int selectZigbeeNumberByDeviceMacAndOnlineStatus(@Param("devMac") String devMac,
			@Param("zigbeeNet")Integer zigbeeNet);

	ArrayList<Zigbee> selectByDevMacPaged(@Param("devMac")String devMac, @Param("index")int index, @Param("limit")int limit);
    
}