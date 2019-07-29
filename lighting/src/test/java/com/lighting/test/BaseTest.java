package com.lighting.test;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.test.dao.DeviceMapper;
import com.test.dao.GroupMapper;
import com.test.dao.GroupPairMapper;
import com.test.dao.PloyMapper;
import com.test.dao.PloyOperateMapper;
import com.test.dao.ZigbeeMapper;
import com.test.domain.Device;
import com.test.domain.GroupPair;
import com.test.domain.Ploy;
import com.test.domain.PloyOperate;
import com.test.domain.Zigbee;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration("src/main/resouces")
@ContextConfiguration(locations = { "classpath:spring-mybatis.xml", "classpath:spring-mvc.xml" })
public class BaseTest {
	@Autowired
	private DeviceMapper devDao;

	@Autowired
	private ZigbeeMapper zigbeeDao;

	@Autowired
	private GroupMapper groupDao;

	@Autowired
	private GroupPairMapper groupPairDao;

	@Autowired
	private PloyMapper ployDao;
	
	@Autowired
	private PloyOperateMapper ployOperateDao;

	@Test
	public void test() {
		System.out.println(devDao);
	}

	@Test
	public void selectDeviceNumberOfUserTest() {
		int num = devDao.selectDeviceNumberOfUser(100000);
		System.out.println(num);
	}

	@Test
	public void selectDeviceByUseridPagedTest() {
		List<Device> list = devDao.selectByUseridPaged(100000, 0, 10);
		for (Device device : list) {
			System.out.println(device);
		}
	}

	@Test
	public void selectZigbeeNumberByDeviceTest() {
		// int num = zigbeeDao.selectZigbeeNumberByDeviceMac("dev1");
		// int offlineNum =
		// zigbeeDao.selectZigbeeNumberByDeviceMacAndOnlineStatus("dev1", 1);
		// System.out.println("zigbeenum:" + num);
		// System.out.println("zigbeeonlinenum:" + offlineNum);
	}

	@Test
	public void selectZigbeeBydevMacPagedTest() {
		ArrayList<Zigbee> zigbeeList = zigbeeDao.selectByDevMacPaged("02AB1205004B1200", 0, 10);
		for (Zigbee zigbee : zigbeeList) {
			System.out.println(zigbee);
		}
	}

	@Test
	public void selectGroupNumberOfUserTest() {
		int num = groupDao.selectGroupNumberOfUser(100000);
		System.out.println("groupnum=" + num);
	}

	@Test
	public void selectGroupPairNumberByGroupidTest() {
		int num = groupPairDao.selectGroupPairNumberByGroupid(1006);
		System.out.println("groupPairnum=" + num);
	}

	@Test
	public void selectGroupPairByGroupidPagedTest() {
		ArrayList<GroupPair> list = groupPairDao.selectByGroupidPaged(1006, 0, 10);
		for (GroupPair temp : list) {
			System.out.println(temp);
		}
	}

	@Test
	public void ployDaoTest() {
		int num = ployDao.selectPloyNumberByUserid(100000);
		System.out.println("ploynum=" + num);
		ArrayList<Ploy> list = ployDao.selectByUseridPaged(100000, 0, 10);
		for (Ploy temp : list) {
			System.out.println(temp);
		}
	}
	
	@Test
	public void ployOperateDaoTest() {
		int num = ployOperateDao.selectPloyOperateNumberByPloyid(2);
		System.out.println("ploynum=" + num);
		ArrayList<PloyOperate> list = ployOperateDao.selectByPloyidPaged(2, 0, 10);
		for (PloyOperate temp : list) {
			System.out.println(temp);
		}
	}
}
