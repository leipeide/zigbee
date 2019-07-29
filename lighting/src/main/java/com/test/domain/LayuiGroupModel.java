package com.test.domain;

public class LayuiGroupModel {
	
	private Integer groupid;

    private String groupName;

    private Integer userid;
    
    private int offlineNodes;
    
    private int onlineNodes;

    //分组控制节点开关灯的标志位，1为开，0为关
    private Integer switchStatus;
    
	public LayuiGroupModel() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public LayuiGroupModel(Group group) {
		super();
		this.setGroupid(group.getGroupid());
		this.setGroupName(group.getGroupName());
		this.setUserid(group.getUserid());
		this.setSwitchStatus(group.getSwitchStatus());
	}

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
		this.groupName = groupName;
	}

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public int getOfflineNodes() {
		return offlineNodes;
	}

	public void setOfflineNodes(int offlineNodes) {
		this.offlineNodes = offlineNodes;
	}

	public int getOnlineNodes() {
		return onlineNodes;
	}

	public void setOnlineNodes(int onlineNodes) {
		this.onlineNodes = onlineNodes;
	}

	public Integer getSwitchStatus() {
		return switchStatus;
	}

	public void setSwitchStatus(Integer switchStatus) {
		this.switchStatus = switchStatus;
	}

	@Override
	public String toString() {
		return "LayuiGroupModel [groupid=" + groupid + ", groupName=" + groupName + ", userid=" + userid
				+ ", offlineNodes=" + offlineNodes + ", onlineNodes=" + onlineNodes + ", switchStatus=" + switchStatus
				+ "]";
	}
	
}
