package com.test.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.domain.Alarm;
import com.test.domain.Device;
import com.test.domain.Ploy;
import com.test.domain.PloyOperate;

public interface AlarmMapper {
	/**
	 * 查询超时报警类型的报警记录
	 * @param devMac
	 * @param alarmDisconnect
	 * @return
	 */
	List<Alarm> selectByDeviceMacAndType(@Param("devMac")String devMac, @Param("type")int type);
	/**
	 * 插入报警记录
	 * @param alarm
	 */
	void insert(Alarm alarm);
	/**
	 * 根据id删除报警记录
	 * @param id
	 */
	int deleteById(int id);
	/**
	 * 按照页码查询报警记录
	 * @param userid
	 * @param index
	 * @param limit
	 * @return
	 */
	ArrayList<Alarm> selectByUseridPaged(@Param("userid")int userid, @Param("index")int index,
			@Param("limit")int limit);
	/**
	 * 查询用户报警数量
	 * @param userid
	 * @return
	 */
	int selectAlarmNumberByUserid(@Param("userid") int userid);
	/**
	 * 查询报警记录
	 * @param id
	 * @return
	 */
	ArrayList<Alarm> selectByUserid(int userid);
	/**
	 * 按照集控器查找报警信息数量
	 * @param userid
	 * @param deviceMac
	 * @return
	 */
	Integer selectAlarmNumberByUseridAndDev(@Param("userid")int userid, @Param("devMac")String devMac);
	/**
	 * 按照集控器查找对应页面的报警信息
	 * @param deviceMac
	 * @param userid
	 * @param i
	 * @param limit
	 * @return
	 */
	ArrayList<Alarm> selectByUseridDevMacPaged(@Param("devMac")String devMac, @Param("userid")int userid, @Param("index")int index,
			@Param("limit")int limit);
}
