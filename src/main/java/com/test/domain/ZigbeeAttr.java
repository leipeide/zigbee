package com.test.domain;

public class ZigbeeAttr {
	/*
	 *节点mac地址，主键
	 */
	private String zigbeeMac;
	/*
	 * 灯具当前使用的软件版本号 
	 */
	private String version;
	/*
	 * 节点类型，具体参照layui界面异步数据接口文档.md附表1
	 */
	private Integer type;
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
	 * 最小功率
	 */
	private Integer minPower;
	//param1-5为预留参数，暂时未用到
	private String param1;

	private String param2;

	private String param3;

	private String param4;

	private String param5;

	public String getZigbeeMac() {
		return zigbeeMac;
	}

	public void setZigbeeMac(String zigbeeMac) {
		this.zigbeeMac = zigbeeMac == null ? null : zigbeeMac.trim();
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version == null ? null : version.trim();
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

	public String getParam1() {
		return param1;
	}

	public void setParam1(String param1) {
		this.param1 = param1 == null ? null : param1.trim();
	}

	public String getParam2() {
		return param2;
	}

	public void setParam2(String param2) {
		this.param2 = param2 == null ? null : param2.trim();
	}

	public String getParam3() {
		return param3;
	}

	public void setParam3(String param3) {
		this.param3 = param3 == null ? null : param3.trim();
	}

	public String getParam4() {
		return param4;
	}

	public void setParam4(String param4) {
		this.param4 = param4 == null ? null : param4.trim();
	}

	public String getParam5() {
		return param5;
	}

	public void setParam5(String param5) {
		this.param5 = param5 == null ? null : param5.trim();
	}
}