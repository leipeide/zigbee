package com.test.service.serviceimpl;

import java.util.ArrayList;
import java.util.LinkedList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.dao.DeviceAttrMapper;
import com.test.dao.DeviceMapper;
import com.test.dao.GroupMapper;
import com.test.dao.GroupPairMapper;
import com.test.dao.PloyMapper;
import com.test.dao.PloyOperateMapper;
import com.test.dao.ZigbeeAttrMapper;
import com.test.dao.ZigbeeMapper;
import com.test.domain.Device;
import com.test.domain.DeviceAttr;
import com.test.domain.Group;
import com.test.domain.GroupPair;
import com.test.domain.LayuiDeviceModel;
import com.test.domain.LayuiTableModel;
import com.test.domain.LayuiZigbeeModel;
import com.test.domain.Ploy;
import com.test.domain.PloyOperate;
import com.test.domain.Zigbee;
import com.test.domain.ZigbeeAttr;
import com.test.service.IModelService;

@Service()
public class ModelServiceImpl implements IModelService {

	// 按照类型注入
	@Autowired
	private DeviceMapper devDao;
	@Autowired
	private ZigbeeMapper zigbeeDao;
	@Autowired
	private GroupMapper groupDao;
	@Autowired
	private GroupPairMapper groupPairDao;
	@Autowired
	private ZigbeeAttrMapper zigbeeAttrDao;
	@Autowired
	private PloyMapper ployDao;
	@Autowired
	private PloyOperateMapper ployOperateDao;
	@Autowired
	private DeviceAttrMapper deviceAttrDao;

	@Override
	public LayuiTableModel getDeviceTableDataByUserid(int userid, int page, int limit) {
		LayuiTableModel ltModel = new LayuiTableModel();
		LinkedList<Object> devModelList = new LinkedList<Object>();
		// 第一步，查询页数
		ltModel.setCount(devDao.selectDeviceNumberOfUser(userid));
		int pageCount = ltModel.getCount() / limit;
		if (ltModel.getCount() % limit > 0) {
			pageCount++;
		}
		// 第二步，判断页面是否越界
		if (0 < page && page <= pageCount) {
			// 分页查找数据
			// 1. 分页查找用户device
			ArrayList<Device> devList = devDao.selectByUseridPaged(userid, (page - 1) * limit, limit);
			// 2. 根据device的devMac查找deviceAttr
			DeviceAttr devAttr;
			LayuiDeviceModel temp;
			for (Device dev : devList) {
				// 3. 生成LayuiDeviceModel
				devAttr = deviceAttrDao.selectByPrimaryKey(dev.getDevMac());
				temp = new LayuiDeviceModel(dev, devAttr);
				// 4. 根据devMac查在线节点数量、离线节点数量，赋值
				temp.setOnlineNodes(zigbeeDao.selectZigbeeNumberByDeviceMacAndOnlineStatus(temp.getDevMac(), 1));
				temp.setOfflineNodes(zigbeeDao.selectZigbeeNumberByDeviceMacAndOnlineStatus(temp.getDevMac(), 0));
				devModelList.add(temp);
			}

			ltModel.setCode(0);
			ltModel.setMsg("");
		} else {
			ltModel.setCode(1);
			ltModel.setMsg("数据读取越界！");
		}
		// 第四步，返回数据
		ltModel.setData(devModelList);
		return ltModel;
	}

	@Override
	public LayuiTableModel getZigbeeTableDataByDeviceMac(String devMac, int page, int limit) {
		LayuiTableModel ltModel = new LayuiTableModel();
		LinkedList<Object> zigbeeModelList = new LinkedList<Object>();
		// 第一步，查询页数
		ltModel.setCount(zigbeeDao.selectZigbeeNumberByDeviceMac(devMac));
		int pageCount = ltModel.getCount() / limit;
		if (ltModel.getCount() % limit > 0) {
			pageCount++;
		}
		// 第二步，判断页面是否越界
		if (0 < page && page <= pageCount) {
			// 分页查找数据
			// 查询在线节点数量
			int onlineNum = zigbeeDao.selectZigbeeNumberByDeviceMacAndOnlineStatus(devMac, 1);
			ArrayList<Zigbee> onlineList = null;
			ArrayList<Zigbee> offlineList = null;
			// 如果在线节点数量足够填充页面
			if ((page - 1) * limit < onlineNum) {
				onlineList = zigbeeDao.selectByDevMacAndOnlineStatusPaged(devMac, 1, (page - 1) * limit, limit);
				// 如果在线节点数量只够填充页面一部分
				if (onlineList.size() < limit) {
					offlineList = zigbeeDao.selectByDevMacAndOnlineStatusPaged(devMac, 0, 0, limit-onlineList.size());
				}
			} else {
				// 如果查询页数超过在线节点数量能填充的页数，返回离线数据
				int offlineIndex = (page - 1) * limit - onlineNum;
				offlineList = zigbeeDao.selectByDevMacAndOnlineStatusPaged(devMac, 0, offlineIndex, limit);
				
			}
			LinkedList<Zigbee> zigbeeList = new LinkedList<Zigbee>();
			if (onlineList != null) {
				zigbeeList.addAll(onlineList);
			}
			if (offlineList != null) {
				zigbeeList.addAll(offlineList);
			}
			ZigbeeAttr zigbeeAttr;
			LayuiZigbeeModel temp;
			for (Zigbee zigbee : zigbeeList) {
				// 3. 生成LayuiZigbeeModel
				zigbeeAttr = zigbeeAttrDao.selectByPrimaryKey(zigbee.getZigbeeMac());
				temp = new LayuiZigbeeModel(zigbee, zigbeeAttr);
				zigbeeModelList.add(temp);
			}
		} else {
			ltModel.setCode(1);
			ltModel.setMsg("数据读取越界！");
		}

		// 第四步，返回数据
		ltModel.setData(zigbeeModelList);
		return ltModel;
	}

