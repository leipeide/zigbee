package com.test.domain;

public class Zigbee {
	/*
	 * 生产时写入设备的地址，是全球唯一固定的地址
	 */
    private String zigbeeMac;
    /*
     * 节点名称
     */
    private String zigbeeName;
    /*
     * 节点网络状态
     */
    private Integer zigbeeNet;
    /*
     * 节点功率百分比
     */
    private Integer zigbeeBright;
    /*
     * 节点开关状态，1为开灯，0为关灯
     */
    private Integer zigbeeStatus;
    /*
     * 网络短地址，在一个组网中每个节点都要有自己的短地址
     * 是主协调器随机分配的，每次上电不一定是相同的
     */
    private String zigbeeSaddr;
    /*
     * 节点所在集控器的mac地址
     */
    private String devMac;

    public String getZigbeeMac() {
        return zigbeeMac;
    }

    public void setZigbeeMac(String zigbeeMac) {
        this.zigbeeMac = zigbeeMac == null ? null : zigbeeMac.trim();
    }

    public String getZigbeeName() {
        return zigbeeName;
    }

    public void setZigbeeName(String zigbeeName) {
        this.zigbeeName = zigbeeName == null ? null : zigbeeName.trim();
    }

    public Integer getZigbeeNet() {
        return zigbeeNet;
    }

    public void setZigbeeNet(Integer zigbeeNet) {
        this.zigbeeNet = zigbeeNet;
    }

    public Integer getZigbeeBright() {
        return zigbeeBright;
    }

    public void setZigbeeBright(Integer zigbeeBright) {
        this.zigbeeBright = zigbeeBright;
    }

    public Integer getZigbeeStatus() {
        return zigbeeStatus;
    }

    public void setZigbeeStatus(Integer zigbeeStatus) {
        this.zigbeeStatus = zigbeeStatus;
    }

    public String getZigbeeSaddr() {
        return zigbeeSaddr;
    }

    public void setZigbeeSaddr(String zigbeeSaddr) {
        this.zigbeeSaddr = zigbeeSaddr == null ? null : zigbeeSaddr.trim();
    }

    public String getDevMac() {
        return devMac;
    }

    public void setDevMac(String devMac) {
        this.devMac = devMac == null ? null : devMac.trim();
    }

	@Override
	public String toString() {
		return "Zigbee [zigbeeMac=" + zigbeeMac + ", zigbeeName=" + zigbeeName + ", zigbeeNet=" + zigbeeNet
				+ ", zigbeeBright=" + zigbeeBright + ", zigbeeStatus=" + zigbeeStatus + ", zigbeeSaddr=" + zigbeeSaddr
				+ ", devMac=" + devMac + "]";
	}
}