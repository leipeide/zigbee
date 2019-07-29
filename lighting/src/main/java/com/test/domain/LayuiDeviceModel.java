package com.test.domain;

public class LayuiDeviceModel {

	private String devMac;

	private String devName;

	private Integer devNet;

	private Integer userid;

	private String gprsPhone;

	private Integer zigbeeFinder;

	private Integer devType;

	private Integer devVersion;

	private String devIp;

	private Integer onlineNodes;

	private Integer offlineNodes;
	
	private Integer nodesNumber;
	//集控器广播控制节点的开关灯标志位，1为开灯，0为关灯
	private Integer switchStatus;

	public LayuiDeviceModel() {
		super();
		// TODO Auto-generated constructor stub
	}

	public LayuiDeviceModel(Device device, DeviceAttr deviceAttr) {
		super();
		
		this.setDevMac(device.getDevMac());
		this.setDevName(device.getDevName());
		this.setDevNet(device.getDevNet());
		this.setUserid(device.getUserid());
		this.setGprsPhone(device.getGprsPhone());

		this.setDevIp(deviceAttr.getDevIp());
		this.setDevType(deviceAttr.getDevType());
		this.setDevVersion(deviceAttr.getDevVersion());
		this.setZigbeeFinder(deviceAttr.getZigbeeFinder());
		this.setSwitchStatus(deviceAttr.getSwitchStatus());
	}

	public Integer getOnlineNodes() {
		return onlineNodes;
	}

	public void setOnlineNodes(Integer onlineNodes) {
		this.onlineNodes = onlineNodes;
	}

	public Integer getOfflineNodes() {
		return offlineNodes;
	}

	public void setOfflineNodes(Integer offlineNodes) {
		this.offlineNodes = offlineNodes;
	}

	public String getDevMac() {
		return devMac;
	}

	public void setDevMac(String devMac) {
		this.devMac = devMac;
	}

	public String getDevName() {
		return devName;
	}

	public void setDevName(String devName) {
		this.devName = devName;
	}

	public Integer getDevNet() {
		return devNet;
	}

	public void setDevNet(Integer devNet) {
		this.devNet = devNet;
	}

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public String getGprsPhone() {
		return gprsPhone;
	}

	public void setGprsPhone(String gprsPhone) {
		this.gprsPhone = gprsPhone;
	}

	public Integer getZigbeeFinder() {
		return zigbeeFinder;
	}

	public void setZigbeeFinder(Integer zigbeeFinder) {
		this.zigbeeFinder = zigbeeFinder;
	}

	public Integer getDevType() {
		return devType;
	}

	public void setDevType(Integer devType) {
		this.devType = devType;
	}

	public Integer getDevVersion() {
		return devVersion;
	}

	public void setDevVersion(Integer devVersion) {
		this.devVersion = devVersion;
	}

	public String getDevIp() {
		return devIp;
	}

	public void setDevIp(String devIp) {
		this.devIp = devIp;
	}

	public Integer getNodesNumber() {
		return nodesNumber;
	}

	public void setNodesNumber(Integer nodesNumber) {
		this.nodesNumber = nodesNumber;
	}

	public Integer getSwitchStatus() {
		return switchStatus;
	}

	public void setSwitchStatus(Integer switchStatus) {
		this.switchStatus = switchStatus;
	}

}
