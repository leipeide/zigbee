package com.test.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.test.domain.PloyOperate;

public interface PloyOperateMapper {
    int deleteByPrimaryKey(Integer id);
    
    int deleteByPloyid(Integer ployid);

    int insert(PloyOperate record);

    int insertSelective(PloyOperate record);

    PloyOperate selectByPrimaryKey(Integer id);
    
    ArrayList<PloyOperate> selectByPloyid(Integer ployid);

    int updateByPrimaryKeySelective(PloyOperate record);

    int updateByPrimaryKey(PloyOperate record);

	int selectPloyOperateNumberByPloyid(@Param("id")int id);

	ArrayList<PloyOperate> selectByPloyidPaged(@Param("id")int id, @Param("index")int index, @Param("limit")int limit);
}