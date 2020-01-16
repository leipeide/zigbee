package com.test.domain;

public class Group {
	/*
	 * 分组id
	 */
    private Integer groupid;
    /*
     * 分组名称
     */
    private String groupName;
    /*
     * 分组绑定的用户id
     */
    private Integer userid;
    /*
     * 分组控制节点开关灯的标志位，1为开，0为关,
     */
    private Integer switchStatus;
    
    public Integer getGroupid() {
        return groupid;
    }

    public void setGroupid(Integer groupid) {
        this.groupid = groupid;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName == null ? null : groupName.trim();
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

	public Integer getSwitchStatus() {
		return switchStatus;
	}

	public void setSwitchStatus(Integer switchStatus) {
		this.switchStatus = switchStatus;
	}

	@Override
	public String toString() {
		return "Group [groupid=" + groupid + ", groupName=" + groupName + ", userid=" + userid + ", switchStatus="
				+ switchStatus + "]";
	}

}