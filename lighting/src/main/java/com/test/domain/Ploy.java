package com.test.domain;

public class Ploy {
    private Integer id;

    private Integer userid;

    private String ployName;

    private Integer status;
    //可以绑定控制器，可以绑定分组，目前只用到绑定分组
    private Integer bindType;
    //
    private String bindData;
    //该属性没有用到
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