package com.test.service.socket;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSONObject;
import com.test.dao.AlarmMapper;
import com.test.dao.DeviceAttrMapper;
import com.test.dao.DeviceConnectRecordMapper;
import com.test.dao.DeviceMapper;
import com.test.dao.GroupMapper;
import com.test.dao.GroupPairMapper;
import com.test.dao.PloyMapper;
import com.test.dao.PloyOperateMapper;
import com.test.dao.UserCmdMessageMapper;
import com.test.dao.UserMapper;
import com.test.dao.ZigbeeAttrMapper;
import com.test.dao.ZigbeeMapper;
import com.test.dao.ZigbeeStatusRecordMapper;
import com.test.domain.Alarm;
import com.test.domain.Device;
import com.test.domain.DeviceAttr;
import com.test.domain.DeviceConnectRecord;
import com.test.domain.Group;
import com.test.domain.GroupPair;
import com.test.domain.Ploy;
import com.test.domain.PloyOperate;
import com.test.domain.UserCmdMessage;
import com.test.domain.Zigbee;
import com.test.domain.ZigbeeAttr;
import com.test.domain.ZigbeeStatusRecord;
import com.test.service.IDeviceService;

@Component
public class SocketTool {
	private static Logger log = Logger.getLogger("D");
	
	static public ArrayList<DeviceSocket> socketList = new ArrayList<>();
	
	static public Boolean HeartBeatReport = true;
	
	@Autowired
	private UserMapper UserDao;
	@Autowired
	private IDeviceService devService;
	@Autowired
	private DeviceMapper devDao;
	@Autowired
	private ZigbeeMapper zigbeeDao;
	@Autowired
	private GroupMapper groupDao;
	@Autowired
	private GroupPairMapper groupPairDao;
	@Autowired
	private PloyMapper ployDao;
	@Autowired
	private PloyOperateMapper ployOperateDao;
	@Autowired
	private ZigbeeAttrMapper zigbeeAttrDao;
	@Autowired
	private DeviceAttrMapper devAttrDao;
	@Autowired
	private UserCmdMessageMapper userCmdMessageDao;
	@Autowired
	private ZigbeeStatusRecordMapper ZigbeeStatusRecordDao;
	@Autowired
	private DeviceConnectRecordMapper DeviceConnectRecordDao;
	@Autowired
	private AlarmMapper AlarmDao;
	
	private Object UserCmdMessageDao;
	
	public static SocketTool testUtils;

	@PostConstruct
	public void init() {
		testUtils = this;
	}

	public static void test(Device record) {
		//System.out.println(testUtils.devDao);
	}
	
	public static boolean updateDeviceData(Device dev) {
		return testUtils.devService.updateDeviceData(dev);
	}
	
	public static ArrayList<Zigbee> selectZigbeeByDevMac(String devMac) {
		return testUtils.zigbeeDao.selectBydevMac(devMac);
	}
	
	public static int updateZigbeeByPrimaryKeySelective(Zigbee record) {
		
		record = testUtils.zigbeeBrightnessTransform(record);
		
		return testUtils.zigbeeDao.updateByPrimaryKeySelective(record);
	}
	
	public static int updateZigbeeBydevMacSelectiveWhereOnline(Zigbee record) {
		
//		record = testUtils.zigbeeBrightnessTransform(record);
		ArrayList<Zigbee> list = testUtils.zigbeeDao.selectBydevMac(record.getDevMac());
		if (list != null) {
			int count = 0;
			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).getZigbeeNet() == 0) {//离线
					list.remove(i);//离线节点删除不做处理
				}
			}
			if (record.getZigbeeStatus() != null) {//非空，即设置状态
				for (Zigbee zb : list) {
					zb.setZigbeeStatus(record.getZigbeeStatus());
				}
			}
			if (record.getZigbeeBright() != null) {//非空，即设置亮度
				for (Zigbee zb : list) {
					zb.setZigbeeBright(record.getZigbeeBright());
					zb = testUtils.zigbeeBrightnessTransform(zb);
				}
			}
			for (Zigbee zb : list) {
				if (testUtils.zigbeeDao.updateByPrimaryKeySelective(zb) >= 0) {
					count++;
				}
			}
			return count;
		} else {
			return 0;
		}
		
