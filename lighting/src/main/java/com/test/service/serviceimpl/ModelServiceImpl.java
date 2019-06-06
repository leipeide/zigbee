package com.test.service.serviceimpl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.dao.DeviceAttrMapper;
import com.test.dao.DeviceMapper;
import com.test.dao.GroupMapper;
import com.test.dao.GroupPairMapper;
import com.test.dao.PloyMapper;
import com.test.dao.PloyOperateMapper;
import com.test.dao.UserMapper;
import com.test.dao.ZigbeeAttrMapper;
import com.test.dao.ZigbeeMapper;
import com.test.domain.Device;
import com.test.domain.DeviceAttr;
import com.test.domain.LayuiDeviceModel;
import com.test.domain.LayuiTableModel;
import com.test.service.IModelService;

@Service()
public class ModelServiceImpl implements IModelService {

	// 按照类型注入
	@Autowired
	private UserMapper userDao;
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
			ArrayList<Device> devList = devDao.selectByUseridPaged(userid, (page-1) * limit, limit);
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
		ltModel.setCount(devModelList.size());
//		List<Object> result = new LinkedList<>();
//		Collections.addAll(result, devModelList);
		ltModel.setData(devModelList);
		return ltModel;
	}

}
