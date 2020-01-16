package com.test.domain;

import java.util.Date;

public class UnusualTemperature {
	/*
	 * id,主键，唯一
	 */
    private Integer id;
    /*
     * 节点mac地址
     */
    private String zigbeeMac;
    /*
     * 记录异常温度的时间
     */
    private Date date;
    /*
     * 温度参数
     */
    private Float temperature;
    /*
     * 湿度参数
     */
    private Float humidity;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getZigbeeMac() {
        return zigbeeMac;
    }

    public void setZigbeeMac(String zigbeeMac) {
        this.zigbeeMac = zigbeeMac == null ? null : zigbeeMac.trim();
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Float getTemperature() {
        return temperature;
    }

    public void setTemperature(Float temperature) {
        this.temperature = temperature;
    }

    public Float getHumidity() {
        return humidity;
    }

    public void setHumidity(Float humidity) {
        this.humidity = humidity;
    }
}