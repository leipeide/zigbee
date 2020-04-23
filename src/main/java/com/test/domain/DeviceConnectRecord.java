package com.test.domain;

import java.util.Date;
/**
 * 集控器链接服务器和断开服务器时间记录。
 *
 */
public class DeviceConnectRecord {
		/**
		 * primary key
		 */
		private int id;
		/**
		 * 时间
		 */
		private Date date;
		/**
		 * 集控器mac地址
		 */
		private String deviceMac;
		/**
		 * 操作
		 * 成功连接为true
		 * 连接断开为false
		 */
		private boolean connection;
		/**
		 * 用户id
		 */
		private int userid;
		/**
		 * 预留参数，暂未使用
		 */
		private String param1;
		
		public DeviceConnectRecord() {
			super();
		}
		
		public DeviceConnectRecord(String deviceMac, Date date, boolean connection, int userid, String param1) {
			super();
			this.deviceMac = deviceMac;
			this.date = date;
			this.connection = connection;
			this.userid = userid;
			this.param1 = param1;
		}
		
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public Date getDate() {
			return date;
		}
		public void setDate(Date date) {
			this.date = date;
		}
		public String getDeviceMac() {
			return deviceMac;
		}
		public void setDeviceMac(String deviceMac) {
			this.deviceMac = deviceMac;
		}
		public boolean isConnection() {
			return connection;
		}
		public void setConnection(boolean connection) {
			this.connection = connection;
		}
		
		public int getUserid() {
			return userid;
		}

		public void setUserid(int userid) {
			this.userid = userid;
		}

		public String getParam1() {
			return param1;
		}
		public void setParam1(String param1) {
			this.param1 = param1;
		}

		@Override
		public String toString() {
			return "DeviceConnectRecord [id=" + id + ", date=" + date + ", deviceMac=" + deviceMac + ", connection="
					+ connection + ", userid=" + userid + ", param1=" + param1 + "]";
		}

		
		
}
