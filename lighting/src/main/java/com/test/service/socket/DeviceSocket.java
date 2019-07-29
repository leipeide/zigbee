package com.test.service.socket;

import java.net.Socket;
import java.util.ArrayList;

import com.test.domain.Device;

public class DeviceSocket {
	
	private Device device;
	private Socket socket;

	private ArrayList<SocketCmd> cmdPool = new ArrayList<>();
	
	public Device getDevice() {
		return device;
	}
	public void setDevice(Device device) {
		this.device = device;
	}
	public Socket getSocket() {
		return socket;
	}
	public void setSocket(Socket socket) {
		this.socket = socket;
	}
	public DeviceSocket() {
		super();
		this.device = new Device();
		// TODO Auto-generated constructor stub
	}
	//指令池：存储指令，依次处理，处理完后删除（超时未回复删除，收到回复后删除）
	public ArrayList<SocketCmd> getCmdPool() {
		return cmdPool;
	}
	public void setCmdPool(ArrayList<SocketCmd> cmdPool) {
		this.cmdPool = cmdPool;
	}
	@Override
	public String toString() {
		return "DeviceSocket [DeviceMac=" + device + ", socket=" + socket + "]";
	}
}
