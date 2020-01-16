package com.test.domain;

public class GroupPair {
	/*
	 * 主键id,
	 */
    private Integer id;
    /*
     * 绑定Group的分组id
     */
    private Integer groupid;
    /*
     * 节点mac地址
     */
    private String zigbeeMac;
    /*
     * 用户id
     */
    private Integer userid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getGroupid() {
        return groupid;
    }

    public void setGroupid(Integer groupid) {
        this.groupid = groupid;
    }

    public String getZigbeeMac() {
        return zigbeeMac;
    }

    public void setZigbeeMac(String zigbeeMac) {
        this.zigbeeMac = zigbeeMac == null ? null : zigbeeMac.trim();
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

	@Override
	public String toString() {
		return "GroupPair [id=" + id + ", groupid=" + groupid + ", zigbeeMac=" + zigbeeMac + ", userid=" + userid + "]";
	}
}