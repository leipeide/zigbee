package com.test.domain;

public class PloyOperate {
	/*
	 * 策略操作id,主键
	 */
    private Integer id;
    /*
     * 策略id
     */
    private Integer ployid;
    /*
     * 日期参数，实际未使用
     */
    private String date;
    /*
     * GMT时间的小时数      
     */
    private Integer hours;
    /*
     * GMT时间的分钟
     */
    private Integer minutes;
    /*
     * 1为开关灯、2为调光
     */
    private Integer operateType;
    /*
     * operateType为1时，为开光灯状态：
     * 当为开灯状态时，operateParam为1；当未关灯状态时，operateParam为0；
     * 当operateType为2时，为调光状态，operateParam值为参数值
     */
    private Integer operateParam;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPloyid() {
        return ployid;
    }

    public void setPloyid(Integer ployid) {
        this.ployid = ployid;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date == null ? null : date.trim();
    }

    public Integer getHours() {
        return hours;
    }

    public void setHours(Integer hours) {
        this.hours = hours;
    }

    public Integer getMinutes() {
        return minutes;
    }

    public void setMinutes(Integer minutes) {
        this.minutes = minutes;
    }

    public Integer getOperateType() {
        return operateType;
    }

    public void setOperateType(Integer operateType) {
        this.operateType = operateType;
    }

    public Integer getOperateParam() {
        return operateParam;
    }

    public void setOperateParam(Integer operateParam) {
        this.operateParam = operateParam;
    }

	@Override
	public String toString() {
		return "PloyOperate [id=" + id + ", ployid=" + ployid + ", date=" + date + ", hours=" + hours + ", minutes="
				+ minutes + ", operateType=" + operateType + ", operateParam=" + operateParam + "]";
	}
}