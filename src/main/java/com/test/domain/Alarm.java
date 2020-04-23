package com.test.domain;

import java.util.Date;

import javax.persistence.Column;

public class Alarm {
	/**
	 * 异常报警原因：
	 * 1. 连接失败
	 */
	public static final int ALARM_DISCONNECT = 1;
	/**
	 * 报警id，primary key
	 */
	private Integer id;
	/**
	 * 报警时间.(报警信息生成的时间)
	 */
	private Date date;
	/**
	 * 集控器设备的mac地址
	 */
	private String devMac;
	/**
	 * 报警的节点地址
	 */
	private String zigbeeMac;
	/**
	 * 报警信息类型
	 */
	private Integer type;
	/**
	 * 用户id
	 */
	private Integer userid;
	/**
	 * 报警参数：可根据报警类型定义，超时报警时，paramter为空
	 * 如功率报警：功率；
	 * 温度报警：温度
	 */
	private String paramter;
	
	public Alarm() {
		super();
	}
	
	public Alarm(Date date, String deviceMac, String zigbeeMac, int type,int userid,String paramter) {
		super();
		this.setDate(date);
		this.setDevMac(deviceMac);
		this.setZigbeeMac(zigbeeMac);
		this.setType(type);
		this.setUserid(userid);
		this.setParamter(paramter);

	}

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

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public String getParamter() {
		return paramter;
	}

	public void setParamter(String paramter) {
		this.paramter = paramter;
	}

	@Override
	public String toString() {
		return "Alarm [id=" + id + ", date=" + date + ", devMac=" + devMac + ", zigbeeMac=" + zigbeeMac + ", type="
				+ type + ", userid=" + userid + ", paramter=" + paramter + "]";
	}





	
}
