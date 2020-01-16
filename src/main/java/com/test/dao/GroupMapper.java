package com.test.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.test.domain.Group;

public interface GroupMapper {
    int deleteByPrimaryKey(Integer groupid);

    int insert(Group record);

    int insertSelective(Group record);

    Group selectByPrimaryKey(Integer groupid);
    
    ArrayList<Group> selectByUserid(Integer userid);

    int updateByPrimaryKeySelective(Group record);

    int updateByPrimaryKey(Group record);

	int selectGroupNumberOfUser(@Param("userid")int userid);

	ArrayList<Group> selectByUseridPaged(@Param("userid")int userid, @Param("index")int index, @Param("limit")int limit);

}