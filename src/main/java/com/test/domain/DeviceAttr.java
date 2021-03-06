package com.test.domain;

public class DeviceAttr {
	/*
	 * 集控器mac地址，主键，唯一
	 */
    private String devMac;
    /*
     * 集控器发现节点状态，1是发现节点状态，0是未发现节点状态
     */
    private Integer zigbeeFinder;
    
    private Integer devType;

    private Integer devVersion;

    private String devIp;
    /*
     * 集控器广播控制节点的开关灯标志位，1为开灯，0为关灯
     */
    private Integer switchStatus;
    
    private String param1;
    
    private String param2;

    private String param3;

    private String param4;
    
    public String getDevMac() {
        return devMac;
    }

    public void setDevMac(String devMac) {
        this.devMac = devMac == null ? null : devMac.trim();
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
        this.devIp = devIp == null ? null : devIp.trim();
    }
    
    public Integer getSwitchStatus() {
        return switchStatus;
    }

    public void setSwitchStatus(Integer switchStatus) {
        this.switchStatus = switchStatus;
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
}