//		return testUtils.zigbeeDao.updateBydevMacSelectiveWhereOnline(record);
	}
	
	public static Zigbee selectZigbeeBySAddrAndDevMac(String sAddr, String devMac) {
		return testUtils.zigbeeDao.selectBySAddrAndDevMac(sAddr, devMac);
	}
	
	public static Device selectDeviceByPrimaryKey(String devMac) {
		return testUtils.devDao.selectByPrimaryKey(devMac);
	}
	
	public static Zigbee selectZigbeeByPrimaryKey(String zigbeeMac) {
		return testUtils.zigbeeDao.selectByPrimaryKey(zigbeeMac);
	}
	
	public static ArrayList<Zigbee> selectzigbeeByGroup (Group group) {
		
		ArrayList<GroupPair> pairlist = testUtils.groupPairDao.selectByUserid(group.getUserid());
		
		ArrayList<Zigbee> zblist = new ArrayList<>();
		
		Zigbee zb;
		if (pairlist != null) {
			for (GroupPair pair : pairlist) {
				if (pair.getGroupid().equals(group.getGroupid())) {
					zb = testUtils.zigbeeDao.selectByPrimaryKey(pair.getZigbeeMac());
					if (zb != null) {
						zblist.add(zb);
					}
				}
			}
		}
		return zblist;
	}
	
	public static int insertZigbee(Zigbee zb) {
		return testUtils.zigbeeDao.insert(zb);
	}
	
	public static ArrayList<Group> selectGroupByUserid(Integer userid) {
		return testUtils.groupDao.selectByUserid(userid);
	}
	
	public static int insertGroupPair(GroupPair gp) {
		return testUtils.groupPairDao.insertSelective(gp);
	}
	
	public static GroupPair selectGroupPairByUseridAndGroupidAndZigbeeMac(int userid, int groupid, String zigbeeMac) {
		ArrayList<GroupPair> list = testUtils.groupPairDao.selectByUserid(userid);
		for (GroupPair pair : list) {
			if (pair.getGroupid() == groupid && pair.getZigbeeMac().equals(zigbeeMac)) {
				return pair;
			}
		}
		return null;
	}
	
	public static int removeGroupPairByid(int id) {
		return testUtils.groupPairDao.deleteByPrimaryKey(id);
	}
	
	public static ArrayList<Ploy> selectPloyByStatus(int status) {
		return testUtils.ployDao.selectByStatus(status);
	}
	
	public static ArrayList<PloyOperate> selectPloyOperateByPloyid(int ployid) {
		return testUtils.ployOperateDao.selectByPloyid(ployid);
	}
	
	public static ZigbeeAttr selectZigbeeAttrByPrimaryKey(String zigbeeMac) {
		return testUtils.zigbeeAttrDao.selectByPrimaryKey(zigbeeMac);
	}
	
	public static int updateZigbeeAttrByPrimaryKeySelective(ZigbeeAttr record) {
		return testUtils.zigbeeAttrDao.updateByPrimaryKeySelective(record);
	}
	
	public static int insertZigbeeAttrSelective(ZigbeeAttr record) {
		return testUtils.zigbeeAttrDao.insertSelective(record);
	}
	
	public static DeviceAttr selectDeviceAttrByDevMac(String devMac) {
		return testUtils.devAttrDao.selectByPrimaryKey(devMac);
	}
	
	public static int updateDeviceAttrByPrimaryKeySelective(DeviceAttr record) {
		return testUtils.devAttrDao.updateByPrimaryKeySelective(record);
	}
	
	//在此处进行亮度转换
	private Zigbee zigbeeBrightnessTransform(Zigbee record) {
		//读取数据库判断节点类型
		ZigbeeAttr zba = testUtils.zigbeeAttrDao.selectByPrimaryKey(record.getZigbeeMac());
		if (zba != null && zba.getType() != null) {
			if (zba.getType() == 1 || zba.getType() == 2 || zba.getType() == 17 || zba.getType() == 18) {//读取节点设备类型
				if (record.getZigbeeBright() < 50) {//如果是金卤灯，钠灯，调为50
					record.setZigbeeBright(50);
				}
				//如果收到的回复是50-100不做处理
			}//如果是led灯，跳过判断，直接进行数据库读写操作
		}
		return record;
	}

	/**
	 * 更新group数据库内switchStatus的最新状态
	 * @param grouptemp
	 * @return
	 */
	public static int updateGroupByPrimaryKeySelective(Group grouptemp) {
		// TODO Auto-generated method stub
		return testUtils.groupDao.updateByPrimaryKeySelective(grouptemp);
	}
	
	/**
	 * 将服务器发送的指令写入数据库
	 * @param deviceSocket
	 * @param cmdString
	 * @return
	 */
	public static int writeUserCmdMessageRecord(DeviceSocket deviceSocket, String cmdString, UserCmdMessage userCmdMessage) {
		Date nowTime = new Date();
		userCmdMessage.setCmdData(cmdString);
		userCmdMessage.setDate(nowTime);
		userCmdMessage.setDevMac(deviceSocket.getDevice().getDevMac());
		userCmdMessage.setUserid(deviceSocket.getDevice().getUserid()); 
		return testUtils.userCmdMessageDao.insert(userCmdMessage); //插入用户指令
	}
	/**
	 * 将策略定时指令写入数据库
	 * @param userCmdMessage
	 */
	public static void InsertPloyTimingCmdToUserCmdMessage(UserCmdMessage userCmdMessage) {
		UserCmdMessage cmdObj = testUtils.userCmdMessageDao.selectLastCmd();
		Date nowDate = new Date();
		if(cmdObj != null) { //获取到了最后一条指令且不为空
			//最后一条指令数据与userCmdMessage对象数据一样（指令内容相同）
			if((cmdObj.getCmdData().equals(userCmdMessage.getCmdData())) && 
					(cmdObj.getCmdType() == userCmdMessage.getCmdType()) &&
					(cmdObj.getDevMac().equals(userCmdMessage.getDevMac())) &&
					(cmdObj.getUserid() == userCmdMessage.getUserid()) &&
					(cmdObj.getDate().getTime() - nowDate.getTime() < 1000*3)) { //<3000毫秒为避免客户在同一时间设置了两条定时指令
				
			}else {//不存在相同指令，插入用户指令
				 testUtils.userCmdMessageDao.insert(userCmdMessage); 
			}
		}else { //未获取到最后一条指令或指令为空则插入指令
			 testUtils.userCmdMessageDao.insert(userCmdMessage); 
		}
		
	}
	//将节点更新的状态写入数据库
	public static int insertZigbeeStatusRecord(ZigbeeStatusRecord zbStatusRecord) {
		return testUtils.ZigbeeStatusRecordDao.insert(zbStatusRecord); //插入节点的状态
		
	}
	
	/**
	 * 将回复广播调光、开关指令引起的变化写入数据库
	 */
	public static void insertZigbeeStatusRecordWhereOnline(Zigbee zigbee) {
		//1.得到所有集控器下的节点列表zbList
		ArrayList<Zigbee> zbList = testUtils.zigbeeDao.selectBydevMac(zigbee.getDevMac());
		if (zbList != null) {
			//2.从节点列表内移除离线节点，得到在线的节点列表zbList
			for (int i = 0; i < zbList.size(); i++) {
				if (zbList.get(i).getZigbeeNet() == 0) {//离线
					zbList.remove(i);//离线节点删除不做处理
				}
			}
			//3.遍历所有集控器下所有在线节点，得到ZigbeeStatusRecord对象，插入到数据库
			for (Zigbee zbObj : zbList) {
				//4.根据节点mac地址得到节点属性对象
				ZigbeeAttr zigbeeAttr =  testUtils.zigbeeAttrDao.selectByPrimaryKey(zbObj.getZigbeeMac());
				//5.得到ZigbeeStatusRecord对象
				ZigbeeStatusRecord zbStatusRecord = new ZigbeeStatusRecord();
				Date nowTime = new Date();
				zbStatusRecord.setDate(nowTime);
				zbStatusRecord.setDevMac(zbObj.getDevMac());
				zbStatusRecord.setZigbeeMac(zbObj.getZigbeeMac());
				zbStatusRecord.setRecordType(zbStatusRecord.RECORD_TYPE_CMD); //记录类型指令导致的节点状态的变化
				if (zigbee.getZigbeeStatus() != null) {//非空，即设置状态
					zbStatusRecord.setZigbeeStatus(zigbee.getZigbeeStatus());
				}else { //为空则从节点数据库读取
					zbStatusRecord.setZigbeeStatus(zbObj.getZigbeeStatus());
				}
				if (zigbee.getZigbeeBright() != null) {//非空，即设置状态
					zbStatusRecord.setZigbeeBright(zigbee.getZigbeeBright());
				}else { //为空则从节点数据库读取
					zbStatusRecord.setZigbeeBright(zbObj.getZigbeeBright());
				}
				if(zigbeeAttr != null) { 
					zbStatusRecord.setPower(zigbeeAttr.getPower());
					zbStatusRecord.setTemperature(zigbeeAttr.getTemperature());
					zbStatusRecord.setHumidity(zigbeeAttr.getHumidity());
					zbStatusRecord.setZigbeeType(zigbeeAttr.getType());
					if(zigbeeAttr.getType() != null) { //根据节点类型进行亮度转换
						if (zigbeeAttr.getType() == 1 || zigbeeAttr.getType() == 2 || zigbeeAttr.getType() == 17 || zigbeeAttr.getType() == 18) {//读取节点设备类型
							if (zigbee.getZigbeeBright() < 50) {//如果是金卤灯，钠灯，调为50
								zbStatusRecord.setZigbeeBright(50);
								}//如果收到的回复是50-100不做处理,直接等于节点的亮度
							}//如果是led灯，跳过判断，直接进行数据库读写操作
						}
					}
				//6.记录状态改变，写入数据库
				testUtils.ZigbeeStatusRecordDao.insert(zbStatusRecord);
			}
			
		}else { //集控器下无节点
			
		}
		
	}
	
	/**
	 * 将回复单节点（或分组控制）调光、开关指令引起的变化写入数据库
	 */
	public static void insertZigbeeStatusRecordSingleNode(Zigbee zigbee) {
		//1.根据节点mac地址得到节点属性对象、节点对象
		ZigbeeAttr zigbeeAttr =  testUtils.zigbeeAttrDao.selectByPrimaryKey(zigbee.getZigbeeMac());
		Zigbee zigbeeObj = testUtils.zigbeeDao.selectByPrimaryKey(zigbee.getZigbeeMac());
	    //2.得到ZigbeeStatusRecord对象
		ZigbeeStatusRecord zbStatusRecord = new ZigbeeStatusRecord();
		Date nowTime = new Date();
		zbStatusRecord.setDate(nowTime);
		zbStatusRecord.setDevMac(zigbee.getDevMac());
		zbStatusRecord.setZigbeeMac(zigbee.getZigbeeMac());
		zbStatusRecord.setRecordType(zbStatusRecord.RECORD_TYPE_CMD); //记录类型指令导致的节点状态的变化
		if (zigbee.getZigbeeStatus() != null) {//非空，即设置状态
			zbStatusRecord.setZigbeeStatus(zigbee.getZigbeeStatus());
		}else { //为空则从节点数据库读取
			zbStatusRecord.setZigbeeStatus(zigbeeObj.getZigbeeStatus());
		}
		if (zigbee.getZigbeeBright() != null) {//非空，即设置状态
			zbStatusRecord.setZigbeeBright(zigbee.getZigbeeBright());
		}else { //为空则从节点数据库读取
			zbStatusRecord.setZigbeeBright(zigbeeObj.getZigbeeBright());
		}
		if(zigbeeAttr != null) { 
			zbStatusRecord.setPower(zigbeeAttr.getPower());
			zbStatusRecord.setTemperature(zigbeeAttr.getTemperature());
			zbStatusRecord.setHumidity(zigbeeAttr.getHumidity());
			zbStatusRecord.setZigbeeType(zigbeeAttr.getType());
			//设置节点状态的亮度，若节点是金卤灯，则亮度小于50时，设置为50；其他状态或类型时则为指令返回的亮度
			if(zigbeeAttr.getType() != null) { //非空，即设置亮度
				if (zigbeeAttr.getType() == 1 || zigbeeAttr.getType() == 2 || zigbeeAttr.getType() == 17 || zigbeeAttr.getType() == 18) {//读取节点设备类型
					if (zigbee.getZigbeeBright() < 50) {//如果是金卤灯，钠灯，调为50
						 zbStatusRecord.setZigbeeBright(50);
	 				}//如果收到的回复是50-100不做处理,直接等于节点的亮度
				}//如果是led灯，跳过判断，直接进行数据库读写操作
			}
		}
	    //3.记录状态改变，写入数据库
		testUtils.ZigbeeStatusRecordDao.insert(zbStatusRecord);
	}
	
	/**
	 * 查询zigbeeStatusRecord记录的节点状态的最后一条指令
	 * 并与节点上报的信息进行对比，若一致，返回true，不插入节点状态记录的数据表中
	 * 若不一致,返回false,插入节点状态记录的数据表中
	 * @return
	 */
	public static Boolean selectZigbeeStatusRecordLastRecord(String strXML) {
		//获取集控器上报的节点对象最新信息
		Zigbee zigbee = SocketTool.selectZigbeeByPrimaryKey(strXML.substring(10, 26));
		// 获取集控器上报的节点对象最新属性信息
		ZigbeeAttr zigbeeAttr = SocketTool.selectZigbeeAttrByPrimaryKey(zigbee.getZigbeeMac());
		//获取该节点的最后一条节点状态记录
		//ZigbeeStatusRecord lastRecord = testUtils.ZigbeeStatusRecordDao.selectLastRecored();
		ZigbeeStatusRecord lastRecord = testUtils.ZigbeeStatusRecordDao.selectLastZigbeeStatusRecordByZigbeeMac(zigbee.getZigbeeMac());
		//System.out.println("最后一条节点状态记录："+ lastRecord.getId());
		if(lastRecord != null && zigbee != null && zigbeeAttr != null) { //节点状态最后一条记录存在且节点对象和节点属性对象存在
			if(lastRecord.getRecordType().equals(lastRecord.RECORD_TYPE_UPDATE)) { //记录类型是update
				//判断最后一条记录的内容石是否与集控器上报的节点类型一致
				if((lastRecord.getDevMac().equals(zigbee.getDevMac())) && 
						//lastRecord.getZigbeeMac().equals(zigbee.getZigbeeMac()) && 
						(lastRecord.getZigbeeBright() == zigbee.getZigbeeBright()) && 
						(lastRecord.getZigbeeStatus() == zigbee.getZigbeeStatus()) && 
						(lastRecord.getTemperature() == zigbeeAttr.getTemperature()) && 
						(lastRecord.getHumidity() == zigbeeAttr.getHumidity()) && 
						(lastRecord.getPower() == zigbeeAttr.getPower()) 
					){ 
					/**
					 * 节点上报的状态未发生改变，则不将节点的信息写入到节点状态记录数据表中 
					 * 此处可以更新一下记录的最新时间；
					 * 如果节点是true，则节点的状态未发生变化，只更新时间即可，可记录节点与服务器链接的最后时间
					 */
					Date nowTime = new Date();
					lastRecord.setDate(nowTime);
					testUtils.ZigbeeStatusRecordDao.updateLastRecordTime(lastRecord);
					return true;
				}else { //节点上报的状态发生了变化，则将节点的信息写入到节点状态记录的数据表中
					return false;
				}
			}
		}
		return false;
	}
	/**
	 * 集控器发送登陆指令时，集控器与服务器链接成功
	 * 记录集控器与服务器连接记录，插入数据库内
	 * @param device
	 */
	public static void insertDeviceConnectRecord(String devMac) {
		//当前时间参数
	    Date nowTime = new Date();
		//得到集控器对象
		Device device = testUtils.devDao.selectByPrimaryKey(devMac);
		//向device_connect_record插入连接记录
		DeviceConnectRecord devConnectRecord = new DeviceConnectRecord();
		devConnectRecord.setDate(nowTime);
		devConnectRecord.setDeviceMac(devMac);
		devConnectRecord.setConnection(true);
		devConnectRecord.setUserid(device.getUserid());
		testUtils.DeviceConnectRecordDao.insert(devConnectRecord);
		
	}
	/**
	 * 集控器与服务器断开链接，线程关闭。
	 * 记录集控器与服务器断开连接记录，插入数据库内
	 * @param device
	 */
	public static void insertDeviceUnconnectRecord(String devMac) {
		//当前时间参数
	    Date nowTime = new Date();
		//得到集控器对象
		Device device = testUtils.devDao.selectByPrimaryKey(devMac);
		//向device_connect_record插入连接记录
		DeviceConnectRecord devConnectRecord = new DeviceConnectRecord();
		devConnectRecord.setDate(nowTime);
		devConnectRecord.setDeviceMac(devMac);
		devConnectRecord.setConnection(false);
		devConnectRecord.setUserid(device.getUserid());
		testUtils.DeviceConnectRecordDao.insert(devConnectRecord);
		
	}
	/**
	 * 轮询超时报警判断函数，每一小时进行一次轮询超时报警
	 * 集控器保持连接状态超过12h,则超时报警
	 * @param deviceSocket
	 */
	public static void PollingAlarmFunction(
		DeviceSocket deviceSocket,long AlarmTime) {//AlarmTime=12小时
		String devMac = deviceSocket.getDevice().getDevMac();
		String zigbeeMac = null;
		ZigbeeStatusRecord zsr = null;
		String alarmParam = null;  //报警参数
		
		if(devMac != null || devMac != "") { //集控器地址不为空
		    //得到集控器对象
			Device device = testUtils.devDao.selectByPrimaryKey(devMac);
			//根据集控器地址查询该集控器最后一条连接服务器记录
			DeviceConnectRecord dcr = 
					testUtils.DeviceConnectRecordDao.selectLastConnectRecordByDeviceMac(devMac); 
		    if (dcr != null && dcr.isConnection() == true) { //集控器连接记录不为空且是保持连接状态的
			    Date date = new Date();
			    //根据集控器地址查询该集控器记录的最后时间的一条节点状态记录
			    zsr = testUtils.ZigbeeStatusRecordDao.selectLastZigbeeStatusRecordByDeviceMac(devMac); 
				if (!zsr.getDevMac().equals("")) { // 2. 节点状态记录存在，判断回复时间是否已经超过12个小时。
					if (date.getTime() - zsr.getDate().getTime() > AlarmTime
							&& date.getTime() - dcr.getDate().getTime() > AlarmTime) {
						List<Alarm> list = testUtils.
								AlarmDao.selectByDeviceMacAndType(devMac, Alarm.ALARM_DISCONNECT);
						// 如果数据库中没有相应的报警信息，生成报警信息，type = ALARM_DISCONNECT，存入数据库。
						if (list.size() == 0) { //该集控器无报警
							Alarm alarm = new Alarm(new Date(), devMac, zigbeeMac,
									Alarm.ALARM_DISCONNECT, device.getUserid(), alarmParam);
							testUtils.AlarmDao.insert(alarm);
						}else {// 判断是否有相应的超时报警信息，如果有，删除
							if (list.size() > 0) {
								for(int i = 0; i < list.size(); i++) {
									Alarm alarm = list.get(i);
									testUtils.AlarmDao.deleteById(alarm.getId());
								}
								Alarm alarm = new Alarm(new Date(), devMac, zigbeeMac,
										Alarm.ALARM_DISCONNECT, device.getUserid(), alarmParam);
								testUtils.AlarmDao.insert(alarm);
							}
						}
					}     
				}else{
					// 未查询到节点状态记录,如果集控器链接已超过12个小时，报警
					if (date.getTime() - dcr.getDate().getTime() > AlarmTime) {
						List<Alarm> list = testUtils.AlarmDao.selectByDeviceMacAndType(devMac, Alarm.ALARM_DISCONNECT);
						// 如果数据库中没有相应的报警信息，生成报警信息，type = ALARM_DISCONNECT，存入数据库。
						if (list.size() == 0) { //该集控器无报警
							Alarm alarm = new Alarm(new Date(), devMac, zigbeeMac,
									Alarm.ALARM_DISCONNECT, device.getUserid(), alarmParam);
							testUtils.AlarmDao.insert(alarm);
						}else {// 判断是否有相应的超时报警信息，如果有，删除
							if (list.size() > 0) {
								for(int i = 0; i < list.size(); i++) {
									Alarm alarm = list.get(i);
									testUtils.AlarmDao.deleteById(alarm.getId());
								}
								Alarm alarm = new Alarm(new Date(), devMac, zigbeeMac,
										Alarm.ALARM_DISCONNECT, device.getUserid(), alarmParam);
								testUtils.AlarmDao.insert(alarm);
							}
						}
						
					}	
				}
		    	
		    }
		}
	
	    
	}
	
	//定时清空所有用户的验证码操作次数
	public static void timingClearAllUserOperateNum() {
		Integer operateNum = 0;
		testUtils.UserDao.clearAllUserOperateNum(operateNum);
		//log.info("定时清空用户的验证码操作次数");
		
	}

	
	

}
