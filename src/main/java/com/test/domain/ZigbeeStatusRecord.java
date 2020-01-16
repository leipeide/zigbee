package com.test.domain;

import java.util.Date;

public class ZigbeeStatusRecord {
	//1.节点状态记录类型cmd:用户发送指令导致状态改变
	public static String RECORD_TYPE_CMD = "cmd";
	//2.节点状态记录类型update：集控器主动上报节点状态的改变
	public static String RECORD_TYPE_UPDATE = "update";
	/*
	 * 节点状态信息记录id,主键
	 */
	private Integer id;
	/*
	 * 记录时间 
	 */
	private Date date; 
	/*
	 * 节点状态记录类型：
	 * cmd(用户发送指令导致状态改变)
	 * update(集控器主动上报节点状态改变)
	 */
	private String recordType;
	/*
	 * 集控器mac地址
	 */
	private String devMac;
	/*
	 * 节点地址
	 */
	private String zigbeeMac;
	/*
	 * 节点功率百分比
	 */
	private Integer zigbeeBright;
	 /*
     * 节点开关状态，1为开灯，0为关灯
     */
    private Integer zigbeeStatus;
    /*
	 * 节点类型，具体参照layui界面异步数据接口文档.md附表1
	 */
	private Integer zigbeeType;
	/*
	 * 温度传感器记录，放大100倍的结果
	 */
	private Integer temperature;
	/*
	 * 湿度传感器记录，放大100倍的结果
	 */
	private Integer humidity;
	/*
	 * 额定功率
	 */
	private Integer power;
	/*
	 * 预留参数
	 */
	private String param1;
	/*
	 * 预留参数
	 */
	private String param2;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getRecordType() {
		return recordType;
	}
	public void setRecordType(String recordType) {
		this.recordType = recordType;
	}
	public String getDevMac() {
		return devMac;
	}
	public void setDevMac(String devMac) {
		this.devMac = devMac;
	}
	public String getZigbeeMac() {
		return zigbeeMac;
	}
	public void setZigbeeMac(String zigbeeMac) {
		this.zigbeeMac = zigbeeMac;
	}
	public Integer getZigbeeBright() {
		return zigbeeBright;
	}
	public void setZigbeeBright(Integer zigbeeBright) {
		this.zigbeeBright = zigbeeBright;
	}
	public Integer getZigbeeStatus() {
		return zigbeeStatus;
	}
	public void setZigbeeStatus(Integer zigbeeStatus) {
		this.zigbeeStatus = zigbeeStatus;
	}
	public Integer getZigbeeType() {
		return zigbeeType;
	}
	public void setZigbeeType(Integer zigbeeType) {
		this.zigbeeType = zigbeeType;
	}
	public Integer getTemperature() {
		return temperature;
	}
	public void setTemperature(Integer temperature) {
		this.temperature = temperature;
	}
	public Integer getHumidity() {
		return humidity;
	}
	public void setHumidity(Integer humidity) {
		this.humidity = humidity;
	}
	public Integer getPower() {
		return power;
	}
	public void setPower(Integer power) {
		this.power = power;
	}
	public String getParam1() {
		return param1;
	}
	public void setParam1(String param1) {
		this.param1 = param1;
	}
	public String getParam2() {
		return param2;
	}
	public void setParam2(String param2) {
		this.param2 = param2;
	}
	@Override
	public String toString() {
		return "ZigbeeStatusRecord [id=" + id + ", date=" + date + ", recordType=" + recordType + ", devMac=" + devMac
				+ ", zigbeeMac=" + zigbeeMac + ", zigbeeBright=" + zigbeeBright + ", zigbeeStatus=" + zigbeeStatus
				+ ", zigbeeType=" + zigbeeType + ", temperature=" + temperature + ", humidity=" + humidity + ", power="
				+ power + ", param1=" + param1 + ", param2=" + param2 + "]";
	}
	

}