	@Override
	public LayuiTableModel getGroupTableDataByUserid(int userid, int page, int limit) {
		LayuiTableModel ltModel = new LayuiTableModel();
		// 第一步，查询页数
		ltModel.setCount(groupDao.selectGroupNumberOfUser(userid));
		int pageCount = ltModel.getCount() / limit;
		if (ltModel.getCount() % limit > 0) {
			pageCount++;
		}
		// 第二步，判断页面是否越界
		ArrayList<Group> groupList = null;
		if (0 < page && page <= pageCount) {
			// 分页查找数据
			// 1. 分页查找用户group
			groupList = groupDao.selectByUseridPaged(userid, (page - 1) * limit, limit);
			ltModel.setCode(0);
			ltModel.setMsg("");
		} else {
			ltModel.setCode(1);
			ltModel.setMsg("数据读取越界！");
			return ltModel;
		}
		// 第三步，返回数据
		ltModel.setData(new LinkedList<Object>());
		ltModel.getData().addAll(groupList);
		return ltModel;
	}

	@Override
	public LayuiTableModel getGroupDetailTableDataByUserid(int groupid, int page, int limit) {
		LayuiTableModel ltModel = new LayuiTableModel();
		LinkedList<Object> zigbeeList = new LinkedList<Object>();
		// 第一步，查询页数
		ltModel.setCount(groupPairDao.selectGroupPairNumberByGroupid(groupid));
		int pageCount = ltModel.getCount() / limit;
		if (ltModel.getCount() % limit > 0) {
			pageCount++;
		}
		// 第二步，判断页面是否越界
		ArrayList<GroupPair> groupPairList = null;
		if (0 < page && page <= pageCount) {
			// 分页查找数据
			// 1. 分页查找用户grouppair
			groupPairList = groupPairDao.selectByGroupidPaged(groupid, (page - 1) * limit, limit);
			// 2. 根据groupPair的zigbeeMac查找zigbee
			for (GroupPair gp : groupPairList) {
				zigbeeList.add(zigbeeDao.selectByPrimaryKey(gp.getZigbeeMac()));
			}
			ltModel.setCode(0);
			ltModel.setMsg("");
		} else {
			ltModel.setCode(1);
			ltModel.setMsg("数据读取越界！");
			return ltModel;
		}
		// 第三步，返回数据
		ltModel.setData(zigbeeList);
		return ltModel;
	}

	@Override
	public LayuiTableModel getPloyTableDataByUserid(int userid, int page, int limit) {
		LayuiTableModel ltModel = new LayuiTableModel();
		ArrayList<Ploy> ployList = null;
		// 第一步，查询页数
		ltModel.setCount(ployDao.selectPloyNumberByUserid(userid));
		int pageCount = ltModel.getCount() / limit;
		if (ltModel.getCount() % limit > 0) {
			pageCount++;
		}
		// 第二步，判断页面是否越界
		if (0 < page && page <= pageCount) {
			// 分页查找数据
			// 1. 分页查找用户ploy
			ployList = ployDao.selectByUseridPaged(userid, (page - 1) * limit, limit);
			ltModel.setCode(0);
			ltModel.setMsg("");
		} else {
			ltModel.setCode(1);
			ltModel.setMsg("数据读取越界！");
			return ltModel;
		}
		// 第三步，返回数据
		ltModel.setData(new LinkedList<Object>());
		ltModel.getData().addAll(ployList);
		return ltModel;
	}

	@Override
	public LayuiTableModel getPloyOperateTableDataByPloyid(int id, int page, int limit) {
		LayuiTableModel ltModel = new LayuiTableModel();
		ArrayList<PloyOperate> list = null;
		// 第一步，查询页数
		ltModel.setCount(ployOperateDao.selectPloyOperateNumberByPloyid(id));
		int pageCount = ltModel.getCount() / limit;
		if (ltModel.getCount() % limit > 0) {
			pageCount++;
		}
		// 第二步，判断页面是否越界
		if (0 < page && page <= pageCount) {
			// 分页查找数据
			// 1. 分页查找用户ploy
			list = ployOperateDao.selectByPloyidPaged(id, (page - 1) * limit, limit);
			ltModel.setCode(0);
			ltModel.setMsg("");
		} else {
			ltModel.setCode(1);
			ltModel.setMsg("数据读取越界！");
			return ltModel;
		}
		// 第三步，返回数据
		ltModel.setData(new LinkedList<Object>());
		ltModel.getData().addAll(list);
		return ltModel;
	}

}
