package com.test.domain;

import java.util.List;

/**
 * 用于layui中table模块的数据模型
 * 创建日期：2019-06-03
 * @author mingxin
 *
 */
public class LayuiTableModel {
	private Integer code; // 解析接口状态
	private String msg; // 解析提示文本
	private Integer count; // 解析数据长度
	private List<Object> data; // 解析数据列表
	
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public List<Object> getData() {
		return data;
	}
	public void setData(List<Object> data) {
		this.data = data;
	}
	
}
