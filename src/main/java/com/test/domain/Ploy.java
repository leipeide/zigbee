package com.test.domain;

public class Ploy {
	/*
	 * 主键，策略id
	 */
    private Integer id;
    /*
     * 策略绑定的用户id
     */
    private Integer userid;
    /*
     * 策略名称
     */
    private String ployName;
    /*
     * 策略执行状态，0未执行，1正在执行
     */
    private Integer status;
    /*
     * 绑定类型，目前只用到绑定分组
     * 1绑定为控制组，2绑定为集控器，3绑定为节点     
     */
    private Integer bindType;
    /*
     * 绑定类型为1时，数据为groupid；其他为设备mac地址
     */
    private String bindData;
    /*
     * 创建策略时，用户所在时区和GMT时间差值，单位分钟。暂无使用，为冗余数据
     */
    private Integer timeZone;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getPloyName() {
        return ployName;
    }

    public void setPloyName(String ployName) {
        this.ployName = ployName == null ? null : ployName.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getBindType() {
        return bindType;
    }

    public void setBindType(Integer bindType) {
        this.bindType = bindType;
    }

    public String getBindData() {
        return bindData;
    }

    public void setBindData(String bindData) {
        this.bindData = bindData == null ? null : bindData.trim();
    }

    public Integer getTimeZone() {
        return timeZone;
    }

    public void setTimeZone(Integer timeZone) {
        this.timeZone = timeZone;
    }
}