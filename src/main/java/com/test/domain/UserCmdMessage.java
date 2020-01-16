package com.test.domain;

import java.util.Date;

//import java.util.Date;

public class UserCmdMessage {
	//0.读取集控器mac地址指令
	public static int CMD_QUERY_DEVICE_MAC = 17;
	//1.允许集控器发现节点指令 *
	public static int CMD_OPEN_FIND_ZIGBEE = 0;
	//2.读取节点所有状态指令(读取某一个节点的状态命令帧)*
	public static int CMD_READ_ZIGBEE_MESSAGE= 1;
	//3.请求节点上报信息指令(节点上电主动上报：回复软件版本、灯类型、额定功率值)
	public static int CMD_RUQUEST_ZIGBEE_MESSAGE = 2;
	//4.查询灯状态指令（新节点主动上报：回复包括灯开关状态、调光值、过温报警、灯具是否工作正常等，具体参照zigee设备通信协议6.6.2）
	public static int CMD_QUERY_ZIGBEE_STATUS = 3;
	//5.广播开灯指令*
	public static int CMD_BROADCAST_ON = 4;
	//6.广播关灯指令*
	public static int CMD_BROADCAST_OFF = 5;
	//7.广播调光指令*
	public static int CMD_BROADCAST_DIM = 6;
	//8.开灯指令*
	public static int CMD_ZIGBEE_ON = 7;
	//9.关灯指令*
	public static int CMD_ZIGBEE_OFF = 8;
	//10.调光指令*
	public static int CMD_ZIGBEE_DIM = 9;
	//11.节点添加组信息指令(节点绑定分组)
	public static int CMD_ZIGBEE_BIND_GROUP = 10;
	//12.节点删除组指令（删除某一节点的组id或全部删除组id）
	public static int CMD_ZIGBEE_DELETE_GROUP = 11;
	//13.获取某一节点的组id
	public static int CMD_GET_GROUP_MESSAGE = 12;
	//14.分组开灯指令*
	public static int CMD_GROUP_ON = 13;
	//15.分组关灯指令*
	public static int CMD_GROUP_OFF = 14;
	//16.分组调光指令*
	public static int CMD_GROUP_DIM = 15;
	//17.策略定时指令
	public static int CMD_PLOY_TIMING = 16; 
	
	/*
	 * 用户发送的指令id,主键
	 */
	private int id;
	/*
	 * 用户指令发送的时间
	 */
	private Date date;
	/*
	 * 指令类型(调光、开关、广播指令)
	 */
	private int cmdType;
	/*
	 * 用户id
	 */
	private int userid;
	/*
	 * 集控器mac地址
	 */
	private String devMac;
	/*
	 * 指令帧（FE-----）
	 */
	private String cmdData;
	
	/*
	 * 预留参数
	 */
	private String param1;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date nowTime) {
		this.date = nowTime;
	}
	public int getCmdType() {
		return cmdType;
	}
	public void setCmdType(int cmdType) {
		this.cmdType = cmdType;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getDevMac() {
		return devMac;
	}
	public void setDevMac(String devMac) {
		this.devMac = devMac;
	}
	public String getCmdData() {
		return cmdData;
	}
	public void setCmdData(String cmdData) {
		this.cmdData = cmdData;
	}
	public String getParam1() {
		return param1;
	}
	public void setParam1(String param1) {
		this.param1 = param1;
	}
	@Override
	public String toString() {
		return "UserCmdMessage [id=" + id + ", date=" + date + ", cmdType=" + cmdType + ", userid=" + userid
				+ ", devMac=" + devMac + ", cmdData=" + cmdData + ", param1=" + param1 + "]";
	}
	
	
}
