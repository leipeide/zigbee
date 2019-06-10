package com.test.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.test.domain.GroupPair;

public interface GroupPairMapper {
    int deleteByPrimaryKey(Integer id);
    
    int deleteByGroupid(Integer groupid);

    int insert(GroupPair record);

    int insertSelective(GroupPair record);

    GroupPair selectByPrimaryKey(Integer id);
    
    ArrayList<GroupPair> selectByUserid(Integer userid);
    
    ArrayList<GroupPair> selectByZigbeeMac(String ZigbeeMac);

    int updateByPrimaryKeySelective(GroupPair record);

    int updateByPrimaryKey(GroupPair record);

	int selectGroupPairNumberByGroupid(@Param("groupid")int groupid);

	ArrayList<GroupPair> selectByGroupidPaged(@Param("groupid")int groupid, @Param("index")int index, @Param("limit")int limit);
}