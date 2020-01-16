package com.test.domain;

public class Device {
	/*
	 * 集控器mac地址，主键，唯一
	 */
    private String devMac;
    /*
     * 集控器名称
     */
    private String devName;
    /*
     * 集控器网络
     */
    private Integer devNet;
    /*
     * 集控器绑定的用户id
     */
    private Integer userid;
    /*
     * 设备sim卡电话号码
     */
    private String gprsPhone;
    
    public String getDevMac() {
        return devMac;
    }

    public void setDevMac(String devMac) {
        this.devMac = devMac == null ? null : devMac.trim();
    }

    public String getDevName() {
        return devName;
    }

    public void setDevName(String devName) {
        this.devName = devName == null ? null : devName.trim();
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
        this.gprsPhone = gprsPhone == null ? null : gprsPhone.trim();
    }

	@Override
	public String toString() {
		return "Device [devMac=" + devMac + ", devName=" + devName + ", devNet=" + devNet + ", userid=" + userid
				+ ", gprsPhone=" + gprsPhone + "]";
	}
}