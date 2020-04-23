package com.test.dao;

import java.util.List;

import com.test.domain.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);
    
    User selectByUsername(String username);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    //通过邮箱查找用户
	User selectByEmail(String email);
	//将user表格内的所有用户的验证码操作次数参数清零
	int clearAllUserOperateNum(Integer operateNum); //Integer operateNum
}