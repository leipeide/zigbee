package com.test.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.test.domain.Device;

public interface DeviceMapper {
    int deleteByPrimaryKey(String devMac);

    int insert(Device record);

    int insertSelective(Device record);

    Device selectByPrimaryKey(String devMac);

    int selectDeviceNumberOfUser(int userid);
    
    ArrayList<Device> selectByUserid(Integer userid);

    int updateByPrimaryKeySelective(Device record);

    int updateByPrimaryKey(Device record);
    
    ArrayList<Device> selectByUseridPaged(@Param("userid")int userid, @Param("index")int index, @Param("limit")int limit);
    
}