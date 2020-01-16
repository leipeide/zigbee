package com.test.service.socket;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import org.apache.log4j.Logger;

import com.test.domain.DeviceAttr;
import com.test.domain.Group;
import com.test.domain.GroupPair;
import com.test.domain.UserCmdMessage;
import com.test.domain.Zigbee;
import com.test.domain.ZigbeeAttr;
import com.test.domain.ZigbeeStatusRecord;
import com.test.util.UnusualUtils;

/**
 * 多线程处理socket接收的数据
 * 
 * @author zhangzhongwen
 * 
 */
public class SocketOperate extends Thread {
	// 指令
	// static private String cmd_setMac = "mac:";
	private final static String READ_STATUS = "FE0969030200000A00CA040000";

	private DeviceSocket deviceSocket;

	private ArrayList<Zigbee> zigbeeList;

	private ArrayList<Zigbee> zigbeePrematureList = new ArrayList<>();

	private Timer timer;
	
	private Logger log = Logger.getLogger("D");

	private Zigbee checkZigbee(String nwkAddr) {
		zigbeeList = SocketTool.selectZigbeeByDevMac(deviceSocket.getDevice().getDevMac());
		for (Zigbee zb : zigbeeList) {
			if (nwkAddr.equals(zb.getZigbeeSaddr())) {// 匹配成功
				return zb;
			}
		}
		return null;
	}

	private String groupidToAddr(Integer groupid) {
		String groupaddr = groupid.toString();
		if (groupaddr.length() >= 4) {
			groupaddr = groupaddr.substring(groupaddr.length() - 4);
		} else {
			String temp = "";
			for (int i = 0; i < 4 - groupaddr.length(); i++) {
				temp = "0" + temp;
			}
			groupaddr = temp + groupaddr;
		}
		return groupaddr;
	}

	private Group checkGroup(Integer userid, String groupAddr) {
		ArrayList<Group> groupList = SocketTool.selectGroupByUserid(userid);
		for (Group group : groupList) {
			if (groupAddr.equals(groupidToAddr(group.getGroupid()))) {
				return group;
			}
		}
		return null;
	}

	private void myprint(PrintWriter out, String cmd) {//输出到控制台文件
		out.print(cmd);
		out.flush();
		//添加时间戳
		log.info("server to " + this.deviceSocket.getDevice().getDevMac() + ": " + cmd);
	}

	private void readZigbeeReply(Zigbee zb, String strXML) { 
		//更新节点状态
		if ("00".equals(strXML.substring(50, 52))) {
			zb.setZigbeeNet(1);
		} else if ("01".equals(strXML.substring(50, 52))) {
			zb.setZigbeeNet(0);
		}
		zb.setZigbeeSaddr(strXML.substring(26, 30));// 更新短地址
		if ("00".equals(strXML.substring(36, 38))) {// 状态正常
			if ("00".equals(strXML.substring(38, 40))) {// 灯亮
				zb.setZigbeeStatus(1);
			} else if ("01".equals(strXML.substring(38, 40))) {// 灯灭
				zb.setZigbeeStatus(0);
			}
			zb.setZigbeeBright(Integer.valueOf(strXML.substring(40, 42), 16));// 读取亮度
			SocketTool.updateZigbeeByPrimaryKeySelective(zb);// 更新数据库
			
			// 其他参数操作
			ZigbeeAttr zigbeeAttr = SocketTool.selectZigbeeAttrByPrimaryKey(zb.getZigbeeMac());
			if (zigbeeAttr != null) {
				//未避免异常温度和湿度，添加if判断，大于100均不写入数据库
				if((Integer.valueOf(strXML.substring(42, 46), 16)/100) < 100) {	
					zigbeeAttr.setTemperature(Integer.valueOf(strXML.substring(42, 46), 16));// get the temperature
				}
				if((Integer.valueOf(strXML.substring(46, 50), 16)/100) < 100) {	
					zigbeeAttr.setHumidity(Integer.valueOf(strXML.substring(46, 50), 16));// get the humidity
				}
				// 更新数据库
				SocketTool.updateZigbeeAttrByPrimaryKeySelective(zigbeeAttr);
			} else {
				zigbeeAttr = new ZigbeeAttr();
				zigbeeAttr.setZigbeeMac(zb.getZigbeeMac());// set primary key
				//未避免异常温度和湿度，添加if判断，大于100均不写入数据库
				if((Integer.valueOf(strXML.substring(42, 46), 16)/100) < 100) {	
					zigbeeAttr.setTemperature(Integer.valueOf(strXML.substring(42, 46), 16));// get the temperature
				}
				if((Integer.valueOf(strXML.substring(46, 50), 16)/100) < 100) {	
					zigbeeAttr.setHumidity(Integer.valueOf(strXML.substring(46, 50), 16));// get the humidity
				}
				// 插入到数据库
				SocketTool.insertZigbeeAttrSelective(zigbeeAttr);
			}
			UnusualUtils.RecordUnusualTemperatureToDB(zigbeeAttr);
			
		} else {// 状态异常

		}
		
	}
	
	/*
	 * 节点状态写入数据库ZigbeeStatusRecord
	 */
	private void writeZigbeeStatusRecord(String strXML) {
		//获取zigbeeAttr属性对象
		ZigbeeAttr zbAttr = SocketTool.selectZigbeeAttrByPrimaryKey(strXML.substring(10, 26));
		//记录节点状态值
		ZigbeeStatusRecord zbStatusRecord = new ZigbeeStatusRecord();
		Date nowTime = new Date();
		if(zbAttr != null) { //zbAttr存在
			zbStatusRecord.setDate(nowTime);
			zbStatusRecord.setDevMac(deviceSocket.getDevice().getDevMac());
			zbStatusRecord.setPower(zbAttr.getPower());
			zbStatusRecord.setZigbeeBright(Integer.valueOf(strXML.substring(40, 42), 16));
			zbStatusRecord.setZigbeeMac(zbAttr.getZigbeeMac());
			zbStatusRecord.setZigbeeType(zbAttr.getType());
			zbStatusRecord.setRecordType(zbStatusRecord.RECORD_TYPE_UPDATE); //记录类型是主动更新
			if ("00".equals(strXML.substring(36, 38))) {// 状态正常
				if ("00".equals(strXML.substring(38, 40))) {// 灯亮
					zbStatusRecord.setZigbeeStatus(1);
				} else if ("01".equals(strXML.substring(38, 40))) {// 灯灭
					zbStatusRecord.setZigbeeStatus(0);
				}
				if((Integer.valueOf(strXML.substring(42, 46), 16)/100) < 100) {	
					zbStatusRecord.setTemperature(Integer.valueOf(strXML.substring(42, 46), 16));
				}
				if((Integer.valueOf(strXML.substring(46, 50), 16)/100) < 100) {	
					zbStatusRecord.setHumidity(Integer.valueOf(strXML.substring(46, 50), 16));
				}
			}
		}else { //zbAttr不存在，节点的类型、功率、无法获取
			zbStatusRecord.setDate(nowTime);
			zbStatusRecord.setDevMac(deviceSocket.getDevice().getDevMac());
			zbStatusRecord.setZigbeeBright(Integer.valueOf(strXML.substring(40, 42), 16));
			zbStatusRecord.setZigbeeMac(strXML.substring(10, 26));
			zbStatusRecord.setRecordType(zbStatusRecord.RECORD_TYPE_UPDATE); //记录类型是主动更新
			if ("00".equals(strXML.substring(36, 38))) {// 状态正常
				if ("00".equals(strXML.substring(38, 40))) {// 灯亮
					zbStatusRecord.setZigbeeStatus(1);
				} else if ("01".equals(strXML.substring(38, 40))) {// 灯灭
					zbStatusRecord.setZigbeeStatus(0);
				}
				if((Integer.valueOf(strXML.substring(42, 46), 16)/100) < 100) {	
					zbStatusRecord.setTemperature(Integer.valueOf(strXML.substring(42, 46), 16));
				}
				if((Integer.valueOf(strXML.substring(46, 50), 16)/100) < 100) {	
					zbStatusRecord.setHumidity(Integer.valueOf(strXML.substring(46, 50), 16));
				}
			}
		}
		//插入数据库
		SocketTool.insertZigbeeStatusRecord(zbStatusRecord);
		
	}

