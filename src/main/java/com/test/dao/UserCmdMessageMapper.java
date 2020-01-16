package com.test.dao;

import com.test.domain.UserCmdMessage;

public interface UserCmdMessageMapper {
	/**
	 * 插入用户指令
	 * @param record
	 * @return
	 */
	int insert(UserCmdMessage record);
	/**
	 * 查找数据库最后一条用户指令
	 * @return
	 */
	UserCmdMessage selectLastCmd();
}
