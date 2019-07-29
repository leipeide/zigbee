package com.test.domain;

public class LayuiZigbeeModel {

	private String zigbeeMac;

	private String zigbeeName;

	private Integer zigbeeNet;

	private Integer zigbeeBright;

	private Integer zigbeeStatus;

	private String zigbeeSaddr;

	private String devMac;

	private String version;

	private Integer type;

	private Integer temperature;

	private Integer humidity;

	private Integer power;

	private Integer minPower;

	public LayuiZigbeeModel() {
		super();
	}

	public LayuiZigbeeModel(Zigbee zigbee, ZigbeeAttr zigbeeAttr) {
		super();
		if (zigbee != null) {
			this.setZigbeeMac(zigbee.getZigbeeMac());
			this.setZigbeeName(zigbee.getZigbeeName());
			this.setZigbeeNet(zigbee.getZigbeeNet());
			this.setZigbeeBright(zigbee.getZigbeeBright());
			this.setZigbeeStatus(zigbee.getZigbeeStatus());
			this.setZigbeeSaddr(zigbee.getZigbeeSaddr());
			this.setDevMac(zigbee.getDevMac());
		}
		if (zigbeeAttr != null) {
			this.setVersion(zigbeeAttr.getVersion());
			this.setType(zigbeeAttr.getType());
			this.setTemperature(zigbeeAttr.getTemperature());
			this.setHumidity(zigbeeAttr.getHumidity());
			this.setPower(zigbeeAttr.getPower());
			this.setMinPower(zigbeeAttr.getMinPower());
		}

	}

	public String getZigbeeMac() {
		return zigbeeMac;
	}

	public void setZigbeeMac(String zigbeeMac) {
		this.zigbeeMac = zigbeeMac;
	}

	public String getZigbeeName() {
		return zigbeeName;
	}

	public void setZigbeeName(String zigbeeName) {
		this.zigbeeName = zigbeeName;
	}

	public Integer getZigbeeNet() {
		return zigbeeNet;
	}

	public void setZigbeeNet(Integer zigbeeNet) {
		this.zigbeeNet = zigbeeNet;
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

	public String getZigbeeSaddr() {
		return zigbeeSaddr;
	}

	public void setZigbeeSaddr(String zigbeeSaddr) {
		this.zigbeeSaddr = zigbeeSaddr;
	}

	public String getDevMac() {
		return devMac;
	}

	public void setDevMac(String devMac) {
		this.devMac = devMac;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
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

	public Integer getMinPower() {
		return minPower;
	}

	public void setMinPower(Integer minPower) {
		this.minPower = minPower;
	}

	@Override
	public String toString() {
		return "LayuiZigbeeModel [zigbeeMac=" + zigbeeMac + ", zigbeeName=" + zigbeeName + ", zigbeeNet=" + zigbeeNet
				+ ", zigbeeBright=" + zigbeeBright + ", zigbeeStatus=" + zigbeeStatus + ", zigbeeSaddr=" + zigbeeSaddr
				+ ", devMac=" + devMac + ", version=" + version + ", type=" + type + ", temperature=" + temperature
				+ ", humidity=" + humidity + ", power=" + power + ", minPower=" + minPower + "]";
	}

}