	public SocketOperate(DeviceSocket deviceSocket) {
		this.deviceSocket = deviceSocket;
	}

	public void run() {
		try {
			InputStream in = deviceSocket.getSocket().getInputStream();
			PrintWriter out = new PrintWriter(deviceSocket.getSocket().getOutputStream());
			Zigbee zbtest;
			Group grouptemp;
			GroupPair gp;
			ArrayList<Zigbee> zbTempList;
			//启动后发三遍错误帧,
			if (timer == null) {
				timer = new Timer();// 实例化Timer类
				new Timer().schedule(new TimerTask() {
					private PrintWriter timerOut = out;
					private Integer count = 0;
					public void run() {
						myprint(this.timerOut, "E0E290202FFFF0A000801002FF000000");//错误帧
						count++;
						if (count == 3) {
							this.cancel();
						}
					}
				}, 500, 500);// 毫秒
				
				//发三遍错误帧后每隔5秒发一个读取集控器mac地址命令帧
				timer.schedule(new TimerTask() {
					private PrintWriter timerOut = out;
					public void run() {
						myprint(this.timerOut, "FE04250100000000");//服务器主动发送读取协调器（集控器）mac地址帧
					}
				}, 5000, 5000);// 毫秒
				
			}
			
			
			
			while (/* deviceSocket.getSocket().isConnected() */true) {
				// 读取客户端发送的信息
				String strXML = "";
				byte[] temp = new byte[1024];
				int length = 0;
				int dataPoint = 0;
				ArrayList<String> dataFrameList = new ArrayList<String>();
				while ((length = in.read(temp)) != -1) { //-1为文件读完的标志,当in.read()值等于-1时，代表数据读取完毕
					dataPoint = 0;
					strXML = new String(temp, 0, length);
					dataFrameList.clear();
					
					///////// 以下为数据粘包处理，将包含多帧数据的的数据包拆开解析 ////////////
					while (dataPoint < length) {
						if (length >= 52 + dataPoint && strXML.substring(dataPoint, 10 + dataPoint).equals("FE18690202")) {// 查询灯状态应答帧，长度52
							dataFrameList.add(strXML.substring(dataPoint, dataPoint + 52));
							dataPoint = 52 + dataPoint;					} else if (length >= 12 + dataPoint && strXML.substring(dataPoint, 12 + dataPoint).equals("FE0165010065")) {// 未知命令
							dataFrameList.add(strXML.substring(dataPoint, dataPoint + 12));
							dataPoint = 12 + dataPoint;
						} else if (length >= 36 + dataPoint && strXML.substring(dataPoint, 10 + dataPoint).equals("FE0D458100")) {// 查询回复mac地址+短地址，长度36
							dataFrameList.add(strXML.substring(dataPoint, dataPoint + 36));
							dataPoint = 36 + dataPoint;
						} else if (length >= 36 + dataPoint && strXML.substring(dataPoint, 8 + dataPoint).equals("FE0D45C1")) {// 上报mac地址+短地址，长度36
							dataFrameList.add(strXML.substring(dataPoint, dataPoint + 36));
							dataPoint = 36 + dataPoint;
						} else if (length >= 26 + dataPoint && strXML.substring(dataPoint, 2 + dataPoint).equals("FE")
								&& "29030200000A00CA0102".equals(strXML.substring(4 + dataPoint, 24 + dataPoint))) {// 电话号码,长度不定，未发现粘包，不作处理
							dataFrameList.add(strXML.substring(dataPoint));
							dataPoint = length;
						} else if (length >= 66 + dataPoint && strXML.substring(dataPoint, 8 + dataPoint).equals("FE1C4584")) {// 节点上报信息应答帧，长度44
							dataFrameList.add(strXML.substring(dataPoint, dataPoint + 66));
							dataPoint = 66 + dataPoint;
						} else if (length >= 26 + dataPoint && strXML.substring(dataPoint, 8 + dataPoint).equals("FE084585")) {// 未知指令，长度26
							dataFrameList.add(strXML.substring(dataPoint, dataPoint + 26));
							dataPoint = 26 + dataPoint;
						} else if (length >= 46 + dataPoint && strXML.substring(dataPoint, 8 + dataPoint).equals("FE124584")) {// 未知指令，长度46
							dataFrameList.add(strXML.substring(dataPoint, dataPoint + 46));
							dataPoint = 46 + dataPoint;
						} else if (length >= 27 + dataPoint && strXML.substring(dataPoint, 27 + dataPoint).equals("FE0B29030200000A00CA0101XTB")) {// 心跳包，长度27
							dataFrameList.add(strXML.substring(dataPoint, dataPoint + 27));
							dataPoint = 27 + dataPoint;
						} else if (length >= 28 && strXML.substring(dataPoint, 8 + dataPoint).equals("FE096902")
								&& "06".equals(strXML.substring(16 + dataPoint, 18 + dataPoint))) {// 开、关命令应答帧，长度28
							dataFrameList.add(strXML.substring(dataPoint, dataPoint + 28));
							dataPoint = 28 + dataPoint;
						} else if (length >= 28 && strXML.substring(dataPoint, 8 + dataPoint).equals("FE096902")
								&& "08".equals(strXML.substring(16 + dataPoint, 18 + dataPoint))) {// 调光命令应答帧，长度28
							dataFrameList.add(strXML.substring(dataPoint, dataPoint + 28));
							dataPoint = 28 + dataPoint;
						} else {
							dataFrameList.add(strXML.substring(dataPoint));
							dataPoint = length;
						}
					}
					
			  /*************************************指令处理程序*******************************/
					
					for (int i = 0; i < dataFrameList.size(); i++) {
						strXML = dataFrameList.get(i);	
						log.info(deviceSocket.getDevice().getDevMac() + ": " + strXML);
						
						//1.未知指令
						if (strXML.startsWith("FE0165010065")) {
							strXML = strXML.replace("FE0165010065", "");//未知指令由空指令代替
						}
						
						// 2.回复查询mac地址+短地址
						if (strXML.length() > 30 && strXML.startsWith("FE0D458100")) {
							//2.1集控器mac地址（集控器回复mac地址应答帧）
							if ("0000".equals(strXML.substring(26, 30))) {
								if (deviceSocket.getDevice().getDevMac() == null) {// 该端口第一次绑定设备
									deviceSocket.getDevice().setDevMac(strXML.substring(10, 26));
									deviceSocket.getDevice().setDevNet(1);// 更新设备网络状态
									SocketTool.updateDeviceData(deviceSocket.getDevice());// 更新数据库
								} else {// 第N次绑定设备
									deviceSocket.getDevice().setDevNet(0);// 先将旧mac地址设备离线
									SocketTool.updateDeviceData(deviceSocket.getDevice());// 更新数据库
									deviceSocket.getDevice().setDevMac(strXML.substring(10, 26));// 读新mac地址
									deviceSocket.getDevice().setDevNet(1);// 上线
									SocketTool.updateDeviceData(deviceSocket.getDevice());// 更新数据库
								}
								deviceSocket.setDevice(
										SocketTool.selectDeviceByPrimaryKey(deviceSocket.getDevice().getDevMac()));// 同步数据，主要是为了获取用户id
								// 将上报mac地址之前连接到集控器的节点更新到数据库
								for (Zigbee zb : zigbeePrematureList) {
									zb.setDevMac(deviceSocket.getDevice().getDevMac());
									zbtest = SocketTool.selectZigbeeByPrimaryKey(zb.getZigbeeMac());
									if (zbtest != null) {// 数据库中已存在，进行更新操作
										SocketTool.updateZigbeeByPrimaryKeySelective(zb);
										zbtest = null;
									} else {
										SocketTool.insertZigbee(zb);
									}
								}
								if (zigbeePrematureList != null) {
									zigbeePrematureList.clear();
								}
								if (timer != null) {
									timer.cancel();
									timer = null;
								}
								//服务器向协调器读取节点所有状态命令帧
								myprint(out, READ_STATUS);
								//将服务器发送的指令写入数据库
								UserCmdMessage ucm = new UserCmdMessage();
								ucm.setCmdType(ucm.CMD_READ_ZIGBEE_MESSAGE);
								SocketTool.writeUserCmdMessageRecord(deviceSocket,READ_STATUS,ucm);
								/*为解决集控器掉电两分钟以上，节点发生复位，
								 * 等再次上电以后，节点无法主动连接到集控器
								 * 故添加集控器上电登陆后服务器端主动发送发现节点指令
								 */
								String timeString = Integer.toHexString(60); //开启发现节点的时间设置为60秒
								timeString = timeString.toUpperCase();
								SocketCmd socketcmd = new SocketCmd();
								socketcmd.setCmdString("FE0969030200000A00CA0500" + timeString);// 设置指令
								// 开新定时器线程计时
								new Timer().schedule(new TimerTask() {
									private SocketCmd thisCmd = socketcmd;
									private PrintWriter timerOut = out;
									private ArrayList<SocketCmd> cmdPool = deviceSocket.getCmdPool();
									public void run() {
										this.cancel();
										if (cmdPool.contains(thisCmd)) {
											cmdPool.remove(thisCmd);
										}
									}
								}, 15000);// 毫秒
								deviceSocket.getCmdPool().add(socketcmd); //将发现节点指令添加到指令池
								myprint(out, socketcmd.getCmdString());	
								//将服务器发送的指令写入数据库
								UserCmdMessage ucm1 = new UserCmdMessage();
								ucm1.setCmdType(ucm1.CMD_OPEN_FIND_ZIGBEE);
								SocketTool.writeUserCmdMessageRecord(deviceSocket,socketcmd.getCmdString(),ucm1);
								
							//2.2 zigbee节点mac地址（回复节点mac地址应答帧）  
							} else if (strXML.length() > 30) {
								Zigbee zb = SocketTool.selectZigbeeByPrimaryKey(strXML.substring(10, 26));// 节点mac地址
								if (zb != null) {
									zb.setZigbeeSaddr(strXML.substring(26, 30));// 节点短地址
									zb.setZigbeeNet(1);// 节点网络状态(上线)
									zb.setDevMac(deviceSocket.getDevice().getDevMac());
									SocketTool.updateZigbeeByPrimaryKeySelective(zb);// 更新数据库
								} else {
									zb = new Zigbee();
									zb.setDevMac(deviceSocket.getDevice().getDevMac());
									zb.setZigbeeMac(strXML.substring(10, 26));
									zb.setZigbeeSaddr(strXML.substring(26, 30));
									zb.setZigbeeName(zb.getZigbeeMac());
									zb.setZigbeeNet(1);
									zb.setZigbeeStatus(1);
									zb.setZigbeeBright(100);
									SocketTool.insertZigbee(zb);// 更新数据库
									
									//将节点更新的状态写入数据库ZigbeeStatusRecord
									ZigbeeAttr zigbeeAttr = SocketTool.selectZigbeeAttrByPrimaryKey(strXML.substring(16, 32));
									ZigbeeStatusRecord zbStatusRecord = new ZigbeeStatusRecord();
									Date nowTime = new Date();
									zbStatusRecord.setDate(nowTime);
									zbStatusRecord.setDevMac(deviceSocket.getDevice().getDevMac());
									zbStatusRecord.setZigbeeBright(zb.getZigbeeBright());
									zbStatusRecord.setZigbeeMac(zb.getZigbeeMac());
									zbStatusRecord.setZigbeeStatus(zb.getZigbeeStatus());
									zbStatusRecord.setRecordType(zbStatusRecord.RECORD_TYPE_UPDATE); //记录类型是主动更新
									zbStatusRecord.setTemperature(zigbeeAttr.getTemperature());
									zbStatusRecord.setHumidity(zigbeeAttr.getHumidity());
									zbStatusRecord.setZigbeeType(zigbeeAttr.getType());
									zbStatusRecord.setPower(zigbeeAttr.getPower());
									SocketTool.insertZigbeeStatusRecord(zbStatusRecord);
								}
							}

							
						//3.上报mac地址+短地址（节点上电后自动向服务器上报mac地址+短地址）
						} else if (strXML.length() >= 32 && strXML.startsWith("FE0D45C1")) { 
							if (deviceSocket.getDevice().getDevMac() != null) {
								zbtest = SocketTool.selectZigbeeByPrimaryKey(strXML.substring(16, 32));// 节点mac地址
								if (zbtest != null) {
									zbtest.setZigbeeSaddr(strXML.substring(12, 16));// 节点短地址
									zbtest.setDevMac(deviceSocket.getDevice().getDevMac());
									zbtest.setZigbeeNet(1);// 节点网络状态(上线)
									SocketTool.updateZigbeeByPrimaryKeySelective(zbtest);// 更新数据库
								} else {
									zbtest = new Zigbee();
									zbtest.setDevMac(deviceSocket.getDevice().getDevMac());
									zbtest.setZigbeeMac(strXML.substring(16, 32));
									zbtest.setZigbeeSaddr(strXML.substring(12, 16));
									zbtest.setZigbeeName(zbtest.getZigbeeMac());
									zbtest.setZigbeeNet(1);
									zbtest.setZigbeeStatus(1);
									zbtest.setZigbeeBright(100);
									SocketTool.insertZigbee(zbtest);// 更新数据库
									
									ZigbeeAttr zigbeeAttr = SocketTool.selectZigbeeAttrByPrimaryKey(strXML.substring(16, 32));
									//将节点更新的状态写入数据库ZigbeeStatusRecord
									ZigbeeStatusRecord zbStatusRecord = new ZigbeeStatusRecord();
									Date nowTime = new Date();
									zbStatusRecord.setDate(nowTime);
									zbStatusRecord.setDevMac(deviceSocket.getDevice().getDevMac());
									zbStatusRecord.setZigbeeBright(zbtest.getZigbeeBright());
									zbStatusRecord.setZigbeeMac(zbtest.getZigbeeMac());
									zbStatusRecord.setZigbeeStatus(zbtest.getZigbeeStatus());
									zbStatusRecord.setRecordType(zbStatusRecord.RECORD_TYPE_UPDATE); //记录类型是主动更新
									if(zigbeeAttr != null) {
										zbStatusRecord.setTemperature(zigbeeAttr.getTemperature());
										zbStatusRecord.setHumidity(zigbeeAttr.getHumidity());
										zbStatusRecord.setZigbeeType(zigbeeAttr.getType());
										zbStatusRecord.setPower(zigbeeAttr.getPower());
									}
									SocketTool.insertZigbeeStatusRecord(zbStatusRecord);
								}
								zbtest = null;
							} else {// 节点连接在集控器上报mac地址之前
								zbtest = SocketTool.selectZigbeeByPrimaryKey(strXML.substring(16, 32));// 节点mac地址
								if (zbtest != null) {
									zbtest.setZigbeeSaddr(strXML.substring(12, 16));// 节点短地址
									zbtest.setZigbeeNet(1);// 节点网络状态(上线)
								} else {
									zbtest = new Zigbee();
									zbtest.setZigbeeMac(strXML.substring(16, 32));
									zbtest.setZigbeeSaddr(strXML.substring(12, 16));
									zbtest.setZigbeeName(zbtest.getZigbeeMac());
									zbtest.setZigbeeNet(1);
									zbtest.setZigbeeStatus(1);
									zbtest.setZigbeeBright(100);
									
									ZigbeeAttr zigbeeAttr = SocketTool.selectZigbeeAttrByPrimaryKey(strXML.substring(16, 32));
									//将节点更新的状态写入数据库ZigbeeStatusRecord
									ZigbeeStatusRecord zbStatusRecord = new ZigbeeStatusRecord();
									Date nowTime = new Date();
									zbStatusRecord.setDate(nowTime);
									zbStatusRecord.setDevMac(deviceSocket.getDevice().getDevMac());
									zbStatusRecord.setZigbeeBright(zbtest.getZigbeeBright());
									zbStatusRecord.setZigbeeMac(zbtest.getZigbeeMac());
									zbStatusRecord.setZigbeeStatus(zbtest.getZigbeeStatus());
									zbStatusRecord.setRecordType(zbStatusRecord.RECORD_TYPE_UPDATE); //记录类型是主动更新
									if(zigbeeAttr != null) {
										zbStatusRecord.setTemperature(zigbeeAttr.getTemperature());
										zbStatusRecord.setHumidity(zigbeeAttr.getHumidity());
										zbStatusRecord.setZigbeeType(zigbeeAttr.getType());
										zbStatusRecord.setPower(zigbeeAttr.getPower());
									}
									SocketTool.insertZigbeeStatusRecord(zbStatusRecord);
								}
								zigbeePrematureList.add(zbtest);
								zbtest = null;
							}

							
						//4.集控器主动上报电话号码帧
						} else if (strXML.length() >= 26 && strXML.startsWith("FE")
								&& "29030200000A00CA0102".equals(strXML.substring(4, 24))) {
							deviceSocket.getDevice().setGprsPhone(strXML.substring(25, strXML.length() - 1));// 设置电话号码
							if (timer == null) {
								timer = new Timer();// 实例化Timer类
								new Timer().schedule(new TimerTask() {
									private PrintWriter timerOut = out;
									private Integer count = 0;
									public void run() {
										myprint(this.timerOut, "E0E290202FFFF0A000801002FF000000"); //发三遍错误帧
										count++;
										if (count == 3) {
											this.cancel();
										}
									}
								}, 500, 500);// 毫秒

								timer.schedule(new TimerTask() {
									private PrintWriter timerOut = out;
									public void run() {
										myprint(this.timerOut, "FE04250100000000"); //发送读取节点所有状态帧
									}
								}, 5000, 5000);// 毫秒
								
								//将服务器发送的指令写入数据库
								UserCmdMessage ucm = new UserCmdMessage();
								ucm.setCmdType(ucm.CMD_QUERY_DEVICE_MAC);
								SocketTool.writeUserCmdMessageRecord(deviceSocket,"FE04250100000000",ucm);
							}

							
						//5.查询灯状态应答帧
						} else if (strXML.length() >= 52 && strXML.startsWith("FE18690202") && strXML.substring(22,26).equals("1200") 
								&& "0ACA00".equals(strXML.substring(30, 36))) {
							//为解决假节点问题，在else if判断语句内添加strXML.substring(22,26).equals("1200");
							Zigbee zb = SocketTool.selectZigbeeByPrimaryKey(strXML.substring(10, 26));
							if (zb != null) {
								// 更新节点属性
								readZigbeeReply(zb, strXML);
								//查询zigbee_status_record最后一条update指令，并将其与集控器上报的节点状态进行对比
								Boolean result = SocketTool.selectZigbeeStatusRecordLastRecord(strXML);
								if(!result) {//result==false,则zigbee_status_record最后一条记录不是update或者节点的状态发生了变化
									//插入节点状态信息记录
									writeZigbeeStatusRecord(strXML);
								}
							} else {
								// 添加新节点
								if (deviceSocket.getDevice() != null && deviceSocket.getDevice().getDevMac() != null) {
									zb = new Zigbee();
									zb.setZigbeeMac(strXML.substring(10, 26));
									zb.setZigbeeName(zb.getZigbeeMac());
									zb.setDevMac(deviceSocket.getDevice().getDevMac());
									zb.setZigbeeSaddr(strXML.substring(26, 30));
									zb.setZigbeeNet(1);
									zb.setZigbeeBright(100);
									zb.setZigbeeStatus(1);
									SocketTool.insertZigbee(zb);
									// 更新节点属性
									readZigbeeReply(zb, strXML);
									//由于是新节点，则直接插入节点状态信息记录
									writeZigbeeStatusRecord(strXML);
								}
								
							}
							
						//6.节点上报信息应答帧（软件版本、灯类型、额定功率），节点上电后主动上报	
						} else if (strXML.length() >= 42 && strXML.startsWith("FE1C4584")) {
							Zigbee zb = checkZigbee(strXML.substring(8, 12));
							if (zb != null) {
								// 其他参数操作
								ZigbeeAttr zigbeeAttr = SocketTool.selectZigbeeAttrByPrimaryKey(zb.getZigbeeMac());
								if (zigbeeAttr != null) {
									zigbeeAttr.setVersion(strXML.substring(34, 36));
									zigbeeAttr.setType(Integer.valueOf(strXML.substring(36, 38), 16));// get device-type
									zigbeeAttr.setPower(Integer.valueOf(strXML.substring(38, 42), 16));// get power
									//更新数据库
									SocketTool.updateZigbeeAttrByPrimaryKeySelective(zigbeeAttr);
									//将节点更新的状态写入数据库ZigbeeStatusRecord
									ZigbeeStatusRecord zbStatusRecord = new ZigbeeStatusRecord();
									Date nowTime = new Date();
									zbStatusRecord.setDate(nowTime);
									zbStatusRecord.setDevMac(deviceSocket.getDevice().getDevMac());
									zbStatusRecord.setZigbeeMac(zb.getZigbeeMac());
									zbStatusRecord.setRecordType(zbStatusRecord.RECORD_TYPE_UPDATE); //记录类型是主动更新
									zbStatusRecord.setZigbeeStatus(zb.getZigbeeStatus());
									zbStatusRecord.setZigbeeBright(zb.getZigbeeBright());
									zbStatusRecord.setTemperature(zigbeeAttr.getTemperature());
									zbStatusRecord.setHumidity(zigbeeAttr.getHumidity());
									zbStatusRecord.setZigbeeType(zigbeeAttr.getType());
									zbStatusRecord.setPower(zigbeeAttr.getPower());
									SocketTool.insertZigbeeStatusRecord(zbStatusRecord);
								} else {
									zigbeeAttr = new ZigbeeAttr();
									zigbeeAttr.setZigbeeMac(zb.getZigbeeMac());// set primary key
									zigbeeAttr.setVersion(strXML.substring(34, 36));
									zigbeeAttr.setType(Integer.valueOf(strXML.substring(36, 38), 16));// get device-type
									zigbeeAttr.setPower(Integer.valueOf(strXML.substring(38, 42), 16));// get power
									//插入数据库
									SocketTool.insertZigbeeAttrSelective(zigbeeAttr);
									//将节点更新的状态写入数据库ZigbeeStatusRecord
									ZigbeeStatusRecord zbStatusRecord = new ZigbeeStatusRecord();
									Date nowTime = new Date();
									zbStatusRecord.setDate(nowTime);
									zbStatusRecord.setDevMac(deviceSocket.getDevice().getDevMac());
									zbStatusRecord.setZigbeeMac(zb.getZigbeeMac());
									zbStatusRecord.setRecordType(zbStatusRecord.RECORD_TYPE_UPDATE); //记录类型是主动更新
									zbStatusRecord.setZigbeeStatus(zb.getZigbeeStatus());
									zbStatusRecord.setZigbeeBright(zb.getZigbeeBright());
									zbStatusRecord.setTemperature(zigbeeAttr.getTemperature());
									zbStatusRecord.setHumidity(zigbeeAttr.getHumidity());
									zbStatusRecord.setZigbeeType(zigbeeAttr.getType());
									zbStatusRecord.setPower(zigbeeAttr.getPower());
									SocketTool.insertZigbeeStatusRecord(zbStatusRecord);
								}
							} else {
								// 添加新节点
							}
							
							
						//7.心跳包指令
						} else if (strXML.startsWith("FE0B29030200000A00CA0101XTB") && SocketTool.HeartBeatReport) {
							myprint(out, "FE0969030200000A00CA010000"); //服务器发送回复心跳包指令
							
						//8.指令队列为空，拦截下面的比对操作
						} else if (deviceSocket.getCmdPool().isEmpty()) {
						
						//9.开、关命令应答帧
						} else if (strXML.length() >= 26 && strXML.startsWith("FE096902")
								&& "06".equals(strXML.substring(16, 18))) {
							for (SocketCmd sc : deviceSocket.getCmdPool()) {
								if (sc == null) {
									continue;
								}
								if ("0006".equals(sc.getCluster_id()) && "29".equals(sc.getCmd0())
										&& "02".equals(sc.getCmd1())) {
									if (strXML.substring(8, 14).equals(sc.getAddr_mode() + sc.getAddr_type())) {// 匹配地址
										if ("00".equals(strXML.substring(24, 26))) {// 如果操作成功, 将zigbee信息同步，更新到数据库
											//9.1如果是通过短地址发送指令
											if ("02".equals(sc.getAddr_mode())) {
												if ("FFFF".equals(sc.getAddr_type())) {// 广播地址
													zbtest = new Zigbee();
													zbtest.setDevMac(deviceSocket.getDevice().getDevMac());
													/*为页面集控器显示广播控制按钮的两种形式，修改集控器的switchStatus状态*/
													DeviceAttr devAttr = SocketTool.selectDeviceAttrByDevMac(deviceSocket.getDevice().getDevMac());
														devAttr.setZigbeeFinder(0);
													SocketTool.updateDeviceAttrByPrimaryKeySelective(devAttr);
													if ("00".equals(strXML.substring(22, 24))) {// 关指令
														zbtest.setZigbeeStatus(0);
														//修改集控器广播控制状态
														devAttr.setSwitchStatus(0);
													} else if ("01".equals(strXML.substring(22, 24))) {// 开指令
														zbtest.setZigbeeStatus(1);
														//修改集控器广播控制状态
														devAttr.setSwitchStatus(1);
													}
													SocketTool.updateZigbeeBydevMacSelectiveWhereOnline(zbtest);// 同一集控器地址的zigbee节点全部修改状态
													/*更新deviceAttr的switchStatus为最新的状态*/
													SocketTool.updateDeviceAttrByPrimaryKeySelective(devAttr);
													/*将由广播指令造成的节点更新的状态（开、关的变化）写入数据库ZigbeeStatusRecord*/
													SocketTool.insertZigbeeStatusRecordWhereOnline(zbtest);
													deviceSocket.getCmdPool().remove(sc);// 将已执行指令从池中移除
													zbtest = null;
													break;// 必须跳出循环，否则数组越界崩溃
												} else {// 非广播地址
													zbtest = checkZigbee(sc.getAddr_type());
													if (zbtest != null) {
														if ("00".equals(strXML.substring(22, 24))) {// 关指令
															zbtest.setZigbeeStatus(0);
														} else if ("01".equals(strXML.substring(22, 24))) {// 开指令
															zbtest.setZigbeeStatus(1);
														}
														SocketTool.updateZigbeeByPrimaryKeySelective(zbtest);// 更新数据库
														/*将由节点开关、调光指令造成的节点更新的状态（开、关的变化）写入数据库ZigbeeStatusRecord*/
														SocketTool.insertZigbeeStatusRecordSingleNode(zbtest);
														deviceSocket.getCmdPool().remove(sc);// 将已执行指令从池中移除
														zbtest = null;
														break;// 必须跳出循环，否则数组越界异常
													} else {// 数据库同步失败
													}
												}
											//9.2如果是通过组地址发送指令
											} else if ("01".equals(sc.getAddr_mode())) {
												grouptemp = checkGroup(deviceSocket.getDevice().getUserid(),
														sc.getAddr_type());// 获取组信息
												if (grouptemp != null) {
													String tempStr = strXML.substring(22, 24);
													zbTempList = SocketTool.selectzigbeeByGroup(grouptemp);// 获取该分组下所有zigbee节点
													for (Zigbee zb : zbTempList) {
														if (zb.getDevMac().equals(deviceSocket.getDevice().getDevMac())
																&& zb.getZigbeeNet() == 1) {// 如果zigbee节点设备mac地址与集控器mac地址相同且在线
															if ("00".equals(tempStr)) {// 关指令
																zb.setZigbeeStatus(0);
																/*为页面分组显示广播控制按钮的两种形式，修改分组的switchStatus状态*/
																//修改分组控制状态
																grouptemp.setSwitchStatus(0);
															} else if ("01".equals(tempStr)) {// 开指令
																zb.setZigbeeStatus(1);
																//修改分组控制状态
																grouptemp.setSwitchStatus(1);
															}
															// 更新数据库
															SocketTool.updateZigbeeByPrimaryKeySelective(zb);
															/*更新group的switchStatus为最新的状态*/
															SocketTool.updateGroupByPrimaryKeySelective(grouptemp);
															/*将由分组开关、调光指令造成的节点更新的状态（开、关的变化）写入数据库ZigbeeStatusRecord*/
															SocketTool.insertZigbeeStatusRecordSingleNode(zb);
														}
													}
												}
												deviceSocket.getCmdPool().remove(sc);// 将已执行指令从池中移除
												zbTempList = null;
												grouptemp = null;
												break;// 必须跳出循环，否则数组越界异常
											}
										} else {// 操作失败
										}
									} else {// 网络地址匹配失败
									}
								}
							}

							
						// 10.调光指令应答帧
						} else if (strXML.length() >= 26 && strXML.startsWith("FE09690202")
								&& "08".equals(strXML.substring(16, 18))) {// 调光命令应答帧
							for (SocketCmd sc : deviceSocket.getCmdPool()) {
								if (sc == null) {
									continue;
								}
								if ("0008".equals(sc.getCluster_id()) && "29".equals(sc.getCmd0())
										&& "02".equals(sc.getCmd1())) {
									if (strXML.substring(8, 14).equals(sc.getAddr_mode() + sc.getAddr_type())) {// 匹配地址
										if ("00".equals(strXML.substring(24, 26))) {// 如果操作成功, 将zigbee信息同步，更新到数据库
											if ("02".equals(sc.getAddr_mode())) {// 如果是通过短地址发送指令
												if ("FFFF".equals(sc.getAddr_type())) {// 广播地址
													zbtest = new Zigbee();
													zbtest.setDevMac(deviceSocket.getDevice().getDevMac());
													int brightness = Integer.valueOf(sc.getPayload().substring(0, 2),
															16);// 读取亮度
													zbtest.setZigbeeBright(brightness);
													SocketTool.updateZigbeeBydevMacSelectiveWhereOnline(zbtest);// 同一集控器地址的zigbee节点全部修改状态
													/*将由广播指令造成的节点更新的状态（亮度变化）写入数据库ZigbeeStatusRecord*/
													SocketTool.insertZigbeeStatusRecordWhereOnline(zbtest);
													deviceSocket.getCmdPool().remove(sc);// 将已执行指令从池中移除
													zbtest = null;
													break;// 必须跳出循环，否则数组越界崩溃
												} else {// 非广播地址
													zbtest = checkZigbee(sc.getAddr_type());
													if (zbtest != null) {
														int brightness = Integer
																.valueOf(sc.getPayload().substring(0, 2), 16);// 读取亮度
														zbtest.setZigbeeBright(brightness);
														SocketTool.updateZigbeeByPrimaryKeySelective(zbtest);// 更新数据库
														/*将由节点开关、调光指令造成的节点更新的状态（开、关的变化）写入数据库ZigbeeStatusRecord*/
														SocketTool.insertZigbeeStatusRecordSingleNode(zbtest);
														deviceSocket.getCmdPool().remove(sc);// 将已执行指令从池中移除
														zbtest = null;
														break;// 必须跳出循环，否则数组越界异常
													} else {// 数据库同步失败
													}
												}
											} else if ("01".equals(sc.getAddr_mode())) {// 如果是通过组地址发送指令
												grouptemp = checkGroup(deviceSocket.getDevice().getUserid(),
														sc.getAddr_type());// 获取组信息
												if (grouptemp != null) {
													int brightness = Integer.valueOf(sc.getPayload().substring(0, 2),
															16);// 读取亮度
													zbTempList = SocketTool.selectzigbeeByGroup(grouptemp);// 获取该分组下所有zigbee节点
													for (Zigbee zb : zbTempList) {
														if (zb.getDevMac().equals(deviceSocket.getDevice().getDevMac())
																&& zb.getZigbeeNet() == 1) {// 如果zigbee节点设备mac地址与集控器mac地址相同且在线，调节亮度
															zb.setZigbeeBright(brightness);
															SocketTool.updateZigbeeByPrimaryKeySelective(zb);// 更新数据库
															/*将由分组开关、调光指令造成的节点更新的状态（开、关的变化）写入数据库ZigbeeStatusRecord*/
															SocketTool.insertZigbeeStatusRecordSingleNode(zb);
														}
													}
												}
												deviceSocket.getCmdPool().remove(sc);// 将已执行指令从池中移除
												zbTempList = null;
												grouptemp = null;
												break;// 必须跳出循环，否则数组越界异常
											}
										} else {// 操作失败
										}
									} else {// 网络地址匹配失败
									}
								}
							}
						
						// 11.组控制指令应答帧FE09690301 1010 0A 0006 00 00 00
						} else if (strXML.length() >= 26 && strXML.startsWith("FE09690301")
								&& strXML.substring(14, 16).equals("0A") && strXML.endsWith("00")) {// 自定义组控制指令应答帧，非标准指令
							//11.1分组开关指令
							if (strXML.substring(16, 20).equals("0006")) {
								for (SocketCmd sc : deviceSocket.getCmdPool()) {
									if (sc == null) {
										continue;
									}
									if ("0006".equals(sc.getCluster_id()) && "29".equals(sc.getCmd0())
											&& "02".equals(sc.getCmd1()) && "01".equals(sc.getAddr_mode())
											&& strXML.substring(10, 14).equals(sc.getAddr_type())) {
										if (strXML.substring(22, 24).equals("00")) {// 成功
											grouptemp = checkGroup(deviceSocket.getDevice().getUserid(),
													sc.getAddr_type());// 获取组信息
											if (grouptemp != null) {
												String tempStr = strXML.substring(20, 22);
												zbTempList = SocketTool.selectzigbeeByGroup(grouptemp);// 获取该分组下所有zigbee节点
												if (zbTempList != null) {
													for (Zigbee zb : zbTempList) {
														if (zb.getDevMac().equals(deviceSocket.getDevice().getDevMac())
																&& zb.getZigbeeNet() == 1) {// 如果zigbee节点设备mac地址与集控器mac地址相同且在线
															if (tempStr.equals("00")) {// 关指令
																zb.setZigbeeStatus(0);
																/*修改分组控制下的广播按钮类型（ON/DIM、OFF/DIM）*/
																grouptemp.setSwitchStatus(0);
															
															} else if (tempStr.equals("01")) {// 开指令
																zb.setZigbeeStatus(1);
																grouptemp.setSwitchStatus(1);
															
															}
															SocketTool.updateZigbeeByPrimaryKeySelective(zb);// 更新数据库
															/*更新group的switchStatus为最新的状态*/
															SocketTool.updateGroupByPrimaryKeySelective(grouptemp);
															/*将由分组开关、调光指令造成的节点更新的状态（开、关的变化）写入数据库ZigbeeStatusRecord*/
															SocketTool.insertZigbeeStatusRecordSingleNode(zb);
														}
													}
												}
											}
											zbTempList = null;
											grouptemp = null;

										}

										deviceSocket.getCmdPool().remove(sc);// 将已执行指令从池中移除
										break;// 必须跳出循环，否则数组越界崩溃
									}
								}
							//11.2分组调光指令
							} else if (strXML.substring(16, 20).equals("0008")) {
								for (SocketCmd sc : deviceSocket.getCmdPool()) {
									if (sc == null) {
										continue;
									}
									if ("0008".equals(sc.getCluster_id()) && "29".equals(sc.getCmd0())
											&& "02".equals(sc.getCmd1()) && "01".equals(sc.getAddr_mode())
											&& strXML.substring(10, 14).equals(sc.getAddr_type())) {
										if (strXML.substring(22, 24).equals("00")) {// 成功?
											grouptemp = checkGroup(deviceSocket.getDevice().getUserid(),
													sc.getAddr_type());// 获取组信息
											if (grouptemp != null) {
												int brightness = Integer.valueOf(strXML.substring(20, 22), 16);
												zbTempList = SocketTool.selectzigbeeByGroup(grouptemp);// 获取该分组下所有zigbee节点
												for (Zigbee zb : zbTempList) {
													if (zb.getDevMac().equals(deviceSocket.getDevice().getDevMac())
															&& zb.getZigbeeNet() == 1) {// 如果zigbee节点设备mac地址与集控器mac地址相同且在线，调节亮度
														zb.setZigbeeBright(brightness);
														SocketTool.updateZigbeeByPrimaryKeySelective(zb);// 更新数据库
														/*将由分组开关、调光指令造成的节点更新的状态（调光的变化）写入数据库ZigbeeStatusRecord*/
														SocketTool.insertZigbeeStatusRecordSingleNode(zb);
													}
												}
											}
											zbTempList = null;
											grouptemp = null;

										}
										deviceSocket.getCmdPool().remove(sc);// 将已执行指令从池中移除
										break;// 必须跳出循环，否则数组越界崩溃
									}
								}
							}
							
							
						// 12.自定义广播指令应答帧	
						} else if (strXML.length() >= 26 && strXML.startsWith("FE09690302FFFF0A")
								&& strXML.endsWith("00")) {// 自定义广播指令应答帧，非标准指令
							if (strXML.substring(16, 20).equals("0006")) {// 广播开关应答帧
								for (SocketCmd sc : deviceSocket.getCmdPool()) {
									if (sc == null) {
										continue;
									}
									if ("0006".equals(sc.getCluster_id()) && "29".equals(sc.getCmd0())
											&& "02".equals(sc.getCmd1()) && "02".equals(sc.getAddr_mode())
											&& "FFFF".equals(sc.getAddr_type())) { //自定义广播开关
										if (strXML.substring(22, 24).equals("00")) {// 成功?
											zbtest = new Zigbee();
											zbtest.setDevMac(deviceSocket.getDevice().getDevMac());
											/*为页面集控器显示广播控制按钮的两种形式，修改集控器的switchStatus状态*/
											DeviceAttr deviceAttr = SocketTool.selectDeviceAttrByDevMac(deviceSocket.getDevice().getDevMac());
											/**/
											if (strXML.substring(20, 22).equals("00")) {// 关指令
												zbtest.setZigbeeStatus(0);
												//修改集控器switchStstus状态
												deviceAttr.setSwitchStatus(0);
												
											} else if (strXML.substring(20, 22).equals("01")) {// 开指令
												zbtest.setZigbeeStatus(1);
												//修改集控器switchStstus状态
												deviceAttr.setSwitchStatus(1);
												
											}
											SocketTool.updateZigbeeBydevMacSelectiveWhereOnline(zbtest);// 同一集控器地址的zigbee节点全部修改状态
											/*更新deviceAttr的switchStatus为最新的状态*/
											SocketTool.updateDeviceAttrByPrimaryKeySelective(deviceAttr);
											/*将由广播指令造成的节点更新的状态（亮度变化）写入数据库ZigbeeStatusRecord*/
											SocketTool.insertZigbeeStatusRecordWhereOnline(zbtest);
											zbtest = null;

										}

										deviceSocket.getCmdPool().remove(sc);// 将已执行指令从池中移除
										break;// 必须跳出循环，否则数组越界崩溃
									}
								}
							} else if (strXML.substring(16, 20).equals("0008")) {// 广播调光应答帧
								for (SocketCmd sc : deviceSocket.getCmdPool()) {
									if (sc == null) {
										continue;
									}
									if ("0008".equals(sc.getCluster_id()) && "29".equals(sc.getCmd0())
											&& "02".equals(sc.getCmd1()) && "02".equals(sc.getAddr_mode())
											&& "FFFF".equals(sc.getAddr_type())) {// 匹配指令
										if (strXML.substring(22, 24).equals("00")) {// 成功?
											zbtest = new Zigbee();
											zbtest.setDevMac(deviceSocket.getDevice().getDevMac());
											int brightness = Integer.valueOf(strXML.substring(20, 22), 16);
											zbtest.setZigbeeBright(brightness);
											SocketTool.updateZigbeeBydevMacSelectiveWhereOnline(zbtest);// 同一集控器地址的zigbee节点全部修改状态
											/*将由广播指令造成的节点更新的状态（亮度变化）写入数据库ZigbeeStatusRecord*/
											SocketTool.insertZigbeeStatusRecordWhereOnline(zbtest);
											zbtest = null;

										}
										deviceSocket.getCmdPool().remove(sc);// 将已执行指令从池中移除
										break;// 必须跳出循环，否则数组越界崩溃
									}
								}
							}
							
						// 13.节点添加到分组应答帧	
						} else if (strXML.length() >= 26 && strXML.startsWith("FE09690202")
								&& strXML.substring(14, 24).equals("0A04000100")) {// 添加分组应答帧
							for (SocketCmd sc : deviceSocket.getCmdPool()) {
								if (sc == null) {
									continue;
								}
								if ("0004".equals(sc.getCluster_id()) && "29".equals(sc.getCmd0())
										&& "02".equals(sc.getCmd1()) && "00".equals(sc.getCmd_id())) {
									if (strXML.substring(8, 14).equals(sc.getAddr_mode() + sc.getAddr_type())) {// 匹配地址
										if (strXML.substring(24, 26).equals("00")
												|| strXML.substring(24, 26).equals("8A")) {// 如果操作成功, 将zigbee信息同步，更新到数据库
											if ("02".equals(sc.getAddr_mode())) {// 如果是通过短地址发送指令
												if ("FFFF".equals(sc.getAddr_type())) {// 广播地址
												} else {// 非广播地址
													zbtest = checkZigbee(sc.getAddr_type());
													grouptemp = checkGroup(deviceSocket.getDevice().getUserid(),
															sc.getPayload().substring(0, 4));
													if (grouptemp != null && zbtest != null) {
														gp = new GroupPair();
														gp.setGroupid(grouptemp.getGroupid());
														gp.setZigbeeMac(zbtest.getZigbeeMac());
														gp.setUserid(grouptemp.getUserid());
														SocketTool.insertGroupPair(gp);
														deviceSocket.getCmdPool().remove(sc);// 将已执行指令从池中移除
														zbtest = null;
														grouptemp = null;
														break;
													} else {// 数据库同步失败
													}
												}
											}
										} else {// 操作失败
										}
									} else {// 网络地址匹配失败
									}
								}
							}
							
					    //13.节点从分组中删除应答帧
						} else if (strXML.length() >= 26 && strXML.startsWith("FE09690202")
								&& (strXML.substring(14, 24).equals("0A04000103")
										|| strXML.substring(14, 24).equals("0A04000104"))) {// 删除分组应答帧
							for (SocketCmd sc : deviceSocket.getCmdPool()) {
								if (sc == null) {
									continue;
								}
								if ("0004".equals(sc.getCluster_id()) && "29".equals(sc.getCmd0())
										&& "02".equals(sc.getCmd1()) && "03".equals(sc.getCmd_id())) {
									if (strXML.substring(8, 14).equals(sc.getAddr_mode() + sc.getAddr_type())) {// 匹配地址
										if (strXML.substring(24, 26).equals("00")) {// 如果操作成功, 将zigbee信息同步，更新到数据库
											if ("02".equals(sc.getAddr_mode())) {// 如果是通过短地址发送指令
												if ("FFFF".equals(sc.getAddr_type())) {// 广播地址
												} else {// 非广播地址
													zbtest = checkZigbee(sc.getAddr_type());
													grouptemp = checkGroup(deviceSocket.getDevice().getUserid(),
															sc.getPayload().substring(0, 4));
													if (grouptemp != null && zbtest != null) {
														gp = SocketTool.selectGroupPairByUseridAndGroupidAndZigbeeMac(
																grouptemp.getUserid(), grouptemp.getGroupid(),
																zbtest.getZigbeeMac());
														if (gp != null) {
															SocketTool.removeGroupPairByid(gp.getId());
														}
														deviceSocket.getCmdPool().remove(sc);// 将已执行指令从池中移除
														zbtest = null;
														grouptemp = null;
														break;
													} else {// 数据库同步失败
													}
												}
											}
										}
									}
								}
							}
							
						//14.集控器允许打开节点加入网络应答帧	
						} else if (strXML.length() >= 26 && strXML.startsWith("FE0969030200000A00CA05")) {// 开启节点发现命令帧
							for (SocketCmd sc : deviceSocket.getCmdPool()) {
								if (sc == null) {
									continue;
								}
								if (strXML.equals(sc.getCmdString())) {// 命令匹配成功
									int seconds = Integer.parseInt(strXML.substring(24, 26), 16);
									if (seconds == 0) {// 关闭发现
										// 修改数据库状态为0
										DeviceAttr devAttr = SocketTool
												.selectDeviceAttrByDevMac(deviceSocket.getDevice().getDevMac());
										if (devAttr != null) {
											devAttr.setZigbeeFinder(0);
											SocketTool.updateDeviceAttrByPrimaryKeySelective(devAttr);
										}
									} else {// 开启发现
										// 修改数据库状态为1
										DeviceAttr devAttr = SocketTool
												.selectDeviceAttrByDevMac(deviceSocket.getDevice().getDevMac());
										if (devAttr != null) {
											devAttr.setZigbeeFinder(1);
											SocketTool.updateDeviceAttrByPrimaryKeySelective(devAttr);
										}
										// 开新定时器线程计时，超 seconds 计时后修改数据库状态为0
										new Timer().schedule(new TimerTask() {
											private DeviceAttr myDeviceAttr = devAttr;
											public void run() {
												myDeviceAttr.setZigbeeFinder(0);
												SocketTool.updateDeviceAttrByPrimaryKeySelective(myDeviceAttr);
												this.cancel();
											}
										}, 1000 * seconds);// 毫秒
									}
									deviceSocket.getCmdPool().remove(sc);// 将已执行指令从池中移除
									break;
								} else if (strXML.substring(24, 26).equals(sc.getCmdString().substring(24, 26))) {// 命令接受成功，执行失败

								}
							}
						} else {// 未识别的命令码头，返回错误
							out.print("error: Unrecognized command header");// 命令头无法识别
							out.flush();
						}
					}//for循环
					
					
				}//内层while
				
				
				break;

			}//外层while

		} catch (IOException ex) {

		} finally {
			try {

				if (timer != null) {
					timer.cancel();// 定时器关闭
				}

				SocketTool.socketList.remove(deviceSocket);// 将socket从list中删除，防判断出错
				if (deviceSocket.getDevice().getDevMac() != null) {
					for (DeviceSocket ds : SocketTool.socketList) {
						if (ds.getDevice().getDevMac() != null
								&& ds.getDevice().getDevMac().equals(deviceSocket.getDevice().getDevMac())) {
							deviceSocket.getSocket().close();
							System.out.println("socket stop......");
							log.info("socket stop......");
							return;
						}
					}
					deviceSocket.getDevice().setDevNet(0);// 更新设备网络状态
					SocketTool.updateDeviceData(deviceSocket.getDevice());// 更新数据库
				}

				deviceSocket.getSocket().close();
				log.info("socket stop......");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	
}